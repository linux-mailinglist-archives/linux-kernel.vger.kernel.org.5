Return-Path: <linux-kernel+bounces-118507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9610A88BBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A54A2A6A56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89A137750;
	Tue, 26 Mar 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVJNUu9I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B4135A4F;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440364; cv=none; b=EkMn7BbxHcRoBhRC+QV0miIRRrxKHBDwz93PIVg4BREV11/DO5RUuzq4lousLHhjSuxDTQS+r/hLgQy7skf3jWxc9Ci0gUaH0/iGPW0vEPbyJSF0y5+x7O/G0JiG0ue1lpwv9y4zBbnp3bXU/xhyA+HKlyrdDpDIjRXmpavl3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440364; c=relaxed/simple;
	bh=/F4IYNjZkp5goJ240YloVO4ChNfJNLy2L2HjVpkOVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE6JJuB+NljdRpw8NItSyc9EOW/XeJq/NrstptyliydSfdEhSKdIYTgXJ+PvmECuZLX0/2cOq5JdRZDbvdif67mSqQufMSWtGZi2D2WWtwMx7QrZJtCGF2md50BjHSP+ovKmo0TktdquQWWNxDiB2crayRyf+8pqQp1vaJr4Hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVJNUu9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B619C43394;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711440364;
	bh=/F4IYNjZkp5goJ240YloVO4ChNfJNLy2L2HjVpkOVpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVJNUu9Ize3Q/PEpbnxSqqjqTeRfSpw7BQKUd3j7GFH65pUE6XR8czkFs/UF/sXE+
	 FkBFcQ0q4j0SYU+GGylxWSsZI7eojaM/VpTFyX/1BKjiE5eoY2eQ+NvmT8dooZw8Xb
	 by5Gaf6f0gVAyHE9C/Nme4a1w7vQIuzqpVDFb+1i4wwXq8VQ1gUch6/DOow3xEeZrL
	 nYCd9RcqlrCGqbCxX9bRLsfaHluu6Xp+Qwlp/U5db3ipPbduMOYd9jy1J59tn6vBZ/
	 XARTnl1XXWyjxLJwWCTBqwAbrwigCS+bwGP/Vk3HBe52+0pDvf4T0AaJcVmri0nG1j
	 kp9eO1twbzt3Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 5/6] crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
Date: Tue, 26 Mar 2024 01:03:03 -0700
Message-ID: <20240326080305.402382-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326080305.402382-1-ebiggers@kernel.org>
References: <20240326080305.402382-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add an AES-XTS implementation "xts-aes-vaes-avx10_256" for x86_64 CPUs
with the VAES, VPCLMULQDQ, and either AVX10/256 or AVX512BW + AVX512VL
extensions.  This implementation avoids using zmm registers, instead
using ymm registers to operate on two AES blocks at a time.  The
assembly code is instantiated using a macro so that most of the source
code is shared with other implementations.

This is the optimal implementation on CPUs that support VAES and AVX512
but where the zmm registers should not be used due to downclocking
effects, for example Intel's Ice Lake.  It should also be the optimal
implementation on future CPUs that support AVX10/256 but not AVX10/512.

The performance is slightly better than that of xts-aes-vaes-avx2, which
uses the same vector length, due to factors such as being able to use
ymm16-ymm31 to cache the AES round keys.  For example, on Ice Lake, the
throughput of decrypting 4096-byte messages with AES-256-XTS is 5.8%
higher with xts-aes-vaes-avx10_256 than with xts-aes-vaes-avx2.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S |  9 +++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 87ae2139b7ca..c868b9af443b 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -773,6 +773,15 @@ SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx2)
 	aes_xts_crypt	1
 SYM_FUNC_END(aes_xts_encrypt_vaes_avx2)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx2)
 	aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_vaes_avx2)
+
+.set	VL, 32
+.set	USE_AVX10, 1
+SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx10_256)
+	aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_vaes_avx10_256)
+SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx10_256)
+	aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_vaes_avx10_256)
 #endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index d958aa073c14..ac45e0b952b7 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1295,10 +1295,11 @@ static struct skcipher_alg aes_xts_alg_##suffix = {			       \
 static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
+DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
 #endif
 
 static int __init register_xts_algs(void)
 {
 	int err;
@@ -1318,10 +1319,22 @@ static int __init register_xts_algs(void)
 		return 0;
 	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx2, 1,
 					     &aes_xts_simdalg_vaes_avx2);
 	if (err)
 		return err;
+
+	if (!boot_cpu_has(X86_FEATURE_AVX512BW) ||
+	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||
+	    !boot_cpu_has(X86_FEATURE_BMI2) ||
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
+			       XFEATURE_MASK_AVX512, NULL))
+		return 0;
+
+	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_256, 1,
+					     &aes_xts_simdalg_vaes_avx10_256);
+	if (err)
+		return err;
 #endif
 	return 0;
 }
 
 static void unregister_xts_algs(void)
@@ -1330,10 +1343,13 @@ static void unregister_xts_algs(void)
 		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
 					  &aes_xts_simdalg_aesni_avx);
 	if (aes_xts_simdalg_vaes_avx2)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
 					  &aes_xts_simdalg_vaes_avx2);
+	if (aes_xts_simdalg_vaes_avx10_256)
+		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_256, 1,
+					  &aes_xts_simdalg_vaes_avx10_256);
 }
 #else
 static int __init register_xts_algs(void)
 {
 	return 0;
-- 
2.44.0


