Return-Path: <linux-kernel+bounces-112096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B558875BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DE91F23DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440582D96;
	Fri, 22 Mar 2024 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ3aJ6Aq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E982C9C;
	Fri, 22 Mar 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149649; cv=none; b=QXUXDNlaVKklfBiSKt2fpuE1MUeJh2XEyioQz5UjhJo+bdb8oh+NKUITSQDVrbIEyyqHBxCkxU+pH7KeET8HkXCQTpMwtiGJFn+2p5gSYa0MYT+1A88YcO+R7wijkD0i99BoeMhs5bFgjkswZBs9AaVOE2dzhTaAkYipW+elZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149649; c=relaxed/simple;
	bh=J1R5X8vTSlAorCGWXVcoIjZ4xXovhj47qBAf0a+X7kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QufTvXRrn7igbey8Vrk7dmEF1coxOC3ubjJ3dJjH7TT54S+npDxCzQBj+6JwI8ZwBFMDBG+m9Vqxv72EeZRE0jHCOsoUBWYw6o8Di5TtLqFfjGnKCpSK3XKXWgb9VFQIWixkIy1WmqAcWGSughCZM0DDHBimZBFe6xl/jwt4tmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ3aJ6Aq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149648; x=1742685648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1R5X8vTSlAorCGWXVcoIjZ4xXovhj47qBAf0a+X7kU=;
  b=kZ3aJ6AqAle4sPw9PuES8gPmy7wZmnSNINeIbnuzbsfr1IV2i3RHwzrd
   FdoDqmzExFtkExpzE84I330yTG6MS8gnEHVZATFZ6OPtbkeEqv3ErGOon
   LdSlSRPkFLwIE9VM8J8JG1uY4cEP4zd8kCBdyaC9UoP0HPPa3HQHx5jx9
   FwMlLQQhsSfIztPZGwD2y/LcE4b8y+J70NxGUxBzZJIVUgJJPl0L9J7mC
   OIgnUih6T9n3HiiRhLmgZ3tn4GxdOUHd8bfNf/fHlHbeije8vhpfcjMVn
   BFohJ0b6PQOZK3ZWq6A9fjFF71NUfmdnsyRTBJmW/OxVfvhorKJ80/Qgi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6408558"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6408558"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19749009"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2024 16:20:47 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	ardb@kernel.org,
	x86@kernel.org,
	chang.seok.bae@intel.com,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 2/2] crypto: x86/aesni - Update aesni_set_key() to return void
Date: Fri, 22 Mar 2024 16:04:59 -0700
Message-Id: <20240322230459.456606-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322230459.456606-1-chang.seok.bae@intel.com>
References: <20240311213232.128240-1-chang.seok.bae@intel.com>
 <20240322230459.456606-1-chang.seok.bae@intel.com>
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
Reviewed-by: Eric Biggers <ebiggers@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2 <- V1:
* Ensure not to return an uninitialized value. (Ard Biesheuvel)

Previously, Eric identified a similar case in my AES-KL code [1]. Then,
this parallel issue was realized.
[1]: https://lore.kernel.org/lkml/20230607053558.GC941@sol.localdomain/
---
 arch/x86/crypto/aesni-intel_asm.S  | 5 ++---
 arch/x86/crypto/aesni-intel_glue.c | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

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
index 8b3b17b065ad..0ea3abaaa645 100644
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
@@ -241,9 +241,9 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
 		return err;
 
 	kernel_fpu_begin();
-	err = aesni_set_key(ctx, in_key, key_len);
+	aesni_set_key(ctx, in_key, key_len);
 	kernel_fpu_end();
-	return err;
+	return 0;
 }
 
 static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
-- 
2.34.1


