Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547687B1523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjI1HjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjI1HjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:39:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DD9F;
        Thu, 28 Sep 2023 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886740; x=1727422740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTsR4bc4ZnGNeFWQnKoWjgv1oT3/1emfbnvRjX1H0pw=;
  b=ItpswK/xPLnNH0C9vlYV0o+OjmhZ7B6mS61K6zDH9Tgz3CCiQ2HeDh4L
   2a0B51Gfmi89gWh6FNmtItlr8jeL3gpnaUKNVcVzMz0qUmN29iok+hqHX
   6ygHdPkNSFvnYpuYFFRhg2lE1qrluZmv3qI0VXaGbV5R5va9DB1u4vghg
   NNZkX0GXdurqFlZuCdXnkc7J1/SrnK/842CGtOf1jQJT7D2NqEuMJZWyt
   vTxLYb53XvBQ7LPDnVS0F0ChL7T+rHilfdSU43EgDcrzoCsOhPGZGPcot
   N7E7QJ6sBIeWK1CS5xG/9wCurcR8lw31Gtah7zVHr7bJ6KHOJIiUb5jPo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367064861"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="367064861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742990421"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="742990421"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 00:38:58 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 1/3] crypto: x86/aesni - Refactor the common address alignment code
Date:   Thu, 28 Sep 2023 00:25:06 -0700
Message-Id: <20230928072508.218368-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928072508.218368-1-chang.seok.bae@intel.com>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
 <20230928072508.218368-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address alignment code has been duplicated for each mode. Instead
of duplicating the same code, refactor the alignment code and simplify
the alignment helpers.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/all/20230526065414.GB875@sol.localdomain/
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
V1->V2: drop the casts (Eric).
---
 arch/x86/crypto/aesni-intel_glue.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 39d6a62ac627..308deeb0c974 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -80,6 +80,13 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
+static inline void *aes_align_addr(void *addr)
+{
+	if (crypto_tfm_ctx_alignment() >= AESNI_ALIGN)
+		return addr;
+	return PTR_ALIGN(addr, AESNI_ALIGN);
+}
+
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			     unsigned int key_len);
 asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
@@ -201,32 +208,19 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
+	return aes_align_addr(crypto_aead_ctx(tfm));
 }
 
 static inline struct
 generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
+	return aes_align_addr(crypto_aead_ctx(tfm));
 }
 #endif
 
 static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 {
-	unsigned long addr = (unsigned long)raw_ctx;
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return (struct crypto_aes_ctx *)ALIGN(addr, align);
+	return aes_align_addr(raw_ctx);
 }
 
 static int aes_set_key_common(struct crypto_aes_ctx *ctx,
-- 
2.34.1

