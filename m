Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608EA7FEDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjK3LPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3LPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:15:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDBD66;
        Thu, 30 Nov 2023 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Znib/mlXynP7QEaUM1Vt8q5PW5YyGqKpMcVV5Eojr9w=; b=ToH+CX/UgvXhWlmi0wJzixANXZ
        vA8DFjG6W4jwaVntxBVQUUlnv+MphluAGUPM5JC2AkJRDsYgCeEOmKlInyZXerqgbApIVB0XRPDPd
        4pgXT/v5EAN9S37qGe75+0czR6UYDbwMiM240UtqyVPgEwon0Ve5TnFP4PSXtxaexw5Js+xuWypME
        M4CG9eVG0XQCbTkuQC80GPa6Gb+W76sOBXa+Mm4rAL/sA3VKkh+HEdM8LkI/2Ed9T1cM45J24XeId
        RR58j2JHrVzHyBsg9u/sMydGIO5589EY5qOTsnt0UtnpE+QdRHrwUXk7/L+qR6rYwza/F47pzLpgU
        H5eZzCBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8f0p-0012EQ-2q;
        Thu, 30 Nov 2023 11:15:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31E97300293; Thu, 30 Nov 2023 12:15:19 +0100 (CET)
Date:   Thu, 30 Nov 2023 12:15:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
 reprogram
Message-ID: <20231130111519.GA20153@noisy.programming.kicks-ass.net>
References: <20231115151325.6262-3-frederic@kernel.org>
 <170126975511.398.12493947150541739641.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170126975511.398.12493947150541739641.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:55:55PM -0000, tip-bot2 for Peter Zijlstra wrote:
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 341ee4f..920426d 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -124,8 +124,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>  		}
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> -		if (!need_resched())
> -			__mwait(eax, ecx);
> +
> +		if (!need_resched()) {
> +			if (ecx & 1) {
> +				__mwait(eax, ecx);
> +			} else {
> +				__sti_mwait(eax, ecx);
> +				raw_local_irq_disable();
> +			}
> +		}

Andrew noted that this is only safe if it precludes #DB from happening
on mwait, because #DB can wreck the STI shadow thing.

> @@ -159,19 +160,13 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
>  static __cpuidle int intel_idle(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int index)
>  {
> +	return __intel_idle(dev, drv, index, true);
>  }
>  
>  static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>  				    struct cpuidle_driver *drv, int index)
>  {
> +	return __intel_idle(dev, drv, index, false);
>  }
>  
>  static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
> @@ -184,7 +179,7 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>  	if (smt_active)
>  		__update_spec_ctrl(0);
>  
> +	ret = __intel_idle(dev, drv, index, true);
>  
>  	if (smt_active)
>  		__update_spec_ctrl(spec_ctrl);
> @@ -196,7 +191,7 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
>  				       struct cpuidle_driver *drv, int index)
>  {
>  	fpu_idle_fpregs();
> +	return __intel_idle(dev, drv, index, true);
>  }

This is so, because all mwait users should be in __cpuidle section,
which itself is part of the noinstr section and as such
kprobes/hw-breakpoints etc.. are disallowed.

Notable vmlinux.lds.h has:

#define NOINSTR_TEXT							\
		ALIGN_FUNCTION();					\
		__noinstr_text_start = .;				\
		*(.noinstr.text)					\
		__cpuidle_text_start = .;				\
		*(.cpuidle.text)					\
		__cpuidle_text_end = .;					\
		__noinstr_text_end = .;
