Return-Path: <linux-kernel+bounces-138420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2989F0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309ED1C20A28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581A15990D;
	Wed, 10 Apr 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYrihpXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FA15921E;
	Wed, 10 Apr 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749028; cv=none; b=RF9x8FCztB8H5rlqn+vpS8QLihdAQB1BbFYA4wkr+sUbLWENN54MVVOIBMiPac772LOgikugvDhMVhVKIjSy/prgS5shILXqlXpZYzUCfN1rJKhhJeiU/ROBpZVsnC4JSixalN1B558kkVyamEbLuJ9yM/qFq2uCeTPnJQpJUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749028; c=relaxed/simple;
	bh=cjSpW4W9xjQq69YU3V2+lPGChaluI7MZVgYx3E/A/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBYiGCzeX/0jeoT3cYKwV6MW56ozmXyfEG8v0bJS3guMXiQLOnkRvHPk+Ivm/6PlwaeiEaYVKf5lQrN/OvJqzZKZyccysGQ/PqTQT0teKTjnb8ee3BXn6upt5vEzw8kUmLrd5vGv/Wtjz2swY+7s/IKeih+kcXD2RafMnMjgSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYrihpXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D7CC43390;
	Wed, 10 Apr 2024 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712749028;
	bh=cjSpW4W9xjQq69YU3V2+lPGChaluI7MZVgYx3E/A/lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYrihpXIYXARvO9uOKEEnf5N7FxT1MNZSGHpQqr9w3lDeH/UqwiDvfd7T7Y9AW8Zd
	 XZFtjQfniebrD2+godUcpvcctC6ik8EOiOuVhOuw9x1FH5bVQQ0GFYzEzsMqBp8a2X
	 g+I7zXnIPIRVshUoGryiqqUW0fC7TMZOzb79fbdBCEFaBd+HkgUmH1Dhf6NXyMWiyf
	 IUaC7PGQ4UJRvuUUtuH5Ufne7Y49nsqKZVqpQeNJy84l/bmDqVtk/SBNJH/mXJ9Jia
	 ArI2XSjXLe8NNtdXZln9kRBddRzyfpYgrWhnYFIJuBX21XBPWzYI4Kc+FtMpRaDOdW
	 jxsiD2X0hQy/w==
Date: Wed, 10 Apr 2024 13:37:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <ZhZ54XAcBt50WEnE@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409134729.JpcBYOsK@linutronix.de>

Le Tue, Apr 09, 2024 at 03:47:29PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-09 14:36:51 [+0200], Frederic Weisbecker wrote:
> > > That wake_up() within preempt_disable() section breaks on RT.
> > 
> > Ah, but the wake-up still wants to go inside recursion protection somehow or
> > it could generate task_work loop again due to tracepoint events...
> 
> okay.
> 
> > Although... the wake up occurs only when the event is dead after all...
> 
> corner case or not, it has to work, right?

Yep.

> 
> > > How do we go on from here?
> > 
> > I'd tend to think you need my patchset first because the problems it
> > fixes were not easily visible as long as there was an irq work to take
> > care of things most of the time. But once you rely on task_work only then
> > these become a real problem. Especially the sync against perf_release().
> 
> I don't mind rebasing on top of your series. But defaulting to task_work
> is not an option then?
> 
> RT wise the irq_work is not handled in hardirq because of locks it
> acquires and is handled instead in a thread. Depending on the priority
> the task (receiving the event) it may run before the irq_work-thread.
> Therefore the task_work looked neat because the event would be handled
> _before_ the task returned to userland.

I see.
 
> Couldn't we either flush _or_ remove the task_work in perf_release()?

Right so the problem in perf_release() is that we may be dealing with task works
of other tasks than current. In that case, task_work_cancel() is fine if it
successes. But if it fails, you don't have the guarantee that the task work
isn't concurrently running or about to run. And you have no way to know about
that. So then you need some sort of flushing indeed.

Thanks.

> > Thanks.
> Sebastian

