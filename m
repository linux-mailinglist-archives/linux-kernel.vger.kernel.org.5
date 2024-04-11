Return-Path: <linux-kernel+bounces-140711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38A8A180C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EB31C22925
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21F15E81;
	Thu, 11 Apr 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTxrHtRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287A14A9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847768; cv=none; b=qt6Lj7NL3A3FxW4roqEexk9eh5knmI1b9vQsdI8RVfm7u4BuE5LDi6COxGE09fJnKJhjEULXE/w2eiSSjL4pv0x4PV/FDBrU2pZNGgHSKbjeogoK3xvQ4imSlBvH859/6zC+fVDaugfe8DjoobqpEUC2dLZnkOYXh7aVS3mtPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847768; c=relaxed/simple;
	bh=rEqyOsi38ZbTsIvKfbdUj7clGJ1K6n+BfTMVaIMXqwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtUN6FHr3IMDu4a6dftMbxhCyOc0K04p1Bd8tF3vc2MKPfucw2Sw2fLofK+r54V9Co1GdIPTx0l+hmdSNhUgWRaffBPqg8DKKd35nh6XTHC277YOK6jkQE8A99Dam5ilEKhI2EPnzSwCmHuIl6/lZYiQUKPIAn2o/ouTsnB2Smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTxrHtRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAA6C072AA;
	Thu, 11 Apr 2024 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712847767;
	bh=rEqyOsi38ZbTsIvKfbdUj7clGJ1K6n+BfTMVaIMXqwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTxrHtREVrJ+CiC8o3ydO+Vdetun9o+h3F18TmR78n6nRMhrt8ipN+08hXY8w5U1V
	 fO0YZES+pu46m7RwRJLMrSxfzFztIQMnU26ESW5jYaR2GdSgcOft+AG185s+jugrL6
	 8mAePzB+bNMce7ZsKzmd5/qVruj+YocUJJ73QnQoQqjX/OcB5p77rWPQOGaBaZTdBn
	 3iXLxbgcjaE5IfGnhrsyEzAdZjNs6y5GigGgmmrSlXUolZZ4wmDXMIRCu8BZ10UQQ5
	 TGLJgg2Zlpg0Hdxb0MZECgEWLIECeHwOIY3ZbMyNGjwKtl7tg+WPHpUq/a/yo5qyp1
	 NCNPj/SUQ80Dw==
Message-ID: <e4efd69c-b155-4c13-99c3-9603f5769f93@kernel.org>
Date: Thu, 11 Apr 2024 17:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/6] sched/fair: Fair server interface
To: Peter Zijlstra <peterz@infradead.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1712337227.git.bristot@kernel.org>
 <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>
 <20240411144327.GB40213@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240411144327.GB40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 16:43, Peter Zijlstra wrote:
> On Fri, Apr 05, 2024 at 07:28:02PM +0200, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each CPU has three files under /debug/sched/fair_server/cpu{ID}:
>>
>>  - runtime: set runtime in ns
>>  - period:  set period in ns
>>  - defer:   on/off for the defer mechanism
>>
>> This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to set
>> bounds on admission control.
>>
>> The interface also add the server to the dl bandwidth accounting.
> 
> I suppose most people will want to use it like:
> 
>   for i in /debug/sched/fair_server/cpu*
>   do
> 	  echo $PERIOD > ${i}/period
> 	  ecoh $RUNTIME > ${i}/runtime
>   done
> 
> And I think we agreed to keep this loop in userspace, but memory is
> vague.

correct, we agreed to keep loop in user-space. It is important to have per-cpu
for large systems, like we have at red hat customers (kubernets): each container can
have a different setup... and they do. Like, DPDK people would like to keep some
few us runtime, while other CPUs it is better to keep the default.

> The 'defer' thing is dubious though, I don't suppose anybody would ever
> want to actually change that, other than you while poking around at this
> code, right?

In a setup where all real-time tasks are DL (without fixed-priority tasks (FIFO/RR))
the defer = 0 makes more sense because the bandwidth is reserved anyways, and the
DL server would have a relatively low prio (long period).

Believe it or not, we are getting there in some cases with automation systems :-)

If it does not hurt, I would like keep it... Otherwise, we can think about it in
the future.

-- Daniel

