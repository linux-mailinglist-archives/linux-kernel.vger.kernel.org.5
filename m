Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCCD7ADB75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjIYPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjIYPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:31:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B090;
        Mon, 25 Sep 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655909; x=1727191909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIJsR74uGLJIZB5dasGzbeVELDM8XVlth+LmABg2/Ts=;
  b=j5qk/i2B5ga/IHa83+GSCn72t+DxaUsGjKq2PQzQU82YZnJGBZ1ikn2E
   BWtWQqgisXPpka5e9MHdpJDAhKqcfIDTye9fquIh6A+ofqQYIb2g0g05o
   xNbihBsmfvPp/+4ClMS4amvzd8Zr6D/Q5wA03DMX454U51FZXyWovO5TO
   6fynjckbYittQSQ/b7GZy41p8s2OZ6hYz7mgb4rhz9CV5t2TsCYkuyfcI
   85pk6axVbQYxjFyPuSKE3XKkK78WBSwOcyrlDE/qceQtzrBrdrR/hT97J
   G4A4behQx9m7mwXSGFOFGSSj7fjL9BuAXnBEP8Wil98OzfUZCVgv1qPzq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361533592"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361533592"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725023009"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="725023009"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2023 08:31:48 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 1/3] crypto: x86/aesni - Refactor the common address alignment code
Date:   Mon, 25 Sep 2023 08:17:50 -0700
Message-Id: <20230925151752.162449-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925151752.162449-1-chang.seok.bae@intel.com>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address alignment code has been duplicated for each mode. Instead
of duplicating the same code, refactor the alignment code and simplify
the alignment helpers.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/all/20230526065414.GB875@sol.localdomain/
---
 arch/x86/crypto/aesni-intel_glue.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 39d6a62ac627..241d38ae1ed9 100644
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
+	return (struct aesni_rfc4106_gcm_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
 }
 
 static inline struct
 generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
+	return (struct generic_gcmaes_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
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
+	return (struct crypto_aes_ctx *)aes_align_addr(raw_ctx);
 }
 
 static int aes_set_key_common(struct crypto_aes_ctx *ctx,
-- 
2.34.1

