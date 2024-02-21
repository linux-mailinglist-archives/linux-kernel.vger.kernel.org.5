Return-Path: <linux-kernel+bounces-73902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B5085CD64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C708284E58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A93D8E;
	Wed, 21 Feb 2024 01:23:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4411FBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478619; cv=none; b=ndZWfT8XS9QDlsJw2rOrSbrfw8cafgVV6QCbX+PCJcB4MGT1ro6w8aXCQ4vapIHBpySUOrYa8lI+8uUBqNH70RTZC0xSYcN7YlyjfVINJkQ6e7laVvKLanr1wyBH8tQG2gmiL0/Rb/vw8g/ELZlK7M54ig0eBvfA0t0YuBf8eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478619; c=relaxed/simple;
	bh=IuGrRgwHUhnGKbjOR1clKgykUMeR34I+TWtRYnHTdrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/WrmWTLRcdcbt+/z7jF1YeaqsN81QFPI57EMYiE7tRiU3XAHYW12OdzvcdRcmA9RYtNIk539HT/fm6CWFk5UCFhCxU2cHrXJw+8lCGceeswbf3F/KzXxnzi8yQErnJ4A6AGE/owYnoy4Hz+T4fEr6lPPVdefR0wpEXlhlqzfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D91C433C7;
	Wed, 21 Feb 2024 01:23:38 +0000 (UTC)
Date: Tue, 20 Feb 2024 20:25:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
 <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/clock: Make local_clock() notrace
Message-ID: <20240220202524.2527c110@gandalf.local.home>
In-Reply-To: <182553e4-a2e2-46f6-8c50-2de6f8effee7@efficios.com>
References: <20240220202002.38fec245@gandalf.local.home>
	<182553e4-a2e2-46f6-8c50-2de6f8effee7@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 20:19:32 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-02-20 20:20, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The "perf" clock in /sys/kernel/tracing/trace_clock enables local_clock(),
> > where on machines that have CONFIG_HAVE_UNSTABLE_SCHED_CLOCK set is a
> > normal function. This function can be traced.
> > 
> > I found that enabling the "perf" clock on some debug configs and running
> > function tracer can live lock the machine. That is, it goes so slow that
> > nothing moves forward.  
> 
> And I bet this is why the try_cmpxchg for reservation was
> looping endlessly. ;)
>

Yes. Debugging that was how I found it ;-) sort of.

I went back to another machine which triggered the cmpxchg issue as well,
but when removing that code and going back to the old code, it then locked
up completely. That was because the other config had more debugging enabled.
That debugging lead to finding this.

I'm now going back to see if I can trigger that again with this update.

-- Steve

