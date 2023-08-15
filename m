Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292C77D3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbjHOT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjHOT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F291F60DC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DA8C433C7;
        Tue, 15 Aug 2023 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692129513;
        bh=liTtQIepDemmgBKm25RqRcTit4+ntzh72R9+hldmPuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHArkGL7SuhedGxZT+Q+tVL7vYEi3VdiFjUtpa7esBW/3gxI2YHGjSp5mc5CY9IEu
         1zACV4FYc11+j3ftiqsvnAUfVHoqWo4rvcKECXXkBbVACapZytiJfUvhgXQLd2GDgc
         Rmjcy3lyfAfbDeAD2NsvQVPApHBh/D6TvHIKfWZraA325ivvMl93sVS4zTpvSgP6mN
         dTECccceg2AONf9EaNELtGc7ymDaA9imtdw/wfAV9J//fgenG9spSXB/5lCftKcPuj
         96J8i4kTBClI0u2i1KpLb7x+LKWd4n9afSGndri4WxsZF8gMr/e1dvtZIInPef9sk1
         cY8EMI51iD2nQ==
Date:   Tue, 15 Aug 2023 12:58:31 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230815195831.2opbgrznnpszaa32@treble>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:57:24AM +0200, Borislav Petkov wrote:
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2417,8 +2417,7 @@ static void __init srso_select_mitigation(void)
>  		 * Zen1/2 with SMT off aren't vulnerable after the right
>  		 * IBPB microcode has been applied.
>  		 */
> -		if ((boot_cpu_data.x86 < 0x19) &&
> -		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
> +		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
>  			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
>  			return;
>  		}
> @@ -2698,8 +2697,12 @@ static ssize_t retbleed_show_state(char *buf)
>  
>  static ssize_t srso_show_state(char *buf)
>  {
> -	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
> -		return sysfs_emit(buf, "Not affected\n");
> +	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> +		if (sched_smt_active())
> +			return sysfs_emit(buf, "Not affected\n");
> +		else
> +			return sysfs_emit(buf, "Mitigation: SMT disabled\n");
> +	}

AFAICT, nowhere in the spec does it say the SRSO_NO bit won't get set by
future (fixed) HW.  In fact I'd expect it will, similar to other *_NO
flags.

Regardless, here SRSO_NO seems to mean two different things: "reported
safe by host (or HW)" and "not reported safe on Zen1/2 with SMT not
possible".

Also, in this code, the SRSO_NO+SMT combo doesn't seem logically
possible, as srso_show_state() only gets called if X86_BUG_SRSO is set,
which only happens if SRSO_NO is not set by the HW/host in the first
place.  So here, if boot_cpu_has(X86_FEATURE_SRSO_NO), it means SRSO_NO
was manually set by srso_select_mitigation(), and SMT can't possibly be
enabled.

Instead of piggybacking on SRSO_NO, which is confusing, why not just add
a new mitigation type, like:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6c04aef4b63b..c925b98f5a15 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2343,6 +2343,7 @@ early_param("l1tf", l1tf_cmdline);
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
 	SRSO_MITIGATION_MICROCODE,
+	SRSO_MITIGATION_SMT,
 	SRSO_MITIGATION_SAFE_RET,
 	SRSO_MITIGATION_IBPB,
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
@@ -2359,6 +2360,7 @@ enum srso_mitigation_cmd {
 static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_NONE]           = "Vulnerable",
 	[SRSO_MITIGATION_MICROCODE]      = "Mitigation: microcode",
+	[SRSO_MITIGATION_SMT]		 = "Mitigation: SMT disabled",
 	[SRSO_MITIGATION_SAFE_RET]	 = "Mitigation: safe RET",
 	[SRSO_MITIGATION_IBPB]		 = "Mitigation: IBPB",
 	[SRSO_MITIGATION_IBPB_ON_VMEXIT] = "Mitigation: IBPB on VMEXIT only"
@@ -2407,19 +2409,15 @@ static void __init srso_select_mitigation(void)
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
 	} else {
-		/*
-		 * Enable the synthetic (even if in a real CPUID leaf)
-		 * flags for guests.
-		 */
+		/* Enable the synthetic flag, as HW doesn't set it. */
 		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
-			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+		if ((boot_cpu_data.x86 < 0x19) && !cpu_smt_possible()) {
+			srso_mitigation = SRSO_MITIGATION_SMT;
 			return;
 		}
 	}
@@ -2698,9 +2696,6 @@ static ssize_t retbleed_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
-	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Not affected\n");
-
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
