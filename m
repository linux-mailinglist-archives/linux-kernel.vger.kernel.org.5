Return-Path: <linux-kernel+bounces-101213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6146587A415
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C3B218A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748619475;
	Wed, 13 Mar 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jy7pPcWB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kPllyf/N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE61428A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318356; cv=none; b=cx14gMD5J8M0P+OAR22Sl6oH67CZ2falP1X4y/amjcMaEKnkh38ZB2iQ7hpcfdCs25OOaQHwjcATK0ZAWUOEgDVL9mQ3DKafOG3qDnHvdxMy9pRO7NbBzHNpFceIWB5Jsoubf0yg/fIzIrRmypjm7IOYK7NN8XXhNNVH59D8fMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318356; c=relaxed/simple;
	bh=b7Tnp/Yse8g4h03H59s1KXPCgkVcxgZsLUGUxUbjJxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUL3oxXtcyyRL9dO6ROFZiDZmXn9n4+CssCIMLFaQteyti4191ArbRrw74G/151+g+xLB31R2zCaB0w6NMopLPnvxAR5HhJq45GgiI3c6IdhgU9F7hqbCpX2pslJr/8m8U0Mk6FzuNCxar2ScdiGmkLHmHMUWAOz/QdQcELY8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jy7pPcWB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kPllyf/N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710318352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qmDJo6fzPhBsNX/lp9m4dC3u9FOBCYDlZ4df3GKyEY=;
	b=Jy7pPcWBk013DFJwQ3yEQ60pnAG5sQXoYL1Va1ljMEowzlVxHuzeuA7zW+x+/YKdc7IaXy
	JV6b0tRnaZl5LLw+WAqKozdA0UuWMzHqYS1yt/CJcDhALEeKnnuxswujtUnRoyCg263MqP
	5peXiJBkuBdbNu873c15iYFMtkmP4JOzdcb3TOhal3UnOBgnFYC1DsukIaWTi3RPTXMKsm
	xiXOBLqMKATTifgdXLitIriA0pszaDowTuAQyDb0BgGMGQ7geY0bMrNyu6e6gW0fFWg0Zs
	2TWKso8X2uQ/DmCNJtAOTtqSRXlABJbaOVdVm5gW57+TDlRhEDWy9cxViilABw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710318352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qmDJo6fzPhBsNX/lp9m4dC3u9FOBCYDlZ4df3GKyEY=;
	b=kPllyf/NWwBadhYPR26w1HrFbuQ/COKEacMoWt9eN4o3RlwbVW32izhgAYCtOEA07lAFF2
	X1yhR0VdSoAtwCCw==
To: Frederic Weisbecker <frederic@kernel.org>, kernel test robot
 <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:
  netperf.Throughput_Mbps -1.2% regression
In-Reply-To: <ZfDr6qOaMVnyoB8W@pavilion.home>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZfDr6qOaMVnyoB8W@pavilion.home>
Date: Wed, 13 Mar 2024 09:25:51 +0100
Message-ID: <87y1amo7w0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13 2024 at 00:57, Frederic Weisbecker wrote:
> So I can reproduce. And after hours staring at traces I haven't really fo=
und
> the real cause of this. 1% difference is not always easy to track down.
> But here are some sort of conclusion so far:
>
> _ There is an increase of ksoftirqd use (+13%) but if I boot with threadi=
rqs
>   before and after the patch (which means that ksoftirqd is used all the =
time
>   for softirq handling) I still see the performance regression. So this
>   shouldn't play a role here.
>
> _ I suspected that timer migrators handling big queues of timers on behal=
f of
>   idle CPUs would delay NET_RX softirqs but it doesn't seem to be the cas=
e. I
>   don't see TIMER vector delaying NET_RX vector after the hierarchical pu=
ll
>   model, quite the opposite actually, they are less delayed overall.
>
> _ I suspected that timer migrators handling big queues would add scheduli=
ng
>   latency. But it doesn't seem to be the case. Quite the opposite again,
>   surprisingly.
>
> _ I have observed that, in average, timers execute later with the hierarc=
hical
>   pull model. The following delta:
>        time of callback execution - bucket_expiry
>   is 3 times higher with the hierarchical pull model. Whether that plays =
a role
>   is unclear. It might still be interesting to investigate.
>
> _ The initial perf profile seem to suggest a big increase of task migrati=
on. Is
>   it the result of ping-pong wakeup? Does that play a role?

Migration is not cheap. The interesting question is whether this is
caused by remote timer expiry.

Looking at the perf data there are significant changes vs. idle too:

    perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_=
enter.cpuidle_idle_call.do_idle
	 36.91 =C2=B1  2%     -12.6       24.32 =C2=B1 10%     -12.3       24.63 =
=C2=B1  5%=20

That indicates that cpuidle is spending less time in idle polling, which
means that wakeup latency increases. That obviously might be a result of
the timer migration properties.

Do you have traces (before and after) handy to share?

Thanks,

        tglx

