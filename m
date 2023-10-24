Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC47D44C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJXBQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJXBQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:16:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F510C7;
        Mon, 23 Oct 2023 18:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DADC433C8;
        Tue, 24 Oct 2023 01:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698110165;
        bh=zqSHAjHVizHo8y4ADA2VLXqP7H3ZRtqJHGeDELzOKIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjXY5kMqELBqneL5YwbFpFGvccdAawmMaOKopnAFGEt7NcqBqYV11i1ldpb3gg4WA
         3quTfkxUe1q6qAxQHI6+m8F0eLGe8nczuRsSlPVINqlf/UWzhoWswZu3PShI+gvlWB
         MHzD+uhsErWrRvdKb4+N4NMERfrwLMwJUSMHQJ3MW8LJDOFCWLQGvbG9uvXh0QEAIu
         LG6oSpyZYGFgkDh0IelZxnAahrRTancEYjtlcrQDFtEv6Ge+XL32Y0ornI94E8WrH2
         v762b0kmHVL30E+oUsHhqBtVXWpwtbEPwyKzd7yPwsJ257GAnYYpqoWidvJoOzQUVl
         wXDwa4A+x47MQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/6] tpm: Add tpm_buf_read_{u8,u16,u32}
Date:   Tue, 24 Oct 2023 04:15:23 +0300
Message-ID: <20231024011531.442587-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024011531.442587-1-jarkko@kernel.org>
References: <20231024011531.442587-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tpm_buf_read_u8(), tpm_buf_read_u16() and tpm_read_u32() for the sake
of more convenient parsing of TPM responses.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-buf.c | 69 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index f1d92d7e758d..bcd3cbcd9dd9 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -124,3 +124,72 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *)&value2, 4);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
+
+/**
+ * tpm_buf_read() - Read from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ * @count:	the number of bytes to read
+ * @output:	the output buffer
+ */
+static void tpm_buf_read(const struct tpm_buf *buf, off_t *offset, size_t count, void *output)
+{
+	if (*(offset + count) >= buf->length) {
+		WARN(1, "tpm_buf: overflow\n");
+		return;
+	}
+
+	memcpy(output, &buf->data[*offset], count);
+	*offset += count;
+}
+
+/**
+ * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 8-bit word
+ */
+u8 tpm_buf_read_u8(const struct tpm_buf *buf, off_t *offset)
+{
+	u8 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
+
+/**
+ * tpm_buf_read_u16() - Read 16-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 16-bit word
+ */
+u16 tpm_buf_read_u16(const struct tpm_buf *buf, off_t *offset)
+{
+	u16 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return be16_to_cpu(value);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
+
+/**
+ * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 32-bit word
+ */
+u32 tpm_buf_read_u32(const struct tpm_buf *buf, off_t *offset)
+{
+	u32 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return be32_to_cpu(value);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 687b5173bdab..6590bd1f0a0e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -337,6 +337,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+u8 tpm_buf_read_u8(const struct tpm_buf *buf, off_t *offset);
+u16 tpm_buf_read_u16(const struct tpm_buf *buf, off_t *offset);
+u32 tpm_buf_read_u32(const struct tpm_buf *buf, off_t *offset);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.42.0

