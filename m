Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40F7D44C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJXBQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJXBQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:16:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A927E10DE;
        Mon, 23 Oct 2023 18:16:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45BAC433C8;
        Tue, 24 Oct 2023 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698110168;
        bh=ZdQqdBn4UrJLrghWqEUDW/8ikCU9oiCOvcpS1PL5Ftc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFk/3BJi45tRWoygTOJ3Iix08XMa0hD5CXMxUAAmwmEbANZYKU/EYBERbW5KU7HhD
         188Ruj7xi6Xo7vcnVClKwE74h9/XHeeklHwTZSl9sLh6q3TLSB7LOUS7bUSNa6DJPU
         rOXlNVFjExh5Lk8fObLODUKUg6ytbt5S1MyoD/0z5VfB387GpZ5FUhpnjLAS8AroRc
         NJ2FRv5gt+wIvs2GdFqnWR4lDXs1XbQg+uifuP7Ikc3lBAX3gVfN0VwiKiblswUMTU
         FR1wny0FewE6C8jyJiFxmYeJC6RbAg/vH8IzUIVIeC1xIaQCiudyP7+WxfEAry5aIL
         hs6DPmAG9btvQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/6] KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
Date:   Tue, 24 Oct 2023 04:15:24 +0300
Message-ID: <20231024011531.442587-7-jarkko@kernel.org>
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

Take advantage of the new sized buffer (TPM2B) mode of struct tpm_buf in
tpm2_seal_trusted(). This allows to add robustness to the command
construction without requiring to calculate buffer sizes manually.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Use tpm_buf_read_*
---
 security/keys/trusted-keys/trusted_tpm2.c | 51 +++++++++++++----------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c41f30770138..5d262306184c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	off_t offset = TPM_HEADER_SIZE;
+	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
 	int i;
@@ -258,6 +259,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		return rc;
 	}
 
+	rc = tpm_buf_init(&sized, true, true);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm_put_ops(chip);
+		return rc;
+	}
+
 	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
@@ -267,36 +275,36 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len);
+	tpm_buf_append_u16(&sized, options->blobauth_len);
 
-	tpm_buf_append_u16(&buf, options->blobauth_len);
 	if (options->blobauth_len)
-		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
+		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
 
-	tpm_buf_append_u16(&buf, payload->key_len);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
+	tpm_buf_append_u16(&sized, payload->key_len);
+	tpm_buf_append(&sized, payload->key, payload->key_len);
+	tpm_buf_append(&buf, sized.data, sized.length);
 
 	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
+	tpm_buf_init(&sized, false, true);
+	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&sized, hash);
 
 	/* key properties */
 	flags = 0;
 	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
-	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
-					    TPM2_OA_FIXED_PARENT);
-	tpm_buf_append_u32(&buf, flags);
+	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
+	tpm_buf_append_u32(&sized, flags);
 
 	/* policy */
-	tpm_buf_append_u16(&buf, options->policydigest_len);
+	tpm_buf_append_u16(&sized, options->policydigest_len);
 	if (options->policydigest_len)
-		tpm_buf_append(&buf, options->policydigest,
-			       options->policydigest_len);
+		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
+	tpm_buf_append_u16(&sized, 0);
+
+	tpm_buf_append(&buf, sized.data, sized.length);
 
 	/* outside info */
 	tpm_buf_append_u16(&buf, 0);
@@ -313,21 +321,20 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		goto out;
 
-	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
+	blob_len = tpm_buf_read_u32(&buf, &offset);
 	if (blob_len > MAX_BLOB_SIZE) {
 		rc = -E2BIG;
 		goto out;
 	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+	if (buf.length - offset < blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options,
-				   &buf.data[TPM_HEADER_SIZE + 4],
-				   blob_len);
+	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
 
 out:
+	tpm_buf_destroy(&sized);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
-- 
2.42.0

