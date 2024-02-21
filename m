Return-Path: <linux-kernel+bounces-74699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13285D7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53261B2305A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841967E92;
	Wed, 21 Feb 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eGdNzpUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECE47F48;
	Wed, 21 Feb 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518790; cv=none; b=YG8LGNsNIzoLl+gGecuEw1QcUMWBk89yEeBM3Eo9GvQpwGZ4CwJpnIzVCD+c6kUxUXDuQDR7KjX5//pW7QO1TXvADSCzcHkcBzsWe0ptlpD+Rj1IjeQB4YjY2evObIFz81LY1q3kBfM7T8s//6FAxsdCodxg2BtruuARqTqIwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518790; c=relaxed/simple;
	bh=TKxrZ5i8qfUSmWmPOGLDIUAMYtKUR9blFenfplJL0Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GbWLuPaIlGMbs7ZYgEnJgIlZcvLr+4Url1exb9y5HGOKr7JfaACrizRWeqoxRpc3UxvYzwTU29Q4CfIB+yYlWK46Qx6w9Y6bUVeiaL/feWTPLMA7xXHXfeTIqJVJB02V6SJH+S/1I6Wf/eI+V35IkGU3MbUcCiHD6eaQGyDusr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eGdNzpUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F419C433C7;
	Wed, 21 Feb 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eGdNzpUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708518784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c8L9OYnDMwIamjO8TmzT17Jz/akuQWtAkEn5w1LxguY=;
	b=eGdNzpUbGU3xkV4rsI7R2mHIuszaFpBv8DB5rgja4laDoQOvtTYLdGpXmX1wF7J/SO/U3H
	voCiZAN1GhkKJpIZSM1JJSTdZgpZT2e5D+N1pjEySxgUBMynHUfgSzimsxQGzF/jnUoQ9F
	mI6FFs8jEqotmifjHbFEL/doiAQbkFE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 02fd8cb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:04 +0000 (UTC)
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
Subject: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Wed, 21 Feb 2024 13:32:40 +0100
Message-ID: <20240221123248.25570-1-Jason@zx2c4.com>
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
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v2->v3:
- Remove patch that handled generic RDRAND failures, because that
  doesn't really have any implication for the RNG, since it's supposed
  to run fine on systems without RDRAND anyway, and CoCo is a weird
  special case. If people still want an extra generic RDRAND failure
  handler, that's standalone anyway, so we can do that disconnected from
  this patch. No need to make it a series.
- Update comments and commit message to reflect this.

Changes v1->v2:
- panic() instead of BUG_ON(), as suggested by Andi Kleen.
- Update comments, now that we have info from AMD and Intel.

 arch/x86/coco/core.c        | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |  2 ++
 arch/x86/kernel/setup.c     |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..0a5d59966d6d 100644
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
2.43.0


