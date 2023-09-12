Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402379C8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjILH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjILH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598219A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:07 -0700 (PDT)
Message-ID: <20230912065501.656264495@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kkIW+v+zNIk9lQpoyroVUgRr0ogOwnyVqvNr/VLjf7s=;
        b=MmUz0z9xeJcrJnxPWAhM0Sg9irL5LYgARz0uyeEaDH49TpRkPWpFfdIeun756Hw9CzJCgr
        HcE0+36CM8yqUrZTC3+N4XKggFfmqs2nEeTMUnbrtSA4jYJdoX0SnTEhdUuxl9wTCoqcmF
        cJfWnR6QFOJNGFZQ2Yn826PEDE0YPyW+1TSBpaa4E6a+8xcf5iVKMGxq9iL/v0X5u1pvTh
        QfHnC59V/7lkdTO8uDeUTXJ73kaVBLIjBrYgUSSg1rrWw05XdnPI2kFESehEwXhV+bS8LL
        i8ECiTGFkpP2+uqiFvEGf7ArEgcC/uEfmOCVnq1HmHpawVwzWGAVvFa7CU4qzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kkIW+v+zNIk9lQpoyroVUgRr0ogOwnyVqvNr/VLjf7s=;
        b=k8+2iG5JfnEGJAuQRw8Z7ZzyuRb880eqYgK9XpNXEhGaZUVQv5PAFFf05u5VWP+04t5PSY
        jE+MezHcy/Fb0gAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 14/30] x86/microcode/amd: Read revision from hardware in
 collect_cpu_info_amd()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:05 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to decrapify the core initialization logic which invokes
microcode_ops::apply_microcode() several times just to set
cpu_data::microcode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -673,12 +673,12 @@ void reload_ucode_amd(unsigned int cpu)
 
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	u32 dummy __always_unused;
 	struct ucode_patch *p;
 
 	csig->sig = cpuid_eax(0x00000001);
-	csig->rev = c->microcode;
+	rdmsr(MSR_AMD64_PATCH_LEVEL, csig->rev, dummy);
 
 	/*
 	 * a patch could have been loaded early, set uci->mc so that

