Return-Path: <linux-kernel+bounces-124281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430CE891506
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748731C23DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B35024E;
	Fri, 29 Mar 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFMPdobM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAD4AEE7;
	Fri, 29 Mar 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699561; cv=none; b=gEDrmvYZUSZCodr6fHF6svTJ9rQwAaEXI8tbj8HYpVhJshEkkY2yQToWRLwNoQR3ldnzB/QnQCO40LlMuwd7kvwteaphPPAYpxuFGJZv3TDTG9OjNv8Bh/3armFdpAY4hP2nTZdm+uHdj1jXjWT3klRmfgkcNgEofAiyWbEdt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699561; c=relaxed/simple;
	bh=hTPh4ID7+uT08Pmb9pplREzEU5MITK5DEdwRz0lQl4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcQTcEXf+XN+tXAjkw/i6cfXFpQK9CBjdMSS7z346bGKJnEmKZJQVjNSHhGl9HuS+3HjjlBGNRJTxZgZl/9zuCm1U8nba8G1RQJGNCUVXQVO6HPALTX7SS8oH3wBmGneWDw0M55X/yotce487s3/ZbMY+jWoJTfVUib5rBg2YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFMPdobM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E814BC4166B;
	Fri, 29 Mar 2024 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699561;
	bh=hTPh4ID7+uT08Pmb9pplREzEU5MITK5DEdwRz0lQl4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFMPdobMJkjyiBcIo8vJP6EswCgS5VZi3eC6JbUfvkR1DrIlSFkxEBl2Ve2zzsnjg
	 fw0o2kJaFbgM4N3rpNsJmcUcx2TczISBqw8qI3viBOIeSptzOPIj23roRgKTHf1mR2
	 KqbMwKpsRKmxt0dK9+DieMm0kSL3HJqj2Q6PvnQquZocFPPaSZsNtgpBuc7N6vEC0V
	 U9oZuZTrTnqJLlOLqwYSPUqqlG/+pZBdh7zqJ5GzWRrfIfU7cOL9VeTc5pBIsb+XA/
	 L6s8p4L0EEFniUJuGmO4jEJuRTge/B2YZtdz22OHcohcfnKzZeur0Kx0GMNhKMpF2Q
	 5jhlRiAijcZ0g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH v2 4/6] crypto: x86/aes-xts - wire up VAES + AVX2 implementation
Date: Fri, 29 Mar 2024 01:03:52 -0700
Message-ID: <20240329080355.2871-5-ebiggers@kernel.org>
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

Add an AES-XTS implementation "xts-aes-vaes-avx2" for x86_64 CPUs with
the VAES, VPCLMULQDQ, and AVX2 extensions, but not AVX512 or AVX10.
This implementation uses ymm registers to operate on two AES blocks at a
time.  The assembly code is instantiated using a macro so that most of
the source code is shared with other implementations.

This is the optimal implementation on AMD Zen 3.  It should also be the
optimal implementation on Intel Alder Lake, which similarly supports
VAES but not AVX512.  Comparing to xts-aes-aesni-avx on Zen 3,
xts-aes-vaes-avx2 provides 70% higher AES-256-XTS decryption throughput
with 4096-byte messages, or 23% higher with 512-byte messages.

A large improvement is also seen with CPUs that do support AVX512 (e.g.,
98% higher AES-256-XTS decryption throughput on Ice Lake with 4096-byte
messages), though the following patches add AVX512 optimized
implementations to get a bit more performance on those CPUs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 11 +++++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 32e26f562cf0..43706213dfca 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -805,5 +805,16 @@ SYM_TYPED_FUNC_START(aes_xts_encrypt_aesni_avx)
 	_aes_xts_crypt	1
 SYM_FUNC_END(aes_xts_encrypt_aesni_avx)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_aesni_avx)
 	_aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_aesni_avx)
+
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+.set	VL, 32
+.set	USE_AVX10, 0
+SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx2)
+	_aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_vaes_avx2)
+SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx2)
+	_aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_vaes_avx2)
+#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 10e283721a85..4cc15c7207f3 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1295,10 +1295,13 @@ static struct skcipher_alg aes_xts_alg_##suffix = {			       \
 };									       \
 									       \
 static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
+#endif
 
 static int __init register_xts_algs(void)
 {
 	int err;
 
@@ -1306,18 +1309,35 @@ static int __init register_xts_algs(void)
 		return 0;
 	err = simd_register_skciphers_compat(&aes_xts_alg_aesni_avx, 1,
 					     &aes_xts_simdalg_aesni_avx);
 	if (err)
 		return err;
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
+	    !boot_cpu_has(X86_FEATURE_VAES) ||
+	    !boot_cpu_has(X86_FEATURE_VPCLMULQDQ) ||
+	    !boot_cpu_has(X86_FEATURE_PCLMULQDQ) ||
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+		return 0;
+	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx2, 1,
+					     &aes_xts_simdalg_vaes_avx2);
+	if (err)
+		return err;
+#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
 	return 0;
 }
 
 static void unregister_xts_algs(void)
 {
 	if (aes_xts_simdalg_aesni_avx)
 		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
 					  &aes_xts_simdalg_aesni_avx);
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+	if (aes_xts_simdalg_vaes_avx2)
+		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
+					  &aes_xts_simdalg_vaes_avx2);
+#endif
 }
 #else /* CONFIG_X86_64 */
 static int __init register_xts_algs(void)
 {
 	return 0;
-- 
2.44.0


