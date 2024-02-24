Return-Path: <linux-kernel+bounces-79421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202C8621DB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4682F284140
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2A46A2;
	Sat, 24 Feb 2024 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WFXpB5qA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649DEC7;
	Sat, 24 Feb 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737577; cv=none; b=KKE+xdNEm1hhDzYmK7Fzk8U2m1Ni9QEuY4k0TYsYIcgUZcMe0i964zxOE5N0M+lxq763b6BxuUOFB21ocnjlDbjCR/NVMOMzV7MNB8UaR+ZcSlrWaciGAOZvKIF5H+/nI5iBt33yOA4Hlqe/6jgoZwAnAU5ace61vqRd00nqu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737577; c=relaxed/simple;
	bh=emhd0YKBzfb9G834PBFJ8OSQYNvvDRHXJfLz0wT+on4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce7irGlmsM2dBaxGrGIfSSHNWi8ueM4E5r8xNPboaF+GKR/NlzNkj17UxnXDE1WH2MymVHBjr3JaGNDLZp7PQyVh8pJ/2xXapgWfuS36kCVXq/CbGn6PhXFm5rBLP5YF4h079Zn6EB4bx1m3pKpXa8GfgBsjfC/N8Y5lxtJxTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WFXpB5qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF64C433F1;
	Sat, 24 Feb 2024 01:19:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WFXpB5qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708737574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg4+2B0WfXNvPcsxCdWLxYVmfBTIzjIfhxm8wCp95lA=;
	b=WFXpB5qA2uDQh2nb3oP5ZPqLrJ7p2CK3FRu7jOhQmR41QMqcK5vbSh7e6XPV+BUXKbhLpy
	Hr/jU7+wN/l1JUtsUi5/UPMvhZa/NaQSYPzNmaclb/vtzRYq7XpDbHk9xrrT85gikKRkAl
	iNgpaW/67SSeV7NHvDVnwLUC6G+5rUk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50136661 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 24 Feb 2024 01:19:33 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: [PATCH v5] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Sat, 24 Feb 2024 02:18:56 +0100
Message-ID: <20240224011921.2663985-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9oN+7rbLYcvQN=+KMjwrokvARy_7khLWJvDK=K_S5uHqg@mail.gmail.com>
References: <CAHmME9oN+7rbLYcvQN=+KMjwrokvARy_7khLWJvDK=K_S5uHqg@mail.gmail.com>
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
Changes v4->v5:
- Use `cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)` instead of checking
  cc_vendor, per Tom's recommendation.

 arch/x86/coco/core.c        | 40 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |  2 ++
 arch/x86/kernel/setup.c     |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..b419a29ef0e5 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -3,13 +3,16 @@
  * Confidential Computing Platform Capability checks
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
+#include <linux/random.h>
 
+#include <asm/archrandom.h>
 #include <asm/coco.h>
 #include <asm/processor.h>
 
@@ -153,3 +156,40 @@ __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
 }
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
index 76c310b19b11..e9d059449885 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -15,6 +15,7 @@ extern enum cc_vendor cc_vendor;
 void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
 
@@ -27,6 +28,7 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+static inline void cc_random_init(void) { }
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..30a653cfc7d2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cacheinfo.h>
+#include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -994,6 +995,7 @@ void __init setup_arch(char **cmdline_p)
 	 * memory size.
 	 */
 	mem_encrypt_setup_arch();
+	cc_random_init();
 
 	efi_fake_memmap();
 	efi_find_mirror();
-- 
2.43.2


