Return-Path: <linux-kernel+bounces-49807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B2846F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714C328CCAC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7AD13E212;
	Fri,  2 Feb 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozg1bor9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CF13DBA8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875068; cv=none; b=iFrrYus9Kg0M3k+YnNxENlVRxQPtoUlGSDxvB4xVM9Vc+9EjikTwpMV8bDkVS42yD7JSQ8ENJWJo6ew+OpHtMAm06ak4qj5G8UND9MC/h5syUAmNRLVQtQCxRPbfAzxQsak3nuDv1uUxacmdD10xRvVU9YKKYmDlSlT+SgIqEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875068; c=relaxed/simple;
	bh=rYvumnDSMWSCXcjlFfDUjse2yjBUSHNWfG3QaEAz+hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4siu4J7iHu1PjBfYr+RRFOni2qOh1UifcIolSUkYxiGKWmpCuhLxQYADEYrXeFIJFfZHChLb2PjQfSgQbaKwJ5js46c0MecUfOI64dClIroAddRVCoiZbS4JciMu6sSgI3vewqeDyY3LYVFn6qmpIELPSGlLAsXhBxV6DOcsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozg1bor9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF1C433F1;
	Fri,  2 Feb 2024 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706875068;
	bh=rYvumnDSMWSCXcjlFfDUjse2yjBUSHNWfG3QaEAz+hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ozg1bor9R/Exbfah1bTIQkQBVs3+kTsw76FfouDk7nJlhwfDjBjpMbknwiUo+VYuz
	 d/1/KdHPBLtVGELDJ4/mCeNRdPxUKGHsKkVw4/pQRUAYKzgcqNbh74xE+IJQe+g5/h
	 iZ/KVBTTeYEz0ZPvTcJ06hY5+9kqGWGi2daf/+fenJXftSsEdGU9JoAQBTZne5ppNi
	 fDXBvINtLIn6lDfDTu+Co1xVkkLOXpwJhPlijqDeVFqHhZDOAycDKTyPWgPudnUS9R
	 fvVb7mi764oYDEfwyvM+2sxedW2Qlkwpcy7mK95FT7Y17l/x9lRzvAaWp2kEZL47lu
	 XXnWFECqfHCjQ==
Date: Fri, 2 Feb 2024 12:57:44 +0100
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
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v10 20/20] timers: Always queue timers on the local CPU
Message-ID: <ZbzYuKUd2F37nnnB@lothringen>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-21-anna-maria@linutronix.de>
 <ZbvWhOOblt3YPaSV@localhost.localdomain>
 <87plxflx4x.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plxflx4x.fsf@somnus>

On Thu, Feb 01, 2024 at 09:58:38PM +0100, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:43PM +0100, Anna-Maria Behnsen a écrit :
> >> The timer pull model is in place so we can remove the heuristics which try
> >> to guess the best target CPU at enqueue/modification time.
> >> 
> >> All non pinned timers are queued on the local CPU in the separate storage
> >> and eventually pulled at expiry time to a remote CPU.
> >> 
> >> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> >> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > Just one detail below:
> >
> >> @@ -590,10 +590,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> >>  
> >>  	/*
> >>  	 * We might have to IPI the remote CPU if the base is idle and the
> >> -	 * timer is not deferrable. If the other CPU is on the way to idle
> >> -	 * then it can't set base->is_idle as we hold the base lock:
> >> +	 * timer is pinned. If it is a non pinned timer, it is only queued
> >> +	 * on the remote CPU, when timer was running during queueing. Then
> >> +	 * everything is handled by remote CPU anyway. If the other CPU is
> >> +	 * on the way to idle then it can't set base->is_idle as we hold
> >> +	 * the base lock:
> >>  	 */
> >> -	if (base->is_idle)
> >> +	if (base->is_idle && timer->flags & TIMER_PINNED)
> >
> > Is the TIMER_PINNED test necessary? If base->is_idle, then the timer
> > is now guaranteed to be TIMER_PINNED, right?
> >
> 
> Yes, you are right. Should I drop it? To clarify it, I could add a
> 
>   WARN_ON_ONCE(!timer->flags & TIMER_PINNED)

Yep, that looks good!

Thanks.

> 
> instead.
> 
> Thanks,
> 
> 	Anna-Maria
> 

