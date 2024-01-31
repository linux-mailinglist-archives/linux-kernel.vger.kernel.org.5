Return-Path: <linux-kernel+bounces-46540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA084411A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B353B1F2DE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AA80C03;
	Wed, 31 Jan 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmcX4Yg+"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C597F491
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709344; cv=none; b=VSmmZzZtJnsA0h54+kggy7qJDPbHnvyqUSO0nlm4MHbX2lQZcdK6HQHHVwZcHsykyKb+Fj8qMjcHcIuE2czMBioJs3kB9T7HlnZZ49I6DoIaTs74NmwWKmz7hV2fP1CLreKSx4RvtcqEtzRmwCfk0C3/6N5m4Bv6/ddXZrumecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709344; c=relaxed/simple;
	bh=lP/iCDT0hUnPesKrb7hWD3dW8NEUrJgALKt9dBmUD4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De6R/T9vDU5YUCQFPaZymwvytM+3nysLLOANLszq5oTEo+STk+1JZeabBDKYLYTbXhJpNmWpNHbwzXake7IAbG+ts5XZPUAyDyMpdWjEFu1doXut3VktI4xPiGxJZvF+XXN3+FX7JAdibvaO0eDUb5cy96wFzp5v2DuTiXK/AhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmcX4Yg+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so3112151a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706709342; x=1707314142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lP/iCDT0hUnPesKrb7hWD3dW8NEUrJgALKt9dBmUD4c=;
        b=BmcX4Yg+C7DnGCekgTcpfKgtpNaYG3sMswR5oyrzm3Yej5sFUxLENwbqQ2QQceDZC8
         KohnmWwvBr4jPzl8WOUyfoa5V2th3hf8YEoocKXLILmIw+UfHozjm3NEZ8ZCYfW/mQXI
         2/u2HbOURlIgTjgd8+rNAa63aVDMF9eraA0J7kvoXXpBVJi4H6sNhp6rtk6vM2oxuups
         vXHsnA38hDBVupLTcNjfgpRj8FwOZj8j958bSf9d2MNvEDOiG2zazmlaqc9kET4D+8/t
         FDyepQ/jGaBEoxNrPLFoe36++u1x3rLqZ7/Gd6IgynYPv5rE1sjNlBpNmDgRym1WMGt6
         fEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709342; x=1707314142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lP/iCDT0hUnPesKrb7hWD3dW8NEUrJgALKt9dBmUD4c=;
        b=Cxro5qqZH1DhvfW3J7knIgNV8oUU2DnxJkqN0iAYH0tKDcfd6Xke2B4qDULb2olu1R
         Og2fJ9Tj4Hgp63gbSe2gT88FU0maFNkSOpitXBb2sBavoC4gNhTfaEjDRMx5nD2jN3s9
         3IFmVMqVSvz8dZ3CcHeR0zSzOFs64Oba1jARyt8nqt933yuwFTJn748dEZ6qVyFwTkVW
         tEicKttiH3QXu21XqSb2H6C4rasMaw0KXzxDwUv6ZAaOdg1o5ia9c9WXBwtAwWuE0+JX
         6uomDj1rb2kzjWA1owsbDbuhrWW1HYuvqKoAo3iRauzMCwOX+QQiPOsFvcJkXpt8YHz/
         +rCQ==
X-Gm-Message-State: AOJu0YwEquwNGfcE6bGrn9XxqCtRAkko3mFjru/wafRg/a7+Erip1VeY
	dJnmA1ffdiChl3BHl57lkjiVBuXi2kxQi/s1ArI4W8FlUFZAtNRXmgBKECZjI0UnDWuNcvRjGfG
	WpNgdZZOmrdvzXD9/OVRCdxbeWv4gJRVNN1oe3akV2aNvdSpDGuw=
X-Google-Smtp-Source: AGHT+IFHMc9NoAOmBIbFCuBZRsmIAQEKzd9i4Nh5py0aHA68IqRt2eTTIhkUs5M0S/JguzNWdnTnmmTWl60YIdJhujE=
X-Received: by 2002:a17:90b:e8a:b0:293:f625:1b0b with SMTP id
 fv10-20020a17090b0e8a00b00293f6251b0bmr1531667pjb.5.1706709342129; Wed, 31
 Jan 2024 05:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu> <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu> <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
 <20240128235005.txztdbdq2obyi4n6@airbuntu> <CAKfTPtC0=MH7bCypeY1QFxt=pFbPxY9YLuuS8_dhkF31nR6ZWQ@mail.gmail.com>
 <20240130235727.wj3texzo4lpbba6b@airbuntu>
In-Reply-To: <20240130235727.wj3texzo4lpbba6b@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 31 Jan 2024 14:55:31 +0100
Message-ID: <CAKfTPtCAETf3F-dkMimqt6VC9TWHseiQyywyuq6BQqxVMWxXRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 00:57, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/30/24 10:41, Vincent Guittot wrote:
> > On Mon, 29 Jan 2024 at 00:50, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/26/24 15:08, Vincent Guittot wrote:
> > >
> > > > > TBH I had a bit of confirmation bias that this is a problem based on the fix
> > > > > (0ae78eec8aa6) that we had in the past. So on verification I looked at
> > > > > balance_interval and this reproducer which is a not the same as the original
> > > > > one and it might be exposing another problem and I didn't think twice about it.
> > > >
> > > > I checked the behavior more deeply and I confirm that I don't see
> > > > improvement for the use case described above. I would say that it's
> > > > even worse as I can see some runs where the task stays on little
> > > > whereas a big core has been added in the affinity. Having in mind that
> > > > my system is pretty idle which means that there is almost no other
> > > > reason to trigger an ilb than the misfit task, the change in
> > > > check_misfit_status() is probably the reason for never kicking an ilb
> > > > for such case
> > >
> > > It seems I reproduced another problem while trying to reproduce the original
> > > issue, eh.
> > >
> > > I did dig more and from what I see the issue is that the rd->overload is not
> > > being set correctly. Which I believe what causes the delays (see attached
> > > picture how rd.overloaded is 0 with some spikes). Only when CPU7
> > > newidle_balance() coincided with rd->overload being 1 that the migration
> > > happens. With the below hack I can see that rd->overload is 1 all the time
> >
> > But here you rely on another activity happening in CPU7 whereas the
>
> I don't want to rely on that. I think this is a problem too. And this is what
> ends up happening from what I see, sometimes at least.
>
> When is it expected for newidle_balance to pull anyway? I agree we shouldn't
> rely on it to randomly happen, but if it happens sooner, it should pull, no?
>
> > misfit should trigger by itself the load balance and not expect
> > another task waking up then sleeping on cpu7 to trigger a newidle
> > balance. We want a normal idle load balance not a newidle_balance
>
> I think there's a terminology problems. I thought you mean newidle_balnce() by
> ilb. It seems you're referring to load_balance() called from
> rebalance_domains() when tick happens at idle?

newidle_balance is different from idle load balance. newidle_balance
happens when the cpu becomes idle whereas busy and idle load balance
happen at tick.

>
> I thought this is not kicking. But I just double checked in my traces and I was
> getting confused because I was looking at where run_rebalance_domains() would
> happen, for example, on CPU2 but the balance would actually be for CPU7.

An idle load balance happens either on the target CPU if its tick is
not stopped or we kick one idle CPU to run the idle load balance on
behalf of all idle CPUs. This is the latter case that doesn't happen
anymore with your patch and the change in check_misfit_status.

>
> No clue why it fails to pull.. I can see actually we call load_balance() twice
> for some (not all) entries to rebalance_domains(). So we don't always operate
> on the two domains. But that's not necessarily a problem.

We have 3 different reasons for kicking an idle load balance :
- to do an actual balance of tasks
- to update stats ie blocked load
- to update nohz.next_balance

You are interested by the 1st one but it's most probably for the 2
last reasons that this happen

>
> I think it's a good opportunity to add some tracepoints to help break this path
> down. If you have suggestions of things to record that'd be helpful.

