Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F67AC6CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjIXGaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:29:59 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C09101
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:29:52 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E545A40E01A2;
        Sun, 24 Sep 2023 06:29:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Eg7mKXJ503s; Sun, 24 Sep 2023 06:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695536986; bh=hKz6s3keNFk3R1YlBi5bD0V/GglNZDFdSDbMdZSJZtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtnYzmc9+flUAM3xDvwpzdJdzEMH+MeFh7D3V3pQgNf+q2d6ZtfnrzlgotF8PC28U
         M+OJkCuQLGAfGZHGczREGcJD9khioHqTWnSTtT96GVglec84uYO99gcvL+9g2Iffka
         pCWsgyB/8uKXiIZSnw9YXIQRzQugidvnCree0ZwFQGVyU8ryTAGPFZAYuf/eLArsRu
         fuY22mSiOKd8DbCRU+5nkiTjKbuHSgbxhvsLRNbrAyA2RTLVUokzf6M56xHFHOVYvG
         yLQqgkRTM22P8liiAjU1BLrpJm4iXggKj46WINmUaY1yEPq85dY/9NOoNBoWmtYorM
         dcR5nFYFENmrWAhXwKPyGtyMtn8y22sdWhBNRV/1tNW8VrNSAVaa+0NzT9eHBtMBrl
         uO16tbJJiYdjm5zrjlEnDCVfj46BBFDuSehu9ztlax4vV+O1qAcyNVfUmje0X9j71s
         7FbRWI1KT25WDQdVSnxP5/cwFYEuf7ZwN+fETzDY2Qr6vW3TCLlDoNu7vTIMBmYIUG
         EkFQNAEAmzWwgmXZ7FW4J/Rl4IlKJVzY7YLqC221v5vWSwpur5PbFzLlk1UtUIyYEv
         5Wvin0xTgAwQMQ8Dg2/54c9Afm2/FM6S+auiHTXsJ7gtmOcHLbEpqxCCn//37uPhpa
         ARyZqN+aXTZ5IWOutbQ2A0mE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8905340E01A1;
        Sun, 24 Sep 2023 06:29:40 +0000 (UTC)
Date:   Sun, 24 Sep 2023 08:29:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 21/30] x86/microcode: Add per CPU result state
Message-ID: <20230924062934.GLZQ/XThoM7jsrjmrt@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.082789879@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.082789879@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:16AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The microcode rendevouz is purely acting on global state, which does not

rendezvous

> allow to analyze fails in a coherent way.
> 
> Introduce per CPU state where the results are written into, which allows to
> analyze the return codes of the individual CPUs.
> 
> Initialize the state when walking the cpu_present_mask in the online check
> to avoid another for_each_cpu() loop.
> 
> Enhance the result print out with that.
> 
> The structure is intentionally named ucode_ctrl as it will gain control
> fields in subsequent changes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/microcode/core.c     |  108 ++++++++++++++++++-------------
>  arch/x86/kernel/cpu/microcode/internal.h |    1 
>  2 files changed, 65 insertions(+), 44 deletions(-)
> ---
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -324,6 +324,11 @@ static struct platform_device	*microcode
>   *   requirement can be relaxed in the future. Right now, this is conservative
>   *   and good.
>   */
> +struct ucode_ctrl {

microcode_ctrl

I know "ucode" is shorter but we already call everything new-er
"microcode_" and this'll cause confusion.

> +	enum ucode_state	result;
> +};
> +
> +static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);

You could do

static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);

so that the naming is different too.

>  static atomic_t late_cpus_in, late_cpus_out;
>  
>  static bool wait_for_cpus(atomic_t *cnt)
> @@ -344,23 +349,19 @@ static bool wait_for_cpus(atomic_t *cnt)
>  	return false;
>  }
>  
> -/*
> - * Returns:
> - * < 0 - on error
> - *   0 - success (no update done or microcode was updated)
> - */
> -static int __reload_late(void *info)
> +static int ucode_load_cpus_stopped(void *unused)

No need for "ucode_" prefixes to static functions.

>  {
>  	int cpu = smp_processor_id();
> -	enum ucode_state err;
> -	int ret = 0;
> +	enum ucode_state ret;
>  
>  	/*
>  	 * Wait for all CPUs to arrive. A load will not be attempted unless all
>  	 * CPUs show up.
>  	 * */
> -	if (!wait_for_cpus(&late_cpus_in))
> -		return -1;
> +	if (!wait_for_cpus(&late_cpus_in)) {
> +		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
> +		return 0;

So the only value this function returns is 0 now.
stop_machine_cpuslocked() still does pay attention at ret so I guess it
should return non-null/negative on error or so?

>  	/*
>  	 * On an SMT system, it suffices to load the microcode on one sibling of
> @@ -369,17 +370,11 @@ static int __reload_late(void *info)
>  	 * loading attempts happen on multiple threads of an SMT core. See
>  	 * below.
>  	 */
> -	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
> -		err = microcode_ops->apply_microcode(cpu);
> -	else
> +	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
>  		goto wait_for_siblings;
>  
> -	if (err >= UCODE_NFOUND) {
> -		if (err == UCODE_ERROR) {
> -			pr_warn("Error reloading microcode on CPU %d\n", cpu);
> -			ret = -1;
> -		}
> -	}
> +	ret = microcode_ops->apply_microcode(cpu);
> +	this_cpu_write(ucode_ctrl.result, ret);
>  
>  wait_for_siblings:
>  	if (!wait_for_cpus(&late_cpus_out))
> @@ -391,19 +386,18 @@ static int __reload_late(void *info)
>  	 * per-cpu cpuinfo can be updated with right microcode
>  	 * revision.
>  	 */
> -	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
> -		err = microcode_ops->apply_microcode(cpu);
> +	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
> +		return 0;
>  
> -	return ret;
> +	ret = microcode_ops->apply_microcode(cpu);
> +	this_cpu_write(ucode_ctrl.result, ret);
> +	return 0;
>  }
>  
> -/*
> - * Reload microcode late on all CPUs. Wait for a sec until they
> - * all gather together.
> - */
> -static int microcode_reload_late(void)
> +static int ucode_load_late_stop_cpus(void)

s/ucode_//

>  {
> -	int old = boot_cpu_data.microcode, ret;
> +	unsigned int cpu, updated = 0, failed = 0, timedout = 0, siblings = 0;
> +	int old_rev = boot_cpu_data.microcode;
>  	struct cpuinfo_x86 prev_info;
>  
>  	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> @@ -418,26 +412,47 @@ static int microcode_reload_late(void)
>  	 */
>  	store_cpu_caps(&prev_info);
>  
> -	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
> +	stop_machine_cpuslocked(ucode_load_cpus_stopped, NULL, cpu_online_mask);
> +
> +	/* Analyze the results */
> +	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> +		switch (per_cpu(ucode_ctrl.result, cpu)) {
> +		case UCODE_UPDATED:	updated++; break;
> +		case UCODE_TIMEOUT:	timedout++; break;
> +		case UCODE_OK:		siblings++; break;
> +		default:		failed++; break;
> +		}

Align vertically.

> +	}
>  
>  	if (microcode_ops->finalize_late_load)
> -		microcode_ops->finalize_late_load(ret);
> +		microcode_ops->finalize_late_load(!updated);
>  
> -	if (!ret) {
> -		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
> -			old, boot_cpu_data.microcode);
> -		microcode_check(&prev_info);
> -		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> -	} else {
> -		pr_info("Reload failed, current microcode revision: 0x%x\n",
> -			boot_cpu_data.microcode);
> +	if (!updated) {
> +		/* Nothing changed. */
> +		if (!failed && !timedout)
> +			return 0;
> +		pr_err("Microcode update failed: %u CPUs failed %u CPUs timed out\n",
> +		       failed, timedout);
> +		return -EIO;
>  	}
> -	return ret;
> +
> +	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +	pr_info("Microcode load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
> +	if (failed || timedout) {
> +		pr_err("Microcode load incomplete. %u CPUs timed out or failed\n",
> +		       num_online_cpus() - (updated + siblings));
> +	}
> +	pr_info("Microcode revision: 0x%x -> 0x%x\n", old_rev, boot_cpu_data.microcode);

You don't need "Microcode" in those strings - the pr_info has already
"microcode:" as prefix.

> +	microcode_check(&prev_info);
> +
> +	return updated + siblings == num_online_cpus() ? 0 : -EIO;
>  }
>  
>  /*
> - *  Ensure that all required CPUs which are present and have been booted
> - *  once are online.
> + * This function does two things:
> + *
> + * 1) Ensure that all required CPUs which are present and have been booted
> + *    once are online.
>   *
>   *    To pass this check, all primary threads must be online.
>   *
> @@ -448,9 +463,12 @@ static int microcode_reload_late(void)
>   *    behaviour is undefined. The default play_dead() implementation on
>   *    modern CPUs is using MWAIT, which is also not guaranteed to be safe
>   *    against a microcode update which affects MWAIT.
> + *
> + * 2) Initialize the per CPU control structure
>   */
> -static bool ensure_cpus_are_online(void)
> +static bool ucode_setup_cpus(void)

s/ucode_//

>  {
> +	struct ucode_ctrl ctrl = { .result = -1, };
>  	unsigned int cpu;
>  
>  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
