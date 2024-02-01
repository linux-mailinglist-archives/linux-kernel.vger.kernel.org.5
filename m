Return-Path: <linux-kernel+bounces-48601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D577845EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC61C287BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518F05C033;
	Thu,  1 Feb 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVC4r455"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0A5C045
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808967; cv=none; b=GRP7pSxcqY3CcVUtGsby0UubVfEc7DOdeJrh/mL5QclDoXl43jGT6ZsVMsA9WgzGBL1/kIzvyYDlWpSVpfuli4350B0p+q8321lx1P+BrSEAe5rOpVmDjICIpCNRvHbpV+AKlAW4k5Nxd3teFlvqKhHxpXCIxSCBIsDJYXMODv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808967; c=relaxed/simple;
	bh=9aqnwUZw2VzPx6YXrvI06CXs6pH2ImPhPIfzFD6ifCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIc7wrc6cJb15XPQswur9i+yGyzNHHHp0vEZRKNWpryHuG56B6uygI7FMrt3s8MUboYbynKZGnpsLjSmr7/ZX5V5BmzzOcjkGNMdCwcmJCAiUJLqmm6UhgVb7rvhSZrLfRxZoyP+O9FJWvhASeTPEfPQOD9WC4KKQYNO+pX9N80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVC4r455; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0982FC433C7;
	Thu,  1 Feb 2024 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808967;
	bh=9aqnwUZw2VzPx6YXrvI06CXs6pH2ImPhPIfzFD6ifCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVC4r455zeZHOTq8GShLCnYvqDDQSXamdlsJR6wHEQgT9zRf28t4Cn2TGU9s6Bf7M
	 nRBr3dKTQ5/TGd2mZg69FuketEYkivjI1J/m7K03coBqWF24+wD67vwHGqs0ZY/9Te
	 KjSMlf9vpbY/Z2SpPZdJeLdO74BFModC2l1k7yGW+W7UrRRapavL+ODkXhW3sDV4xc
	 T2+idkFWo54jgCkqalZJGoJXUkXnz5aa3C4Um3+ibBD23nWpFr/dVx83MM1cW0CKO3
	 reFIn2MSkhDqSgCM79o7m+Cdixa/ekASU9n+0sAUjkg2QB0WHVEbmMSKlxPCUW0Yt8
	 Wbylw6MguJYTg==
Date: Thu, 1 Feb 2024 18:36:04 +0100
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
Message-ID: <ZbvWhOOblt3YPaSV@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-21-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-21-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:43PM +0100, Anna-Maria Behnsen a écrit :
> The timer pull model is in place so we can remove the heuristics which try
> to guess the best target CPU at enqueue/modification time.
> 
> All non pinned timers are queued on the local CPU in the separate storage
> and eventually pulled at expiry time to a remote CPU.
> 
> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just one detail below:

> @@ -590,10 +590,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  
>  	/*
>  	 * We might have to IPI the remote CPU if the base is idle and the
> -	 * timer is not deferrable. If the other CPU is on the way to idle
> -	 * then it can't set base->is_idle as we hold the base lock:
> +	 * timer is pinned. If it is a non pinned timer, it is only queued
> +	 * on the remote CPU, when timer was running during queueing. Then
> +	 * everything is handled by remote CPU anyway. If the other CPU is
> +	 * on the way to idle then it can't set base->is_idle as we hold
> +	 * the base lock:
>  	 */
> -	if (base->is_idle)
> +	if (base->is_idle && timer->flags & TIMER_PINNED)

Is the TIMER_PINNED test necessary? If base->is_idle, then the timer
is now guaranteed to be TIMER_PINNED, right?

Thanks.

