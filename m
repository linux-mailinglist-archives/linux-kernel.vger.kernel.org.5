Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567978EE09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjHaNDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHaNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:03:16 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE20CFE;
        Thu, 31 Aug 2023 06:03:13 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5711d5dac14so182600eaf.0;
        Thu, 31 Aug 2023 06:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486992; x=1694091792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9jm6k3mZ7DtL6C9l6hYtOCCTfhPR3psQJlw1t5U+L8=;
        b=HqV91C8UZKr+2fcz8t3Ot1cXPuHmQoPeDMhP4uhkGUxqkYq+FAarJT/aLuQcug7A1h
         hx1Ekw1lfUGOiQPs/YPbvmka1092Ct99kioXrIrJiWb2vIMMw4jxTaBgL/ZUiHyc92Xo
         FXj4XWwRlmlyDk+YtR+TObUBijFYiXSHrQnW6U8q5670ftPGqiV1z2Xgre5VzMlrLkVv
         BbVNOYgw8/8CN8RwlzzxYQmmUIBUs7l/BwK3Oj86CS9DdM60BFbQvNSkxqvf1rqaFdHy
         yMXBnj/Z6hnlhsHDvv/7OLykdlKmt2Esy9lrbfd9SzMdciMFxACn98nCI8/3cjW0a9sp
         kBPw==
X-Gm-Message-State: AOJu0YyeuTzhhDd6GReFhJl27jRnZchhhLacLNPJZlvN/FvkdfGrMq6+
        /HmqTEw0I8/JsptZ7uLuRQiM4uEGhtvalKc0GIM=
X-Google-Smtp-Source: AGHT+IFnz0uQbTsxb2U4BE8XUd/FYbV05/gm2etOOQk9Yh8996UEbCDBlW6vWoZsK6H0LKC8ecHBuIgWwo8N2ML7M18=
X-Received: by 2002:a4a:bd8f:0:b0:573:2a32:6567 with SMTP id
 k15-20020a4abd8f000000b005732a326567mr4905484oop.0.1693486992644; Thu, 31 Aug
 2023 06:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230808111325.8600-1-TonyWWang-oc@zhaoxin.com>
 <CAJZ5v0h8M-hNJfRTSxtVmfmpF09h9zmNmG-e=iMemzPwsK50Zg@mail.gmail.com> <e9b4de96-624e-96a5-0a41-93de36719340@zhaoxin.com>
In-Reply-To: <e9b4de96-624e-96a5-0a41-93de36719340@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Aug 2023 15:03:01 +0200
Message-ID: <CAJZ5v0j7c2aO7=AQrjnF9_DGLjdqibDdm72Y9BLzFxWEvQhnvw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: ACPI: add ITMT support when CPPC enabled
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
        LindaChai@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:19 PM Tony W Wang-oc
<TonyWWang-oc@zhaoxin.com> wrote:
>
>
> On 8/23/23 04:01, Rafael J. Wysocki wrote:
> > On Tue, Aug 8, 2023 at 1:13 PM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
> >>
> >> The _CPC method can get per-core highest frequency.
> >
> > Well, not exactly.  A more precise way to say this would be "The
> > per-core highest frequency can be obtained via CPPC."
> >
>
> Thanks for your reply, will rewrite the commit in next version.
>
> >> The highest frequency may varies between cores which mean cores can
> >
> > "may vary" and "which means"
> >
> >> running at different max frequency, so can use it as a core priority
> >
> > "can run", but it would be better to say "may run".
> >
> >> and give a hint to scheduler in order to put critical task to the
> >> higher priority core.
> >
> > Well, roughly speaking ...
> >
> > You should really talk about ITMT and how it can be hooked up to this.
> >
>
> Ok, Got it.
>
> >> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> >> ---
> >> v1->v2: Fix build errors reported by kernel test robot
> >>
> >>  arch/x86/kernel/itmt.c         |  2 ++
> >>  drivers/cpufreq/acpi-cpufreq.c | 59 ++++++++++++++++++++++++++++++----
> >>  2 files changed, 54 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
> >> index ee4fe8cdb857..b49ac8ecbbd6 100644
> >> --- a/arch/x86/kernel/itmt.c
> >> +++ b/arch/x86/kernel/itmt.c
> >> @@ -122,6 +122,7 @@ int sched_set_itmt_support(void)
> >>
> >>         return 0;
> >>  }
> >> +EXPORT_SYMBOL_GPL(sched_set_itmt_support);
> >
> > This requires an ACK from the x86 maintainers.
> >
> >>
> >>  /**
> >>   * sched_clear_itmt_support() - Revoke platform's support of ITMT
> >> @@ -181,3 +182,4 @@ void sched_set_itmt_core_prio(int prio, int cpu)
> >>  {
> >>         per_cpu(sched_core_priority, cpu) = prio;
> >>  }
> >> +EXPORT_SYMBOL_GPL(sched_set_itmt_core_prio);
> >
> > And same here.
> >
> >> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> >> index b2f05d27167e..5733323e04ac 100644
> >> --- a/drivers/cpufreq/acpi-cpufreq.c
> >> +++ b/drivers/cpufreq/acpi-cpufreq.c
> >> @@ -628,28 +628,35 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
> >>  #endif
> >>
> >>  #ifdef CONFIG_ACPI_CPPC_LIB
> >> -static u64 get_max_boost_ratio(unsigned int cpu)
> >> +static void cpufreq_get_core_perf(int cpu, u64 *highest_perf, u64 *nominal_perf)
> >
> > This is not a cpufreq core function, so please use a different prefix
> > in its name.
> >
>
> Ok. Will remove the prefix of "cpufreq_".
>
> >>  {
> >>         struct cppc_perf_caps perf_caps;
> >> -       u64 highest_perf, nominal_perf;
> >>         int ret;
> >>
> >>         if (acpi_pstate_strict)
> >> -               return 0;
> >> +               return;
> >>
> >>         ret = cppc_get_perf_caps(cpu, &perf_caps);
> >>         if (ret) {
> >>                 pr_debug("CPU%d: Unable to get performance capabilities (%d)\n",
> >>                          cpu, ret);
> >> -               return 0;
> >> +               return;
> >>         }
> >>
> >>         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> >> -               highest_perf = amd_get_highest_perf();
> >> +               *highest_perf = amd_get_highest_perf();
> >>         else
> >> -               highest_perf = perf_caps.highest_perf;
> >> +               *highest_perf = perf_caps.highest_perf;
> >> +
> >> +       *nominal_perf = perf_caps.nominal_perf;
> >> +       return;
> >> +}
> >>
> >> -       nominal_perf = perf_caps.nominal_perf;
> >> +static u64 get_max_boost_ratio(unsigned int cpu)
> >> +{
> >> +       u64 highest_perf, nominal_perf;
> >> +
> >> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
> >>
> >>         if (!highest_perf || !nominal_perf) {
> >>                 pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
> >> @@ -663,8 +670,44 @@ static u64 get_max_boost_ratio(unsigned int cpu)
> >>
> >>         return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> >>  }
> >> +
> >> +static void cpufreq_sched_itmt_work_fn(struct work_struct *work)
> >
> > A similar comment applies here.
> >
> >> +{
> >> +       sched_set_itmt_support();
> >> +}
> >> +
> >> +static DECLARE_WORK(sched_itmt_work, cpufreq_sched_itmt_work_fn);
> >> +
> >> +static void cpufreq_set_itmt_prio(int cpu)
> >> +{
> >> +       u64 highest_perf, nominal_perf;
> >> +       static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
> >> +
> >> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
> >> +
> >> +       sched_set_itmt_core_prio(highest_perf, cpu);
> >> +
> >> +       if (max_highest_perf <= min_highest_perf) {
> >> +               if (highest_perf > max_highest_perf)
> >> +                       max_highest_perf = highest_perf;
> >> +
> >> +               if (highest_perf < min_highest_perf)
> >> +                       min_highest_perf = highest_perf;
> >> +
> >> +               if (max_highest_perf > min_highest_perf) {
> >> +                       /*
> >> +                        * This code can be run during CPU online under the
> >> +                        * CPU hotplug locks, so sched_set_itmt_support()
> >> +                        * cannot be called from here.  Queue up a work item
> >> +                        * to invoke it.
> >> +                        */
> >> +                       schedule_work(&sched_itmt_work);
> >> +               }
> >
> > This potentially runs before ITMT priorities are set for all CPUs.
> > Isn't it a problem?
> >
>
> Yes, you are right.
> Will use schedule_delayed_work(&sched_itmt_work, msecs_to_jiffies(500))
> to fix this.

If the ordering matters, it is better to enforce it directly (through
an explicit code dependency, for example) than to rely on the timing
to do the right thing.

If you do the above, then it will not be clear why it is done (a
comment may help to address that, though) and why the delay is 500 us
in particular.
