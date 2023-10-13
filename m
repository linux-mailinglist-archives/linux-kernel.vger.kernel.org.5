Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F27C889F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjJMP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjJMP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7BCC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697210795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mUdyGKrhTvWzjp7XpWrq9UCsdSwHboq+VnImVBM5VZ4=;
        b=ReU36xhWm1fRg196v4z0pxKn+DKzwa9oc/huKPBHa+cwXgKPJukuu8rxIVOshDvmQEhUfH
        px/d0w1kCC3iIdr5hTZ20sg19Gk6P1sSMencLdUsUZSi7KJ6833dGUxFzyVrzCcT7heJLN
        znf6yqUzRuhXFfrEsw1uiz02fcAMU90=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-6dCuIPGpMmCwFF9kt8A13w-1; Fri, 13 Oct 2023 11:26:28 -0400
X-MC-Unique: 6dCuIPGpMmCwFF9kt8A13w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6b2dff02dfcso629908b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210788; x=1697815588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUdyGKrhTvWzjp7XpWrq9UCsdSwHboq+VnImVBM5VZ4=;
        b=Rd3OZTgbfcMWKLcJexIinxwqP3aB8mVl3WM+7Qj1pPsbK4k5FnoLPSeOaofFYKvAKx
         E5jDexPM4jwqj+hwYNVMod8VOOJpIvX4VeKzwpU7qf5bIon8pIHJoiV65+a1rMiqCBgj
         iBgHaFKzRN6vCfUUQxoKHY0XjwlCjt7/NAQAvR3GjQkudmamOOE8UP2h5zMGL2OyZSiu
         0Lpvs1nesLi6c9c7t7Yl7vNfargkzuKcFaaYGEBTWo9aR5u3LBD73yhwj/+t/2XvjPSw
         n8EnmDUvUglElXNf+Ks0QpaKmELb3Xlr8nYS6BkQ/K9C7OmHUho37pxaD/yu2vILhr9w
         o2rg==
X-Gm-Message-State: AOJu0YyGhAvbdUqtKU2iJFrqejHsSZeC6/68TdWBwC1bamGmHZz9W3e9
        uYbxWvEenQIFmaR2eu5a2nX5QSEMA54DM5UZg6/7XVx+B3UkduF+egDp667Uy7125pzFF9RJCAz
        oESwD2ruJCTFNAGnX98MIdlqa
X-Received: by 2002:a05:6a00:8c7:b0:68b:e710:ee9c with SMTP id s7-20020a056a0008c700b0068be710ee9cmr32827278pfu.19.1697210787874;
        Fri, 13 Oct 2023 08:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdz5NBa4dtFt7emb8U609yGEVLPswchIPrAH3ophOZ9xhZ2QHHxm7yDuRdiRpg2RrHSvIUQ==
X-Received: by 2002:a05:6a00:8c7:b0:68b:e710:ee9c with SMTP id s7-20020a056a0008c700b0068be710ee9cmr32827258pfu.19.1697210787487;
        Fri, 13 Oct 2023 08:26:27 -0700 (PDT)
Received: from redhat.com ([2804:431:c7ec:597b:9920:d8b1:f175:73f7])
        by smtp.gmail.com with ESMTPSA id m11-20020a656a0b000000b0059d6f5196fasm3102920pgu.78.2023.10.13.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:26:26 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:26:22 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Message-ID: <ZSlhnu0n9eOfkN-U@redhat.com>
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
 <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:39:38AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 06, 2023 at 10:32:07AM +1100, Imran Khan wrote:
> > Hello Paul,
> > 
> > On 6/10/2023 3:48 am, Paul E. McKenney wrote:
> > > The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> > > temporarily, it usually gets released in a few seconds, and sometimes
> > > up to one or two minutes.
> > > 
> > > If the CSD lock stays stuck for more than several minutes, it never
> > > seems to get unstuck, and gradually more and more things in the system
> > > end up also getting stuck.
> > > 
> > > In the latter case, we should just give up, so the system can dump out
> > > a little more information about what went wrong, and, with panic_on_oops
> > > and a kdump kernel loaded, dump a whole bunch more information about
> > > what might have gone wrong.
> > > 
> > > Question: should this have its own panic_on_ipistall switch in
> > > /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> > > way than via BUG_ON?
> > > 
> > panic_on_ipistall (set to 1 by default) looks better option to me. For systems
> > where such delay is acceptable and system can eventually get back to sane state,
> > this option (set to 0 after boot) would prevent crashing the system for
> > apparently benign CSD hangs of long duration.
> 
> Good point!  How about like the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 6bcf3786291b86f13b3e13d51e998737a8009ec3
> Author: Rik van Riel <riel@surriel.com>
> Date:   Mon Aug 21 16:04:09 2023 -0400
> 
>     smp,csd: Throw an error if a CSD lock is stuck for too long
>     
>     The CSD lock seems to get stuck in 2 "modes". When it gets stuck
>     temporarily, it usually gets released in a few seconds, and sometimes
>     up to one or two minutes.
>     
>     If the CSD lock stays stuck for more than several minutes, it never
>     seems to get unstuck, and gradually more and more things in the system
>     end up also getting stuck.
>     
>     In the latter case, we should just give up, so the system can dump out
>     a little more information about what went wrong, and, with panic_on_oops
>     and a kdump kernel loaded, dump a whole bunch more information about what
>     might have gone wrong.  In addition, there is an smp.panic_on_ipistall
>     kernel boot parameter that by default retains the old behavior, but when
>     set enables the panic after the CSD lock has been stuck for more than
>     five minutes.
>     
>     [ paulmck: Apply Imran Khan feedback. ]
>     
>     Link: https://lore.kernel.org/lkml/bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop/
>     Signed-off-by: Rik van Riel <riel@surriel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Valentin Schneider <vschneid@redhat.com>
>     Cc: Juergen Gross <jgross@suse.com>
>     Cc: Jonathan Corbet <corbet@lwn.net>
>     Cc: Randy Dunlap <rdunlap@infradead.org>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..592935267ce2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5858,6 +5858,11 @@
>  			This feature may be more efficiently disabled
>  			using the csdlock_debug- kernel parameter.
>  
> +	smp.panic_on_ipistall= [KNL]
> +			If a csd_lock_timeout extends for more than
> +			five minutes, panic the system.  By default, let
> +			CSD-lock acquisition take as long as they take.
> +

It could be interesting to have it as an s64 parameter (in {mili,}seconds) 
instead of bool, this way the user could pick the time to wait before the 
panic happens. 0 or -1 could mean disabled.

What do you think?

Other than that,
Reviewed-by: Leonardo Bras <leobras@redhat.com>


>  	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
>  	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
>  	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 8455a53465af..b6a0773a7015 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -170,6 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
>  
>  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
>  module_param(csd_lock_timeout, ulong, 0444);
> +static bool panic_on_ipistall;
> +module_param(panic_on_ipistall, bool, 0444);
>  
>  static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  
> @@ -230,6 +232,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	}
>  
>  	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
> @@ -243,9 +246,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	else
>  		cpux = cpu;
>  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>  		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> 

