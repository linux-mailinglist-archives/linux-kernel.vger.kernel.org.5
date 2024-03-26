Return-Path: <linux-kernel+bounces-118508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96B88BBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B28E1C34C70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42115137755;
	Tue, 26 Mar 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4KcKZBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060F13664E;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440365; cv=none; b=hWYC6fQZDImJ4+QnUqdrLvlCdvScfDCtn0KGb9cpH2XyReSN1zXhy8ZQu6Qd1DoXzFuCsJFPJ0tHZatVA/8IeRWqBc1/UQ027LVOrm2P00R93Hn7PBcUlhQd6O/GNAtopvFCAvl6SgD6vZIcCnzRr7zfMaCNxuU4nwzm87gNfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440365; c=relaxed/simple;
	bh=ZlxDvu9l7nXvQJFAq2dKxijHSNJoP2+Pk3O48836x94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZUhsBWg+JDsW3gAR3OtdlOAEpDEeJUgU7iD4w2niacXkFXf6cnEskbWiyWfxiTf8LMOAh2Nw4rfHs9gvOd/ES9q05qaC+g/D8YaobvYIPYd+pFEuAlx7BDUHCqtsx+SjjiG9uLNQtCaiRtW0lfO8z2/9whmDADLkd9FMSJH9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4KcKZBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F71C3278B;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711440364;
	bh=ZlxDvu9l7nXvQJFAq2dKxijHSNJoP2+Pk3O48836x94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4KcKZBM2G6Qk7FZnb50z68YbUTHN5CRMPKrjC/0cGBPlSBEkwOqAkrn7IVaZGIsR
	 Dn4rDmDtaHefrljTmmPSVuJhdSvxPddDfViTTuvi5vHRLZPqnVnARK8FGCrL8gvoAl
	 OLjwITM8kb0jYXxW3osyQ3HdfvFaH2S9xisY/YPI4hcOaxFDg8S39aG0nT+0XZ+1g4
	 ma2h0nCypRPFYrzm8GHJlS3vNqxLP45/SXMAeRoXoUUznYyUKe/Y5cGy6KR0zxf6mg
	 KdBjX2sSsrxv5M/4iCEWn5rD7ZMLs+F7KBuFTQhzX5Aqwd8sXEAj9eeZ/LGekY12uN
	 Gbctuzqm7UwEA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 6/6] crypto: x86/aes-xts - wire up VAES + AVX10/512 implementation
Date: Tue, 26 Mar 2024 01:03:04 -0700
Message-ID: <20240326080305.402382-7-ebiggers@kernel.org>
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

Add an AES-XTS implementation "xts-aes-vaes-avx10_512" for x86_64 CPUs
with the VAES, VPCLMULQDQ, and either AVX10/512 or AVX512BW + AVX512VL
extensions.  This implementation uses zmm registers to operate on four
AES blocks at a time.  The assembly code is instantiated using a macro
so that most of the source code is shared with other implementations.

To avoid downclocking on older Intel CPU models, an exclusion list is
used to prevent this 512-bit implementation from being used by default
on some CPU models.  They will use xts-aes-vaes-avx10_256 instead.  For
now, this exclusion list is simply coded into aesni-intel_glue.c.  It
may make sense to eventually move it into a more central location.

xts-aes-vaes-avx10_512 is slightly faster than xts-aes-vaes-avx10_256 on
some current CPUs.  E.g., on Intel Sapphire Rapids, AES-256-XTS
decryption throughput increases by 5.6% with 4096-byte inputs, or 8.9%
with 512-byte inputs.  On AMD Genoa, AES-256-XTS decryption throughput
increases by 15.3% with 4096-byte inputs, or 7.6% with 512-byte inputs.

Future CPUs may provide stronger 512-bit support, in which case a larger
benefit should be seen.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S |  9 ++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 33 +++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index c868b9af443b..024fc12c9a94 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -782,6 +782,15 @@ SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx10_256)
 	aes_xts_crypt	1
 SYM_FUNC_END(aes_xts_encrypt_vaes_avx10_256)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx10_256)
 	aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_vaes_avx10_256)
+
+.set	VL, 64
+.set	USE_AVX10, 1
+SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx10_512)
+	aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_vaes_avx10_512)
+SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx10_512)
+	aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_vaes_avx10_512)
 #endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index ac45e0b952b7..49b259dff81f 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1296,12 +1296,32 @@ static struct simd_skcipher_alg *aes_xts_simdalg_##suffix
 
 DEFINE_XTS_ALG(aesni_avx, "xts-aes-aesni-avx", 500);
 #if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_XTS_ALG(vaes_avx2, "xts-aes-vaes-avx2", 600);
 DEFINE_XTS_ALG(vaes_avx10_256, "xts-aes-vaes-avx10_256", 700);
+DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
 #endif
 
+/*
+ * This is a list of CPU models that are known to suffer from downclocking when
+ * zmm registers (512-bit vectors) are used.  On these CPUs, the AES-XTS
+ * implementation with zmm registers won't be used by default.  An
+ * implementation with ymm registers (256-bit vectors) will be used instead.
+ */
+static const struct x86_cpu_id zmm_exclusion_list[] = {
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_SKYLAKE_X },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_X },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_D },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_L },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_NNPI },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE_L },
+	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE },
+	/* Allow Rocket Lake and later, and Sapphire Rapids and later. */
+	/* Also allow AMD CPUs (starting with Zen 4, the first with AVX-512). */
+};
+
 static int __init register_xts_algs(void)
 {
 	int err;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
@@ -1331,11 +1351,19 @@ static int __init register_xts_algs(void)
 
 	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_256, 1,
 					     &aes_xts_simdalg_vaes_avx10_256);
 	if (err)
 		return err;
-#endif
+
+	if (x86_match_cpu(zmm_exclusion_list))
+		aes_xts_alg_vaes_avx10_512.base.cra_priority = 1;
+
+	err = simd_register_skciphers_compat(&aes_xts_alg_vaes_avx10_512, 1,
+					     &aes_xts_simdalg_vaes_avx10_512);
+	if (err)
+		return err;
+#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
 	return 0;
 }
 
 static void unregister_xts_algs(void)
 {
@@ -1346,10 +1374,13 @@ static void unregister_xts_algs(void)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
 					  &aes_xts_simdalg_vaes_avx2);
 	if (aes_xts_simdalg_vaes_avx10_256)
 		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_256, 1,
 					  &aes_xts_simdalg_vaes_avx10_256);
+	if (aes_xts_simdalg_vaes_avx10_512)
+		simd_unregister_skciphers(&aes_xts_alg_vaes_avx10_512, 1,
+					  &aes_xts_simdalg_vaes_avx10_512);
 }
 #else
 static int __init register_xts_algs(void)
 {
 	return 0;
-- 
2.44.0


