Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9B7D44BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjJXBQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjJXBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:16:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF552D7B;
        Mon, 23 Oct 2023 18:15:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26458C433C8;
        Tue, 24 Oct 2023 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698110156;
        bh=TF+i454t5XKk/NRc+FR3n+bDnLASS2x1jCVscaJ0wVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ggiq+Bij10jWoFUrAtahWhRA38cI5EzCR7D9RuDtVRVXVhXnHpIcODLMlFBiM2/zG
         vgcI5HK12TbGxwIoy9yG2Tyf4ebKlxt9GMF7Emr5wTvhgg39hrLLT6WIpndqUp+zWe
         Fe3/nbUebUnTbNcabB/q+6CVjhkVsftYZZHh1ybnsDtU45vEBeX7K6pfJdV7Z4wTXc
         AsUtPs9OT46bmxdWAnMpQTs/bkkpA0OES4Qno1hLD4MjZ/Eu1aXSMl/a1rQT/xbzrZ
         uO/7gfAV6LMSPdd/CEdmEKUIoWIXlaUxj0M60RANZoY7KRuYciZxUUEAVzwJciJaSw
         Go4dC2/shm7MA==
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
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
Date:   Tue, 24 Oct 2023 04:15:21 +0300
Message-ID: <20231024011531.442587-4-jarkko@kernel.org>
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

In order to use tpm_buf_init() for other buffer types, detach
tpm_buf_reset() from tpm_buf_init().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-buf.c                | 15 ++++++++--
 drivers/char/tpm/tpm-sysfs.c              |  3 +-
 drivers/char/tpm/tpm1-cmd.c               | 26 +++++++++++-----
 drivers/char/tpm/tpm2-cmd.c               | 36 ++++++++++++++++-------
 drivers/char/tpm/tpm2-space.c             |  7 +++--
 drivers/char/tpm/tpm_vtpm_proxy.c         | 13 ++++----
 include/linux/tpm.h                       |  2 +-
 security/keys/trusted-keys/trusted_tpm1.c |  4 +--
 security/keys/trusted-keys/trusted_tpm2.c |  9 ++++--
 9 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 8dc6b9db006b..fa9a4c51157a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -6,14 +6,25 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+/**
+ * tpm_buf_init() - Initialize from the heap
+ * @buf:	A @tpm_buf
+ *
+ * Initialize all structure fields to zero, allocate a page from the heap, and
+ * zero the bytes that the buffer headers will consume.
+ *
+ * Return: 0 or -ENOMEM
+ */
+int tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
 	if (!buf->data)
 		return -ENOMEM;
 
 	buf->flags = 0;
-	tpm_buf_reset(buf, tag, ordinal);
+	buf->length = TPM_HEADER_SIZE;
+	memset(buf->data, 0, TPM_HEADER_SIZE);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_init);
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..557e7f86d98d 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -44,9 +44,10 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	if (tpm_try_get_ops(chip))
 		return 0;
 
-	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
+	if (tpm_buf_init(&tpm_buf))
 		goto out_ops;
 
+	tpm_buf_reset(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK);
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
 	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..28fea4e2daaf 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -328,10 +328,11 @@ static int tpm1_startup(struct tpm_chip *chip)
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
+	rc = tpm_buf_init(&buf);
 	if (rc < 0)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
@@ -466,10 +467,11 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
@@ -485,10 +487,12 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
+
 	if (subcap_id == TPM_CAP_VERSION_1_1 ||
 	    subcap_id == TPM_CAP_VERSION_1_2) {
 		tpm_buf_append_u32(&buf, subcap_id);
@@ -537,10 +541,12 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	u32 recd;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
 
@@ -586,10 +592,11 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
 	tpm_buf_append_u32(&buf, pcr_idx);
 
 	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE,
@@ -622,10 +629,12 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
+
 	rc = tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
 	tpm_buf_destroy(&buf);
 	return rc;
@@ -752,9 +761,12 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
 				     "extending dummy pcr before suspend");
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
+
+	tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
 		rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..94dacbf74e0d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -183,10 +183,12 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		expected_digest_size = chip->allocated_banks[i].digest_size;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
+
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
@@ -240,10 +242,11 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	tpm_buf_append_u32(&buf, pcr_idx);
 
 	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
@@ -299,7 +302,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm_buf_init(&buf);
 	if (err)
 		return err;
 
@@ -350,13 +353,14 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
+	rc = tpm_buf_init(&buf);
 	if (rc) {
 		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
 			 handle);
 		return;
 	}
 
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
 	tpm_buf_append_u32(&buf, handle);
 
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
@@ -390,9 +394,11 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, property_id);
 	tpm_buf_append_u32(&buf, 1);
@@ -431,9 +437,11 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return;
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
 	tpm_buf_append_u16(&buf, shutdown_type);
 	tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
 	tpm_buf_destroy(&buf);
@@ -459,10 +467,11 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 	int rc;
 
 	for (full = 0; full < 2; full++) {
-		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		rc = tpm_buf_init(&buf);
 		if (rc)
 			return rc;
 
+		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
 		tpm_buf_append_u8(&buf, full);
 		rc = tpm_transmit_cmd(chip, &buf, 0,
 				      "attempting the self test");
@@ -495,9 +504,11 @@ int tpm2_probe(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(&buf, 1);
@@ -560,10 +571,11 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	int rc;
 	int i = 0;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
 	tpm_buf_append_u32(&buf, 0);
 	tpm_buf_append_u32(&buf, 1);
@@ -649,10 +661,11 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		goto out;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		goto out;
 
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(&buf, TPM2_CAP_COMMANDS);
 	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
 	tpm_buf_append_u32(&buf, nr_commands);
@@ -711,10 +724,11 @@ static int tpm2_startup(struct tpm_chip *chip)
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
+	rc = tpm_buf_init(&buf);
 	if (rc < 0)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 363afdd4d1d3..43584b4176d6 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -76,10 +76,12 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
+	rc = tpm_buf_init(&tbuf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
+
 	ctx = (struct tpm2_context *)&buf[*offset];
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
@@ -126,10 +128,11 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
+	rc = tpm_buf_init(&tbuf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
 	tpm_buf_append_u32(&tbuf, handle);
 
 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 30e953988cab..b2b9a15a4a59 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -399,14 +399,15 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS,
-				  TPM2_CC_SET_LOCALITY);
-	else
-		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
-				  TPM_ORD_SET_LOCALITY);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
+	else
+		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SET_LOCALITY);
+
 	tpm_buf_append_u8(&buf, locality);
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3cfe2aeb1d9a..c355597351c6 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -328,7 +328,7 @@ struct tpm2_hash {
 };
 
 
-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init(struct tpm_buf *buf);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 7c1515014a5d..fcf0eef79ba0 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -664,7 +664,7 @@ static int key_seal(struct trusted_key_payload *p,
 	struct tpm_buf tb;
 	int ret;
 
-	ret = tpm_buf_init(&tb, 0, 0);
+	ret = tpm_buf_init(&tb);
 	if (ret)
 		return ret;
 
@@ -690,7 +690,7 @@ static int key_unseal(struct trusted_key_payload *p,
 	struct tpm_buf tb;
 	int ret;
 
-	ret = tpm_buf_init(&tb, 0, 0);
+	ret = tpm_buf_init(&tb);
 	if (ret)
 		return ret;
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index bc700f85f80b..c54659d06dcb 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -252,12 +252,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	rc = tpm_buf_init(&buf);
 	if (rc) {
 		tpm_put_ops(chip);
 		return rc;
 	}
 
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
 			     NULL /* nonce */, 0,
@@ -409,10 +410,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
 			     NULL /* nonce */, 0,
@@ -465,10 +467,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	rc = tpm_buf_init(&buf);
 	if (rc)
 		return rc;
 
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 	tpm_buf_append_u32(&buf, blob_handle);
 	tpm2_buf_append_auth(&buf,
 			     options->policyhandle ?
-- 
2.42.0

