Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ABC7B4A67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 02:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjJBABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 20:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjJBABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 20:01:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31ECE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 17:01:11 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F8363F13B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696204867;
        bh=lpqGdzs9z+5RSvDu12eox5UE/cn06VRPHpB8RQjruMU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Rw4pP/9Bo3LU9sZo4mF0iZQwt6Ssg92n68W+5+MaoWENcDrIP2Et5CxgWNw1ADjgd
         pXHaogZx7wb68JslgKlU4/MkijQz3EzRHg+cFhkepu6hZhcChg5ifWTdx0hAVNtM1O
         PfUGlmMuTTgSLTlQWW7aKKzmuc7POCvJPJiPRSY1N+dD8KfDEd9rp3F18PrZ/vVD8c
         zej4LgznhWAeB45QcmvZgj3l+EiprAXDU3uv3fDxDh5/xw5ipykAvpallnNERxXIUo
         Mqngx/kk8xmPjDrWsg7fo0rkPd/9bxLLHddf7TslQ59Ajxu3K89EjNfFgPXRQE9Agu
         JLsYbuBE0meJw==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2790596f1a7so4990042a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 17:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696204863; x=1696809663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpqGdzs9z+5RSvDu12eox5UE/cn06VRPHpB8RQjruMU=;
        b=QgIxS+f80aa75caUy/J5D6o0TA9hzzOaFu5JuoSHwds95zb+QwPGRACJbfiG0Pk6EI
         J/XFZF1HX/VBBInf2QRQOsHb6rIl1bxmBj0LH8Jq/h3Og4iqJK+iq80Qy0l5yW15Ueiw
         A64d0aECywDmcM4Ir8dLjHb1ds22m+q3cKHQHw8Jf0raIhmlU3ObEIm14yZY+XLh/1R+
         OlElasN37JEOI9VZqK+Y+EhjDoJTtmrqwsY5WFJVlOHew0tAJBfTIMlx9CUQfYFKwR8X
         L51ih9QjCIoYBxMzXyrDoEZRp2lbZtuQhc/ynHbAPyBktRtovGXIDORLw3NlC+rcdM5F
         4CIA==
X-Gm-Message-State: AOJu0YxNR5RrRII/A7WY04cBDRLgE0M4OsUpMarKNY1ScjiKsHkquz3N
        ilMgIFDmTmry/QJZ+Opn315aeeJpEGezRItfGB8CYnuc2ss1h+M6JuKOsVNzQxO3JQQC1PlATGo
        9Qe3bC/d2We7sPymPoEdVstWo2ZZpIRTeof0yh9FwRw==
X-Received: by 2002:a17:90b:4f42:b0:26d:3ad:7c83 with SMTP id pj2-20020a17090b4f4200b0026d03ad7c83mr7635537pjb.13.1696204862858;
        Sun, 01 Oct 2023 17:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYp9oZSBIYGvi+Uv05g/BFdWpX0L1+kEJFNOgU3pQcKkjj7d/QsbUfnWz9OP/gfBBh64sjIw==
X-Received: by 2002:a17:90b:4f42:b0:26d:3ad:7c83 with SMTP id pj2-20020a17090b4f4200b0026d03ad7c83mr7635514pjb.13.1696204862468;
        Sun, 01 Oct 2023 17:01:02 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a035700b002796494b98csm1971164pjf.37.2023.10.01.17.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 17:01:02 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: pkcs7: remove md4 md5 x.509 support
Date:   Mon,  2 Oct 2023 00:57:15 +0100
Message-Id: <20231001235716.588251-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Remove support for md4 md5 hash and signatures in x.509 certificate
parsers, pkcs7 signature parser, authenticode parser.

All of these are insecure or broken, and everyone has long time ago
migrated to alternative hash implementations.

Also remove md2 & md3 oids which have already didn't have support.

This is also likely the last user of md4 in the kernel, and thus
crypto/md4.c and related tests in tcrypt & testmgr can likely be
removed. Other users such as cifs smbfs ext modpost sumversions have
their own internal implementation as needed.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/asymmetric_keys/mscode_parser.c    | 6 ------
 crypto/asymmetric_keys/pkcs7_parser.c     | 6 ------
 crypto/asymmetric_keys/x509_cert_parser.c | 6 ------
 include/linux/oid_registry.h              | 8 --------
 4 files changed, 26 deletions(-)

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 839591ad21..690405ebe7 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -75,12 +75,6 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
 
 	oid = look_up_OID(value, vlen);
 	switch (oid) {
-	case OID_md4:
-		ctx->digest_algo = "md4";
-		break;
-	case OID_md5:
-		ctx->digest_algo = "md5";
-		break;
 	case OID_sha1:
 		ctx->digest_algo = "sha1";
 		break;
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 277482bb17..cf4caab962 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -227,12 +227,6 @@ int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
 	struct pkcs7_parse_context *ctx = context;
 
 	switch (ctx->last_oid) {
-	case OID_md4:
-		ctx->sinfo->sig->hash_algo = "md4";
-		break;
-	case OID_md5:
-		ctx->sinfo->sig->hash_algo = "md5";
-		break;
 	case OID_sha1:
 		ctx->sinfo->sig->hash_algo = "sha1";
 		break;
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 7a9b084e20..8d23a69890 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -195,15 +195,9 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 	pr_debug("PubKey Algo: %u\n", ctx->last_oid);
 
 	switch (ctx->last_oid) {
-	case OID_md2WithRSAEncryption:
-	case OID_md3WithRSAEncryption:
 	default:
 		return -ENOPKG; /* Unsupported combination */
 
-	case OID_md4WithRSAEncryption:
-		ctx->cert->sig->hash_algo = "md4";
-		goto rsa_pkcs1;
-
 	case OID_sha1WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha1";
 		goto rsa_pkcs1;
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 0f4a890392..89fb4612b2 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -30,9 +30,6 @@ enum OID {
 
 	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
 	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
-	OID_md2WithRSAEncryption,	/* 1.2.840.113549.1.1.2 */
-	OID_md3WithRSAEncryption,	/* 1.2.840.113549.1.1.3 */
-	OID_md4WithRSAEncryption,	/* 1.2.840.113549.1.1.4 */
 	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
 	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
 	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
@@ -49,11 +46,6 @@ enum OID {
 	OID_smimeCapabilites,		/* 1.2.840.113549.1.9.15 */
 	OID_smimeAuthenticatedAttrs,	/* 1.2.840.113549.1.9.16.2.11 */
 
-	/* {iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2)} */
-	OID_md2,			/* 1.2.840.113549.2.2 */
-	OID_md4,			/* 1.2.840.113549.2.4 */
-	OID_md5,			/* 1.2.840.113549.2.5 */
-
 	OID_mskrb5,			/* 1.2.840.48018.1.2.2 */
 	OID_krb5,			/* 1.2.840.113554.1.2.2 */
 	OID_krb5u2u,			/* 1.2.840.113554.1.2.2.3 */
-- 
2.34.1

