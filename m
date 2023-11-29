Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8DF7FCC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbjK2BdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:33:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26364183
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:33:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da39d244087so7441164276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701221598; x=1701826398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOZ4wahs3lobvOneDy8Jd5Ygdm6wAPNocIR2yUTw9Co=;
        b=PnOs/mTB+UZFcfgkl/eOoXceVOBF34eTKjpbAZnbEQcOnRB6OCbbpSa0nb+gFFnNBL
         R5QINtMz7/9/FfP4DrcVq6GwEkMl9Q/Kc1Y8MNpM0b/aYiGjHcMXlX1025le7eloitOP
         npjQ2la37cOxtlu30553XWGmVEcCHnBMJYLzpfMUMUvTIbn9IvUu8iu0msbfVh4/v5pZ
         ei5tDYcf1RA7KlHIVyJZCn8AMgBFBatvY3TJzSmLTYntWYG0aHZgMFrEPM4mmkxGNEIw
         Wurmx4nLt8sEdLgJ6xitjlVdgJDVABBHzHWsmQGox0qhvxF6MLiNHdMob5MZH5sxHqv7
         e6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221598; x=1701826398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOZ4wahs3lobvOneDy8Jd5Ygdm6wAPNocIR2yUTw9Co=;
        b=MBa22aBGoYwz8ms4TEj0XDtW0oZGPmZcAIQ1WmcTxcp7TpBIdxjKay7xnGwcvJzF9R
         SE12uhvKy9YGOPbR+qiBC/5DesAOgOjgMCRtfcjylhQsf4Sia3MCyslGFUHXT3nO2dMc
         sTU70o9jhh0lDcJyghL419iaXYwtdNC5caHoWoc1aLOMTxsKavIzXGpdM8l4D/xi0hO8
         mo8Bys0sxlT5QamDJWUljMFdQdV/736Ez9qmcBdY+rDwtRxhsJZ2Pmo5qpbjEux/fPYk
         08EknMpGedvGgB6RUBIyMCE7YkaKRcgKP58H9rC2ViPunch9yTkaq366SPX2AuuVP6L4
         kAZg==
X-Gm-Message-State: AOJu0Yw4O/rLfpRodkdwDHYFBjxUpITxr+P2SOQEbbc4gW/oxfDcbjX7
        l8yFc8xQ/lRc4NtLffwPFkLblNG+u4I=
X-Google-Smtp-Source: AGHT+IFhGe4EXP7BVJs2IZlP2wbVgEkiFOTUDd8qRLyNsc8IhtYPIoOTFtT363Z5UQTHRTeqBUDaEInNAgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ca04:0:b0:da3:a91c:7356 with SMTP id
 a4-20020a25ca04000000b00da3a91c7356mr428452ybg.8.1701221598425; Tue, 28 Nov
 2023 17:33:18 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:33:16 -0800
In-Reply-To: <20231117103236.GI3818@noisy.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <20231117103236.GI3818@noisy.programming.kicks-ass.net>
Message-ID: <ZWaU3HZURCjms5DM@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023, Peter Zijlstra wrote:
> On Tue, Nov 07, 2023 at 10:36:05AM -0800, Sean Christopherson wrote:
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
> 
> Hmm, IIRC we can disable that left < 2 thing for anything that doesn't
> have x86_pmu.pebs_no_isolation IIRC.
> 
> I'm not sure about taking out the limit_period call, why does it make
> sense to allow the guest to program obviously invalid settings?

I don't see how the guest behavior is obviously invalid.  Architecturally, writing
-1 to a counter should result in overflow after a single event.  Underlying uarch
goofiness shouldn't enter into that equation.

Honoring the guest's programming *might* cause oddness for the guest, whereas
not honoring the architecture is guaranteed to cause visible issues.

If programming a "period" of 1 puts the host at risk in some way, then I agree
that this is unsafe and we need a different solution.  But if the worst case
scenario is non-determinstic or odd behavior from the guest's perspective, then
that's the guest's problem (with the caveat that the guest might not have accurate
Family/Model/Stepping data to make informed decisions).

> That is, would something like the below work for you?

No, because the fix ideally wouldn't require fancy hardware, i.e. would work for
all CPUs for which KVM supports a virtual PMU.
