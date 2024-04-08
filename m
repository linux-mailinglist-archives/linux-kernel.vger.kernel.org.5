Return-Path: <linux-kernel+bounces-135882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD189CC97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DFDB21C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD09145B27;
	Mon,  8 Apr 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWxjxI3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84A1448D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605425; cv=none; b=U5DmZzzZv4LI+kWXbL4zZDNo0NgC1vmwWqeErjSLX4FZpfe1koBik92kWpf/LzWd6DBfDaLL8SW+CUPQbAGL8NI0j5qQREEh5PT/av4cGlXgwxkwjwyURr7XTB5FjBBlm+K7SrmXKYrKdyM13aYD0NCDnSl9762mbUpYQLyC0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605425; c=relaxed/simple;
	bh=BkSTcCa7P95+0xNGk9pfPNydAixF7fgFE/gIk/vA5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P12nBgC6v9MNSxL0ShE1hbRLeh4c6GT2sjIRzRuJnY9iLzolnivgB0IpwJWNv0z6Hs5xupsnrux9eiuzfn+T1ySxbyHxDaiem2dvq3WKNNhzNjiYWKlqKjFa8dCfLBKu9yJWl+xzQr6k8DnKG4X+LT9gyUkHGQtF2K25ljrvH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWxjxI3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4ABC433C7;
	Mon,  8 Apr 2024 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712605424;
	bh=BkSTcCa7P95+0xNGk9pfPNydAixF7fgFE/gIk/vA5No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWxjxI3saf/KYjm7wbLcynNdlmqhP9L76BhQNVUs2UkIu7nX7TdTl4Hh/LHPCkybJ
	 9qZ5a9MwGMqqkC8INOWrl4IuFpyW627NMvI2GDsTcZeTabSPHzIguKGlF5GeX8/ahJ
	 E7Yr+U0u3jfF1cV50+OjaBsaC4tqtfO50ANFmPuKndSm53gZ4LuRM3sHI5IxG4YFgQ
	 OgBXFiV4sEn1ZGqxYkqsrgzP0AQKJI7dB4sirbzeT+9iQr3caPuDvN8CDbEFe3IyiW
	 99TTaKAJX5qM9QE/Lb52zS8lqKL0cKKxKKWNNuE99f7uThk8dpjicVy6jwchk7e+uW
	 I5GG7TEdSkcJQ==
Date: Mon, 8 Apr 2024 21:43:41 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] perf: Fix leaked events when sigtrap = 1
Message-ID: <ZhRI7WfjgkCTK9aK@pavilion.home>
References: <20240329235812.18917-1-frederic@kernel.org>
 <CAP-5=fVwT1FPTps=i=hG2O0sWr9DH92VSt66Co=Rhf9dyZX7ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVwT1FPTps=i=hG2O0sWr9DH92VSt66Co=Rhf9dyZX7ag@mail.gmail.com>

Le Fri, Mar 29, 2024 at 08:23:49PM -0700, Ian Rogers a écrit :
> On Fri, Mar 29, 2024 at 4:58 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > While looking at task_work users I just noticed that perf doesn't flush
> > its own upon event exiting. This looks especially problematic with child
> > events. Please have a thourough look at the last patch, I may easily
> > have missed something within the maze.
> >
> > Frederic Weisbecker (4):
> >   task_work: s/task_work_cancel()/task_work_cancel_func()/
> >   task_work: Introduce task_work_cancel() again
> >   perf: Fix event leak upon exit
> >   perf: Fix event leak upon exec and file release
> >
> >  include/linux/perf_event.h |  1 +
> >  include/linux/task_work.h  |  3 ++-
> >  kernel/events/core.c       | 40 +++++++++++++++++++++++++++++++-------
> >  kernel/irq/manage.c        |  2 +-
> >  kernel/task_work.c         | 34 +++++++++++++++++++++++++++-----
> >  security/keys/keyctl.c     |  2 +-
> >  6 files changed, 67 insertions(+), 15 deletions(-)
> 
> Thanks for this! I wonder if this relates to fuzzing failures like:
> https://lore.kernel.org/linux-perf-users/CAP-5=fUa+-Tj2b_hxk96Qg5=Qu7jYHgHREbsmBa2ZmuF-X9QaA@mail.gmail.com/
> "[ 2519.138665] unexpected event refcount: 2; ptr=000000009c56b097"

Probably not since those seem to happen on perf_event_open() failures. This
looks different.

Thanks.


> 
> Thanks,
> Ian
> 
> > --
> > 2.44.0
> >

