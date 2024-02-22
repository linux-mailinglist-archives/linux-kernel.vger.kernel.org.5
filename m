Return-Path: <linux-kernel+bounces-75786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363185EEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A893283440
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71F17573;
	Thu, 22 Feb 2024 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e60CWs9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CC17558;
	Thu, 22 Feb 2024 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567606; cv=none; b=iZdLxf8moKleonzMGN2jYYHd+kOcRXjYh4DTYW5jCEtEuySgJSjEmp+Pz0yvFrxHuwSYkB7Ybj5MdGoaaiI+nYPOa69r1qCVt5y8FcIoq3INRa6NKC4959dVC9AlmMZxn4eOY78qmKdG1NlcTl4GywxeiuLfyxXaTSJyezF8Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567606; c=relaxed/simple;
	bh=7su2uc/qjT5uiRB7c3q8axt/+BDQygJevCLmMZSgwVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYNJZAeZNN6+SMYOcqw4CcMSVPhc/aTYbysP8iYjZm5tHtb1KxQljjc8EbkluKYtol2G54O7U15opL5a4KiwQiLhCL5G5USOmmuCSDK91Z37w7iMlxaP8SdVAkuDEaxJZcvoB9SKcUutfQw0H5YoXF5eCrbV/d8pe49Iv2vuMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=e60CWs9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0385DC433C7;
	Thu, 22 Feb 2024 02:06:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e60CWs9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708567601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSpZ9HfMHwwDA3D6imETo1Lc+vWLLY3fMavVn1pGHck=;
	b=e60CWs9OyzstH4poKO4dJoti0RWaX5QLMQKIQK/dNOEZTsHUjUGa10VU3HzyJLG2TpYszN
	n8oeI9VNpNXcOnsdiiz+w8WMkLdaiMZyJasn7EeJiZyyCcWTd3EdTtOMnwJscKYdyuT9o+
	BRg5jJfopa5NgNgsZ6uHW1+y+gZ8iV8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3b5d701a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 02:06:41 +0000 (UTC)
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
	stable@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v4] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Thu, 22 Feb 2024 03:05:51 +0100
Message-ID: <20240222020616.2315199-1-Jason@zx2c4.com>
In-Reply-To: <5648f43d-76e4-4396-b626-411d60657c93@intel.com>
References: <5648f43d-76e4-4396-b626-411d60657c93@intel.com>
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
Cc: stable@vger.kernel.org
Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v3->v4:
- Add stable@ tag and reviewed-by lines.
- Add comment for Dave explaining where the "32" comes from.

 arch/x86/coco/core.c        | 40 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |  2 ++
 arch/x86/kernel/setup.c     |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..0e988bff4aec 100644
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
2.43.2


