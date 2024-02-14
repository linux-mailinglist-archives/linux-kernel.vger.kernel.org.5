Return-Path: <linux-kernel+bounces-65438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AA854CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248E7B29A81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474B5D47E;
	Wed, 14 Feb 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNf/EI+V"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99635A0FB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925084; cv=none; b=RTfE63ZTyAdTJWMIvcmmoBym4PotFYCO9xdLhW0RIXq7xXqiV2KXCLLaiWXTpxulBc2NCebxMpz2f8Ndu7fjWTqOgWXp4PUTXkydnII1JzFs4FRm9rwoer0602RcwDc86ohpr6UclPF7WibO09imkeMW0Lnq3PByVkvGGhI0PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925084; c=relaxed/simple;
	bh=441B8ZJQjNEAgfsyw604EwAXWFTnO+esIANSxfDG4tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT/Jeo4+dBh4qwGXxmkEPHBeK+ukro4+w0ATXfYqaUquu0F+vcH9d/owmkzCjt2b5b7nJfLDLxexPJfRd9tHgDtf9DqZtSvyeIkubEk4bkCv/MvqhtVA5uaCNwmm4fpUW2vc91dRaoxdxVgmt8h7WGTewEh8tlJ1yD9QQBK6EpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNf/EI+V; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dc949f998fso453921a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707925082; x=1708529882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rG/2I7dMwLX8NSfp282+cal6DfpO3WqQaajevtU90Mk=;
        b=yNf/EI+VGGQUeOVDEvDG8D4JkGIGA7Q7Qn1oaYypZ7FdS9mkf7JJkEplnVj5Edx7aj
         w6FnzJfnnka+rwgNUeye0OU2P54FBBeYqYh9S3Lu2WNz5VMy2YmwfLJY3eplPKsxIvOk
         OhXwD+I8EWk8B+fftnm9a3BVg07ubtidvFQ7cmdTrloxI+KKRMTphrAc6XZ6h9m9d1mk
         pDocglVX6O4E3jlOUHdSJm8BM/wWV7UxMEsKuVb/h9R04eCIK+KWmJWXBCXMcW7wsGvl
         17PPVduZTjsOMAIf9BpcvwVy7JfgTchRCGLYcSfPRz6lOO7D4OCptftR2zf3t495HuA2
         A1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925082; x=1708529882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG/2I7dMwLX8NSfp282+cal6DfpO3WqQaajevtU90Mk=;
        b=ZJjSyfzn0CekfMDPq7Cn1sN4HpQfZEvCn2zumV2UFfLWOV7I4V195gai0ockSMx6em
         r+D6ki56lv67IZLrOnHLezE7ocK6m+q1YnfD7fWI9a1cOmULBVJc1OgIzeytsnN0xey4
         MvYiAiE114ELjkewIikdP2Qy4FlgTPCG1C73482CAYwDGpjx0k4BE4SGiNK+QSNl1wTa
         5XnjJKypiiGCDOaJZBrjxYvFH1x/kmHuDwX/fXbUlAO0ByB6itDf43EmwrYPaKMV23O3
         oNX5jSPmaMY5TwOnkzHXccpg2ER1uPOgp4oIdYMk1rpiurPZ6fr4ikOXT7ojB+qiLGOZ
         EvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzLEo7zJuwwi2HWIhL717HsePjY/ODALRHDrDARH0R/ZUvl+i5xw59h1zEc9ycyfBGhDLC+7wuOyzGjZLywp2TAoAMGOuhzdf5H5+Y
X-Gm-Message-State: AOJu0YwXm2BnDDownOf8u6Pj0Upp988bt8yikYCtPvCmPpqzQBcxrvqz
	SIZJ3YiZEZdJ7NLqx1Wbi5tJ/iVu1u56Mx2kV2qIxw3iIyjwmfp6WO3j5DmZbWnB4Dr5lV+UqUX
	jIRgrOz/HcbrY1t10Mj7Nr9PG1sDZrYfCzFtC9jyekIQ/lPOZ6UY=
X-Google-Smtp-Source: AGHT+IEKFkSRaxg/NH2mnKlmv7YhcDus8k5JiWtewnM9MT0N2jWGr84wpn+AsMITzI0ZsPgZrSfR5BcyY2aAWxJcibk=
X-Received: by 2002:a17:90b:810:b0:297:167b:2e4d with SMTP id
 bk16-20020a17090b081000b00297167b2e4dmr3074138pjb.42.1707925082275; Wed, 14
 Feb 2024 07:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net> <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
 <001b01da5ea7$86c7a070$9456e150$@telus.net>
In-Reply-To: <001b01da5ea7$86c7a070$9456e150$@telus.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Feb 2024 16:37:51 +0100
Message-ID: <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Doug Smythies <dsmythies@telus.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 19:07, Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2024.02.13 03:27 Vincent wrote:
> > On Sun, 11 Feb 2024 at 17:43, Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2024.02.11 05:36 Vincent wrote:
> >>> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
> >>>> On 2024.02.09.14:11 Vincent wrote:
> >>>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
> >>>>>>
> >>>>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
> >>>>>>
> >>>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> >>>>>> sched/cpufreq: Rework schedutil governor performance estimation
> >>>>>>
> >>>>>> There was previous bisection and suggestion of reversion,
> >>>>>> but I guess it wasn't done in the end. [1]
> >>>>>
> >>>>> This has been fixed with
> >>>>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
> >>>>
> >>>> Okay, thanks. I didn't find that one.
> >>>>
> >>>>>> The regression: reduced maximum CPU frequency is ignored.
> >>
> >> Perhaps I should have said "sometimes ignored".
> >> With a maximum CPU frequency for all CPUs set to 2.4 GHz and
> >> a 100% load on CPU 5, its frequency was sampled 1000 times:
> >> 28.6% of samples were 2.4 GHz.
> >> 71.4% of samples were 4.8 GHz (the max turbo frequency)
> >> The results are highly non-repeatable, for example another sample:
> >> 32.8% of samples were 2.4 GHz.
> >> 76.2% of samples were 4.8 GHz
> >>
> >> Another interesting side note: If load is added to the other CPUs,
> >> the set maximum CPU frequency is enforced.
> >
> > Could you trace cpufreq and pstate ? I'd like to understand how
> > policy->cur can be changed
> > whereas there is this comment in intel_pstate_set_policy():
> >        /*
> >         * policy->cur is never updated with the intel_pstate driver, but it
> >         * is used as a stale frequency value. So, keep it within limits.
> >         */
> >
> > but cpufreq_driver_fast_switch() updates it with the freq returned by
> > intel_cpufreq_fast_switch()
>
> Perhaps I should submit a patch clarifying that comment.
> It is true for the "intel_pstate" CPU frequency scaling driver but not for the
> "intel_cpufreq" CPU frequency scaling driver, also known as the intel_pstate
> driver in passive mode. Sorry for any confusion.
>
> I ran the intel_pstate_tracer.py during the test and do observe many, but
> not all, CPUs requesting pstate 48 when the max is set to 24.
> The calling request seems to always be via "fast_switch" path.
> The root issue here appears to be a limit clamping problem for that path.

Yes, I came to a similar conclusion as well. Whatever does schedutil
ask for, it should be clamped by  cpu->max|min_perf_ratio.

Do you know if you use fast_switch or adjust_perf call back ?

> I'll try to attach a couple of graphs and screen shots from the tracer data.
>
> I do not know how to trace cpufreq at the same time.

I was thinking of enabling cpufreq traces in ftrace in addition to
pstate ones that intel_pstate_tracer.py is enabling

Vincent
>
> ... Doug
>

