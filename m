Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B17F6A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjKXCDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjKXCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:03:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53E19AC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:03:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2814C433C9;
        Fri, 24 Nov 2023 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791383;
        bh=QxqRnwnwf/AxgHt8+bTTK2G02f45I3yxIt0Ytvx6QdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASsI15mdzvCNaBq5rXvzB4Nd8ICJz7E0gaH/EKZ7qXU0hKbX9KxWNVfTyjj3iC4O4
         qHgMbd8RubYG5DwMKrwY9kiYVH2AEKZDbOdxBQCNQHKV1fD44zIdRb3KvXVFz/iPYn
         B2vgDQDEpOABh7Nr48fy1cCXLW2foYinIXr0TlNzhHrtf9yGcLAITvXdyq8g2d7o6p
         INqwlQ0HmxqYZ/ejCwWiXjnD157iNb1tjazhGrjid1Fz7Hk6oywNYHhREWftqcu8Fa
         u+YglqCEaHbmU2uh6MwkJyd2A36J8WpgAO0cLdY+p27iAPDS0N4g+zDC+eJzpbbAiW
         nvvfZkmyLW9+g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v6 7/8] tpm: Add tpm_buf_read_{u8,u16,u32}
Date:   Fri, 24 Nov 2023 04:02:36 +0200
Message-ID: <20231124020237.27116-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124020237.27116-1-jarkko@kernel.org>
References: <20231124020237.27116-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare reader functions for the instances of struct tpm_buf. If the read
goes out of boundary, TPM_BUF_BOUNDARY_ERROR is set, and subsequent read
will do nothing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5 [2023-11-24]: Fixed off-by-one error in the boundary check.
v4 [2023-11-21]: Address James Bottomley's feedback for v2 of this
patch, i.e. offset pointer was not correctly dereferenced.
v3 [2023-11-21]: Add possibility to check for boundary error to the
as response to the feedback from Mario Limenciello:
https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
---
 drivers/char/tpm/tpm-buf.c | 79 +++++++++++++++++++++++++++++++++++++-
 include/linux/tpm.h        |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 099b4a56c5d5..32619e9ab4fa 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -107,7 +107,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
+		WARN(1, "tpm_buf: write overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
 	}
@@ -143,3 +143,80 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
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
+static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void *output)
+{
+	off_t next_offset;
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return;
+
+	next_offset = *offset + count;
+	if (next_offset > buf->length) {
+		WARN(1, "tpm_buf: read out of boundary\n");
+		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		return;
+	}
+
+	memcpy(output, &buf->data[*offset], count);
+	*offset = next_offset;
+}
+
+/**
+ * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 8-bit word
+ */
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
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
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
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
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
+{
+	u32 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return be32_to_cpu(value);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 715db4a91c1f..e8172f81c562 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -302,6 +302,8 @@ enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
 	TPM_BUF_TPM2B		= BIT(1),
+	/* read out of boundary: */
+	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
 };
 
 /*
@@ -338,6 +340,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.43.0

