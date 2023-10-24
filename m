Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5DD7D44B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJXBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:15:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DADE;
        Mon, 23 Oct 2023 18:15:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD40DC433C8;
        Tue, 24 Oct 2023 01:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698110152;
        bh=cLRdo+8IxAjCsHwUYHoxQKR+U1/pFiEGPIZr1qKxNSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9GbSJPVL3MlMICTk6HzGkBkbgK/o5vsi5Wcm4kLxfyhlcPCLfag3FW+ROWuFcAWA
         CNkE5Wtn/ZevfBMbM7VBfBJnRF7VopEidonlFqgSC4lY5DG0hnGKcpedWXWxEqMfiC
         VuRe25qHtk9pOASRWpy2CttHUT1fhVnv77c+e8/DIUikthPe+Y+9/wamWLEYQhYXLR
         RZLpp4LvoxA/qASRIWujKU3AWSeeal5xmci6UROwuitr7ypncHkrclKrnYJ5jk0me5
         pfDPZrhWIVJCJ037wzEnh97yowS4QuJgj7cd/ICUHpvfZokfaAWckcYacITk4Ocyv3
         DgQ1ag/R4kt7Q==
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
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 2/6] tpm: Store TPM buffer length
Date:   Tue, 24 Oct 2023 04:15:20 +0300
Message-ID: <20231024011531.442587-3-jarkko@kernel.org>
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

Both TPM commands and sized buffers (TPM2B) have a fixed size header, which
is followed by the body. Store TPM buffer length to a new field in the
struct tpm_buf.

The invariant here is that the length field must always contain the total
length of the buffer, i.e. the sum header and body length. The value must
then be mapped to the length representation of the buffer type, and this
correspondence must be maintained.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-buf.c                | 36 ++++++++++++++++-------
 drivers/char/tpm/tpm-interface.c          | 18 +++++++++---
 include/linux/tpm.h                       | 10 +++----
 security/keys/trusted-keys/trusted_tpm1.c |  8 ++---
 4 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 88ce1a5402de..8dc6b9db006b 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -18,6 +18,12 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_init);
 
+/**
+ * tpm_buf_reset() - Initialize a TPM command
+ * @buf:	A @tpm_buf
+ * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
+ * @ordinal:	A command ordinal
+ */
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
@@ -25,6 +31,8 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
+
+	buf->length = sizeof(*head);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
@@ -34,33 +42,41 @@ void tpm_buf_destroy(struct tpm_buf *buf)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 
+/**
+ * tpm_buf_length() - Return the number of bytes consumed by the buffer
+ *
+ * Return: The number of bytes consumed by the buffer
+ */
 u32 tpm_buf_length(struct tpm_buf *buf)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be32_to_cpu(head->length);
+	return buf->length;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_length);
 
-void tpm_buf_append(struct tpm_buf *buf,
-		    const unsigned char *new_data,
-		    unsigned int new_len)
+/**
+ * tpm_buf_append() - Append data to an initialized buffer
+ * @buf:	A &tpm_buf
+ * @new_data:	A data blob
+ * @new_length:	Size of the appended data
+ */
+
+void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
-	u32 len = tpm_buf_length(buf);
 
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
 
-	if ((len + new_len) > PAGE_SIZE) {
+	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
 	}
 
-	memcpy(&buf->data[len], new_data, new_len);
-	head->length = cpu_to_be32(len + new_len);
+	memcpy(&buf->data[buf->length], new_data, new_length);
+	buf->length += new_length;
+	head->length = cpu_to_be32(buf->length);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..492136214447 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -217,6 +217,9 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 	int err;
 	ssize_t len;
 
+	/* The recorded length is expected to match the command length: */
+	WARN_ON(buf->length != be32_to_cpu(header->length));
+
 	len = tpm_transmit(chip, buf->data, PAGE_SIZE);
 	if (len <  0)
 		return len;
@@ -232,6 +235,11 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 	if (len < min_rsp_body_length + TPM_HEADER_SIZE)
 		return -EFAULT;
 
+	buf->length = len;
+
+	/* The recorded length is expected to match the response length: */
+	WARN_ON(buf->length != be32_to_cpu(header->length));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
@@ -345,12 +353,12 @@ EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 /**
  * tpm_send - send a TPM command
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @cmd:	a TPM command buffer
- * @buflen:	the length of the TPM command buffer
+ * @data:	command blob
+ * @cmdlen:	length of the command
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
+int tpm_send(struct tpm_chip *chip, void *data, size_t length)
 {
 	struct tpm_buf buf;
 	int rc;
@@ -359,7 +367,9 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 	if (!chip)
 		return -ENODEV;
 
-	buf.data = cmd;
+	buf.flags = 0;
+	buf.length = length;
+	buf.data = data;
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
 
 	tpm_put_ops(chip);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 60032c60994b..3cfe2aeb1d9a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -307,7 +307,8 @@ enum tpm_buf_flags {
 };
 
 struct tpm_buf {
-	unsigned int flags;
+	u32 flags;
+	u16 length;
 	u8 *data;
 };
 
@@ -331,8 +332,7 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
-void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
-		    unsigned int new_len);
+void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
@@ -361,7 +361,7 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
-extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
+int tpm_send(struct tpm_chip *chip, void *data, size_t length);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
@@ -382,7 +382,7 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return -ENODEV;
 }
 
-static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
+static inline int tpm_send(struct tpm_chip *chip, void *data, size_t length)
 {
 	return -ENODEV;
 }
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739..7c1515014a5d 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -407,7 +407,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	tpm_buf_append_u32(tb, handle);
 	tpm_buf_append(tb, ononce, TPM_NONCE_SIZE);
 
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	ret = trusted_tpm_send(tb->data, tb->length);
 	if (ret < 0)
 		return ret;
 
@@ -431,7 +431,7 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 		return -ENODEV;
 
 	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OIAP);
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	ret = trusted_tpm_send(tb->data, tb->length);
 	if (ret < 0)
 		return ret;
 
@@ -543,7 +543,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	tpm_buf_append_u8(tb, cont);
 	tpm_buf_append(tb, td->pubauth, SHA1_DIGEST_SIZE);
 
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	ret = trusted_tpm_send(tb->data, tb->length);
 	if (ret < 0)
 		goto out;
 
@@ -634,7 +634,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 	tpm_buf_append_u8(tb, cont);
 	tpm_buf_append(tb, authdata2, SHA1_DIGEST_SIZE);
 
-	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
+	ret = trusted_tpm_send(tb->data, tb->length);
 	if (ret < 0) {
 		pr_info("authhmac failed (%d)\n", ret);
 		return ret;
-- 
2.42.0

