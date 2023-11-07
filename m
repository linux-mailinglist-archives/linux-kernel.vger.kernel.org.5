Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D17E494E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbjKGTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKGTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:38:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AFF184
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:38:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so5007727b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699385924; x=1699990724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YooUC7wAsbwQVIzHaC9GP78WuDWccMbkHNxr3T9dcU8=;
        b=SHO0GuRSVmR3NkFDKLuOmMTRpnjuXHByiMpTIlppa7Unm+OtZV8cb5iTe7uEF/XsZp
         gELRhztEhAFgCq6boC9gYFVLZZ0EahfG6zEbNcTDl+33DeC7xR9JJbLPB7hkck+AMUVa
         na9YBRNfRJrxTPSLwKoDOoGmUNwPvGkqqU40aFiwM/IDptwuykNbspzPNCVgL4Ci1SL0
         xS9IWWENRJn7IMuBjSzEoKURdR2ieu9tIIYECCkGBUFrQqybR4XSqpPST2vew2l/CIBM
         DJPbmOV7zAd/V0r0+e67ch5J+yT95ULt+gQECark9DllUzQ3xoeMXvTgZuJ3LNsD6NLR
         fQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385924; x=1699990724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YooUC7wAsbwQVIzHaC9GP78WuDWccMbkHNxr3T9dcU8=;
        b=lKxNbDQZCV+e05V0gtJqU0VimL8BjU2wnSHaXgi5TbH/Y9SM4fBSl/6DWzK93poyLH
         gFMLVu9EvqR6A1jaQeyCfVxo6XLcKxfbCLVGv4MwQLGAo917vswHxf9t1cvEZNWeWMr4
         t1w6LVY0Zir+sDDBkke3wUR5PaAhJa5q1MmLICcwAIlCzcIcOJt/aTsNkghyOmCMMAJv
         DumruTj5iwHnjZ96SfB3OF1pc0OnVyF0GwaDjJFKScAJI4eUSik3AZIIJVHx4WviGAZK
         tFNMleyhyQIq3H58RO1a+XhS3PektaAAKykAJlwUaQAtV2sj+ovuvksZcOi7cV5QU1wz
         FuKA==
X-Gm-Message-State: AOJu0YxuC0USjA6vRV9m6y+CrrHYAnAxGTEmh2MQmatbX7a1XO0n3R9n
        kaomOr5Sk/vfRfS1i0xlfvPEZA==
X-Google-Smtp-Source: AGHT+IHmbIbXorHTfL5S4I7xTQbCC49re91nec9ePgSbTGNsHsMMYSN/YNxaUQSEyWTR2+dTypAeRA==
X-Received: by 2002:a05:6a20:4422:b0:13d:8876:4c97 with SMTP id ce34-20020a056a20442200b0013d88764c97mr33581954pzb.16.1699385924171;
        Tue, 07 Nov 2023 11:38:44 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7810e000000b006be17e60708sm7485929pfi.204.2023.11.07.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:38:43 -0800 (PST)
Date:   Tue, 7 Nov 2023 19:38:40 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM
 guest-only events
Message-ID: <ZUqSQKHwvKQs7_qA@google.com>
References: <20231107183605.409588-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107183605.409588-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Sean Christopherson wrote:
> Don't apply minimum period workarounds/requirements to events that are
> being created by KVM to virtualize PMCs for guests, i.e. skip limit
> enforcement for events that exclude the host.  Perf's somewhat arbitrary
> limits prevents KVM from correctly virtualizing counter overflow, e.g. if
> the guest sets a counter to have an effective period of '1', forcing a
> minimum period of '2' results in overflow occurring at the incorrect time.
> 
> Whether or not a "real" profiling use case is affected is debatable, but
> the incorrect behavior is trivially easy to observe and reproduce, and is
> deterministic enough to make the PMU appear to be broken from the guest's
> perspective.
> 
> Furthermore, the "period" set by KVM isn't actually a period, as KVM won't
> automatically reprogram the event with the same period on overflow.  KVM
> will synthesize a PMI into the guest when appropriate, but what the guest
> does in response to the PMI is purely a guest decision.  In other words,
> KVM effectively operates in a one-shot mode, not a periodic mode.
> 
> Letting KVM and/or the guest program "too small" periods is safe for the
> host, as events that exclude the host are atomically disabled with respect
> to VM-Exit, i.e. are guaranteed to stop counting upon transitioning to the
> host.  And whether or not *explicitly* programming a short period is safe
> is somewhat of a moot point, as transitions to/from the guest effectively
> yield the same effect, e.g. an unrelated VM-Exit => VM-Enter transition
> will re-enable guest PMCs with whatever count happened to be in the PMC at
> the time of VM-Exit.
> 
> Cc: Like Xu <likexu@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Disclaimer: I've only tested this from KVM's side of things.
> 
>  arch/x86/events/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 40ad1425ffa2..f8a8a4ea4d47 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_event *event)
>  		hwc->last_period = period;
>  		ret = 1;
>  	}
> -	/*
> -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> -	 */
> -	if (unlikely(left < 2))
> -		left = 2;
>  
>  	if (left > x86_pmu.max_period)
>  		left = x86_pmu.max_period;
>  
> -	static_call_cond(x86_pmu_limit_period)(event, &left);
> +	/*
> +	 * Exempt KVM guest events from the minimum period requirements.  It's
> +	 * the guest's responsibility to ensure it can make forward progress,
> +	 * and it's KVM's responsibility to configure an appropriate "period"
> +	 * to correctly virtualize overflow for the guest's PMCs.
> +	 */
> +	if (!event->attr.exclude_host) {
> +		/*
> +		 * Quirk: certain CPUs dont like it if just 1 event is left:
> +		 */
> +		if (unlikely(left < 2))
> +			left = 2;
> +
> +		static_call_cond(x86_pmu_limit_period)(event, &left);
> +	}
>  
>  	this_cpu_write(pmc_prev_left[idx], left);
>  

Nice one. I am curious how you tested this one? I would like to
reproduce that one on my side.

>
> base-commit: 744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
