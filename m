Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE87E4C65
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbjKGXCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjKGXCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:02:48 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8C10C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:02:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1682607eso49599595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699398165; x=1700002965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EVsKpDQ2kjOduD9kf9++j1jY5Py297YD+PLdhOq3bk=;
        b=mTM9+LoPPe5ZETe1SinIcv6pmXVJ9H1CwVrT11XSmRiiHqfYFhjgdM03zf3WdJWTTG
         D1W9KBBn/YtjJBs7E9IlfVghrULoNHBj3ML8g0Dcxjw6jTwlSV27u8XJRMdIvf28smnN
         We0+fAs1U39aLGhqBUKpgGAVqdTt9nCcH+n3NK/t4+XWkzG3SWbaEMDan0hxnknnl/hz
         B9TeWrXN13+RLbRKqNk41PRXNzn9Ck/M6oCGsqcr7A9LoQIv5tQJdGosWxNytefga0Ed
         RJLVJUN1Ovs3Ix1Fn0cLX5mMeATRqdyGjWk+uL3uDlebcEHI1Gvax1VPsNcgBWHUF2pH
         MSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398165; x=1700002965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EVsKpDQ2kjOduD9kf9++j1jY5Py297YD+PLdhOq3bk=;
        b=PzrXE4F6jPzHECtNyibA511FUY722GRmdvf/2Qh+SFiADhAzlx+oZDC6pUkwttE8z1
         pKJJZ13zU7qV7/nGMolO+WoZi8O+vdvur8mdOVll9wRFSeasK0HJYtqKykfmFiJ24Zwe
         tH9N5Q7cx9mCRmAs5ehsHKMlserxl9Gaw4D6iEwXamt9poWuemML5vbu82lK4jnPIdkw
         XzEugUUaCvQ19uVQXyIjgjquzB47xUR/3/NTY8VpQ0vJvoDeS7dmwBxHahOtYcpXB+SR
         xdi0qYAdub3clLHw3LNn1KPqlJhw4TLz9MbbedSQjgr1ehxJj3DnKoH1p2GhTofQkLVL
         AwsQ==
X-Gm-Message-State: AOJu0Yy17nYJKg5oyWfGAn3yfm2MDJ53LDaQrLfzuk3UH7RigFTAlj9c
        n4MklrrfgHNWgTJybvZ7RZFCeYmw4M0=
X-Google-Smtp-Source: AGHT+IFLGhmdifdfEZseQ28YW9EhMqsnGxCCvj5bzGJ8Mr/sYu8XEsUXxO+Dn9NoXwtjRS0sPvB8BCRLmO4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef84:b0:1cc:b65:fdb5 with SMTP id
 iz4-20020a170902ef8400b001cc0b65fdb5mr8143plb.0.1699398165461; Tue, 07 Nov
 2023 15:02:45 -0800 (PST)
Date:   Tue, 7 Nov 2023 15:02:43 -0800
In-Reply-To: <ZUqSQKHwvKQs7_qA@google.com>
Mime-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <ZUqSQKHwvKQs7_qA@google.com>
Message-ID: <ZUrCE9j1Gvw4zacY@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Mingwei Zhang wrote:
> On Tue, Nov 07, 2023, Sean Christopherson wrote:
> >  arch/x86/events/core.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 40ad1425ffa2..f8a8a4ea4d47 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_event *event)
> >  		hwc->last_period = period;
> >  		ret = 1;
> >  	}
> > -	/*
> > -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> > -	 */
> > -	if (unlikely(left < 2))
> > -		left = 2;
> >  
> >  	if (left > x86_pmu.max_period)
> >  		left = x86_pmu.max_period;
> >  
> > -	static_call_cond(x86_pmu_limit_period)(event, &left);
> > +	/*
> > +	 * Exempt KVM guest events from the minimum period requirements.  It's
> > +	 * the guest's responsibility to ensure it can make forward progress,
> > +	 * and it's KVM's responsibility to configure an appropriate "period"
> > +	 * to correctly virtualize overflow for the guest's PMCs.
> > +	 */
> > +	if (!event->attr.exclude_host) {
> > +		/*
> > +		 * Quirk: certain CPUs dont like it if just 1 event is left:
> > +		 */
> > +		if (unlikely(left < 2))
> > +			left = 2;
> > +
> > +		static_call_cond(x86_pmu_limit_period)(event, &left);
> > +	}
> >  
> >  	this_cpu_write(pmc_prev_left[idx], left);
> >  
> 
> Nice one. I am curious how you tested this one? I would like to
> reproduce that one on my side.

The check_emulated_instr() sub-test in KVM-Unit-Tests's x86/pmu.c fails when run
with "my" (which is really yours) fix for the KVM's handling of emulated PMC
events[*].  If KVM synthesizes an "instructions retired" event that bumps the
PMC to all ones, i.e. -1 for all intents and purposes, the test fails because
KVM creates a sample_period of '1', but perf programs a period of '2'.

I suspect a very simple test of writing -1 to a PMC from the guest would exhibit
the same behavior.

[*] https://lkml.kernel.org/r/ZUWAg3WP2XESCAR4%40google.com
