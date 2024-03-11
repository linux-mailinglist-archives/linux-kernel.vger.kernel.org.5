Return-Path: <linux-kernel+bounces-98800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73166877F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AFC1C221AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4183BBF7;
	Mon, 11 Mar 2024 12:07:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648B3B78E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158832; cv=none; b=pkhl1Lbz5k6DVRiDalzU7qsMuH3LsFaw+8LE0Q5Nm0gF3bcyESYwbsSfRF2aZGkx4DN31sV+fyLmx96WAHnr3YLsvR1zS4tTxRDzmjVaTJ9ujTuZFNkaS3bsTXR55tI1RCBc3CiLRmJOkq5pjEatmEKDejLATOAHhZdwhmdDMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158832; c=relaxed/simple;
	bh=B+m2Bjcxx1YSgN6LpD3F3IefXoQbz8pZeaCQuEGQC7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlYQwZ2S6UvDnvlXonAQ/msLmzAmmnp7ntymTdiZFOSnfklg7dKbUeI44lMZs2cDbd0kc2Di0iY/CHWE49vYposKasgPg2pIGFqVh4zVnakPQTdtkiYYW++qvdMbeWQfEOM7C0sqeR1v1yH60YON2M/6fJlh/bsgbBqIdK0eias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ttb7K0DgjzsXKF;
	Mon, 11 Mar 2024 20:05:01 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 808DA1400F4;
	Mon, 11 Mar 2024 20:07:05 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 11 Mar
 2024 20:07:03 +0800
Date: Mon, 11 Mar 2024 20:06:59 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: Changbin Du <changbin.du@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
	<linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: kmsan: fix instrumentation recursion on preempt_count
Message-ID: <20240311120659.2la4s5vwms5jebut@M910t>
References: <20240311112330.372158-1-changbin.du@huawei.com>
 <Ze7uJUynNXDjLmmn@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ze7uJUynNXDjLmmn@FVFF77S0Q05N>
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100011.china.huawei.com (7.221.188.204)

On Mon, Mar 11, 2024 at 11:42:29AM +0000, Mark Rutland wrote:
> On Mon, Mar 11, 2024 at 07:23:30PM +0800, Changbin Du wrote:
> > This disables msan check for preempt_count_{add,sub} to fix a
> > instrumentation recursion issue on preempt_count:
> > 
> >   __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() ->
> > 	preempt_disable() -> __msan_metadata_ptr_for_load_4()
> > 
> > With this fix, I was able to run kmsan kernel with:
> >   o CONFIG_DEBUG_KMEMLEAK=n
> >   o CONFIG_KFENCE=n
> >   o CONFIG_LOCKDEP=n
> > 
> > KMEMLEAK and KFENCE generate too many false positives in unwinding code.
> > LOCKDEP still introduces instrumenting recursions issue. But these are
> > other issues expected to be fixed.
> > 
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  kernel/sched/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9116bcc90346..5b63bb98e60a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
> >  	}
> >  }
> >  
> > -void preempt_count_add(int val)
> > +void __no_kmsan_checks preempt_count_add(int val)
> >  {
> >  #ifdef CONFIG_DEBUG_PREEMPT
> >  	/*
> > @@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
> >  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> >  }
> 
> What prevents a larger loop via one of the calles of preempt_count_{add,sub}()
> 
> For example, via preempt_latency_{start,stop}() ?
> 
> ... or via some *other* instrumentation that might be placed in those?
> 
> I suspect we should be using noinstr or __always_inline in a bunch of places to
> clean this up properly.
>
In my local build, these two are not that small for inlining. (I has preempt_off
tracer enabled).

$ readelf -s vmlinux | grep -sw -E 'preempt_count_add|preempt_count_sub'
157043: ffffffff81174de0   186 FUNC    GLOBAL DEFAULT    1 preempt_count_add
157045: ffffffff81174eb0   216 FUNC    GLOBAL DEFAULT    1 preempt_count_sub

The noinstr adds __no_sanitize_memory to the tagged functions so we might see
many false positives.

> Mark.

-- 
Cheers,
Changbin Du

