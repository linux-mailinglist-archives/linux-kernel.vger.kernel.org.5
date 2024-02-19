Return-Path: <linux-kernel+bounces-71582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A785A752
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66A82842EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B40383A4;
	Mon, 19 Feb 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lg4QFBre";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x29P0Wj3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DE1EA80
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356380; cv=none; b=D+BgeXxDE4D/bgD907iZeKQkU2UNT0vcYrvSX4NJvI/CE6BbusKK2U3V6s8I7i+brpJlnJTC1xw0zgyWmw1st6f30h2s5flqUA0InI0mDxR1w8tASUm1jDB2IS1U91MuSCwEfzXIg21GDNEMdeIyLsIO/8+FZRiUMxCn0ZpgMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356380; c=relaxed/simple;
	bh=FIHb8oY6ndO0qGpjBGexXM43yBrJyQywjtHvJ2RI5MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JpNMUrV1cXqlcLwVA5QrQWnuC6IItDhE1zoS4vKa8lhSCnYw9mAPZXtYqYIVcOPs3QoORrPWR8RRblSRDLT1MPeSydj128pbTcjgzVdgDs7vrjZyEiUBJ7xDByBNjnCyOBhoqG/gX0O6WRENpIpdJ6Zb9lmfwNDjCWwNLaVvUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lg4QFBre; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x29P0Wj3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708356377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWvz3grHonU3ARZYEQTfdA/UObu82g21jkmiwjT7p3k=;
	b=Lg4QFBreV3hiBKcUhF9TbxcqOfhIy86SMDw0Gt/u2iCtsoNrCeydWyUp9ibqcqyK4fNWia
	L1p5zYX5emRVjMgSgL+TBK+itIb1GAYj/Kq+mk12SIMSod1avD0eeopp/u1FVXWIsigWap
	DKEx+f+3hV0h6aIrb+vkZSsKLZ3U1PycHSbtr+o4ppTzKsBQF52IgR2PsDmBZNIhdx7dhP
	Y1xGsyONJqjOuheylwgnnPwZWc2rviRiVRXG60i3B0ROwtT8sCmD4fK+II+IgxbcC+GqMR
	CzfkmdW/d+xDeW+VcJsriZO4+MNfRgkXIJs3qLmi5vBuQYY976DGDL87BnyHdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708356377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWvz3grHonU3ARZYEQTfdA/UObu82g21jkmiwjT7p3k=;
	b=x29P0Wj3tnMoE5BJ19V7ZQ8c12iFFgXPCIwIVm8XpgkpRlLNSEJTu0NJLMUloKg3w+jpRy
	iRbP37AW366H82Bg==
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 05/30] sched: *_tsk_need_resched() now takes resched_t
 as param
In-Reply-To: <20240213055554.1802415-6-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-6-ankur.a.arora@oracle.com>
Date: Mon, 19 Feb 2024 16:26:17 +0100
Message-ID: <87sf1o8oh2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:

The subject line reads odd...

> -static inline bool test_tsk_need_resched(struct task_struct *tsk)
> +static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  {
> -	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
> +		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
> +	else
> +		return false;
>  }

Same like the others. This wants wrappers with now/lazy.
  
>  /*
> @@ -2104,7 +2121,8 @@ static __always_inline bool need_resched(void)
>  
>  static __always_inline bool need_resched_lazy(void)
>  {
> -	return unlikely(tif_need_resched(NR_lazy));
> +	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
> +		unlikely(tif_need_resched(NR_lazy));

Shouldn't this be folded into the patch which adds need_resched_lazy()?

Thanks,

        tglx

