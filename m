Return-Path: <linux-kernel+bounces-68630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1686857D81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9162F1C2160B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26F129A7A;
	Fri, 16 Feb 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBTgpLcW"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C22129A6A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089490; cv=none; b=q1OgvjxieKAykIC5PncNuCusNshIrnJBl+3ORUvKplht5vlB3nryTqHKqvItmspwzX2Zl8OXjBon1ygiflJPg4zFh4Q7/FqWZblV99A11G8Ee7kdsQog2CJKT4rYpMOz1LvBcQTscn9CcoQ3rNVQm4x5+LLoGoKqF8Xo9po2z3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089490; c=relaxed/simple;
	bh=/H/RhV5vGD/KMCO91KuZqHjmm/UTBivLhxXH1J6/QO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY363YAZVoaWXQZpuik9BRRcjLhDWz+YOzRb4IOSXxdUKC9CPps0lifQNiqtOYKqUImPFTIm36FPfrH0+QEERZBaKNQP7QDzkQu8AWN+AhKUcUQhQqWDrYRhsDIMXX9XhOoWK2gDP0l/RqlArMlunO0FzAkZ0k3VGSby89uVdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBTgpLcW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso521688a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708089488; x=1708694288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgUO7dxVVRWyGJZaDscwaD0xXaHwHxCegMCZe0+JAOc=;
        b=nBTgpLcWtgDNC9FYaAmti9GAEcPA6IAEBMSDbl0+h13FryF5/n5RAAHuVCpuYy8mDq
         tqovl0UwdSBcLXQQoj9XRTHPVhvQ4CpgPKzj9KPZxEUfoWxMco1VBUOnz15RgrTO+YtO
         Teg5e0g5d3aOA0mETnc+MmgTpmhORkEs6qSUSJ6xx3Zni7sAMBdub6OP/GHF+G4l9478
         7b++OlOn8gZPUxs0lfamD5g/K97QY2XcSG6h/+GvHJSVAc88l135XZitFClwbfg4Ft0U
         ZjWiY1F2PnQsGbNtskkK4ngJSX1cioU2N4EWROD/44VY+YsSsGH8AExHpMtrFsKZ9H52
         eUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089488; x=1708694288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgUO7dxVVRWyGJZaDscwaD0xXaHwHxCegMCZe0+JAOc=;
        b=BtRAvwQwEpK2Jz/PHfQPr7Cx89rRCgYr8RlAETsAppv9eI2AAbkY6G82Pk5/uqG4g8
         XNMjAWY0FuVdLqTBGTML1aXRAftnsN24QPC8ru7YHrdfW3hZ4HWqmFdQb/FTBOXt9enz
         Pf549Eul+brCqeoIqeWP4a541RF1sxi/UTb/ApczAAXaCDsayzr28dZmrDdrhDXpUyQp
         Hpbx9Baj5dXLqpwfuMzyH0EUZDMtfc/21pI0oGtEq1VlfbwCZEmKg+7WkmGs50r65L6O
         f0eY2+j4GRbeTsS4lBj/RCvXyWnl5rKvXMEEldHar2+9e32Lx1s9gJEpsvMrkfEodvTd
         ChiA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1VvHwYDRPMC1xQwytTcUqWaAxOJ/suNc5sCOVYlLkL68Pid56tCKH1yd2MuuDPYypgmecm5ryEUbQsj/mB2/bGoIhT74RZeWNeZr
X-Gm-Message-State: AOJu0YxrcVrjbxAqm/MUF5gZrovGxrliHLl4TY/7s/l6Q/1GqL2712kR
	NxW81KIKxn6YxNwWZyYS+DOmC7TSomlEy9uTjLtjZOVvhIR1TMabSGexBTDfQOS73duwB9OfqhU
	iiJK6EPGp8GkpwPaXdT1ZMSxVOBNLGX590Jte5w==
X-Google-Smtp-Source: AGHT+IFMTjOMZcMtdP+Ne2AFbg5itLRY8xwteckg4Is3iv/WCDHyYm1Lt7Yn9nfx/8fh7qVJny0kyuuy8JXPuTwSt3g=
X-Received: by 2002:a17:90b:1212:b0:296:6ea5:9c92 with SMTP id
 gl18-20020a17090b121200b002966ea59c92mr4401810pjb.15.1708089486639; Fri, 16
 Feb 2024 05:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net> <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
 <001b01da5ea7$86c7a070$9456e150$@telus.net> <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
 <003001da6061$bbad1e30$33075a90$@telus.net>
In-Reply-To: <003001da6061$bbad1e30$33075a90$@telus.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 16 Feb 2024 14:17:54 +0100
Message-ID: <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Doug,

On Thu, 15 Feb 2024 at 23:53, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Vincent,
>
> This email thread appears as if it might be moving away from a regression
> caused by your commit towards a conclusion that your commit exposed
> a pre-existing bug in the intel_psate.c code.

Ok

>
> Therefore, I have moved Rafael from the C.C. line to the "to" line and
> added Srinivas.
>
> On 2024.02.14 07:38 Vincent wrote:
> > On Tue, 13 Feb 2024 at 19:07, Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2024.02.13 03:27 Vincent wrote:
> >>> On Sun, 11 Feb 2024 at 17:43, Doug Smythies <dsmythies@telus.net> wrote:
> >>>> On 2024.02.11 05:36 Vincent wrote:
> >>>>> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
> >>>>>> On 2024.02.09.14:11 Vincent wrote:
> >>>>>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
> >>>>>>>>
> >>>>>>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
> >>>>>>>>
> >>>>>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> >>>>>>>> sched/cpufreq: Rework schedutil governor performance estimation
> >>>>>>>>
> >>>>>>>> There was previous bisection and suggestion of reversion,
> >>>>>>>> but I guess it wasn't done in the end. [1]
> >>>>>>>
> >>>>>>> This has been fixed with
> >>>>>>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
> >>>>>>
> >>>>>> Okay, thanks. I didn't find that one.
> >>>>>>
> >>>>>>>> The regression: reduced maximum CPU frequency is ignored.
> >>>>
> >>>> Perhaps I should have said "sometimes ignored".
> >>>> With a maximum CPU frequency for all CPUs set to 2.4 GHz and
> >>>> a 100% load on CPU 5, its frequency was sampled 1000 times:
> >>>> 28.6% of samples were 2.4 GHz.
> >>>> 71.4% of samples were 4.8 GHz (the max turbo frequency)
> >>>> The results are highly non-repeatable, for example another sample:
> >>>> 32.8% of samples were 2.4 GHz.
> >>>> 76.2% of samples were 4.8 GHz
> >>>>
> >>>> Another interesting side note: If load is added to the other CPUs,
> >>>> the set maximum CPU frequency is enforced.
> >>>
> >>> Could you trace cpufreq and pstate ? I'd like to understand how
> >>> policy->cur can be changed
> >>> whereas there is this comment in intel_pstate_set_policy():
> >>>        /*
> >>>         * policy->cur is never updated with the intel_pstate driver, but it
> >>>         * is used as a stale frequency value. So, keep it within limits.
> >>>         */
> >>>
> >>> but cpufreq_driver_fast_switch() updates it with the freq returned by
> >>> intel_cpufreq_fast_switch()
> >>
> >> Perhaps I should submit a patch clarifying that comment.
> >> It is true for the "intel_pstate" CPU frequency scaling driver but not for the
> >> "intel_cpufreq" CPU frequency scaling driver, also known as the intel_pstate
> >> driver in passive mode. Sorry for any confusion.
> >>
> >> I ran the intel_pstate_tracer.py during the test and do observe many, but
> >> not all, CPUs requesting pstate 48 when the max is set to 24.
> >> The calling request seems to always be via "fast_switch" path.
> >> The root issue here appears to be a limit clamping problem for that path.
> >
> > Yes, I came to a similar conclusion as well. Whatever does schedutil
> > ask for, it should be clamped by  cpu->max|min_perf_ratio.
>
> Agreed. And it is not clamping properly under specific conditions.
>
> > Do you know if you use fast_switch or adjust_perf call back ?
>
> I am not certain, but I think it uses "adjust_perf" call back.
> I do know for certain that it never takes the
> "intel_cpufreq_update_pstate" path
> and always takes the
> "intel_cpu_freq_adjust_perf" path.

intel_cpu_freq_adjust_perf is registered as the callback for
cpufreq->adjust_perf

>
> The problem seems to occur when that function is called with:
> min_perf = 1024
> target_perf = 1024
> capacity = 1024
>
> Even though cpu->max_perf_ratio is 24, the related HWP MSR,
> 0x774: IA32_HWP_REQUEST, ends up as 48, 48, 48 for min, max, des.
>
> This patch appears to fix the issue (still has my debug code and
> includes a question):
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ca94e60e705a..8f88a04a494b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2987,12 +2987,22 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
>         if (min_pstate < cpu->min_perf_ratio)
>                 min_pstate = cpu->min_perf_ratio;
>
> +//     if (min_pstate > cpu->pstate.max_pstate)   /* needed? I don't know */
> +//             min_pstate = cpu->pstate.max_pstate;
> +
> +       if (min_pstate > cpu->max_perf_ratio)
> +               min_pstate = cpu->max_perf_ratio;
> +
>         max_pstate = min(cap_pstate, cpu->max_perf_ratio);
>         if (max_pstate < min_pstate)
>                 max_pstate = min_pstate;
>
>         target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
>
> +       if((max_pstate > 40) || (max_pstate < 7) || (min_pstate < 7) || min_pstate > 40 || target_pstate > 40){
> +               pr_debug("Doug: t: %d : min %d : max %d : minp %d : maxp %d : mnperf %lu : tgperf %lu : capacity %lu\n", target_pstate, min_pstate, max_pstate, cpu->min_perf_ratio, cpu->max_perf_ratio, min_perf, target_perf, capacity);
> +       }
> +
>         intel_cpufreq_hwp_update(cpu, min_pstate, max_pstate, target_pstate, true);
>
>         cpu->pstate.current_pstate = target_pstate;
>
> With the patch, I never hit the debug statement if the max CPU frequency is limited to 2.4 GHz,
> whereas it used to get triggered often.
> More importantly, the system seems to now behave properly and obey set CPU frequency limits.
>
>

