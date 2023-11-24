Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2F7F6A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjKXCD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjKXCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:03:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229510E5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:03:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B190CC433C7;
        Fri, 24 Nov 2023 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791380;
        bh=Q4MshG8lgDl83wh8pCEak01kU4faTZKHZoaH6OydOg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCrUStpqiXrcXuecEyYumXr+1J/K7cV3Vil0/3Z7m0t14tA8eM9ZGqgmxWBu5xiRd
         8Y4ydmz7ug7oK+ZU/uVfR41pw0xLQ7Y4Z+hE9XNgNy47VwktJKPG4hf+7NGhX5wFZQ
         ipnIK5qK9HhmRcJFlggXV5HDWNfPyb8KLl3tPEStsOcdARGlyS7/aUBsfXQzrOpu2j
         QaLVS/iR3DsPf2RKpkIaYoX5g/FamV+ATkdDUv/NCXTACg0s0tvx7pPYmd4cZeVP6z
         iIuIGxR9IX/1a6BHInmfYLDm0VOMVtmI9UXxyGPOpqW22C/L0n6ffivUbumr4dZVJJ
         v+zihpAMbcv3Q==
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
Subject: [PATCH v6 6/8] tpm: TPM2B formatted buffers
Date:   Fri, 24 Nov 2023 04:02:35 +0200
Message-ID: <20231124020237.27116-7-jarkko@kernel.org>
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

Declare tpm_buf_init_sized() and tpm_buf_reset_sized() for creating TPM2B
formatted buffers. These buffers are also known as sized buffers in the
specifications and literature.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2: [2021-11-21] Refine the API according to the comments for
    https://lore.kernel.org/linux-integrity/20231024011531.442587-5-jarkko@kernel.org/
---
 drivers/char/tpm/tpm-buf.c | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/tpm.h        |  4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 3f39893f3bb1..099b4a56c5d5 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -47,6 +47,36 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
+/**
+ * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
+ * @buf:	A @tpm_buf
+ *
+ * Return: 0 or -ENOMEM
+ */
+int tpm_buf_init_sized(struct tpm_buf *buf)
+{
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+
+	tpm_buf_reset_sized(buf);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
+
+/**
+ * tpm_buf_reset_sized() - Initialize a sized buffer
+ * @buf:	A &tpm_buf
+ */
+void tpm_buf_reset_sized(struct tpm_buf *buf)
+{
+	buf->flags = TPM_BUF_TPM2B;
+	buf->length = 2;
+	buf->data[0] = 0;
+	buf->data[1] = 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
+
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	free_page((unsigned long)buf->data);
@@ -72,8 +102,6 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
@@ -86,7 +114,11 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 
 	memcpy(&buf->data[buf->length], new_data, new_length);
 	buf->length += new_length;
-	head->length = cpu_to_be32(buf->length);
+
+	if (buf->flags & TPM_BUF_TPM2B)
+		((__be16 *)buf->data)[0] = cpu_to_be16(buf->length - 2);
+	else
+		((struct tpm_header *)buf->data)->length = cpu_to_be32(buf->length);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1d7b39b5c383..715db4a91c1f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -300,6 +300,8 @@ struct tpm_header {
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
+	/* TPM2B format: */
+	TPM_BUF_TPM2B		= BIT(1),
 };
 
 /*
@@ -328,6 +330,8 @@ struct tpm2_hash {
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_sized(struct tpm_buf *buf);
+void tpm_buf_reset_sized(struct tpm_buf *buf);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
-- 
2.43.0

