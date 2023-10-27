Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17B7D9E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjJ0Qie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjJ0Qic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:38:32 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434F11B;
        Fri, 27 Oct 2023 09:38:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A50320004;
        Fri, 27 Oct 2023 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698424706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ek39OqwYg/m1N32pN0YWnCrzQoTlfIvGPB8z1vPcH9U=;
        b=XZCStyDItBJ3g1+fgkCjgTheffh86nF9+NLQRxokdrBwqUShLOjLBtqpa5JvzZ1di84h+W
        MFoQK8xc+VhPiBPHrUa5EEq+BHPIlv5N2I/dwYabGlBke+j24N+Dx4QBV0K/oQ4wDQPE+u
        dRcDSVegF/TlOarhM8xV5LMrlA9uJ1TOVr4XZZhLMMeQ6CsjNL7bEuji60Xn2K+BLtjtCm
        UbK7B6YKgCJpmLdZVb1bWCqHVKQMYIh4o6M1otyFgSSNFHT2K5T2A52OyounUzf6q0b5JC
        AUjrkPE0ed9+4AAgK2dSsL9P8SKuX62/b85H/PW6sIMdh1CiSb3N1U+yZHXFvA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 4/5] MIPS: Handle mips_cps_core_entry within lower 4G
In-Reply-To: <20231023191400.170052-5-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
 <20231023191400.170052-5-jiaxun.yang@flygoat.com>
Date:   Fri, 27 Oct 2023 18:38:26 +0200
Message-ID: <8734xw81h9.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiaxun Yang <jiaxun.yang@flygoat.com> writes:

> Set CM_GCR_Cx_RESET_BASE_MODE and use XKPHYS base address for
> core_entry for 64bit CM when mips_cps_core_entry is beyond
> KSEG1.
>
> Also disable SMP and warn user if mips_cps_core_entry is
> unsuitable as reset vector.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Note: IMO it does not solve the problem of MobileEye,
> which have mips_cps_core_entry beyond lower 4G,
> it just enables me to test kernel in XKPHYS on boston.
> ---
>  arch/mips/include/asm/mips-cm.h |  1 +
>  arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> index 23c67c0871b1..15d8d69de455 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -311,6 +311,7 @@ GCR_CX_ACCESSOR_RW(32, 0x018, other)
>  /* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
>  GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
>  #define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
> +#define CM_GCR_Cx_RESET_BASE_MODE		BIT(1)
>  
>  /* GCR_Cx_ID - Identify the current core */
>  GCR_CX_ACCESSOR_RO(32, 0x028, id)
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index dd55d59b88db..623dfd05585b 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -26,6 +26,7 @@
>  #include <asm/uasm.h>
>  
>  static DECLARE_BITMAP(core_power, NR_CPUS);
> +static uint32_t core_entry_reg;
>  
>  struct core_boot_config *mips_cps_core_bootcfg;
>  
> @@ -37,7 +38,6 @@ static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
>  static void __init cps_smp_setup(void)
>  {
>  	unsigned int nclusters, ncores, nvpes, core_vpes;
> -	unsigned long core_entry;
>  	int cl, c, v;
>  
>  	/* Detect & record VPE topology */
> @@ -94,10 +94,20 @@ static void __init cps_smp_setup(void)
>  	/* Make core 0 coherent with everything */
>  	write_gcr_cl_coherence(0xff);
>  
> -	if (mips_cm_revision() >= CM_REV_CM3) {
> -		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
> -		write_gcr_bev_base(core_entry);
> -	}
> +	/*
> +	 * Set up the core entry address
> +	 * If accessible in KSEG1 just use KSEG1
> +	 */
> +	if (__pa_symbol(mips_cps_core_entry) < SZ_512M)
> +		core_entry_reg =  CKSEG1ADDR(__pa_symbol(mips_cps_core_entry));
> +
> +	/* If CM is 64bit and with-in low 4G just use XKPHYS */
> +	if (mips_cm_is64 && __pa_symbol(mips_cps_core_entry) < SZ_4G)
> +		core_entry_reg =  __pa_symbol(mips_cps_core_entry) |
> +					CM_GCR_Cx_RESET_BASE_MODE;
> +
> +	if (core_entry_reg && mips_cm_revision() >= CM_REV_CM3)
> +		write_gcr_bev_base(core_entry_reg);
>  
>  #ifdef CONFIG_MIPS_MT_FPAFF
>  	/* If we have an FPU, enroll ourselves in the FPU-full mask */
> @@ -114,6 +124,11 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
>  
>  	mips_mt_set_cpuoptions();
>  
> +	if (!core_entry_reg) {
> +		pr_err("core_entry address unsuitable, disabling smp-cps\n");
> +		goto err_out;
> +	}
> +
>  	/* Detect whether the CCA is unsuited to multi-core SMP */
>  	cca = read_c0_config() & CONF_CM_CMASK;
>  	switch (cca) {
> @@ -213,7 +228,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
>  	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
>  
>  	/* Set its reset vector */
> -	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
> +	write_gcr_co_reset_base(core_entry_reg);
>  
>  	/* Ensure its coherency is disabled */
>  	write_gcr_co_coherence(0);

For my point of view the following chunk is missing, and in my tests it
was needed to have this part to fully boot.
Maybe you don't have VP core in tour hardware.

@@ -349,8 +355,8 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 
        if (cpu_has_vp) {
                mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
-               core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
-               write_gcr_co_reset_base(core_entry);
+               write_gcr_co_reset_base(core_entry_reg);
+
                mips_cm_unlock_other();
        }


> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
