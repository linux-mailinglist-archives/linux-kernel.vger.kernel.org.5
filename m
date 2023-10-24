Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4A7D5199
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjJXNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbjJXNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:21:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429161738;
        Tue, 24 Oct 2023 06:21:03 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3BWkAF3K0oG26y0zccu3hr2d5yCYQH1v5JkIZ4rBLc=;
        b=PLoYSarO0OhwM8QaHFnDeQwE4PE/ikcA3EtOl59bBelUAIYbfOw4MmeBkw8+3ylSK/aCd3
        gGRh16js5eK2X38IrsbGPYDwy6kanBFnc7TwFu1n6JCZ+PHaz32h5zRT3QF4+r3JER/HiZ
        SeNhvLQCJi17FsWmkqPWBQGiJkPZ/OSnafAd++TMVRu1TV8faNfAzyIvRejzaprbhud8Xi
        dYBv3aw6GEkO6fMB/7pCICSH3QSgAMvxjZDq9F5vGjUntRmhMQuHiXzXs+Xo2lWCGCjhbg
        CsJBm1kvKJicePaT1/T60SI+525hgm6rPPf/SXPWAJwTOyWOyHHWH0CqzOC85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3BWkAF3K0oG26y0zccu3hr2d5yCYQH1v5JkIZ4rBLc=;
        b=Q5i/RnKFz00s+huuyj1hW06mFR7Bge2+d/rDKEflzOfWhszkzk177Xp8pScXD7Kj+icF/g
        OkSHmJjC5CLl02Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Cache builtin/initrd microcode early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211723.187566507@linutronix.de>
References: <20231017211723.187566507@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366114.3135.14229193019329228281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a7939f01672034a58ad3fdbce69bb6c665ce0024
Gitweb:        https://git.kernel.org/tip/a7939f01672034a58ad3fdbce69bb6c665ce0024
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:53 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

x86/microcode/amd: Cache builtin/initrd microcode early

There is no reason to scan builtin/initrd microcode on each AP.

Cache the builtin/initrd microcode in an early initcall so that the
early AP loader can utilize the cache.

The existing fs initcall which invoked save_microcode_in_initrd_amd() is
still required to maintain the initrd_gone flag. Rename it accordingly.
This will be removed once the AP loader code is converted to use the
cache.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211723.187566507@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c  |  8 +++++++-
 arch/x86/kernel/cpu/microcode/core.c | 20 ++++----------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2458379..6717f0e 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -527,12 +527,17 @@ void load_ucode_amd_early(unsigned int cpuid_1_eax)
 
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
@@ -549,6 +554,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 
 	return 0;
 }
+early_initcall(save_microcode_in_initrd);
 
 /*
  * a small, trivial cache of per-family ucode patches
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cfc1f7a..3d769ff 100644
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
