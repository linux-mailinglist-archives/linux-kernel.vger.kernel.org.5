Return-Path: <linux-kernel+bounces-110839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73B886494
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB01284829
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8210FA;
	Fri, 22 Mar 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMyvcjck"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2C376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711069885; cv=none; b=ZcLUe9QrliG9FnljoRy61G4mBYyZtuPny2oVAn0eOXCgZfqxg8zGcDbCXATaVp+DgNHAaTcd1P1M1Sjr5fqRDvY3nbDK9OkQFwXM8OSOJuupmi3fZlLmiefLxKIeyht8yU2pEz2oIS5cqVP7e7i+IsbKFA9HpM+OQMnawtqDQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711069885; c=relaxed/simple;
	bh=96SAwPUUiUG9ICvo3SfW48QSZaBuN3QaPXtcsiTzUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuWzwVieo1TbR/PaoGeV8OevskloEtseFy1hWi8LXFxl+EnArj4jczXHbAsaeo3w9hlXEL7IFid7nUkegd4rT+8K0S23luzeTt6Ybd3P15+udOiulKVh7f63pfrnF5dNcoAQLRUZoM1VFSZW7WuUN9npsDRgT7j8wI5JHHNpA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMyvcjck; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711069882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4jtIXZkeEsKNNOM9A/oT110PaXa8dHoTnPtjKKPkd0=;
	b=WMyvcjckZsqDNYiZ7W72SJEP6RRKT6UWm9oQ9lQIHVIvh2jfuglscIc9EpF1amIiRVKdhf
	zz+ZsVgXXmZffkv+ZsPh0vhc6S3LI+InL06yXSPCRuLYepV83KUzi3DyYFT+zwHZAnv5ZG
	0BWC5+2RqdTtl1mrX8QfYpDN7ueeqGE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-20ayKDrdPue-iedqHk-R1w-1; Thu, 21 Mar 2024 21:11:18 -0400
X-MC-Unique: 20ayKDrdPue-iedqHk-R1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19A1685A58C;
	Fri, 22 Mar 2024 01:11:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D123C20;
	Fri, 22 Mar 2024 01:11:11 +0000 (UTC)
Date: Fri, 22 Mar 2024 09:10:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Andrew Theurer <atheurer@redhat.com>, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
	ming.lei@redhat.com
Subject: Re: [PATCH V4] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <Zfzal65zM3u+1qXc@fedora>
References: <20240320023446.882006-1-ming.lei@redhat.com>
 <05c44354-1c48-409e-827f-910d1e3c2db9@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c44354-1c48-409e-827f-910d1e3c2db9@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Mar 21, 2024 at 11:07:52AM -0600, Jens Axboe wrote:
> On 3/19/24 8:34 PM, Ming Lei wrote:
> > Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
> > for specific task, and it isn't expected to let block IO disturb these CPUs.
> > blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> > CPUs is run for blk-mq kworker, long block IO latency can be caused.
> > 
> > Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> > WQ, the responsibility is on user because CPU is specified as WQ API
> > parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> > and queue_work_on(cpu).
> > 
> > So not run blk-mq kworker on isolated CPUs by removing isolated CPUs
> > from hctx->cpumask. Meantime use queue map to check if all CPUs in this
> > hw queue are offline instead of hctx->cpumask, this way can avoid any
> > cost in fast IO code path, and is safe since hctx->cpumask are only
> > used in the two cases.
> 
> In general, I think the fix is fine. Only thing that's a bit odd is:

Thanks for the review!

> 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 555ada922cf0..187fbfacb397 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/prefetch.h>
> >  #include <linux/blk-crypto.h>
> >  #include <linux/part_stat.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include <trace/events/block.h>
> >  
> > @@ -2179,7 +2180,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  	bool tried = false;
> >  	int next_cpu = hctx->next_cpu;
> >  
> > -	if (hctx->queue->nr_hw_queues == 1)
> > +	/*
> > +	 * Switch to unbound work if all CPUs in this hw queue fall
> > +	 * into isolated CPUs
> > +	 */
> > +	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
> >  		return WORK_CPU_UNBOUND;
> 
> This relies on find_next_foo() returning >= nr_cpu_ids if the set is
> empty, which is a lower level implementation detail that someone reading
> this code may not know.

Indeed, looks it is more readable to add one helper:

static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
{
	return hctx->next_cpu >= nr_cpu_ids;
}

> 
> >  	if (--hctx->next_cpu_batch <= 0) {
> > @@ -3488,14 +3493,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> >  	return data.has_rq;
> >  }
> >  
> > -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> > -		struct blk_mq_hw_ctx *hctx)
> > +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> > +		unsigned int this_cpu)
> >  {
> > -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> > -		return false;
> > -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> > -		return false;
> > -	return true;
> > +	enum hctx_type type = hctx->type;
> > +	int cpu;
> > +
> > +	/*
> > +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
>                             ^^
> 
> has to
> 
> > +	 * might submit IOs on these isolated CPUs, so use queue map to
> 							  ^^
> 
> use the queue map

OK, will fix them in V5.


thanks,
Ming


