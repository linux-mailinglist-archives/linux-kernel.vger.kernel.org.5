Return-Path: <linux-kernel+bounces-75468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59BA85E91B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F872834E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A653B2A6;
	Wed, 21 Feb 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8epUoUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950001E485
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547778; cv=none; b=rmQwqHpljeuIc5/lR0ShXuO/2pMksfM9KCVzttdSJK7onJ5RpSkJ5q9Jis3J13uRnj2L3jWXVFzqU8E8gHslOGnc4T8s0hVgAzb/+vvh7ziuKpPCFa3Mn8VU9foqKduZZZLYqpkpG1YHEx7tDo/cqqk+L5/nBv2NXiiuPTP66B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547778; c=relaxed/simple;
	bh=NzM1hRe8wv7YB8wEXVEeZHO9YYwtH/8T9TsFR/fw1pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVRr9nkgNXZPdORhSjQPCIPeR+kSV31KNRft2UVk/eNkkdTUkedYZB4WkSPlLMnHQIzP7Z6963ocdAZdrhIlZD9vbEWsgArzblISuXci74/GDfqA7te9az9hYiWM003YVscU2/EfEAF18BJQGQpnSBdMA6YySfVbHk4NRsV7hbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8epUoUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED03C433F1;
	Wed, 21 Feb 2024 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708547778;
	bh=NzM1hRe8wv7YB8wEXVEeZHO9YYwtH/8T9TsFR/fw1pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8epUoUGnpHiIhKsWaClqpSTWhBTyfSj0xBYoD3c7ohSqqA/9Gjgx/6cLZELHvmAD
	 gj4IOz7qx2eHbUQuP1o4nnoT+AZnev4OM3sfqyH9Xqz77uVAwoydmw67lUVh3TeYTf
	 bPFbfN/OZWQkTCEDlp4WXILExjHFj2HBpD1n3RuGYA1DvnTaBM09hHqhf09zXdZwXv
	 Z+DS0Cv8+tyl0DxVL4MZ7NO2h5Mh4jASHEyL7olz4qBp1a3BbYk9l6EdJ9sB0RvvyL
	 Jwc4mu84vwvS5Vz5Gfet+XfC1zZJNh0ZZ15LwFTH6UN8hu6fUIjB6HAa1+sebzKqiV
	 /c/biw5Xdli3w==
Date: Wed, 21 Feb 2024 21:36:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 03/20] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <ZdZevnP0p1y476jn@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221090548.36600-4-anna-maria@linutronix.de>

Le Wed, Feb 21, 2024 at 10:05:31AM +0100, Anna-Maria Behnsen a écrit :
> The timer base is marked idle when get_next_timer_interrupt() is
> executed. But the decision whether the tick will be stopped and whether the
> system is able to go idle is done later. When the timer bases is marked
> idle and a new first timer is enqueued remote an IPI is raised. Even if it
> is not required because the tick is not stopped and the timer base is
> evaluated again at the next tick.
> 
> To prevent this, the timer base is marked idle in tick_nohz_stop_tick() and
> get_next_timer_interrupt() is streamlined by only looking for the next timer
> interrupt. All other work is postponed to timer_base_try_to_set_idle() which is
> called by tick_nohz_stop_tick(). timer_base_try_to_set_idle() never resets
> timer_base::is_idle state. This is done when the tick is restarted via
> tick_nohz_restart_sched_tick().
> 
> With this, tick_sched::tick_stopped and timer_base::is_idle are always in
> sync. So there is no longer the need to execute timer_clear_idle() in
> tick_nohz_idle_retain_tick(). This was required before, as
> tick_nohz_next_event() set timer_base::is_idle even if the tick would not be
> stopped. So timer_clear_idle() is only executed, when timer base is idle. So the
> check whether timer base is idle, is now no longer required as well.
> 
> While at it fix some nearby whitespace damage as well.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

