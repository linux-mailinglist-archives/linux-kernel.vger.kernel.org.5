Return-Path: <linux-kernel+bounces-119424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFB88C893
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C881C2FAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973313C9AE;
	Tue, 26 Mar 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LA3vWYhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13B13C696;
	Tue, 26 Mar 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469278; cv=none; b=XfuXH6HXJIiGsFOxTO2Az6yyTob/nMWHj7xah76wnMdL5hC3TGPkteHg7ziovOziZm2nsQ4hEhNest+paZ1EASNto98hkurMCKKCjPoIaSpw8+0gGbKWXAj32nIXW4J8UOm16698IaCIaWIMYYLDHf+swEK+hYRRmDX3ZoYdO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469278; c=relaxed/simple;
	bh=30JIHtimg6n8W6Ta1n9cVF3rWKvRQkP+z9819UW55F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEAXgJZL1H5/ieHkf0t70l5X7jKosarUC6pQxIjAWagJoGXFkwn8wC/jTXZq6RWH0bUeaNhKf8wKUPjV55KAMlSVI08ATx8eID3fD5RgQaPajjmEtgCaknTXlRFzsCxWfCtlsOCNeLcQbEvBA/r27lnADaeWEGk157fYzDa/ikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LA3vWYhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F1C433F1;
	Tue, 26 Mar 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LA3vWYhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1711469273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRlhV/wNtR2/43VLUsHVHpymnq61r5ZGY83YpOPrN94=;
	b=LA3vWYhI8E4ciTAaUxImG87k3puXPqFgsORrEg9fZYgFW/SG1E0KEx+Rx0H/C+11JQaZb/
	YsKQZeDQnqdSrNM3co0GO+PVi6PzoTiPcQXlgqATXGbjFzfRIYAj5/DgV3jQCtMOwA474e
	E+6DyVgXy88k+fRqt8op4STygCX8Q4M=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 557207e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 16:07:53 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	stable@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v6] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Tue, 26 Mar 2024 17:07:35 +0100
Message-ID: <20240326160735.73531-1-Jason@zx2c4.com>
In-Reply-To: <20240326112137.GDZgKvwRHD4yQs3Zm-@fat_crate.local>
References: <20240326112137.GDZgKvwRHD4yQs3Zm-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are few uses of CoCo that don't rely on working cryptography and
hence a working RNG. Unfortunately, the CoCo threat model means that the
VM host cannot be trusted and may actively work against guests to
extract secrets or manipulate computation. Since a malicious host can
modify or observe nearly all inputs to guests, the only remaining source
of entropy for CoCo guests is RDRAND.

If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
is meant to gracefully continue on gathering entropy from other sources,
but since there aren't other sources on CoCo, this is catastrophic.
This is mostly a concern at boot time when initially seeding the RNG, as
after that the consequences of a broken RDRAND are much more
theoretical.

So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
fails, panic(). This will also trigger if the system is booted without
RDRAND, as RDRAND is essential for a safe CoCo boot.

This patch is deliberately written to be "just a CoCo x86 driver
feature" and not part of the RNG itself. Many device drivers and
platforms have some desire to contribute something to the RNG, and
add_device_randomness() is specifically meant for this purpose. Any
driver can call this with seed data of any quality, or even garbage
quality, and it can only possibly make the quality of the RNG better or
have no effect, but can never make it worse. Rather than trying to
build something into the core of the RNG, this patch interprets the
particular CoCo issue as just a CoCo issue, and therefore separates this
all out into driver (well, arch/platform) code.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v5->v6:
- Rebase on tip/master.
- Add string.h include.

 arch/x86/coco/core.c        | 41 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |  2 ++
 arch/x86/kernel/setup.c     |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d07be9d05cd0..ddd4efdc79d6 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -3,13 +3,17 @@
  * Confidential Computing Platform Capability checks
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
+#include <linux/string.h>
+#include <linux/random.h>
 
+#include <asm/archrandom.h>
 #include <asm/coco.h>
 #include <asm/processor.h>
 
@@ -148,3 +152,40 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
+
+__init void cc_random_init(void)
+{
+	/*
+	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
+	 * is the security level that the RNG is targeting.
+	 */
+	unsigned long rng_seed[32 / sizeof(long)];
+	size_t i, longs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * Since the CoCo threat model includes the host, the only reliable
+	 * source of entropy that can be neither observed nor manipulated is
+	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
+	 * CoCo guests have no other unobservable source of entropy, it's
+	 * important to at least ensure the RNG gets some initial random seeds.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
+		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
+
+		/*
+		 * A zero return value means that the guest doesn't have RDRAND
+		 * or the CPU is physically broken, and in both cases that
+		 * means most crypto inside of the CoCo instance will be
+		 * broken, defeating the purpose of CoCo in the first place. So
+		 * just panic here because it's absolutely unsafe to continue
+		 * executing.
+		 */
+		if (longs == 0)
+			panic("RDRAND is defective.");
+	}
+	add_device_randomness(rng_seed, sizeof(rng_seed));
+	memzero_explicit(rng_seed, sizeof(rng_seed));
+}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index fb7388bbc212..c086699b0d0c 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -22,6 +22,7 @@ static inline void cc_set_mask(u64 mask)
 
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
 
@@ -34,6 +35,7 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+static inline void cc_random_init(void) { }
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f04cef846e51..e3f01caf104b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -37,6 +37,7 @@
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cacheinfo.h>
+#include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -993,6 +994,7 @@ void __init setup_arch(char **cmdline_p)
 	 * memory size.
 	 */
 	mem_encrypt_setup_arch();
+	cc_random_init();
 
 	efi_fake_memmap();
 	efi_find_mirror();
-- 
2.44.0


