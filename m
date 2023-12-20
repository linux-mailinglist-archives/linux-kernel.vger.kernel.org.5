Return-Path: <linux-kernel+bounces-7084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427281A170
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89781F232FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE563D96C;
	Wed, 20 Dec 2023 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQXOr7gz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3323D965
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950C0C433C8;
	Wed, 20 Dec 2023 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083799;
	bh=Iv/cIaQAPXm2RUPeVXr5JzCDgj9SXoRlobSmJJOPQFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQXOr7gzagqoaj5/1+PdA2Hp8Q8tB74zmovhZnKW5X1u6IErFzsn4NiwJ3cgusHgL
	 xVImRMLHcjHDIqrJHjp8ovC5DgW40EQSyiw+ndonkABdiJo1qIOmz1G69MdcVfP1Gj
	 +qJK5W7DLGx2V2CeY5FwFRaIl+aIE/qEw5sqH+SdFT65YXOPKWDCNJ0RycorNoPrZj
	 eUqHKRvi5OVeBsSfpNZ/RgNRGQJMYVHk41CyOgHFgfsR5Aj6z/AguhEeW2jaO/3s7W
	 QHv873dVj77M8BXMkgBysH9Wtj459T5hHpg8ZhM3W3g0LUxM7ZHuOzyQb2qHMJAJwG
	 +9I/TOgzMNueg==
Date: Wed, 20 Dec 2023 15:49:55 +0100
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
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
Message-ID: <ZYL_E39vfS_963eg@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-13-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:34AM +0100, Anna-Maria Behnsen a écrit :
> When no timer is queued into an empty timer base, the next_expiry will not
> be updated. It was originally calculated as
> 
>   base->clk + NEXT_TIMER_MAX_DELTA
> 
> When the timer base stays empty long enough (> NEXT_TIMER_MAX_DELTA), the
> next_expiry value of the empty base suggests that there is a timer pending
> soon. This might be more a kind of a theoretical problem, but the fix
> doesn't hurt.

This solves a real issue. I suggest removing the last sentence and add instead:

If the CPU sleeps in idle for a bit more than NEXT_TIMER_MAX_DELTA
(~12 days in HZ=1000) and then an interrupt fires, upon going back to idle
get_next_timer_interrupt() will still return KTIME_MAX but incorrectly set
is_idle to false. Therefore the CPU will keep the tick stopped and go back to
sleep though further remote enqueue of timers to this CPU will fail to send an IPI.
As a result the timer will remain ignored.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

