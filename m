Return-Path: <linux-kernel+bounces-138692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B399C89F919
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F512289931
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757616D309;
	Wed, 10 Apr 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ5HWuEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B515CD4B;
	Wed, 10 Apr 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757523; cv=none; b=iHzf78Ktbcna9XapkbAOkKhn/Hvn2XwhaTVnNveIik6+v0J1USCCVSMT0F7/iMIfwxTaODAI7ULFdxprr+UTTWAtFiVqpKqMOwLm5WbspTlYvYRHVCbV4cWPig0p9tt+g5dBfXG8P3nmfb6UKpCRNn1qM+hhWXq27AsMEI/KC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757523; c=relaxed/simple;
	bh=CteGrLp21p90H//plZVTRArhoHufEhyzcxklfO2rDtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXHIB+QwN+ccjjin5PE3+WJ2s9piNYsXYMyUJyzAc0wOHUIYjdQ7BZG0lUcRV233gZ1sz336NkV7HMOqgZCajZCH9qRKfkOnJ0znznr8hOO/0Gv3nBI9IWIo9FQqdNgK9pmUqDLM9n0TM0M66zWRd6ld95e19+XEfJvJWdTeGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ5HWuEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF5C433F1;
	Wed, 10 Apr 2024 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757523;
	bh=CteGrLp21p90H//plZVTRArhoHufEhyzcxklfO2rDtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ5HWuEviNHm1qAE+YQNb3OQsWEmGjHsMyckLuumeCpTAF5uQiCn/i7I85js2B5S4
	 KCSnBcl0DscAqrV2hvDLsXgE4+x9UfNnYH0QCU1G2dBDTdlwMDXbPRWphK1rk31m6W
	 DPDNMOOjVuKynkZh4cimbDorssZ86nAhRUkolMbHmgeni28RBLS4pKCmuklVqwlIOv
	 N7217bKyaDQfrhLSL6HweYfz7M6c4U0coXLvc68iuTuGq15hIdr86v3UaCYgZgarS9
	 usd7jU2TuBt4Tqr6O+gF/F5Q5FT819Fs61KxgShir0g2PC3zFnt5HQopQVQMucXSKV
	 AeZdEqe6YyWpA==
Date: Wed, 10 Apr 2024 15:58:40 +0200
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
Subject: Re: [PATCH v3 3/4] perf: Remove perf_swevent_get_recursion_context()
 from perf_pending_task().
Message-ID: <ZhabEORWtSsdSq9x@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
 <20240409105405.TXUU--_W@linutronix.de>
 <ZhUt8XMndGSwNuwx@localhost.localdomain>
 <20240409133336.Y4Io-16-@linutronix.de>
 <ZhZsOvM3uTP6nTnZ@localhost.localdomain>
 <20240410125126.X26tR8tM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410125126.X26tR8tM@linutronix.de>

Le Wed, Apr 10, 2024 at 02:51:26PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-10 12:38:50 [+0200], Frederic Weisbecker wrote:
> > Some alternatives:
> > 
> > _ Clear event->pending_work = 0 after perf_sigtrap(), preventing an
> > event in there from adding a new task work. We may miss a signal though...
> > 
> > _ Make the recursion context per task on -RT...
> 
> The per-task counter would be indeed the easiest thing to do. But then
> only for task context, right?

It should work for CPU context as well. A context switch shouldn't be
considered as recursion. Hopefully...

> 
> But why would we miss a signal if we clean event->pending_work late?
> Isn't cleaning late same as clearing in
> perf_swevent_put_recursion_context()?

Not exactly. perf_swevent_get_recursion_context() avoids a new software event
altogether from being recorded. It is completely ignored. Whereas clearing late
event->pending_work records new software events but ignores the signal.

> If clearing pending_work late works, I would prefer to avoid yet another
> per-task counter if possible.

Yeah I know :-/

Thanks.

> 
> > > > Thanks.
> 
> Sebastian

