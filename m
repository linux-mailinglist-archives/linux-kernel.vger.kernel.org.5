Return-Path: <linux-kernel+bounces-118506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23E88BBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4672A6E28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A8135A6D;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5+jIEae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A781134419;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440364; cv=none; b=bwAp5WR17wVTj5wgAsiCB42zsH1E20VgM8z34UGo4oiaeSxiLZMRFLUtp+ZZIbyWp5y0mHfZulKVJKH4ZOsWs6YrFYSx57IplKWpkc3pCMi9zS77eWkIgL1LxiveeGXtrK7M0CURC/bQikmmktwWhV1opMfXZqtkZXsQz8kfyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440364; c=relaxed/simple;
	bh=w5K6xVfYR5E60XvzxChAqfFSyXXfCltz6Uub4kp+Bv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXsSc0cDcYoWawt3OZ9CGW1vfh38bj9Y8kvRhOV7k1twkjW0T0hKplzpfCds++B5tsj58AuiHUdju+EPYXPDn6kkJs03JoBEkt6K8nPL6NjfhpbcOccw0iKpIEvoqzWEc17TY9X/I47JIogLXzU8XppcXiMlRi8RiUBwG1g9I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5+jIEae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2D0C43330;
	Tue, 26 Mar 2024 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711440363;
	bh=w5K6xVfYR5E60XvzxChAqfFSyXXfCltz6Uub4kp+Bv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5+jIEaem7qWbZa4D9mVmDHzB1bEC1al+YjN7KqAQYvufZfN/JjCn8jhkiYUVV2rO
	 XmrhwjkslKHcL0EIZLugZZ9Oobr559gIK1ImD6y8U4f+nsoce+OAFdnSoDzsx9Hcv/
	 W8BNOocvdI8l32fMwxRlMX02EHsnAIjXu6IzAYnFUEjJIvh9FYaEafikHwKlFCLe22
	 pwQZwTu6UtVMyFYBfg4mN0DNiHIY57LTuyu6hDz3JhwL4fuJzABkZh/wmuD79mzkec
	 QbQV4q4BX3cfNKlswa63Bdr4/viMfOjULlp98w0z57qT6nrgShVviNK2y2XYAMIr6R
	 Oe0EJIRJml88A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 4/6] crypto: x86/aes-xts - wire up VAES + AVX2 implementation
Date: Tue, 26 Mar 2024 01:03:02 -0700
Message-ID: <20240326080305.402382-5-ebiggers@kernel.org>
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

Add an AES-XTS implementation "xts-aes-vaes-avx2" for x86_64 CPUs with
the VAES, VPCLMULQDQ, and AVX2 extensions, but not AVX512 or AVX10.
This implementation uses ymm registers to operate on two AES blocks at a
time.  The assembly code is instantiated using a macro so that most of
the source code is shared with other implementations.

This is the optimal implementation on AMD Zen 3.  It should also be the
optimal implementation on Intel Alder Lake, which similarly supports
VAES but not AVX512.  Comparing to xts-aes-aesni-avx on Zen 3,
xts-aes-vaes-avx2 provides 51% higher AES-256-XTS decryption throughput
with 4096-byte messages, or 19% higher with 512-byte messages.

A large improvement is also seen with CPUs that do support AVX512 (e.g.,
74% higher AES-256-XTS decryption throughput on Ice Lake with 4096-byte
messages), though the following patches add AVX512 optimized
implementations to get a bit more performance on those CPUs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 11 +++++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index a8003fea97b7..87ae2139b7ca 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -763,5 +763,16 @@ SYM_TYPED_FUNC_START(aes_xts_encrypt_aesni_avx)
 	aes_xts_crypt	1
 SYM_FUNC_END(aes_xts_encrypt_aesni_avx)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_aesni_avx)
 	aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_aesni_avx)
+
+#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+.set	VL, 32
+.set	USE_AVX10, 0
+SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx2)
+	aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_vaes_avx2)
+SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx2)
+	aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_vaes_avx2)
+#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index d5e33c396b3e..d958aa073c14 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1293,10 +1293,13 @@ static struct skcipher_alg aes_xts_alg_##suffix = {			       \
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
 
@@ -1304,18 +1307,33 @@ static int __init register_xts_algs(void)
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
+#endif
 	return 0;
 }
 
 static void unregister_xts_algs(void)
 {
 	if (aes_xts_simdalg_aesni_avx)
 		simd_unregister_skciphers(&aes_xts_alg_aesni_avx, 1,
 					  &aes_xts_simdalg_aesni_avx);
+	if (aes_xts_simdalg_vaes_avx2)
+		simd_unregister_skciphers(&aes_xts_alg_vaes_avx2, 1,
+					  &aes_xts_simdalg_vaes_avx2);
 }
 #else
 static int __init register_xts_algs(void)
 {
 	return 0;
-- 
2.44.0


