Return-Path: <linux-kernel+bounces-109304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A59881767
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887EFB20A23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CC85641;
	Wed, 20 Mar 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Wsrfpeoy"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8E6A8A6;
	Wed, 20 Mar 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960155; cv=none; b=WWd/4Rg4oi89Or+lESFybS64+iCgNPeI8Axd320s8+4AbVxqNHqi0sSgADl7zT4KDstQvOXT1ag26JjKMsgIZGUDoNsR/7OGLgfJ+Z5EBbqpFNLTeRhe4A3uoaG4Ikun8CZbRDIl7nH2dbB0IF7LHGAb62KsLZLeLhFurYrzx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960155; c=relaxed/simple;
	bh=mSf36M6+ozi+UXP0kZAkJzy6JWKv6y+KNFAS3NVr9Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZcAwxoT7gfewGmLPMFHnUBjZ5McaTYu+OXdwmi7ac92Ug7Sq6tHUM0tNORTt+LpfFsfh55BKyxMtsedH8mmpry+0VHchT1lVqeDTxH8NJTjfKbMJX+fVHXwZWd2xFci3cWu+0FEiDlyeR1uH9ZDJr75cORZZQ1Jp1A6V54Kd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Wsrfpeoy; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710959731;
	bh=mSf36M6+ozi+UXP0kZAkJzy6JWKv6y+KNFAS3NVr9Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WsrfpeoyxWE2YmTBNvU2aOHGgVke3371rbcgM0PKWWtn6uurUbyyxpcwJRwFuJNcj
	 IG1TnFE8lpsubpUh/p1Q7qO1JvoWAcDHEa/3oThNNdG9OHn41efq05pcRD289m33w9
	 vscBeHvYsWJ8ZOXbEMwi72qmAAgusZYKrYukLeDnaSTJtLOpt+f2ZtDCTNX8zNEw8t
	 3ZwB1OaWs2XMN9Lc7X/ohwP8WVwD4IN/158A/fRqaeOKMFBQi7OzUFm/VqtHwMWkOO
	 MqxkGIoxvDTU3r1egQoAJej/C7+wT7z7Cds9wtgojdx7FyDq8eviXM8K2RPBDB4/qc
	 Adwz7YeiF+faw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V0HMl5D2Yzkh9;
	Wed, 20 Mar 2024 14:35:31 -0400 (EDT)
Message-ID: <07272f98-859b-4a10-9096-9cba763af429@efficios.com>
Date: Wed, 20 Mar 2024 14:35:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20240320122012.2c1f461f@gandalf.local.home>
 <0015569b-15dc-4ccd-b322-67c3665c585e@efficios.com>
 <20240320135819.4a25c50f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240320135819.4a25c50f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-20 13:58, Steven Rostedt wrote:
> On Wed, 20 Mar 2024 13:15:39 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> I would like to introduce restart_critical_timings() and place it in
>>> locations that have this behavior.
>>
>> Is there any way you could move this to need_resched() rather than
>> sprinkle those everywhere ?
> 
> Because need_resched() itself does not mean it's going to schedule
> immediately. I looked at a few locations that need_resched() is called.
> Most are in idle code where the critical timings are already handled.
> 
> I'm not sure I'd add it for places like mm/memory.c or drivers/md/bcache/btree.c.
> 
> A lot of places look to use it more for PREEMPT_NONE situations as a open
> coded cond_resched().
> 
> The main reason this one is particularly an issue, is that it spins as long
> as the owner is still running. Which may be some time, as here it was 7ms.

What I think we should be discussing here is how calling need_resched()
should interact with the latency tracked by critical timings.

AFAIU, when code explicitly calls need_resched() in a loop, there are
two cases:

- need_resched() returns false: This means the loop can continue without
   causing long latency on the system. Technically we could restart the
   critical timings at this point.

- need_resched() returns true: This means the loop should exit quickly
   and call the scheduler. I would not reset the critical timings there,
   as whatever code is executed between need_resched() returning true
   and calling the scheduler is adding to latency.

Having stop/start critical timings around idle loops seems to just be
an optimization over that.

As for mm and driver/md code, what is wrong with doing a critical
timings reset when need_resched() returns false ? It would prevent
a whole class of false-positives rather than playing whack-a-mole with
those that pop up.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


