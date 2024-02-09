Return-Path: <linux-kernel+bounces-59680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17D84FA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815091C25315
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287307BB1C;
	Fri,  9 Feb 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HG3l0MQQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E18762CD;
	Fri,  9 Feb 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497571; cv=none; b=P9boCjeKLMlVWAMoBNIPs2NkOkIN6LHNbSoKTvcMol9ehPqYrA4TaFsSzFeR0NpmPUXcY83Oefy7xC4WB2iEzgyb63grZCuaPv5z2BR3Ge71CERBNGFBtqwOxkuzgSzwJR+jgbzfPgcC4S5mDUZTyqGqQbAmCWbKcQkvtot1Bz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497571; c=relaxed/simple;
	bh=NmxkS+jMEl1UDH6K3hczdpAMvlCTTVjwBXbAsGC195I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQrth0eJXD1KYQXU7VASZPnmvTmHk6AxC/kIo8lRl9J2RJOR2WnIQEIekyspVJzyV40j/cAx7Ya6D/KuvPBxQie4MHtBDntKifUyOU+jduRKo8WouK3lyxfBD8xtujoH64GLt9A7qkMoi64IYq6t/nJAhbKFab3jhxHVXohpmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HG3l0MQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E0C433F1;
	Fri,  9 Feb 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HG3l0MQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707497565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ynfqeEaOI5g7zJp9rFKHbivlh40eLsPZgdwI7uHEjME=;
	b=HG3l0MQQMBB/izRV3H7Zc7JNrczDOpSpsAZXyzy5j/UH6cLoiMw5DTRxwVxAGeKSa7DRsk
	LL1NMS7VhaL8tbyNi2QFjNNIo+HcQuY9RgMxn3QuyfWQeF3/uoFHkb6hZ/VbFdy57kv3s7
	PpuOkZxB3krT0n1j8Fn8X5nx/IkFDYg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1048efb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Feb 2024 16:52:45 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Fri,  9 Feb 2024 17:49:15 +0100
Message-ID: <20240209164946.4164052-1-Jason@zx2c4.com>
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

Unfortunately, RDRAND itself can be rendered unreliable by the host,
since the host controls guest scheduling and can starve RDRAND's
generation. A malicious host could also choose to simply terminate or
not boot a CoCo guest. So, tie the starvation of RDRAND to a BUG_ON at
boot time.

Specifically, try at boot to seed the RNG using 256 bits of RDRAND
output. If these fail, BUG(). This doesn't handle the more complicated
case of reseeding later in boot, but that's fraught with its own
difficulties, such as a malicious userspace starving the kernel. For
now, simply make sure the RNG is initially seeded securely during boot,
avoiding the worst of potential pitfalls.

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
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Probably this shouldn't be merged until Dave/Elena and others get back
with regards to the full picture, with information from inside Intel.
But I have a feeling this patch, or something like it, is ultimately
what we'll wind up with, so I'm posting it now.

I don't have a functional CoCo setup, so this patch has only been very
lightly tested.

 arch/x86/coco/core.c        | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |  2 ++
 arch/x86/kernel/setup.c     |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..4e3b1cfe0063 100644
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
 
@@ -153,3 +156,36 @@ __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
 }
+
+__init void cc_random_init(void)
+{
+	unsigned long rng_seed[32 / sizeof(long)];
+	size_t i, longs;
+
+	if (cc_vendor == CC_VENDOR_NONE)
+		return;
+
+	/*
+	 * Since the CoCo threat model includes the host, the only reliable
+	 * source of entropy that can be neither observed nor manipulated is
+	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since a
+	 * host can possibly induce failures consistently, it's important to at
+	 * least ensure the RNG gets some initial random seeds.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
+		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
+
+		/*
+		 * A zero return value means that the guest is under attack,
+		 * the hardware is broken, or some other mishap has occurred
+		 * that means the RNG cannot be properly rng_seeded, which also
+		 * likely means most crypto inside of the CoCo instance will be
+		 * broken, defeating the purpose of CoCo in the first place. So
+		 * just panic here because it's absolutely unsafe to continue
+		 * executing.
+		 */
+		BUG_ON(longs == 0);
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
2.43.0


