Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E37821ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHUDhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjHUDhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF67A1;
        Sun, 20 Aug 2023 20:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC527612BF;
        Mon, 21 Aug 2023 03:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABEC433C7;
        Mon, 21 Aug 2023 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692589019;
        bh=QIX6HWfuBu8ysTl9xaEzm8Nky/AQwBgCKGJVjIFJw/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cskFIhi7fxPTfx8Y04Ium/cCO1m5NcgqM2KOJ5LHPyaDGi7DKqq8bi/4LIVsDF3cA
         qUj+s/q4BnhAlx9PNqda8z569WAumXsY5WYIwDGv7jd5lG6yibSEOm+exw2gaSLJq9
         BTwTmboxNAzImTUcvLMxRHwFJtwXqLf0PldIKJ3Rt+2D6mR5etmy4NFKciOEt5UUjx
         cUYfjCHq0llbhuTal/XqCfebwufzSep/vCJkotel9aem9otfeITDQJv3Ft79cjmuzL
         FZ9eOFPAVxdtlR6o5UcJ1CNrozxVU1Te4t+zu3UBes9D6mt/PAphM8GjJ7xz7lMQjU
         KQNrz/RJRQPUw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] tpm: Support TPM2 sized buffers (TPM2B)
Date:   Mon, 21 Aug 2023 03:36:29 +0000
Message-Id: <20230821033630.1039527-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821033630.1039527-1-jarkko@kernel.org>
References: <20230821033630.1039527-1-jarkko@kernel.org>
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

Add boolean parameters @alloc and @sized to tpm_buf_init():

* If @alloc is set to false, buf->data is assumed to be pre-feeded and
  owned by the caller.
* If @sized is set to true, the buffer represents a sized buffer
  (TPM2B).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-buf.c                | 32 ++++++++++++++++-------
 drivers/char/tpm/tpm-sysfs.c              |  2 +-
 drivers/char/tpm/tpm1-cmd.c               | 14 +++++-----
 drivers/char/tpm/tpm2-cmd.c               | 22 ++++++++--------
 drivers/char/tpm/tpm2-space.c             |  4 +--
 drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
 include/linux/tpm.h                       |  3 ++-
 security/keys/trusted-keys/trusted_tpm1.c |  4 +--
 security/keys/trusted-keys/trusted_tpm2.c |  6 ++---
 9 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index fa9a4c51157a..f1d92d7e758d 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -7,22 +7,32 @@
 #include <linux/tpm.h>
 
 /**
- * tpm_buf_init() - Initialize from the heap
+ * tpm_buf_init() - Initialize a TPM buffer
  * @buf:	A @tpm_buf
+ * @sized:	Represent a sized buffer (TPM2B)
+ * @alloc:	Allocate from the heap
  *
  * Initialize all structure fields to zero, allocate a page from the heap, and
  * zero the bytes that the buffer headers will consume.
  *
  * Return: 0 or -ENOMEM
  */
-int tpm_buf_init(struct tpm_buf *buf)
+int tpm_buf_init(struct tpm_buf *buf, bool alloc, bool sized)
 {
-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!buf->data)
-		return -ENOMEM;
+	if (alloc) {
+		buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+		if (!buf->data)
+			return -ENOMEM;
+	}
+
+	if (sized) {
+		buf->flags = TPM_BUF_SIZED;
+		buf->length = 2;
+	} else {
+		buf->flags = 0;
+		buf->length = TPM_HEADER_SIZE;
+	}
 
-	buf->flags = 0;
-	buf->length = TPM_HEADER_SIZE;
 	memset(buf->data, 0, TPM_HEADER_SIZE);
 
 	return 0;
@@ -73,8 +83,6 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
 
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
@@ -87,7 +95,11 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 
 	memcpy(&buf->data[buf->length], new_data, new_length);
 	buf->length += new_length;
-	head->length = cpu_to_be32(buf->length);
+
+	if (buf->flags & TPM_BUF_SIZED)
+		((__be16 *)buf->data)[0] = cpu_to_be16(buf->length - 2);
+	else
+		((struct tpm_header *)buf->data)->length = cpu_to_be32(buf->length);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 557e7f86d98d..047a7064039e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -44,7 +44,7 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	if (tpm_try_get_ops(chip))
 		return 0;
 
-	if (tpm_buf_init(&tpm_buf))
+	if (tpm_buf_init(&tpm_buf, true, false))
 		goto out_ops;
 
 	tpm_buf_reset(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 28fea4e2daaf..396694018590 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc < 0)
 		return rc;
 
@@ -467,7 +467,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -487,7 +487,7 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -541,7 +541,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	u32 recd;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -592,7 +592,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -629,7 +629,7 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -761,7 +761,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
 				     "extending dummy pcr before suspend");
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 94dacbf74e0d..1d3e0833641d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -183,7 +183,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		expected_digest_size = chip->allocated_banks[i].digest_size;
 	}
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -242,7 +242,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -302,7 +302,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf);
+	err = tpm_buf_init(&buf, true, false);
 	if (err)
 		return err;
 
@@ -353,7 +353,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc) {
 		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
 			 handle);
@@ -394,7 +394,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -437,7 +437,7 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return;
 
@@ -467,7 +467,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 	int rc;
 
 	for (full = 0; full < 2; full++) {
-		rc = tpm_buf_init(&buf);
+		rc = tpm_buf_init(&buf, true, false);
 		if (rc)
 			return rc;
 
@@ -504,7 +504,7 @@ int tpm2_probe(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -571,7 +571,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	int rc;
 	int i = 0;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -661,7 +661,7 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		goto out;
 	}
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		goto out;
 
@@ -724,7 +724,7 @@ static int tpm2_startup(struct tpm_chip *chip)
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4538178e398c..115feb334c68 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -76,7 +76,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf);
+	rc = tpm_buf_init(&tbuf, true, false);
 	if (rc)
 		return rc;
 
@@ -128,7 +128,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf);
+	rc = tpm_buf_init(&tbuf, true, false);
 	if (rc)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index b2b9a15a4a59..52325abd395d 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -399,7 +399,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c355597351c6..687b5173bdab 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -304,6 +304,7 @@ struct tpm_header {
 
 enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
+	TPM_BUF_SIZED		= BIT(1),
 };
 
 struct tpm_buf {
@@ -328,7 +329,7 @@ struct tpm2_hash {
 };
 
 
-int tpm_buf_init(struct tpm_buf *buf);
+int tpm_buf_init(struct tpm_buf *buf, bool alloc, bool sized);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index fcf0eef79ba0..ed5dc3b45d52 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -664,7 +664,7 @@ static int key_seal(struct trusted_key_payload *p,
 	struct tpm_buf tb;
 	int ret;
 
-	ret = tpm_buf_init(&tb);
+	ret = tpm_buf_init(&tb, true, false);
 	if (ret)
 		return ret;
 
@@ -690,7 +690,7 @@ static int key_unseal(struct trusted_key_payload *p,
 	struct tpm_buf tb;
 	int ret;
 
-	ret = tpm_buf_init(&tb);
+	ret = tpm_buf_init(&tb, true, false);
 	if (ret)
 		return ret;
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c54659d06dcb..c41f30770138 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -252,7 +252,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc) {
 		tpm_put_ops(chip);
 		return rc;
@@ -410,7 +410,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
@@ -467,7 +467,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf);
+	rc = tpm_buf_init(&buf, true, false);
 	if (rc)
 		return rc;
 
-- 
2.39.2

