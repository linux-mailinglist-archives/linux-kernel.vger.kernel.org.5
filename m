Return-Path: <linux-kernel+bounces-66440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2B855CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56061B30B27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B279E13AC9;
	Thu, 15 Feb 2024 08:45:15 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64B13FE0;
	Thu, 15 Feb 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986715; cv=none; b=p0RPvk0truk8u6mEYEvcy6PaeaGdPzP6XZTAu5bm/d+EuIEmBcXI2vrcaUKJbh7+JSgwt+xI0zXwsCMjBFo1c7eoCKcwdJ4xuzsBhcwIbaetg05gGU11h1IDg/l3UpL9Y5D9wTgqDdoh6xNVaHSRPmJQMDXSfwiZk1EBk+lCNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986715; c=relaxed/simple;
	bh=P30eQt85pILS+8iYd/I7kRbfNwa0y6eSKTutvbbpLqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGRNQtpRlWa+9MZBJFevwIR6FRsXu1qLrOQ28dO523Uyp5IvOG1dXK5xqobxZUKsQy7vpznnGdX1qba75DzmvCCvlTui+nJZ4yUP4tq0eEMqKvUFD2vEa0kVyil55G/mkRY1LcQf6tUTjMiliQbDm/1WDMyegvnXoNTTZqwbRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1raXMd-0007RI-1i; Thu, 15 Feb 2024 09:45:03 +0100
Message-ID: <42052f23-d582-4533-a09d-a1de437836b7@leemhuis.info>
Date: Thu, 15 Feb 2024 09:45:01 +0100
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com,
 qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707986713;be9aface;
X-HE-SMSGID: 1raXMd-0007RI-1i

Linus, what...

On 14.02.24 18:22, Vincent Guittot wrote:
> On Wed, 14 Feb 2024 at 18:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> We have also observed a performance degradation on our Tegra platforms
>>> with v6.8-rc1. Unfortunately, the above change does not fix the problem
>>> for us and we are still seeing a performance issue with v6.8-rc4. For
>>> example, running Dhrystone on Tegra234 I am seeing the following ...
>>> [...]
>>> If I revert this change and the following ...
>>>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>>>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
>>>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>>> ... then the perf is similar to where it was ...
>>
>> Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
>> completely buggered.
>> [...]
> This should fix it:
> https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/

..do you want me to do in situations like this? I'm asking, as I see
situations like this frequently -- e.g. people reporting problems a
second, third, or fourth time while the fix is already sitting in -next
for a few days.

Want me to list them in the weekly reports so that you can cherry-pick
them from -next if you want?

Ciao, Thorsten

