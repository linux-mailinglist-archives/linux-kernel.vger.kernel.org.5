Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DD7821F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjHUDhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjHUDhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D720C3;
        Sun, 20 Aug 2023 20:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AED262804;
        Mon, 21 Aug 2023 03:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B6C43391;
        Mon, 21 Aug 2023 03:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692589022;
        bh=AKMF8KXh+pmIVW6h4ohhXyQ9DGyfVE6RymaY/KQPYCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EubgdrJUSCHZfCrpraRuVYG7rwWw6Koko7iAOP7H5+J+1bztSkD5/WQyfW1ian1pv
         O0yIXeQBI86iWXDuLFb1aCvQAq57AJ5Vo5PxYRO9G49azuG/nMX1jDMnOWsr7c3H++
         oO4d6nC1r+LvWA+BxrdCgYTg4LFDle0kImlwIxMxCfPrgh+sy4oeFxM6NkMAAYsXJE
         qqNVpI54fLoz2IUvJuBZRXizfC0LDCZmd8HQ99ta9vcF3CSzs/KrBePx80Dkf2yykw
         NpBbsZQ1b8ypDHODPwCueUBASbyvEGg+69J0W/n6/yntD+5nTTU1k+wxuY5gdxk0wB
         vWBfaduBPSe3g==
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
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
Date:   Mon, 21 Aug 2023 03:36:30 +0000
Message-Id: <20230821033630.1039527-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821033630.1039527-1-jarkko@kernel.org>
References: <20230821033630.1039527-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 security/keys/trusted-keys/trusted_tpm2.c | 42 ++++++++++++++---------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c41f30770138..a976de3c28ae 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -228,8 +228,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
 	int i;
@@ -258,6 +258,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -267,36 +274,36 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -328,6 +335,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 				   blob_len);
 
 out:
+	tpm_buf_destroy(&sized);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
-- 
2.39.2

