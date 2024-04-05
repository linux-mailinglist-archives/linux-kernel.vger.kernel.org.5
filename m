Return-Path: <linux-kernel+bounces-133440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221289A3BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167911F2417F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE09171E53;
	Fri,  5 Apr 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pp8ex2Zs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21i9kyjH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4B171E5C;
	Fri,  5 Apr 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339540; cv=none; b=mLg8cz5xvMx6jYqRl3Bn5Ij6azqpcJm6YskxkUyAF2CL7ctmWJgV5NP2rEIW/LVFs31Sq5a76u4y0/W7tXP4aQPWb0aiodnw79JRPsTygw7IU6VKXX2M/AI1tk4hg5pMLWsyQIEOTbe/OVMR4URkjIm8SyYFipKCDJXi0ObqBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339540; c=relaxed/simple;
	bh=j7yhX/0k89FjgZpWop60wH7jFudilKgIEAQOT4pmwFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8iKmwizXXOS/tCqms7UKU0Zs4KC5yxezLD7qSmHSk/z/6kVhMAbcYKzF/aWRHVJIaCEqyMfJhJTbhLn3laMOu0QsRhtbqyAURP5n21kRS7+1OKqNlMnrLAP+7P8Aq8uwkZutCKRBsxZmPWWpBkh0oU211DcRt1mJMdLdBsRh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pp8ex2Zs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21i9kyjH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712339536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7yhX/0k89FjgZpWop60wH7jFudilKgIEAQOT4pmwFc=;
	b=pp8ex2ZsLRPjTgD5B64xpI/Ztqb+a3c8XLyOM5lBZ0X1XlPNn3N443JQJUPx2FFIult+gD
	CnvtHY7LJ9vfRpbMZdNITpA25tjaumpkzjcwinlKxPVsdEhdmNF5B4DGXEiy16ua3msDPZ
	7hTg5OmQ8FdNj2892/9G0aZhEZrGLjTSN9AweM2WrRt/4Qu8yPvCs+NIHEeQHXGo1SGwt6
	5Fy+boPBiIHxgq64uU0ZfsD52t5ci2Y/zFzPLdahPkbqcvVbUevdVc+cqoFocjpEFlFpDc
	aghVnAc3Tx4AR63TJ1VTchMZcbzd8NBcu6P7bWdgDc/OPyIRgO7yh0kfSeXvBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712339536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7yhX/0k89FjgZpWop60wH7jFudilKgIEAQOT4pmwFc=;
	b=21i9kyjHmB1jIK0h8UR8AjeiTCXFhrCFrthxjn9uL94YkY2aosXsbD20lo2w9pvGyV1cHr
	LoK9FbGzohFzFhCw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-pm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 x86@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, Mario
 Limonciello <mario.limonciello@amd.com>, stable@kernel.org
Subject: Re: [PATCH] PM: s2idle: Make sure CPUs will wakeup directly on resume
In-Reply-To: <20240405083410.4896-1-anna-maria@linutronix.de>
References: <20240405083410.4896-1-anna-maria@linutronix.de>
Date: Fri, 05 Apr 2024 19:52:16 +0200
Message-ID: <87jzlb8zov.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 10:34, Anna-Maria Behnsen wrote:
> s2idle works like a regular suspend with freezing processes and freezing
> devices. All CPUs except the control CPU go into idle. Once this is
> completed the control CPU kicks all other CPUs out of idle, so that they
> reenter the idle loop and then enter s2idle state. The control CPU then
> issues an swait() on the suspend state and therefore enters the idle loop
> as well.
>
> Due to being kicked out of idle, the other CPUs leave their NOHZ states,
> which means the tick is active and the corresponding hrtimer is programmed
> to the next jiffie.
>
> On entering s2idle the CPUs shut down their local clockevent device to
> prevent wakeups. The last CPU which enters s2idle shuts down its local
> clockevent and freezes timekeeping.
>
> On resume, one of the CPUs receives the wakeup interrupt, unfreezes
> timekeeping and its local clockevent and starts the resume process. At that
> point all other CPUs are still in s2idle with their clockevents switched
> off. They only resume when they are kicked by another CPU or after resuming
> devices and then receiving a device interrupt.
>
> That means there is no guarantee that all CPUs will wakeup directly on
> resume. As the consequence there is no guarantee that timers which are

s/As the/As a/

> queued on those CPUs and should expire directly after resume, are
> handled. Also timer list timers which are remotely queued to one of those
> CPUs after resume will not result in a reporgramming IPI as the tick is

s/reporgramming/reprogamming/

> active. A queue hrtimer will also not result in a reprogramming IPI because

s/A queue/Queueing a/

> the first hrtimer event is already in the past.
>
> The recent introduction of the timer pull model (7ee988770326 ("timers:
> Implement the hierarchical pull model")) amplifies this problem, if the
> current migrator is one of the non woken up CPUs. When a non pinned timer
> list timer is queued and the queueing CPU goes idle, it relies on the still
> suspended migrator CPU to expire the timer which will happen by chance.
>
> The problem existis since commit 8d89835b0467 ("PM: suspend: Do not pause
> cpuidle in the suspend-to-idle path"). There the cpuidle_pause() call which
> in turn invoked a wakeup for all idle CPUs was moved to a later point in
> the resume process. This might not be reached or reached very late because
> it waits on a timer of a still suspended CPU.
>
> Address this by kicking all CPUs out of idle after the control CPU returns
> from swait() so that they resume their timers and restore consistent system
> state.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218641
> Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@kernel.org

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


