Return-Path: <linux-kernel+bounces-99576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA1878A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF2D1F21AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266B56B89;
	Mon, 11 Mar 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrNYXage"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83C56B77;
	Mon, 11 Mar 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193700; cv=none; b=oJVakHvJZhFo3vLpSI6bs+Yc9hUCwFi1CokGCxTY6EQXckIGAICzDYZdR5o5tClv4J1jCnLMhehP7uJ23dlpfwTkiVqm/3IpKhNdm+eWwXCaiQGT5aSLqdYU9IqkZGfJ7oERwiajF2aF8evZAzGBPJF3ztA+OQP9iKD1UAxwnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193700; c=relaxed/simple;
	bh=kgsHjUwQwd4rVDKBpPbujkQt0Vy5Zo8ikjpALNVE4RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2toefkt6nS04Sau7s2x5OVdVpdUbGefQPYphBmSwHo96OtB7x97WQxMqqPQ/TKShznmaud66H3MBjksyDTredR5ackIYxgEvk35kdyrTzFeJGcmheIJaiYlzpb2ncYMSLugyBGSIHIs22UfFGzWS6oDXXxjVq0fWP4jss9IJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrNYXage; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710193698; x=1741729698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgsHjUwQwd4rVDKBpPbujkQt0Vy5Zo8ikjpALNVE4RY=;
  b=OrNYXagesYz1dCCxCKPcOGJwF+Q6sEsNg/c7TXfn9qJvr+9f81isz5i1
   15vLy0O7rkj6ACwY74HKga5zPHqmNsOacxbtRoHuTFVTu9HDJtYhdcBiF
   NeW7q/5Pk5Z3MpEnAAXN/TC5ZDwYGGhsZo7vPqR3xv2ToVwowehWCbWjx
   qlyxeCRrjaSEjcPySAnZfcwQOI3QGp8H6VOsaog8GYyRC/DTZr7FlEc3L
   r9BvywAtkId8TSQoYljNEObh45Y52uYeQ19YYh06HteiA/ysEePboWC8e
   mvz2Y9TNmoVj89k+p1AhCnJN+lvgFBzuDp9VryI9ZMytmRWvW+nExC5KE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27355603"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27355603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 14:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="42296937"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2024 14:48:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	x86@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
Date: Mon, 11 Mar 2024 14:32:32 -0700
Message-Id: <20240311213232.128240-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607053558.GC941@sol.localdomain>
References: <20230607053558.GC941@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aesni_set_key() implementation has no error case, yet its prototype
specifies to return an error code.

Modify the function prototype to return void and adjust the related code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Previously, Eric identified a similar case in my AES-KL code [1]. Then,
this parallel issue was realized.

[1]: https://lore.kernel.org/lkml/20230607053558.GC941@sol.localdomain/
---
 arch/x86/crypto/aesni-intel_asm.S  | 5 ++---
 arch/x86/crypto/aesni-intel_glue.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 411d8c83e88a..7ecb55cae3d6 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1820,8 +1820,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 SYM_FUNC_END(_key_expansion_256b)
 
 /*
- * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
- *                   unsigned int key_len)
+ * void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+ *                    unsigned int key_len)
  */
 SYM_FUNC_START(aesni_set_key)
 	FRAME_BEGIN
@@ -1926,7 +1926,6 @@ SYM_FUNC_START(aesni_set_key)
 	sub $0x10, UKEYP
 	cmp TKEYP, KEYP
 	jb .Ldec_key_loop
-	xor AREG, AREG
 #ifndef __x86_64__
 	popl KEYP
 #endif
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index b1d90c25975a..c807b2f48ea3 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -87,8 +87,8 @@ static inline void *aes_align_addr(void *addr)
 	return PTR_ALIGN(addr, AESNI_ALIGN);
 }
 
-asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			     unsigned int key_len);
+asmlinkage void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			      unsigned int key_len);
 asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
@@ -241,7 +241,7 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
 		err = aes_expandkey(ctx, in_key, key_len);
 	else {
 		kernel_fpu_begin();
-		err = aesni_set_key(ctx, in_key, key_len);
+		aesni_set_key(ctx, in_key, key_len);
 		kernel_fpu_end();
 	}
 
-- 
2.34.1


