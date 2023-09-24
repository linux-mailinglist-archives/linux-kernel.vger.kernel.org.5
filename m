Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996947AC6DA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjIXGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXGr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:47:29 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2210B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:47:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 755AC40E01A1;
        Sun, 24 Sep 2023 06:47:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LiKNzCWlXoMu; Sun, 24 Sep 2023 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695538036; bh=miEjHzEWnf3ThiVWWF82uZ3MnsD7Klip9YHQ5JoyyeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKzdFnAgw71dF5Jk9kZcB6ovPeuJi/fNd/4vEuSrGZgbNkFD9y5EXcCYy9enx7H4Z
         qLTUpWXGKOmzBJS7bRzVkdyMNEOAdbSG3a0UJQXPvXjnc197Rr8M7YpYBEzlBJUYlY
         U3VToWD0Edm6V4T9PnTznPDftXUrAnXKsO3iKFfOTxYc+/BLT4GPV8BKoJWzAh9yri
         bMO7e87CdxfEPJKjWxLveM0mO9KXw0GSclxdz384hXB6g0Eq/OJa846RXFIREz4IZL
         p2OlwpiewpJSgEXMsvzSO++rEtyRFsf6DloAiCwJ5r+8Wl1n/WyM+bhti7NeB12oFF
         mrBNeggChT98AlDWBmXRR74r24Zi6O7kW07SPdH7+DJQBkPbNqavK/UIY9y8R1fJTS
         dQrt4aMKhlXoLWI7lRcfYJjN0wUlN7GA4NkHApEMQGPqqRbPkBhHEuNSRrWokytN6q
         Gtw9tmmtXC/hAgmMrO5Y1zl+CeZBPKrnDothiOXqyjI2xbc+Rdr7+s0efeSh96LJHN
         qdIVM4K1BQ75AZolQ4cPIUi4Kd7aWpv0LGr/JqyFFcwol1HvADy33W6G1Yq+w2YSJt
         Cb2LtR7AkWQZxBaUEC4jC0691jZIe6dGvlAZ3ZBTvAKqUAfn91XuDfZioUZQaXzHPk
         K49jKivj4MyxBvfoDJfuYZaE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5246240E0176;
        Sun, 24 Sep 2023 06:47:10 +0000 (UTC)
Date:   Sun, 24 Sep 2023 08:47:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 22/30] x86/microcode: Add per CPU control field
Message-ID: <20230924064705.GMZQ/baav2qVQ3CFju@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.143157215@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.143157215@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:18AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add a per CPU control field to ucode_ctrl and define constants for it:
> 
> SCTRL_WAIT    indicates that the CPU needs to spinwait with timeout
> SCTRL_APPLY   indicates that the CPU needs to invoke the microcode_apply()
> 	      callback
> SCTRL_DONE    indicates that the CPU can proceed without invoking the
> 	      microcode_apply() callback.

Can we put those explanations over the enum definition pls?

Also, s/indicates that //g when you do.

> In theory this could be a global control field, but a global control does
> not cover the following case:
> 
>  15 primary CPUs load microcode successfully
>   1 primary CPU fails and returns with an error code
> 
> With global control the sibling of the failed CPU would either try again or
> the whole operation would be aborted with the consequence that the 15
> siblings do not invoke the apply path and end up with inconsistent software
> state. The result in dmesg would be inconsistent too.
> 
> There are two additional fields added and initialized:
> 
> ctrl_cpu and secondaries. ctrl_cpu is the CPU number of the primary thread
> for now, but with the upcoming uniform loading at package or system scope
> this will be one CPU per package or just one CPU. Secondaries hands the
> control CPU a CPU mask which will be required to release the secondary CPUs
> out of the wait loop.

Also as a comment above their definitions pls.

> Preparatory change for implementing a properly split control flow for
> primary and secondary CPUs.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 
> ---
>  arch/x86/kernel/cpu/microcode/core.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> ---
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -324,8 +324,16 @@ static struct platform_device	*microcode
>   *   requirement can be relaxed in the future. Right now, this is conservative
>   *   and good.
>   */
> +enum sibling_ctrl {
> +	SCTRL_WAIT,
> +	SCTRL_APPLY,
> +	SCTRL_DONE,
> +};
> +
>  struct ucode_ctrl {
> +	enum sibling_ctrl	ctrl;
>  	enum ucode_state	result;
> +	unsigned int		ctrl_cpu;
>  };
>  
>  static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
> @@ -468,7 +476,7 @@ static int ucode_load_late_stop_cpus(voi
>   */
>  static bool ucode_setup_cpus(void)
>  {
> -	struct ucode_ctrl ctrl = { .result = -1, };
> +	struct ucode_ctrl ctrl = { .ctrl = SCTRL_WAIT, .result = -1, };
>  	unsigned int cpu;
>  
>  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> @@ -478,7 +486,15 @@ static bool ucode_setup_cpus(void)
>  				return false;
>  			}
>  		}
> -		/* Initialize the per CPU state */
> +
> +		/*
> +		 * Initialize the per CPU state. This is core scope for now,
> +		 * but prepared to take package or system scope into account.
> +		 */
> +		if (topology_is_primary_thread(cpu))
> +			ctrl.ctrl_cpu = cpu;
> +		else
> +			ctrl.ctrl_cpu = cpumask_first(topology_sibling_cpumask(cpu));

<---- newline here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
