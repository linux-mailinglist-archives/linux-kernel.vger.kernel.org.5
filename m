Return-Path: <linux-kernel+bounces-124047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3E891185
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AEE293339
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4B3FB3F;
	Fri, 29 Mar 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQnQ4B4C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207244C63;
	Fri, 29 Mar 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678204; cv=none; b=uMy+MkafhhtaFoPZ04k64NrhwACpFPvNBw7zdOlxUQUk1OZDCnAnuFw6xLE9Jvw15OGLBPxb10G6G1pG+2kCqwfrinQjAvWRCLpDJyg9J9EE9ROnjYFkDkhpkuGHeN+GzshIKWq6udx/i57TZZhWwCKKU7bVIMosISpaYIGZo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678204; c=relaxed/simple;
	bh=1LDGQG8Tv2hZlx4EpDC4r0s9O2jkinHHSZjPSmJhxNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1ywNdezDsybGgCDIvC2lupSsygT62tSLLxmv+DbeW2C9arRtxjn0+O3Uz9fu0gb2gfG771OER9UvVr72NmkzS//jmvsC9arK02xH39DSvq46Y9Rc6bkUpaxTgoOllzNWRWGLdmGwf8oQJnpVKVwyhFNHGev4RC9UJK/GQ9c1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQnQ4B4C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678202; x=1743214202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1LDGQG8Tv2hZlx4EpDC4r0s9O2jkinHHSZjPSmJhxNE=;
  b=aQnQ4B4CbSVVFgWSqhn6BdQ79uEYypph+ESYl0edKfloc4gt/vdgMeFO
   o6o7478hz5koEmAIDLhtVcSn0XESqRIxbjBL0maIFvdY8qtkPMNBCyme/
   huzxzTyzMLe4qbciZXMTYGvbJFQ7LApi80ZdGM1trsvQ4AoPf7hpI8cEh
   /y+gIB+bdSaXbUR1UjhxUDPZl9vN7LhRKXnN16hCVZoLN+nWxblc41IoR
   velVM8ystoJkMHxovFClrT807tVuqWKqLQRZxSomIS4qOzYmU1X3INErp
   dg7O7K3gwMs45mK/sq02kfGyyBP1hKA/XHZ3i6wUKEFUoJNLQ2+R6djue
   w==;
X-CSE-ConnectionGUID: R6el/fnyQMa1TGBcBMpLOA==
X-CSE-MsgGUID: E0ZfMyEVRn6rjvtNEP4WPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700147"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301436"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:54 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 14/14] crypto: x86/aes-kl - Implement the AES-XTS algorithm
Date: Thu, 28 Mar 2024 18:53:46 -0700
Message-Id: <20240329015346.635933-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Key Locker is a CPU feature to reduce key exfiltration opportunities.
It converts the AES key into an encoded form, called 'key handle', to
reduce the exposure of private key material in memory.

This key conversion as well as all subsequent data transformations are
provided by new AES instructions ('AES-KL'). AES-KL is analogous to
that of AES-NI as maintains a similar programming interface.

Support the XTS mode as the primary use case is dm-crypt. The support has
some details worth mentioning, which differentiate itself from AES-NI,
that users may need to be aware of:

== Key Handle Restriction ==

The AES-KL instruction set supports selecting key usage restrictions at
key handle creation time. Restrict all key handles created by the kernel
to kernel mode use only.

The AES-KL instructions themselves are executable in userspace. This
restriction enforces the mode consistency in its operation.

If the key handle is created in userspace but referenced in the kernel,
then encrypt() and decrypt() functions will return -EINVAL.

=== AES-NI Dependency for AES Compliance ===

Key Locker is not AES compliant as it lacks 192-bit key support.
However, per the expectations of Linux crypto-cipher implementations,
the software cipher implementation must support all the AES-compliant
key sizes.

The AES-KL cipher implementation achieves this constraint by logging a
warning and falling back to AES-NI. In other words, the 192-bit
key-size limitation for what can be converted into a key handle is
only documented, not enforced.

This then creates a rather strong dependency on AES-NI. If this driver
supports a module build, the exported AES-NI functions cannot be inlined.
More importantly, indirect calls will impact the performance.

To simplify, disallow a module build for AES-KL and always select AES-NI.
This restriction can be relaxed if strong use cases arise against it.

== Wrapping Key Restore Failure Handling ==

In the event of hardware failure, the wrapping key is lost from deep
sleep states. Then, the wrapping key turns to zero which is an unusable
state.

The x86 core provides valid_keylocker() to indicate the failure.
Subsequent setkey() as well as encode()/decode() can check it and return
-ENODEV if failed. In this way, an error code can be returned, instead of
facing abrupt exceptions.

== Userspace Exposition ==

The Keylocker implementations so far have measurable performance
penalties. So, keep AES-NI as the default.

However, with a slow storage device, storage bandwidth is the bottleneck,
even if disk encryption is enabled by AES-KL. Thus, it is an end-user
consideration for selecting AES-KL. Users may pick it according to the
name 'xts-aes-aeskl' shown in /proc/crypto.

== 64-bit Only ==

Support 64-bit only, as the 32-bit kernel is being deprecated.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
Changes from v8:
* Rebase on the upstream changes.
* Combine the XTS enc/dec assembly code in a macro. (Eric Biggers)
* Define setkey() as void instead of returning 'int'. (Eric Biggers)
* Rearrange the assembly code to reduce jumps especially for success
  cases. (Eric Biggers)
* Update the changelog for clarification. (Eric Biggers)
* Exclude module build.

Changes from v7:
* Update the changelog -- remove 'API Limitation'. (Eric Biggers)
* Update the comment for valid_keylocker(). (Eric Biggers)
* Improve the code:
  - Remove the key-length check and simplify the code. (Eric Biggers)
  - Remove aeskl_dec() and __aeskl_dec() as not needed.
  - Simplify the register-function return handling. (Eric Biggers)
  - Rename setkey functions for coherent naming:
    aeskl_setkey() -> __aeskl_setkey(),
    aeskl_setkey_common() -> aeskl_setkey(),
    aeskl_xts_setkey() -> xts_setkey()
  - Revert an unnecessary comment.

Changes from v6:
* Merge all the AES-KL patches. (Eric Biggers)
* Make the driver for the 64-bit mode only. (Eric Biggers)
* Rework the key-size check code:
  - Trim unnecessary checks. (Eric Biggers)
  - Document the reason
  - Make sure both XTS keys with the same size
* Adjust the Kconfig change:
  - Move the location. (Robert Elliott)
  - Trim the description to follow others such as AES-NI.
* Update the changelog:
  - Explain the priority value for the common name under 'User
    Exposition' (renamed from 'Performance'). (Eric Biggers)
  - Trim the introduction
  - Switch to more imperative mood for those explaining the code
    change
  - Add a new section '64-bit Only'
* Adjust the ASM code to return a proper error code. (Eric Biggers)
* Update assembly code macros:
  - Remove unused one.
  - Document the reason for the duplicated ones.

Changes from v5:
* Replace the ret instruction with RET as rebased on the upstream -- commit
  f94909ceb1ed ("x86: Prepare asm files for straight-line-speculation").

Changes from v3:
* Exclude non-AES-KL objects. (Eric Biggers)
* Simplify the assembler dependency check. (Peter Zijlstra)
* Trim the Kconfig help text. (Dan Williams)
* Fix a defined-but-not-used warning.

Changes from RFC v2:
* Move out each mode support in new patches.
* Update the changelog to describe the limitation and the tradeoff
  clearly. (Andy Lutomirski)

Changes from RFC v1:
* Rebased on the refactored code. (Ard Biesheuvel)
* Dropped exporting the single block interface. (Ard Biesheuvel)
* Fixed the fallback and error handling paths. (Ard Biesheuvel)
* Revised the module description. (Dave Hansen and Peter Zijlstra)
* Made the build depend on the binutils version to support new
  instructions. (Borislav Petkov and Peter Zijlstra)
* Updated the changelog accordingly.
---
 arch/x86/Kconfig.assembler         |   5 +
 arch/x86/crypto/Kconfig            |  17 ++
 arch/x86/crypto/Makefile           |   3 +
 arch/x86/crypto/aes-helper_glue.h  |   7 +-
 arch/x86/crypto/aeskl-intel_asm.S  | 412 +++++++++++++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c | 187 +++++++++++++
 arch/x86/crypto/aeskl-intel_glue.h |  35 +++
 arch/x86/crypto/aesni-intel_glue.c |  30 +--
 arch/x86/crypto/aesni-intel_glue.h |  40 +++
 9 files changed, 704 insertions(+), 32 deletions(-)
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.h
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 8ad41da301e5..0e58f2b61dd3 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -25,6 +25,11 @@ config AS_GFNI
 	help
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
 
+config AS_HAS_KEYLOCKER
+	def_bool $(as-instr,encodekey256 %eax$(comma)%eax)
+	help
+	  Supported by binutils >= 2.36 and LLVM integrated assembler >= V12
+
 config AS_WRUSS
 	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
 	help
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index c9e59589a1ce..067bb149998b 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -29,6 +29,23 @@ config CRYPTO_AES_NI_INTEL
 	  Architecture: x86 (32-bit and 64-bit) using:
 	  - AES-NI (AES new instructions)
 
+config CRYPTO_AES_KL
+	bool "Ciphers: AES, modes: XTS (AES-KL)"
+	depends on X86 && 64BIT
+	depends on AS_HAS_KEYLOCKER
+	select CRYPTO_AES_NI_INTEL
+	select X86_KEYLOCKER
+
+	help
+	  Block cipher: AES cipher algorithms
+	  Length-preserving ciphers: AES with XTS
+
+	  Architecture: x86 (64-bit) using:
+	  - AES-KL (AES Key Locker)
+	  - AES-NI for a 192-bit key
+
+	  See Documentation/arch/x86/keylocker.rst for more details.
+
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
 	depends on X86 && 64BIT
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 9aa46093c91b..ae2aa7abd151 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -50,6 +50,9 @@ obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
 
+obj-$(CONFIG_CRYPTO_AES_KL) += aeskl-intel.o
+aeskl-intel-y := aeskl-intel_asm.o aeskl-intel_glue.o
+
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
 sha1-ssse3-y := sha1_avx2_x86_64_asm.o sha1_ssse3_asm.o sha1_ssse3_glue.o
 sha1-ssse3-$(CONFIG_AS_SHA1_NI) += sha1_ni_asm.o
diff --git a/arch/x86/crypto/aes-helper_glue.h b/arch/x86/crypto/aes-helper_glue.h
index 52ba1fe5cf71..262c1cec0011 100644
--- a/arch/x86/crypto/aes-helper_glue.h
+++ b/arch/x86/crypto/aes-helper_glue.h
@@ -19,16 +19,17 @@
 #include <crypto/internal/aead.h>
 #include <crypto/internal/simd.h>
 
+#include "aeskl-intel_glue.h"
+
 #define AES_ALIGN		16
 #define AES_ALIGN_ATTR		__attribute__((__aligned__(AES_ALIGN)))
 #define AES_ALIGN_EXTRA		((AES_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
 #define XTS_AES_CTX_SIZE	(sizeof(struct aes_xts_ctx) + AES_ALIGN_EXTRA)
 
-/*
- * Preserve data types for various AES implementations available in x86
- */
+/* Data types for the two AES implementations available in x86 */
 union x86_aes_ctx {
 	struct crypto_aes_ctx aesni;
+	struct aeskl_ctx aeskl;
 };
 
 struct aes_xts_ctx {
diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
new file mode 100644
index 000000000000..81af7f61aab5
--- /dev/null
+++ b/arch/x86/crypto/aeskl-intel_asm.S
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Implement AES algorithm using AES Key Locker instructions.
+ *
+ * Most code is based from the AES-NI implementation, aesni-intel_asm.S
+ *
+ */
+
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <asm/errno.h>
+#include <asm/inst.h>
+#include <asm/frame.h>
+#include "aes-helper_asm.S"
+
+.text
+
+#define STATE1	%xmm0
+#define STATE2	%xmm1
+#define STATE3	%xmm2
+#define STATE4	%xmm3
+#define STATE5	%xmm4
+#define STATE6	%xmm5
+#define STATE7	%xmm6
+#define STATE8	%xmm7
+#define STATE	STATE1
+
+#define IV	%xmm9
+#define KEY	%xmm10
+#define INC	%xmm13
+
+#define IN	%xmm8
+
+#define HANDLEP	%rdi
+#define OUTP	%rsi
+#define KLEN	%r9d
+#define INP	%rdx
+#define T1	%r10
+#define LEN	%rcx
+#define IVP	%r8
+
+#define UKEYP	OUTP
+#define GF128MUL_MASK %xmm11
+
+/*
+ * void __aeskl_setkey(struct crypto_aes_ctx *handlep, const u8 *ukeyp,
+ *		       unsigned int key_len)
+ */
+SYM_FUNC_START(__aeskl_setkey)
+	FRAME_BEGIN
+	movl %edx, 480(HANDLEP)
+	movdqu (UKEYP), STATE1
+	mov $1, %eax
+	cmp $16, %dl
+	je .Lsetkey_128
+
+	movdqu 0x10(UKEYP), STATE2
+	encodekey256 %eax, %eax
+	movdqu STATE4, 0x30(HANDLEP)
+	jmp .Lsetkey_end
+.Lsetkey_128:
+	encodekey128 %eax, %eax
+
+.Lsetkey_end:
+	movdqu STATE1, (HANDLEP)
+	movdqu STATE2, 0x10(HANDLEP)
+	movdqu STATE3, 0x20(HANDLEP)
+
+	FRAME_END
+	RET
+SYM_FUNC_END(__aeskl_setkey)
+
+/*
+ * int __aeskl_enc(const void *handlep, u8 *outp, const u8 *inp)
+ */
+SYM_FUNC_START(__aeskl_enc)
+	FRAME_BEGIN
+	movdqu (INP), STATE
+	movl 480(HANDLEP), KLEN
+
+	cmp $16, KLEN
+	je .Lenc_128
+	aesenc256kl (HANDLEP), STATE
+	jz .Lenc_err
+	xor %rax, %rax
+	jmp .Lenc_end
+.Lenc_128:
+	aesenc128kl (HANDLEP), STATE
+	jz .Lenc_err
+	xor %rax, %rax
+	jmp .Lenc_end
+
+.Lenc_err:
+	mov $(-EINVAL), %rax
+.Lenc_end:
+	movdqu STATE, (OUTP)
+	FRAME_END
+	RET
+SYM_FUNC_END(__aeskl_enc)
+
+/*
+ * XTS implementation
+ */
+
+/*
+ * _aeskl_gf128mul_x_ble: 	internal ABI
+ *	Multiply in GF(2^128) for XTS IVs
+ * input:
+ *	IV:	current IV
+ *	GF128MUL_MASK == mask with 0x87 and 0x01
+ * output:
+ *	IV:	next IV
+ * changed:
+ *	CTR:	== temporary value
+ *
+ * While based on the AES-NI code, this macro is separated here due to
+ * the register constraint. E.g., aesencwide256kl has implicit
+ * operands: XMM0-7.
+ */
+#define _aeskl_gf128mul_x_ble() \
+	pshufd $0x13, IV, KEY; \
+	paddq IV, IV; \
+	psrad $31, KEY; \
+	pand GF128MUL_MASK, KEY; \
+	pxor KEY, IV;
+
+.macro XTS_ENC_DEC operation
+	FRAME_BEGIN
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(HANDLEP), KLEN
+
+.ifc \operation, dec
+	test $15, LEN
+	jz .Lxts_op8_\@
+	sub $16, LEN
+.endif
+
+.Lxts_op8_\@:
+	sub $128, LEN
+	jl .Lxts_op1_pre_\@
+
+	movdqa IV, STATE1
+	movdqu (INP), INC
+	pxor INC, STATE1
+	movdqu IV, (OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE5
+	movdqu 0x40(INP), INC
+	pxor INC, STATE5
+	movdqu IV, 0x40(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE6
+	movdqu 0x50(INP), INC
+	pxor INC, STATE6
+	movdqu IV, 0x50(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE7
+	movdqu 0x60(INP), INC
+	pxor INC, STATE7
+	movdqu IV, 0x60(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE8
+	movdqu 0x70(INP), INC
+	pxor INC, STATE8
+	movdqu IV, 0x70(OUTP)
+
+	cmp $16, KLEN
+	je .Lxts_op8_128_\@
+.ifc \operation, dec
+	aesdecwide256kl (%rdi)
+.else
+	aesencwide256kl (%rdi)
+.endif
+	jz .Lxts_op_err_\@
+	jmp .Lxts_op8_end_\@
+.Lxts_op8_128_\@:
+.ifc \operation, dec
+	aesdecwide128kl (%rdi)
+.else
+	aesencwide128kl (%rdi)
+.endif
+	jz .Lxts_op_err_\@
+
+.Lxts_op8_end_\@:
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
+	pxor INC, STATE2
+	movdqu STATE2, 0x10(OUTP)
+
+	movdqu 0x20(OUTP), INC
+	pxor INC, STATE3
+	movdqu STATE3, 0x20(OUTP)
+
+	movdqu 0x30(OUTP), INC
+	pxor INC, STATE4
+	movdqu STATE4, 0x30(OUTP)
+
+	movdqu 0x40(OUTP), INC
+	pxor INC, STATE5
+	movdqu STATE5, 0x40(OUTP)
+
+	movdqu 0x50(OUTP), INC
+	pxor INC, STATE6
+	movdqu STATE6, 0x50(OUTP)
+
+	movdqu 0x60(OUTP), INC
+	pxor INC, STATE7
+	movdqu STATE7, 0x60(OUTP)
+
+	movdqu 0x70(OUTP), INC
+	pxor INC, STATE8
+	movdqu STATE8, 0x70(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+
+	add $128, INP
+	add $128, OUTP
+	test LEN, LEN
+	jnz .Lxts_op8_\@
+
+.Lxts_op_ret_\@:
+	movups IV, (IVP)
+	xor %rax, %rax
+	FRAME_END
+	RET
+
+.Lxts_op1_pre_\@:
+	add $128, LEN
+	jz .Lxts_op_ret_\@
+.ifc \operation, enc
+	sub $16, LEN
+	jl .Lxts_op_cts4_\@
+.endif
+
+.Lxts_op1_\@:
+	movdqu (INP), STATE1
+
+.ifc \operation, dec
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_op_cts1_\@
+.endif
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_op1_128_\@
+.ifc \operation, dec
+	aesdec256kl (HANDLEP), STATE1
+.else
+	aesenc256kl (HANDLEP), STATE1
+.endif
+	jz .Lxts_op_err_\@
+	jmp .Lxts_op1_end_\@
+.Lxts_op1_128_\@:
+.ifc \operation, dec
+	aesdec128kl (HANDLEP), STATE1
+.else
+	aesenc128kl (HANDLEP), STATE1
+.endif
+	jz .Lxts_op_err_\@
+
+.Lxts_op1_end_\@:
+	pxor IV, STATE1
+	_aeskl_gf128mul_x_ble()
+
+	test LEN, LEN
+	jz .Lxts_op1_out_\@
+
+.ifc \operation, enc
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_op_cts1_\@
+.endif
+
+	movdqu STATE1, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_op1_\@
+
+.Lxts_op1_out_\@:
+	movdqu STATE1, (OUTP)
+	jmp .Lxts_op_ret_\@
+
+.Lxts_op_cts4_\@:
+.ifc \operation, enc
+	movdqu STATE8, STATE1
+	sub $16, OUTP
+.endif
+
+.Lxts_op_cts1_\@:
+.ifc \operation, dec
+	movdqa IV, STATE5
+	_aeskl_gf128mul_x_ble()
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_cts_pre_128_\@
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_op_err_\@
+	jmp .Lxts_dec1_cts_pre_end_\@
+.Lxts_dec1_cts_pre_128_\@:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_op_err_\@
+.Lxts_dec1_cts_pre_end_\@:
+	pxor IV, STATE1
+.endif
+
+	lea .Lcts_permute_table(%rip), T1
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), STATE2
+	movaps STATE1, STATE3
+	pshufb STATE2, STATE1
+	movups STATE1, (LEN)
+
+	movups (IVP), STATE1
+	pshufb STATE1, IN
+	pblendvb STATE3, IN
+	movaps IN, STATE1
+
+.ifc \operation, dec
+	pxor STATE5, STATE1
+.else
+	pxor IV, STATE1
+.endif
+
+	cmp $16, KLEN
+	je .Lxts_op1_cts_128_\@
+.ifc \operation, dec
+	aesdec256kl (HANDLEP), STATE1
+.else
+	aesenc256kl (HANDLEP), STATE1
+.endif
+	jz .Lxts_op_err_\@
+	jmp .Lxts_op1_cts_end_\@
+.Lxts_op1_cts_128_\@:
+.ifc \operation, dec
+	aesdec128kl (HANDLEP), STATE1
+.else
+	aesenc128kl (HANDLEP), STATE1
+.endif
+	jz .Lxts_op_err_\@
+
+.Lxts_op1_cts_end_\@:
+.ifc \operation, dec
+	pxor STATE5, STATE1
+.else
+	pxor IV, STATE1
+.endif
+	movups STATE1, (OUTP)
+	xor %rax, %rax
+	FRAME_END
+	RET
+
+.Lxts_op_err_\@:
+	mov $(-EINVAL), %rax
+	FRAME_END
+	RET
+.endm
+
+/*
+ * int __aeskl_xts_encrypt(const struct aeskl_ctx *handlep, u8 *outp,
+ *			   const u8 *inp, unsigned int klen, le128 *ivp)
+ */
+SYM_FUNC_START(__aeskl_xts_encrypt)
+	XTS_ENC_DEC enc
+SYM_FUNC_END(__aeskl_xts_encrypt)
+
+/*
+ * int __aeskl_xts_decrypt(const struct crypto_aes_ctx *handlep, u8 *outp,
+ *			   const u8 *inp, unsigned int klen, le128 *ivp)
+ */
+SYM_FUNC_START(__aeskl_xts_decrypt)
+	XTS_ENC_DEC dec
+SYM_FUNC_END(__aeskl_xts_decrypt)
+
diff --git a/arch/x86/crypto/aeskl-intel_glue.c b/arch/x86/crypto/aeskl-intel_glue.c
new file mode 100644
index 000000000000..7672c4836da8
--- /dev/null
+++ b/arch/x86/crypto/aeskl-intel_glue.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Support for AES Key Locker instructions. This file contains glue
+ * code and the real AES implementation is in aeskl-intel_asm.S.
+ *
+ * Most code is based on AES-NI glue code, aesni-intel_glue.c
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/internal/simd.h>
+#include <asm/simd.h>
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+
+#include "aes-helper_glue.h"
+#include "aesni-intel_glue.h"
+
+asmlinkage void __aeskl_setkey(struct aeskl_ctx *ctx, const u8 *in_key, unsigned int keylen);
+
+asmlinkage int __aeskl_enc(const void *ctx, u8 *out, const u8 *in);
+
+asmlinkage int __aeskl_xts_encrypt(const struct aeskl_ctx *ctx, u8 *out, const u8 *in,
+				   unsigned int len, u8 *iv);
+asmlinkage int __aeskl_xts_decrypt(const struct aeskl_ctx *ctx, u8 *out, const u8 *in,
+				   unsigned int len, u8 *iv);
+
+/*
+ * If a hardware failure occurs, the wrapping key may be lost during
+ * sleep states. The state of the feature can be retrieved via
+ * valid_keylocker().
+ *
+ * Since disabling can occur preemptively, check for availability on
+ * every use along with kernel_fpu_begin().
+ */
+
+static int aeskl_setkey(union x86_aes_ctx *ctx, const u8 *in_key, unsigned int keylen)
+{
+	int err;
+
+	if (!crypto_simd_usable())
+		return -EBUSY;
+
+	err = aes_check_keylen(keylen);
+	if (err)
+		return err;
+
+	if (unlikely(keylen == AES_KEYSIZE_192)) {
+		pr_warn_once("AES-KL does not support 192-bit key. Use AES-NI.\n");
+		kernel_fpu_begin();
+		aesni_set_key(&ctx->aesni, in_key, keylen);
+		kernel_fpu_end();
+		return 0;
+	}
+
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	kernel_fpu_begin();
+	__aeskl_setkey(&ctx->aeskl, in_key, keylen);
+	kernel_fpu_end();
+	return 0;
+}
+
+static inline int aeskl_enc(const void *ctx, u8 *out, const u8 *in)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_enc(ctx, out, in);
+}
+
+static inline int aeskl_xts_encrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_xts_encrypt(&ctx->aeskl, out, in, len, iv);
+}
+
+static inline int aeskl_xts_decrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_xts_decrypt(&ctx->aeskl, out, in, len, iv);
+}
+
+static int xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+		      unsigned int keylen)
+{
+	return xts_setkey_common(tfm, key, keylen, aeskl_setkey);
+}
+
+static inline u32 xts_keylen(struct skcipher_request *req)
+{
+	struct aes_xts_ctx *ctx = aes_xts_ctx(crypto_skcipher_reqtfm(req));
+
+	return ctx->crypt_ctx.aeskl.key_length;
+}
+
+static int xts_encrypt(struct skcipher_request *req)
+{
+	u32 keylen = xts_keylen(req);
+
+	if (likely(keylen != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_encrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_encrypt, aesni_enc);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	u32 keylen = xts_keylen(req);
+
+	if (likely(keylen != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_decrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_decrypt, aesni_enc);
+}
+
+static struct skcipher_alg aeskl_skciphers[] = {
+	{
+		.base = {
+			.cra_name		= "__xts(aes)",
+			.cra_driver_name	= "__xts-aes-aeskl",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= XTS_AES_CTX_SIZE,
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
+		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.walksize	= 2 * AES_BLOCK_SIZE,
+		.setkey		= xts_setkey,
+		.encrypt	= xts_encrypt,
+		.decrypt	= xts_decrypt,
+	}
+};
+
+static struct simd_skcipher_alg *aeskl_simd_skciphers[ARRAY_SIZE(aeskl_skciphers)];
+
+static int __init aeskl_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	if (!(ebx & KEYLOCKER_CPUID_EBX_WIDE))
+		return -ENODEV;
+
+	/*
+	 * AES-KL itself does not rely on AES-NI. But, AES-KL does not
+	 * support 192-bit keys. To ensure AES compliance, AES-KL falls
+	 * back to AES-NI.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_AES))
+		return -ENODEV;
+
+	return simd_register_skciphers_compat(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+					      aeskl_simd_skciphers);
+}
+
+static void __exit aeskl_exit(void)
+{
+	simd_unregister_skciphers(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+				  aeskl_simd_skciphers);
+}
+
+late_initcall(aeskl_init);
+module_exit(aeskl_exit);
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm, AES Key Locker implementation");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("aes");
diff --git a/arch/x86/crypto/aeskl-intel_glue.h b/arch/x86/crypto/aeskl-intel_glue.h
new file mode 100644
index 000000000000..57cfd6c55a4f
--- /dev/null
+++ b/arch/x86/crypto/aeskl-intel_glue.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _AESKL_INTEL_GLUE_H
+#define _AESKL_INTEL_GLUE_H
+
+#include <crypto/aes.h>
+#include <linux/types.h>
+
+#define AESKL_AAD_SIZE		16
+#define AESKL_TAG_SIZE		16
+#define AESKL_CIPHERTEXT_MAX	AES_KEYSIZE_256
+
+/* The Key Locker handle is an encoded form of the AES key. */
+struct aeskl_handle {
+	u8 additional_authdata[AESKL_AAD_SIZE];
+	u8 integrity_tag[AESKL_TAG_SIZE];
+	u8 ciphre_text[AESKL_CIPHERTEXT_MAX];
+};
+
+/*
+ * Key Locker does not support 192-bit key size. The driver needs to
+ * retrieve the key size in the first place. The offset of the
+ * 'key_length' field here should be compatible with struct
+ * crypto_aes_ctx.
+ */
+#define AESKL_CTX_RESERVED (sizeof(struct crypto_aes_ctx) - sizeof(struct aeskl_handle) \
+			    - sizeof(u32))
+
+struct aeskl_ctx {
+	struct aeskl_handle handle;
+	u8 reserved[AESKL_CTX_RESERVED];
+	u32 key_length;
+};
+
+#endif /* _AESKL_INTEL_GLUE_H */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 4ac7b9a28967..d9c4aa055383 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -37,6 +37,7 @@
 #include <linux/static_call.h>
 
 #include "aes-helper_glue.h"
+#include "aesni-intel_glue.h"
 
 #define RFC4106_HASH_SUBKEY_SIZE 16
 #define AES_BLOCK_MASK (~(AES_BLOCK_SIZE - 1))
@@ -72,9 +73,6 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
-asmlinkage void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			      unsigned int key_len);
-asmlinkage void __aesni_enc(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void __aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
@@ -89,21 +87,9 @@ asmlinkage void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
-static inline int aesni_enc(const void *ctx, u8 *out, const u8 *in)
-{
-	__aesni_enc(ctx, out, in);
-	return 0;
-}
-
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
 
-asmlinkage void __aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				    const u8 *in, unsigned int len, u8 *iv);
-
-asmlinkage void __aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				    const u8 *in, unsigned int len, u8 *iv);
-
 #ifdef CONFIG_X86_64
 
 asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
@@ -271,20 +257,6 @@ static inline int aesni_xts_setkey(union x86_aes_ctx *ctx,
 	return aes_set_key_common(&ctx->aesni, in_key, key_len);
 }
 
-static inline int aesni_xts_encrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
-				    unsigned int len, u8 *iv)
-{
-	__aesni_xts_encrypt(&ctx->aesni, out, in, len, iv);
-	return 0;
-}
-
-static inline int aesni_xts_decrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
-				    unsigned int len, u8 *iv)
-{
-	__aesni_xts_decrypt(&ctx->aesni, out, in, len, iv);
-	return 0;
-}
-
 static int aesni_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			         unsigned int len)
 {
diff --git a/arch/x86/crypto/aesni-intel_glue.h b/arch/x86/crypto/aesni-intel_glue.h
new file mode 100644
index 000000000000..999f81f5bcde
--- /dev/null
+++ b/arch/x86/crypto/aesni-intel_glue.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * These are AES-NI functions that are used by the AES-KL code as a
+ * fallback when it is given a 192-bit key. Key Locker does not support
+ * 192-bit keys.
+ */
+
+#ifndef _AESNI_INTEL_GLUE_H
+#define _AESNI_INTEL_GLUE_H
+
+asmlinkage void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			      unsigned int key_len);
+asmlinkage void __aesni_enc(const void *ctx, u8 *out, const u8 *in);
+asmlinkage void __aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				    const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void __aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				    const u8 *in, unsigned int len, u8 *iv);
+
+static inline int aesni_enc(const void *ctx, u8 *out, const u8 *in)
+{
+	__aesni_enc(ctx, out, in);
+	return 0;
+}
+
+static inline int aesni_xts_encrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	__aesni_xts_encrypt(&ctx->aesni, out, in, len, iv);
+	return 0;
+}
+
+static inline int aesni_xts_decrypt(const union x86_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	__aesni_xts_decrypt(&ctx->aesni, out, in, len, iv);
+	return 0;
+}
+
+#endif /* _AESNI_INTEL_GLUE_H */
-- 
2.34.1


