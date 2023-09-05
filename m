Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5A792D66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjIEScb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjIESc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:32:29 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B331B7;
        Tue,  5 Sep 2023 11:31:56 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a9f094b399so153277b6e.0;
        Tue, 05 Sep 2023 11:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938645; x=1694543445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8rxdS5gZfTweDJAb7+tn6z5B9vsKxogFFuV/jTlAKI=;
        b=IwGqIfH5oAmxQvYSYr9N+xvdA0gPO7c94joDJpKj/O/48TO9ESJ8DwliprW6R0dDmi
         hNz7ZEnsBrs1aKp9fEQ44Lx+n9pZ6lwX/7SmntC6dNCrPDFQNiVgM/E5qgA1NK/L5L2W
         YIYNu76UvLDd2gkJLV6VfuiJwAC6zngtywe8Pl1aY8/NREtoz4cXznbM/hTMTic3LmrU
         Ydsoa+YTOYSC2PRH5RvCqEapDu8YIhlS0L5JzNNj/kZzo1qj1y1huwcDpsyvEmvhL71S
         HKHDfjU1u259ppE3k++DpawKhGt5RElj4wT+rlUGZMf/8FHbw5Jgo1Nlah+2TAUOyYN2
         Y5IA==
X-Gm-Message-State: AOJu0Ywdr+lFDtlw6NaQf7LVE5GG+COHK8n28K10o4lQY9QdBt41rJ8c
        apMJN0NgJYZnOB42Z6WTXPGJCn0HqR+aFedQerk=
X-Google-Smtp-Source: AGHT+IGEysi/fNPxz0Ty9WdbG+m/nnpz4E7E1jsKKNwH27GPpMJAaNAoqpjnup006hyr22QdcYVpKrqF64cUF1hvEVw=
X-Received: by 2002:a05:6808:1a06:b0:3a8:8aa8:a4c8 with SMTP id
 bk6-20020a0568081a0600b003a88aa8a4c8mr15862937oib.2.1693938645234; Tue, 05
 Sep 2023 11:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <001d01d9d3a7$71736f50$545a4df0$@telus.net> <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
 <9665af79-d439-e05a-5333-62f71a2ac55c@linux.intel.com> <2023082901-moonscape-album-b7cc@gregkh>
 <02d8a574-a07a-f595-aee2-13908df74e68@linux.intel.com>
In-Reply-To: <02d8a574-a07a-f595-aee2-13908df74e68@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Sep 2023 20:30:34 +0200
Message-ID: <CAJZ5v0i4_PnCJGkkMzBMF9GX3N6LLNQdnuyX6nRzWHy_f9T=3A@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to minimum
To:     Keyon Jie <yang.jie@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:17 PM Keyon Jie <yang.jie@linux.intel.com> wrote:
>
>
>
> On 8/29/23 01:57, Greg KH wrote:
> > On Mon, Aug 28, 2023 at 04:35:13PM -0700, Keyon Jie wrote:
> >>
> >>
> >> On 8/22/23 04:46, Rafael J. Wysocki wrote:
> >>> On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
> >>>>
> >>>> The intel_pstate CPU frequency scaling driver does not
> >>>> use policy->cur and it is 0.
> >>>> When the CPU frequency is outdated arch_freq_get_on_cpu()
> >>>> will default to the nominal clock frequency when its call to
> >>>> cpufreq_quick_getpolicy_cur returns the never updated 0.
> >>>> Thus, the listed frequency might be outside of currently
> >>>> set limits. Some users are complaining about the high
> >>>> reported frequency, albeit stale, when their system is
> >>>> idle and/or it is above the reduced maximum they have set.
> >>>>
> >>>> This patch will maintain policy_cur for the intel_pstate
> >>>> driver at the current minimum CPU frequency.
> >>>>
> >>>> Reported-by: Yang Jie <yang.jie@linux.intel.com>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> >>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> >>>> ---
> >>>>
> >>>> v1 -> v2:
> >>>>      * v1 was a completely different approach, programming around
> >>>>        the issue rather than fixing it at the source.
> >>>>        reference:
> >>>>        https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
> >>>>      * v2 does not fix an issue with the intel_cpufreq CPU scaling
> >>>>        driver (A.K.A. the intel_pstate driver in passive mode) and
> >>>>        the schedutil CPU frequency scaling governor when HWP is enabled
> >>>>        where limit changes are not reflected in the stale listed frequencies.
> >>>>        A fix for that will be some future patch.
> >>>>
> >>>> ---
> >>>>    drivers/cpufreq/intel_pstate.c | 5 +++++
> >>>>    1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> >>>> index 8ca2bce4341a..08284dee583a 100644
> >>>> --- a/drivers/cpufreq/intel_pstate.c
> >>>> +++ b/drivers/cpufreq/intel_pstate.c
> >>>> @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
> >>>>                           intel_pstate_clear_update_util_hook(policy->cpu);
> >>>>                   intel_pstate_hwp_set(policy->cpu);
> >>>>           }
> >>>> +       /* policy current is never updated with the intel_pstate driver
> >>>> +        * but it is used as a stale frequency value. So, keep it within
> >>>> +        * limits.
> >>>> +        */
> >>>> +       policy->cur = policy->min;
> >>>>
> >>>>           mutex_unlock(&intel_pstate_limits_lock);
> >>>>
> >>>> --
> >>>
> >>> Applied as 6.6 material, with some mailer-induced white space damage
> >>> fixed and the new comment adjusted to the kernel coding style.
> >>>
> >>> Thanks!
> >>
> >> Hi Doug and Rafael,
> >>
> >> Thank you for making the fix happen.
> >>
> >> Hi Greg,
> >>
> >> Will this be picked to the stable linux-6.1.y and linux-6.4.y kernel, it
> >> could benefit to users there.
> >
> > Sure, when it hits Linus's tree, please follow the instructions in:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to get it merged.
>
> Thank you Greg.
>
> Hi Rafael,
>
> As the issue happens from the 5.18 onward kernels, we need the fix to be
> picked for stable kernels after that, could you please help to add "Cc:
> stable@vger.kernel.org" in the sign-off area when you send it to the
> mainline?

It's already merged, as commit d51847acb018 ("cpufreq: intel_pstate:
set stale CPU frequency to minimum").

Please feel free to send an inclusion request for it to stable@vger.kernel.org

Thanks!
