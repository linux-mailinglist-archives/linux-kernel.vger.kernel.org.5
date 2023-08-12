Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21777A236
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjHLUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjHLUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:02:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E63584
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:01:57 -0700 (PDT)
Message-ID: <20230812195728.767559362@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kkIW+v+zNIk9lQpoyroVUgRr0ogOwnyVqvNr/VLjf7s=;
        b=zuNXQTulA8DtnMFk1kcH3noS0gOIC12+/0PSST/h+Rmc2YczU2Q5O471jiL/xl4AJqkClu
        OXONrmERT89Cs94ZdPx8qdBeNSAM4uzjLa3oetmdG0wLpCxONwYB9G/+Utwe2VaFFTfLDf
        2PN0kIxBtnhoKAEaKQrPNktdHGrgdN53W2tjtf8P/6TRfBLV7RU+GS0LK3hpkYtW4cjPaq
        peX8HMUcixXza48s/EyCMDDk1QLkaHfi831eir3+XHJOsMwiQGsAklS4BTkEvjdny9rRXt
        9Z21iRJNiEs6qEJVIcKWakKhE4makNymmMGuDwxG+M8ogV/xVZI21a9+XKFGDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kkIW+v+zNIk9lQpoyroVUgRr0ogOwnyVqvNr/VLjf7s=;
        b=oKOr19vBE0Rbk5OMlHnMPH7YRqTr0xsB63QVZRC/CVdLuXJZT5ZU9VnFkNr04H9EWJ+bcW
        aV2fjO0J8UNvNkCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 21/37] x86/microcode/amd: Read revision from hardware in
 collect_cpu_info_amd()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:09 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

