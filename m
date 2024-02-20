Return-Path: <linux-kernel+bounces-72592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4185B5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26F72818C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D45D74F;
	Tue, 20 Feb 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLXFp3W6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28675D73E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418627; cv=none; b=nYKAEUauzYDQa4b51XcF9fvvBX44WEj9AQG/bb5W2I2dz24xR/HjQ8fObTWhqEDWvm86gOQ9QC2cBfZXHhlJVqiAA2ggloqGFPyycUBl8bqVZxFiIA7AIftey/RZUMB+BS/tRGfCJmKAETKMNQ2JLCC9LNzEm+yBp+o+JvpCgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418627; c=relaxed/simple;
	bh=jiKygd1TMHvHAdFLBMMyyM+ctA1TbGkCDRuL++B7qmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WtkKBqK0lT7zAqVba5w0GEH+0C27CdXRbBXU4MJArVNs6IgDDHl393ijNgDDwtei/sLjF1olQmSFdr1c9RmGP0PV8kGvPbx0solCoYoJTALgzQhGXqdDwbzp72Hu7Dn+3H8PGUy4AFLQEQq93kvYGMpiyNNT3aJtJPiCBqWXZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLXFp3W6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708418626; x=1739954626;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jiKygd1TMHvHAdFLBMMyyM+ctA1TbGkCDRuL++B7qmE=;
  b=RLXFp3W6kxh6mVKFHsBCd1Jvv6IxyZCRAGVKeRJpKT59pZwd7pWfo/Fc
   V33ZxsE0rH2TkPGOsZn9CnmS8sp2FUVlfREBSGYoCOea/ngICkg9dbbnC
   6uo/Xo5PBhGmGJPOqM6NbWEHoeVfg7EXgIkluJTOwDAX8gn0rDXm6Ikdp
   VLk3Rl+SbqPFXGkk8yACYkRo1KQ+lEIhsrHGcvRRV5SugqY8WYhzTcLC7
   Isw0877/nG3ZxMsS2m9RvI6FwgRvzbAw6LyCF7PcHLXvHBHn4sO13orY9
   6TThxiZDLPO5yFG7S+z609kZ+9/4D9rrefWHowM9Fz1rj/4lWt1lKoO3U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13626084"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13626084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5081600"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:43:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Juri Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Daniel
 Bristot de Oliveira <bristot@redhat.com>,  Valentin Schneider
 <vschneid@redhat.com>,  linux-kernel@vger.kernel.org,  Luca Abeni
 <luca.abeni@santannapisa.it>,  Tommaso Cucinotta
 <tommaso.cucinotta@santannapisa.it>,  Thomas Gleixner
 <tglx@linutronix.de>,  Joel Fernandes <joel@joelfernandes.org>,  Vineeth
 Pillai <vineeth@bitbyteword.org>,  Shuah Khan <skhan@linuxfoundation.org>,
  Phil Auld <pauld@redhat.com>,  Aaron Lu <aaron.lu@intel.com>,  Kairui
 Song <kasong@tencent.com>,  Guo Ziliang <guo.ziliang@zte.com.cn>
Subject: Re: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
In-Reply-To: <b859f20b-5df7-403d-8078-06d747ec6b75@kernel.org> (Daniel Bristot
	de Oliveira's message of "Tue, 20 Feb 2024 09:31:55 +0100")
References: <cover.1699095159.git.bristot@kernel.org>
	<8734tosyb9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<23b87c48-c4b8-4b85-822a-33cffaf6f779@kernel.org>
	<878r3freza.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<b859f20b-5df7-403d-8078-06d747ec6b75@kernel.org>
Date: Tue, 20 Feb 2024 16:41:39 +0800
Message-ID: <87le7fo7cs.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Daniel Bristot de Oliveira <bristot@kernel.org> writes:

> On 2/20/24 04:28, Huang, Ying wrote:
>> Daniel Bristot de Oliveira <bristot@kernel.org> writes:
>> 
>>> Hi
>>>
>>> On 2/19/24 08:33, Huang, Ying wrote:
>>>> Hi, Daniel,
>>>>
>>>> Thanks a lot for your great patchset!
>>>>
>>>> We have a similar starvation issue in mm subsystem too.  Details are in
>>>> the patch description of the below commit.  In short, task A is busy
>>>> looping on some event, while task B will signal the event after some
>>>> work.  If the priority of task A is higher than that of task B, task B
>>>> may be starved.
>>>
>>> ok...
>>>
>>>>
>>>> IIUC, if task A is RT task while task B is fair task, then your patchset
>>>> will solve the issue.
>>>
>>> This patch set will not solve the issue. It will mitigate the effect of the
>>> problem. Still the system will perform very poorly...
>> 
>> I don't think that it's common (or even reasonable) for real-time tasks
>> to use swap.  So, IMHO, performance isn't very important here.  But, we
>> need to avoid live-lock anyway.  I think that your patchset solves the
>> live-lock issue.
>
> I mean, if for you this is solving your user problem, be happy :-) Play with parameters...
> find a way to tune your system as a user... use it :)
>
> But your problem is also "solved" with RT throttling without RT_RUNTIME_SHARE (the
> default since... two years ago, I think). So there is not much news here.
>
> IMHO, it is not a solution. As a developer, there is a synchronization problem
> in swap code, and pushing a workaround to the scheduling side is not the way to go...
>
>> 
>>>> If both task A and task B is RT tasks, is there
>>>> some way to solve the issue?
>>>
>>> I would say reworking the swap algorithm, as it is not meant to be used when
>>> real-time tasks are in place.
>>>
>>> As an exercise, let's say that we add a server per priority on FIFO, with a default
>>> 50ms/1s runtime period. Your "real-time" workload would suffer a 950ms latency,
>>> busy loop in vain.
>> 
>> If the target is only the live-lock avoidance, is it possible to run
>> lower priority runnable tasks for a short while if we run long enough in
>> the busy loop?
>
> If you do it in the algorithm side (instead of relying on scheduling), it could be a
> thing.
>
> I think NAPI still uses something like this: Busy-loop for two jiffies in the softirq
> context (a priority higher than all threads on the !rt kernel), then move to thread
> the thread context to avoid starvation. In the swap case, it could run for two jiffies
> and then go to sleep for a while. How well will swap people receive this as a solution...
> I do not know :) I would first try something better than this using synchronization
> primitives.
>
> This patch set is for things outside of kernel control. For example, people running
> poll mode DPDK in user-space with FIFO priority; FIFO tasks in user-space for too long...
> with a better design than rt throttling.
>
> Will this patch help in misbehaving kernel activities: yes. Is it a reason not to
> fix kernel problems? I do not think so, and I bet many other people do not believe as
> well.

I totally agree with you that we need to fix the kernel problems.  And,
Thanks for your information!

--
Best Regards,
Huang, Ying

