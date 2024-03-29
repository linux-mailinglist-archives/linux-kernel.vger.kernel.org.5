Return-Path: <linux-kernel+bounces-124282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938D89150B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91591F233BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1785467F;
	Fri, 29 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLGpHiJw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8B4F606;
	Fri, 29 Mar 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699561; cv=none; b=L1P6tAn+IlEFJjB1kFzS8+I2eju00SssDkAVvHQ5mxWCHaTlqW1tLnpWHeqgwcQRT8k/PmirspSLlXkiXlgOKdJ/4m1cYFBHJdrq89HtB5hF/e4neFecQYewQWMvFJkML62tmlcpBDbngtrXp+l8f5JOykCe6mcySNcsCZzsf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699561; c=relaxed/simple;
	bh=cwKbsRa5+4j6tLRcb2nECqjE6MrPiyU1VuI5Llnpq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkFKP+uNE2WMAYH1MuMYymT2/9gnI6ZJ8cUwopPUZYkLngtoxyFUaphIRDBIIqU4vJ7aeUh3QvEssqmXKl/gcGgGhSapdCOUXatJSaCA218klo+vF3Cn/NKQNl0RMN0j2WCE7W27jZI2xasq+WUYKM03ZSSrHeveHR04/t+8Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLGpHiJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927BC43330;
	Fri, 29 Mar 2024 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699561;
	bh=cwKbsRa5+4j6tLRcb2nECqjE6MrPiyU1VuI5Llnpq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLGpHiJwGP7HnGCEjv+ea2lYxIZ3b4yd9A+sA7N9evLlU0HhCYnT8eXjL1ReL7QgO
	 uCTigWDeR1Lbm7SrU2AT5J6aPybD553fJnYlWO0rjZREklW9yH/NjweP+jbWcB6Swk
	 4u4Z8Dk3cg9Ctga9KktcJMLLf53SmGNDAJ/bFDLLHN+jGTB35f96yWpR5h0Jfx7PXM
	 tYFIDXDszGcEZDoXB8xWiTw+TAPql5qVNsmGOmgPP4ABZTVuJ2LjpCRUtgksrwrrZM
	 85gwKD6B9Z19kVH/XSdpBP7h10hXuIY9TnfTQkdlqQ4fdmfG2A9itPlPyDbXvy62ag
	 jwCUZSzSleqPw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH v2 5/6] crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
Date: Fri, 29 Mar 2024 01:03:53 -0700
Message-ID: <20240329080355.2871-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329080355.2871-1-ebiggers@kernel.org>
References: <20240329080355.2871-1-ebiggers@kernel.org>
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
uses the same 256-bit vector length, due to factors such as being able
to use ymm16-ymm31 to cache the AES round keys, and being able to use
the vpternlogd instruction to do XORs more efficiently.  For example, on
Ice Lake, the throughput of decrypting 4096-byte messages with
AES-256-XTS is 6.6% higher with xts-aes-vaes-avx10_256 than with
xts-aes-vaes-avx2.  While this is a small improvement, it is
straightforward to provide this implementation (xts-aes-vaes-avx10_256)
as long as we are providing xts-aes-vaes-avx2 and xts-aes-vaes-avx10_512
anyway, due to the way the _aes_xts_crypt macro is structured.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S |  9 +++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 43706213dfca..71be474b22da 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -815,6 +815,15 @@ SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx2)
 	_aes_xts_crypt	1
 SYM_FUNC_END(aes_xts_encrypt_vaes_avx2)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx2)
 	_aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_vaes_avx2)
+
+.set	VL, 32
+.set	USE_AVX10, 1
+SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx10_256)
+	_aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_vaes_avx10_256)
+SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx10_256)
+	_aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_vaes_avx10_256)
 #endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 4cc15c7207f3..914cbf5d1f5c 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1297,10 +1297,11 @@ static struct skcipher_alg aes_xts_alg_##suffix = {			       \
 static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
+DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
 #endif
 
 static int __init register_xts_algs(void)
 {
 	int err;
@@ -1320,10 +1321,22 @@ static int __init register_xts_algs(void)
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
 #endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
 	return 0;
 }
 
 static void unregister_xts_algs(void)
@@ -1333,10 +1346,13 @@ static void unregister_xts_algs(void)
 					  &aes_xts_simdalg_aesni_avx);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 	if (aes_xts_simdalg_vaes_avx2)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
 					  &aes_xts_simdalg_vaes_avx2);
+	if (aes_xts_simdalg_vaes_avx10_256)
+		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_256, 1,
+					  &aes_xts_simdalg_vaes_avx10_256);
 #endif
 }
 #else /* CONFIG_X86_64 */
 static int __init register_xts_algs(void)
 {
-- 
2.44.0


