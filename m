Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE047BFFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJJPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjJJPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643FCB8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:46 -0700 (PDT)
Message-ID: <20231010150702.551141238@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g/Yygr9A2Il7UvnXxciW5CWUkAO8Yu2F0f5qpSzvguA=;
        b=144ei3NnW+bCXOx31fsFaFPjODLcJ4BuZdguAbxZW8FQayQc/LZ65jfFRGFxy9LSHIJnrM
        BFo+VFyKc1EkoNbJd7wIk8cAkw93McVCL9JOqnXwSbjrZcI2prCs6fb/4hi4kiXY55IAeP
        QS5MhbJA/3SW9UOyxP44jFQpMoIQmI39ZdfT2F3xQrPEDAeaECqfQGRdR5wBDOd6lX6rlN
        iDSgal6RFT9Oyyw0z4G7PgIQ2idJRBZ4ZTYEBKtcc/s1I9pma+SASf9ZZlGVFRjJj6pJkq
        q/0vESVJ6N3jTrC1iRXCbnp8zjd+56hFP44f5YLtVC2fpmguHFllgpakwWFEvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g/Yygr9A2Il7UvnXxciW5CWUkAO8Yu2F0f5qpSzvguA=;
        b=XkO1cBpyl7r/ik0f1fyWT5d2N0ZgKCx1IcXv18nXfhCEIR4nrDbwDs4gRdkcdMMSz1BVYS
        DDs0KgiruzBzwfCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 3/5] x86/microcode/amd: Cache builtin/initrd microcode early
References: <20231010145130.987300357@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Oct 2023 17:08:44 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to scan builtin/initrd microcode on each AP.

Cache the builtin/initrd microcode in an early initcall so that the early
AP loader can utilize the cache.

The existing fs initcall which invoked save_microcode_in_initrd_amd() is
still required to maintain the initrd_gone flag. Rename it accordingly.
This will be removed once the AP loader code is converted to use the cache.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c  |    8 +++++++-
 arch/x86/kernel/cpu/microcode/core.c |   20 ++++----------------
 2 files changed, 11 insertions(+), 17 deletions(-)

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
 
+	if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
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
@@ -185,24 +185,13 @@ void load_ucode_ap(void)
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
@@ -895,5 +884,4 @@ static int __init microcode_init(void)
 	return error;
 
 }
-fs_initcall(save_microcode_in_initrd);
 late_initcall(microcode_init);

