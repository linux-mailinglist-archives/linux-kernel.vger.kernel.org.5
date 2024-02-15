Return-Path: <linux-kernel+bounces-66585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BA855EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A994EB24877
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76737657B3;
	Thu, 15 Feb 2024 10:00:57 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686B65BC5;
	Thu, 15 Feb 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991257; cv=none; b=SbHaQq6Bg6AgnaPw4ZqTU/l0KeB+NNmEnwNYHum/KYFeleHYoJG/DFhVgiOAEQsnv2lnhEuXkjhzPdrUROu9XfZ8H5CjR6U0cYGc4C9GbSnyfkWVGBS1653b08eiiLm7SUGVVOn1+9d/EscnyUWOyV8MZVsCLfcvuTdvT2QwBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991257; c=relaxed/simple;
	bh=aEQWvoXb3fstBlw62tnmDDTFyQZ5jvByM1k8o7XeXJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrBAdUOsBHvEWbMqyxTfZgbOLISS+lHOhE2eXXs8yCt+sZGY4ICn2j31ZWOBIOuuaKVVJM5rD/C4WCbNSS6vc0/ed3vovZn+eif+7zQDTcHnfUTGnGxXJ1WX85wYQQLb3giZqrZyRkxc+Bwvu/e7tsqIdExcgGCYNCVNeHA7inY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1raYXo-00009t-RA; Thu, 15 Feb 2024 11:00:40 +0100
Message-ID: <9a74676c-0032-4f29-84aa-c91e5ef01aae@leemhuis.info>
Date: Thu, 15 Feb 2024 11:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Content-Language: en-US, de-DE
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jon Hunter <jonathanh@nvidia.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, wkarny@gmail.com, qyousef@layalina.io,
 tglx@linutronix.de, rafael@kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Shardar Mohammed <smohammed@nvidia.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
 <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
 <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
 <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
 <42052f23-d582-4533-a09d-a1de437836b7@leemhuis.info>
 <2024021545-rise-plot-24c3@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2024021545-rise-plot-24c3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707991254;5e3a281b;
X-HE-SMSGID: 1raYXo-00009t-RA

On 15.02.24 10:13, Greg KH wrote:
> On Thu, Feb 15, 2024 at 09:45:01AM +0100, Thorsten Leemhuis wrote:
>> Linus, what...
>>
>> On 14.02.24 18:22, Vincent Guittot wrote:
>>> On Wed, 14 Feb 2024 at 18:20, Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>> On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>> We have also observed a performance degradation on our Tegra platforms
>>>>> with v6.8-rc1. Unfortunately, the above change does not fix the problem
>>>>> for us and we are still seeing a performance issue with v6.8-rc4. For
>>>>> example, running Dhrystone on Tegra234 I am seeing the following ...
>>>>> [...]
>>>>> If I revert this change and the following ...
>>>>>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>>>>>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
>>>>>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>>>>> ... then the perf is similar to where it was ...
>>>>
>>>> Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
>>>> completely buggered.
>>>> [...]
>>> This should fix it:
>>> https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/
>>
>> ...do you want me to do in situations like this? I'm asking, as I see
>> situations like this frequently -- e.g. people reporting problems a
>> second, third, or fourth time while the fix is already sitting in -next
>> for a few days.
>>
>> Want me to list them in the weekly reports so that you can cherry-pick
>> them from -next if you want?
> 
> Poke the maintainer to get off their butt and submit the pull request to
> Linus 

Well, I did that sometimes and will continue to do so. But some
maintainers then feel pestered and become annoyed by my efforts -- which
in the long-term is counter productive, as regression tracking will only
work well if maintainers and I work well together. That's why I'm a bit
careful with such things (side note: don't worry, I know that some
conflict is inevitable -- but I don't have your or Linus standing, so I
have to choose my fights carefully...).

I sometimes also got replies along the lines of "we are only at -rc2,
this can wait till -rc5 or -rc6" -- and I have no quote from Linus at
hand I can point maintainers to that says something along the lines of
"if a regression fix was in -next for at least two days, submit it to
mainline before the next -rc, unless there is a strong reason why that
particular fix needs more testing" (or whatever he actually wants).

> (note, this is me in this case...)
> I'll get it into the next -rc, sorry for the delay, other things got in
> the way, my fault.

Happens, I don't care too much about this specific event, more about the
general problem. Especially the -mm tree bugs me sometimes, as I noticed
that Andrew often lets regression fixes linger in -next for round about
a week; he furthermore sometimes sends this stuff to Linus on Mondays or
Tuesdays. Due to that the fixes often miss at least one, sometimes two
-rcs. That is especially hard to watch if the regression made it to a
stable kernel and you are waiting for the fix to get mainlined.

Ciao, Thorsten

