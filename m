Return-Path: <linux-kernel+bounces-135730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B989CA76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CC31C2439A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413C143888;
	Mon,  8 Apr 2024 17:11:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E84143876
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596282; cv=none; b=H/eyo72v6psuM2dkjM9t5Y4V/JdicB0rskskNL0jTYS2qYjFzNECf63RVmR/4TSiZa/1hirLYA3dBoa05oCZSyc8Llx5A42oo0nSbioSYZXF32huoKj3HacJTK6myjNwCMfZpI5TvwtmNaca4rdLKKaIP81ujmjEGz3Ax9O+L5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596282; c=relaxed/simple;
	bh=LUX+1ZzbvXxppPmeoL9sYk2grjk/mywpAHH5HQ8YEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3xLWFBbJg1qFhx8Dqpz4GZ6KAhcZd2oXGVGyd1Kv6hBGUTVSW394XCF9qcwm5d2eIZOOlcjP7KnnEf/3LTsqDx24VlKsoQS+cRPr40NtiE6VtG7by3vEiVOM2JkUdyBMN+ZTT2LgAcMK7tS+kDJAkf2bwnhlF0J+9dBnl0rFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AFCC433F1;
	Mon,  8 Apr 2024 17:11:19 +0000 (UTC)
Date: Mon, 8 Apr 2024 13:11:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Luca Abeni
 <luca.abeni@santannapisa.it>, Tommaso Cucinotta
 <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>, David Vernet
 <void@manifault.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20240408131118.7bbca82f@rorschach.local.home>
In-Reply-To: <b5e0dbb8-3aab-4316-85bb-6b7ac3134e07@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
	<c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
	<1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
	<d7d8540e-c417-41fa-aea9-acb80541a30d@kernel.org>
	<bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
	<b5e0dbb8-3aab-4316-85bb-6b7ac3134e07@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 16:35:49 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> A reproducer always helps. So, your task there is not a periodic task... it is
> a sporadic task because it sleeps for a fixed amount of time after the runtime.
> 
> A periodic task with period 76 would wake at 0, 76, 152 - like cyclictest...
> so consuming at a fixed time rate if the scheduler allows it.
> 
> In the case of a fixed sleep time at the end of the execution, it will end up
> "throwing away bandwidth" if the runtime is not given at the beginning of the
> period because it will run slower... accumulating error. But that was not the
> main point here...
> 
> The problem here was more like: if a fair task goes to sleep in the middle of
> the server activation (for a lock?), and then wakes up again, the code in v5 is
> forcing it to defer... again. Thus, it is getting less bandwidth... notice that
> it does not even need to be at the start of the period. It is the middle of the
> execution.
> 
> Intuitively, reducing the deferred time would help there. But the best thing to do is:
> 
> If the fair task waited for the defer, and the real-time tasks are still using all
> CPU time, do not defer the activation again, and keep the defer mechanism disabled
> until the real-time tasks allow the fair scheduler to run in the background. So,
> making the defer mode equivalent to the non-defer mode until the RT tasks start
> to behave again.
> 
> For that, in the v6, there is a variable (dl_defer_running), once the dl_server
> is enqueued after the defer time, the variable dl_defer_running is set.
> 
> If the fair task sleeps in the middle of the period, that variable do not change.
> 
> If the fair task wakes up and the dl_defer_running is still set, do not defer.
> Keep running until you consume the reservation.
> 
> The variable dl_defer_running is set to 0 only after the fair tasks consume
> its runtime without being in a dl_server... IOW, when the RT tasks start to
> behave.

Very nice explanation! Thanks Daniel.

> 
> No interface change.
> 
> With that in place, your reproducers are working. I have a periodic version
> of your reproducer, also improving how the task consumes the runtime,.. I
> will send it to you so you can have a look.

Looking forward to reviewing your patches when I'm back from PTO.

-- Steve

