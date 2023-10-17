Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED77CCF33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjJQVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjJQVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66C1700
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:55 -0700 (PDT)
Message-ID: <20231017211723.187566507@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WQKKrIM+Or60lNHBMCvYO0+xUQpVl/8KUTxnGXot8hw=;
        b=Lanv0vBpQoMbZM/KWgBw4Od9bGin2InD8vXKL3eE+KARCkojPUAAPyPaSauMFO0ENx4sBZ
        JiU2PzALQVXFrDzjPHoWXWdUorFmnJupEHN86gcibcBK1j2SkcmubfoDa0dVkFDWrUrziU
        MUyUrc7wak0CboC4nUleonq5PiTIMbTg0SiQd+18PGLxh9gkBRkucN6grb0qncdEsE9B8y
        18l3F2OhXgsSgHPZqfBPOW9xLj1xw1hZWemL95aZb/ExLwcxPitvu5qahvMC30GOZVUG3M
        aAma1o6HwmHi3NRtNOZhQWoVIvAo+jOz+D26tzH0VBPRJNFgUt4fy3dqs3TVeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WQKKrIM+Or60lNHBMCvYO0+xUQpVl/8KUTxnGXot8hw=;
        b=GUHPZio0Nhd7IiYCGlmlUc2IudFKDbmJFU9iHYKnN8VcXQ+REnAmE4ciT692iHLRELQp5G
        riF0JUi6mzq2DYCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 22/39] x86/microcode/amd: Cache builtin/initrd microcode
 early
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:53 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to scan builtin/initrd microcode on each AP.

Cache the builtin/initrd microcode in an early initcall so that the
early AP loader can utilize the cache.

The existing fs initcall which invoked save_microcode_in_initrd_amd() is
still required to maintain the initrd_gone flag. Rename it accordingly.
This will be removed once the AP loader code is converted to use the
cache.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Prevent saving the microcode blob when the loader is disabled
---
 arch/x86/kernel/cpu/microcode/amd.c  |    8 +++++++-
 arch/x86/kernel/cpu/microcode/core.c |   20 ++++----------------
 2 files changed, 11 insertions(+), 17 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -527,12 +527,17 @@ void load_ucode_amd_early(unsigned int c
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
 
-int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
+static int __init save_microcode_in_initrd(void)
 {
+	unsigned int cpuid_1_eax = native_cpuid_eax(1);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
 	struct cont_desc desc = { 0 };
 	enum ucode_state ret;
 	struct cpio_data cp;
 
+	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+		return 0;
+
 	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
@@ -549,6 +554,7 @@ int __init save_microcode_in_initrd_amd(
 
 	return 0;
 }
+early_initcall(save_microcode_in_initrd);
 
 /*
  * a small, trivial cache of per-family ucode patches
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -180,24 +180,13 @@ void load_ucode_ap(void)
 	}
 }
 
-static int __init save_microcode_in_initrd(void)
+/* Temporary workaround until find_microcode_in_initrd() is __init */
+static int __init mark_initrd_gone(void)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	int ret = -EINVAL;
-
-	switch (c->x86_vendor) {
-	case X86_VENDOR_AMD:
-		if (c->x86 >= 0x10)
-			ret = save_microcode_in_initrd_amd(cpuid_eax(1));
-		break;
-	default:
-		break;
-	}
-
 	initrd_gone = true;
-
-	return ret;
+	return 0;
 }
+fs_initcall(mark_initrd_gone);
 
 struct cpio_data find_microcode_in_initrd(const char *path)
 {
@@ -615,5 +604,4 @@ static int __init microcode_init(void)
 	return error;
 
 }
-fs_initcall(save_microcode_in_initrd);
 late_initcall(microcode_init);

