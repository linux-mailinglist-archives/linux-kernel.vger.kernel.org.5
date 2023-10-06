Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1557BB90C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJFN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:26:35 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4783
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:26:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3EF8440E0196;
        Fri,  6 Oct 2023 13:26:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uKpwv-KELvyl; Fri,  6 Oct 2023 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696598788; bh=REO2AXGCRnnwM7snIHMcZdzhEM2xBgUZaWA0kjDWuSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVyo7ObKaAQkbH6Ut9sD/ElCrjwSfNd33ZyS3A04hO9vE5BCkQWcseZ073U2COh8Q
         glSdv24asybCUSV80oX62Aof1v54ZlQaL8o0fgPRVmsnDnKLIJD6mufUMKL25IzxnT
         6genzVqr7YJPwtGfJNWTVunfjKXDnINzOxcA+WSDBsfkunqCHZyXginQBMDRXxgdyl
         k1+SN5Ndzq7u8CB9ck4HACRUMpo9mhhF+uDImNJHrIZMuXtLzlKS/F/r3DMTexH3l6
         0na+c5EF2/Y+vpEYyZ4yZlmV7LCqxErgR0P1cRHCoL8yyBU4W7cA4tSywW8rIp9as1
         BZchBZG1WJEXbZsgqd7Ue0H+xNEzOm4Kk8Mw8cde8Kzi5xgTIqrMDSAR7ivT6zSLcE
         v8xGTvoJNn5g72tw4LnkDvOuZzOLCTUHL4ZpHwmO1+GYqxdDJ949zYjNouEp7APtPq
         pLoP/H8JzEyEPRV8mlTgFt1kbjb33ZcdxrzHhsmolipO/420lQHQnU7ftbHhm8G1Gv
         SViTg8n0HXQtGvvt0JIOT1HX8vEly/2gJJfJKovbhVfAN6OjBt316CyA5QNwLsyLKY
         mDEq7CA80r1/mScXuT9aeKszM6QgMx3+gF/kLe1v7tI3hdAOElo/R8LkCwX3Dv7n/J
         Hi5oeZiSGHVPGZlJkrfEoatM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C04AD40E0193;
        Fri,  6 Oct 2023 13:26:22 +0000 (UTC)
Date:   Fri, 6 Oct 2023 15:26:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V4 15/30] x86/microcode: Remove pointless apply()
 invocation
Message-ID: <20231006132617.GOZSAK+YCEwVsEuUdr@fat_crate.local>
References: <20231002115506.217091296@linutronix.de>
 <20231002115902.914469212@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002115902.914469212@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:59:52PM +0200, Thomas Gleixner wrote:
> Microcode is applied on the APs during early bringup. There is no point in
> trying to apply the microcode again during the hotplug operations and
> neither at the point where the microcode device is initialized.
> 
> Collect CPU info and microcode revision in setup_online_cpu() for now. This
> will move to the CPU hotplug callback in the next step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/cpu/microcode/core.c |   34 ++++++----------------------------
>  include/linux/cpuhotplug.h           |    1 -
>  2 files changed, 6 insertions(+), 29 deletions(-)

Partial revert, as discussed. I've left enough breadcrumbs in case we
wanna tackle this again in the future:

---
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 2 Oct 2023 13:59:52 +0200
Subject: [PATCH] x86/microcode: Remove pointless apply() invocation

Microcode is applied on the APs during early bringup. There is no point
in trying to apply the microcode again during the hotplug operations and
neither at the point where the microcode device is initialized.

Collect CPU info and microcode revision in setup_online_cpu() for now.
This will move to the CPU hotplug callback later.

  [ bp: Leave the starting notifier for the following scenario:

    - boot, late load, suspend to disk, resume

    without the starting notifier, only the last core manages to update the
    microcode upon resume:

    # rdmsr -a 0x8b
    10000bf
    10000bf
    10000bf
    10000bf
    10000bf
    10000dc <----

    This is on an AMD F10h machine.

    For the future, one should check whether potential unification of
    the CPU init path could cover the resume path too so that this can
    be simplified even more. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.914469212@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 0d99d5eab3fc..6f7632fa2e61 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -490,17 +490,6 @@ static void microcode_fini_cpu(int cpu)
 		microcode_ops->microcode_fini_cpu(cpu);
 }
 
-static enum ucode_state microcode_init_cpu(int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
-
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
-
-	return microcode_ops->apply_microcode(cpu);
-}
-
 /**
  * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
@@ -555,14 +544,14 @@ static int mc_cpu_down_prep(unsigned int cpu)
 static void setup_online_cpu(struct work_struct *work)
 {
 	int cpu = smp_processor_id();
-	enum ucode_state err;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	err = microcode_init_cpu(cpu);
-	if (err == UCODE_ERROR) {
-		pr_err("Error applying microcode on CPU%d\n", cpu);
-		return;
-	}
+	memset(uci, 0, sizeof(*uci));
 
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	cpu_data(cpu).microcode = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 	mc_cpu_online(cpu);
 }
 
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
