Return-Path: <linux-kernel+bounces-104922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E087D5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85121F26A33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA159B72;
	Fri, 15 Mar 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYUrCV0u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InKu6YPv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F325336A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535897; cv=none; b=itMJWxIIiPm/5a9Hhh+E963pEhyV7hC/3bziRHiF7qJx7wapBPMKCk+04njUB72atsS3AE88q9L4BePrWazqmgNUM9zDtLCpDddwPpcH8Huu1iEM8u/yyl+gYcsGeDKi6pM4+XFTpa0tRT3vVt8zcTnu0TnNL+P6U6O1VfyUqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535897; c=relaxed/simple;
	bh=Aqo8LsgNu+lIgVOiVjFoat9jG/tN0Wr+u+tBs8UInTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXfKdWkq37oa4Rne8l4ltA2Zbs9snlATwGKcqXCkKR1iqhdNT/1/37rXcrM1W3dp60HlAJB7+WLFq56Qfk2l6eYdIg4GHNxsi5ft9Mq1HKNaBfr+JXttChs+0cutMjweO6E+iU9y6uz1Mj7ejHNodA+yY+1m3YthlUo1qHolXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYUrCV0u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InKu6YPv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710535893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfuKwhJCpC4zjR/2fFwKXHgi3jqDFD9Ar1EymDRr3Nc=;
	b=mYUrCV0uvgRWyPFqQKOY02Mepw/NdW0HV8rC3RZO8DmSd0KQypzmqxHTNXY5QwUHJvrmTG
	LMPq0pYbxtSiEaRPbeuKz25pU+Juy5DetuorSDZKLOzu2NJW3jbsdC28cC/IKy4WXV+WGG
	THYalh6hSt3zjqjhLzEQuFLQPB+SDEUCG4KGO5DRG+aHS626I6/fpWsjXiNS7qtMUjuzpy
	ZMZ0YrY5DMqdOHFkLuW2tYOEGHCHk+4ggs04OpurpbJL4jorFXn9adSqhISidaXy3dqbT6
	TlHQgqgA8b2M7dPWsDuKv6zX7PGz1cM6nJaX/2eSAgDAT4x3LDyb9td5QwrFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710535893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfuKwhJCpC4zjR/2fFwKXHgi3jqDFD9Ar1EymDRr3Nc=;
	b=InKu6YPvg4U96s7UljH1SQ87f8MXe9KhXnDjIMpZstUq9HTWxXMUpQS0diGPcl3va9tpD/
	N+0s41MycglrTLCg==
To: Dave Hansen <dave.hansen@intel.com>, Feng Tang <feng.tang@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, paulmck@kernel.org, rui.zhang@intel.com, Waiman Long
 <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package number
In-Reply-To: <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
Date: Fri, 15 Mar 2024 21:51:32 +0100
Message-ID: <87r0gbjk17.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 10:58, Dave Hansen wrote:
> On 3/15/24 04:26, Feng Tang wrote:
>>         /*
>>          * Today neither Intel nor AMD support heterogeneous systems so
>>          * extrapolate the boot cpu's data to all packages.
>>          */
>>         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
>>         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
>
> Because Intel obviously has heterogeneous systems today.

Hybrid is a per package property. 

But neither Intel nor AMD support populating multi socket systems with
random packages, where socket 0 has less cores than socket 1 or socket 0
is hybrid and socket 1 is not.

> So I'll buy that removing 'nr_online_nodes' takes NUMA out of the
> picture (which is good), but I want to hear more about why
> topology_max_packages() and '4' are the right things to be checking.
>
> I suspect the real reason '4' was picked was to give the calculation
> some wiggle room because it's not actually all that precise.

IIRC the TSC is only guaranteed to be synchronized up to 4 sockets, but
my memory might be wrong as usual.

Thanks,

        tglx

