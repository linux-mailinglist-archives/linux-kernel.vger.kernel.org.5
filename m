Return-Path: <linux-kernel+bounces-159941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAD8B368F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089DD1F22E10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676A145339;
	Fri, 26 Apr 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+sMlxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8A1448DA;
	Fri, 26 Apr 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131342; cv=none; b=hjM9XdHE61JNhsb/66jyTiqaeT9hau6mK6wd5e8OxVFZJEUvfYpeW9wIMBHPZsR4HmZ+Rt3ueazEKREP1UiwGSU1CFSDnrRTQeHCDj0HzyU/oGP18v9czBzle+WbO+M/35mcLyOweJYXSqwOwaTmWEg54cX26okqkgb2Fx+QO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131342; c=relaxed/simple;
	bh=/QQwxfaRpu9LMwD7lIaSpN/8sAgx3OeT00gXgYnvfNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD3gbOU5S6lcaXy5BtZpBBP8iSOZ00Bs4+Smxc9hF2L5ZNeWbC+irVBLywO3vqX64iX870U935q/YhB8RYKNpgEo2TUQVAS/p5M6V5dt40jY7htfTvP0T+KXaie4wUQvN5XHJEm1RlQ01wa1KJgzaILmEfGS+15bDZOA5s/yQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+sMlxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8607C113CD;
	Fri, 26 Apr 2024 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714131342;
	bh=/QQwxfaRpu9LMwD7lIaSpN/8sAgx3OeT00gXgYnvfNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ry+sMlxscR2Rbaic+gim6Q5CbqsWmHIZo8+DmPxKArLoPWCBi6VHdWwja6oLjxLeP
	 SCLaMrCCtMJvgOPZ+qT3YqysiXWkV4dc0wKUTcmNkIXbiycAMqBm46fFkfXVNFWbSZ
	 afdnMQ4ctbgkw2DnVJAHTnAkzpXY/RMP9zn3wm9vL03OLzan8y0LWytHXUIkmZbWUR
	 9bCIknDkxwWkYpkOSfnl80TuiwhgLMqheWT6M/NsBlu7HSHOUPtqv5WzlvWhLjugAE
	 qME9g+38bVrhZNfE+dxEnJbIee46bATBztHTP8GpklJ1vRmhW2EuZOgPm67tQ3z8+6
	 zYfY/4oQOhW0w==
Date: Fri, 26 Apr 2024 13:35:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
Message-ID: <ZiuRiwOZ1eMOZN5J@pavilion.home>
References: <87zfth3l6y.fsf@somnus>
 <9272d284-ec2c-4e35-be90-c8852278b648@arm.com>
 <87h6foig4s.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6foig4s.fsf@somnus>

Le Fri, Apr 26, 2024 at 12:15:47PM +0200, Anna-Maria Behnsen a écrit :
> Christian Loehle <christian.loehle@arm.com> writes:
> 
> > On 25/04/2024 09:23, Anna-Maria Behnsen wrote:
> >> Hi,
> >> 
> >> (adding cpuidle/power people to cc-list)
> >> 
> >> Oliver Sang <oliver.sang@intel.com> writes:
> >> 
> >>> hi, Frederic Weisbecker,
> >>>
> >>> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
> >>>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
> >>>>>
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>>
> >>>>> we reported
> >>>>> "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
> >>>>> in
> >>>>> https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
> >>>>>
> >>>>> now we noticed this commit is in mainline and we captured further results.
> >>>>>
> >>>>> still include netperf results for complete. below details FYI.
> >>>>>
> >>>>>
> >>>>> kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
> >>>>> on:
> >>>>
> >>>> The good news is that I can reproduce.
> >>>> It has made me spot something already:
> >>>>
> >>>>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
> >>>>
> >>>> But that's not enough to fix the regression. Investigation continues...
> >>>
> >>> Thanks a lot for information! if you want us test any patch, please let us know.
> >> 
> >> Oliver, I would be happy to see, whether the patch at the end of the
> >> message restores the original behaviour also in your test setup. I
> >> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
> >> the kernel path, that might cause the regression. I know, it is
> >> probable, that a warning in tick_sched is triggered. This happens when
> >> the first timer is alredy in the past. I didn't add an extra check when
> >> creating the 'defacto' timer thingy. But existing code handles this
> >> problem already properly. So the warning could be ignored here.
> >> 
> >> For the cpuidle people, let me explain what I oberserved, my resulting
> >> assumption and my request for help:
> >> 
> >> cpuidle governors use expected sleep length values (beside other data)
> >> to decide which idle state would be good to enter. The expected sleep
> >> length takes the first queued timer of the CPU into account and is
> >> provided by tick_nohz_get_sleep_length(). With the timer pull model in
> >> place the non pinned timers are not taken into account when there are
> >> other CPUs up and running which could handle those timers. This could
> >> lead to increased sleep length values. On my system during the stress-ng
> >> uprobes test it was in the range of maximum 100us without the patch set
> >> and with the patch set the maximum was in a range of 200sec. This is
> >> intended behaviour, because timers which could expire on any CPU should
> >> expire on the CPU which is busy anyway and the non busy CPU should be
> >> able to go idle.
> >> 
> >> Those increased sleep length values were the only anomalies I could find
> >> in the traces with the regression.
> >> 
> >> I created the patch below which simply fakes the sleep length values
> >> that they take all timers of the CPU into account (also the non
> >> pinned). This patch kind of restores the behavoir of
> >> tick_nohz_get_sleep_length() before the change but still with the timer
> >> pull model in place.
> >> 
> >> With the patch the regression was gone, at least on my system (using
> >> cpuidle governor menu but also teo).
> >
> > I assume the regression is reproducible for both?
> > (The original report is using menu for anyone else looking at this)
> 
> Yes. (at least in my setup)
> 
> >> 
> >> So my assumption here is, that cpuidle governors assume that a deeper
> >> idle state could be choosen and selecting the deeper idle state makes an
> >> overhead when returning from idle. But I have to notice here, that I'm
> >> still not familiar with cpuidle internals... So I would be happy about
> >> some hints how I can debug/trace cpuidle internals to falsify or verify
> >> this assumption.
> >
> > I'd say that sounds correct.
> > Comparing cpu_idle_miss would be interesting for both.
> 
> 	total nr	above		below
> "bad":	2518343		2329072		189271
> "good":	3016019         2960004		56015
> 
> -> this is the result of just a single run using:
> 
>   perf script record -a -e power:cpu_idle_miss /home/anna-maria/src/stress-ng/stress-ng --timeout 60  --times --verify --metrics --no-rand-seed --uprobe 112
> 
> 
> 
> But beside of this, when running this stress-ng test, the cpus seems to
> be mostly idle (top tells me). So the question here fore me is, what is
> the stress in this test and what should the numbers tell we are
> comparing? It is not totally clear to me even after looking at the code.

I can at least help a bit with that since I stared at stress-uprobe for a while.

A single stress-uprobe thread creates a uprobe trace event to fire everytime
getpid() is called. Then it does a lot of getpid() calls, which creates uprobes
events in ftrace and then it does a loop reading /sys/kernel/tracing/trace_pipe
until the end.

The bogomips measured is the total number of uprobes trace events read from
trace_pipe.

And since there are 112 threads doing all this at the same time, there is
probably a lot of contention on trace_pipe rwsem: trace_access_lock() ->
down_write(). Although what I observed with perf was more about mutex contention
so there could be another lock somewhere I missed...

Christian may correct me if I'm wrong...

Thanks.

> Thanks,
> 
> 	Anna-Maria
> 

