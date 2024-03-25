Return-Path: <linux-kernel+bounces-117760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E260888AF31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BFA1C23D30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6085C83;
	Mon, 25 Mar 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Al4xSWlm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE494C6C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393328; cv=none; b=ZEWFL0TWfICO2+P8DbGaUupnh7PTKwMvAl7UWxBMc/aN0vltjAp9YW0oZghaeKvJ3EOKT1lHfUdO7c0nvi1X4p5yyHmEwfcQ+g0tinFfY7gfuhu+3PE2K9RmoCRmxV12UKMKRrWBvwSQ4L5SeDeww5sIa7ZlQtqJ02P21Sr25do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393328; c=relaxed/simple;
	bh=uSaHUaVkcR6NaZJgrhfLasMtn+6xcE+Tog5QLv90pLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvvoP05J1IhoLymzl6ZsYuSd/7QQJP3+A8G/mKlhgqx7tz4lXe5YwNHbi4bISoY0hTUWmuYlrfKddjRF/5/6/idP/OK+QVe64Z5Z6+qXtX2UHq6iJJGe8Nz1gYLNhYDGo1iwi800Rlw5jyFYxjaFRC9Zk0RHToeNGQZ2tjJvESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Al4xSWlm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711393325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYPO24K28JXgRV/rJkMvZAjaOK5QN2Q6jV8hhVu8B2Y=;
	b=Al4xSWlmGDliuBbpBT1hvD4dpYkiA3n375Kjv5hFnfTCPeDumPYolpnGURT5kHl3RAbBhz
	Sy3K9lc0DiOXE51H9WDj0+L6+QTXzAKeWgxSGXEfLbdJVnKN6pIM44OYOntA+HULOtrBsX
	4gAsR49OWz2vAFXmICX+FDnCX6daRLs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-6jXdsGT1NFaIoUyQJB1cSA-1; Mon, 25 Mar 2024 15:02:03 -0400
X-MC-Unique: 6jXdsGT1NFaIoUyQJB1cSA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so7431282276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393323; x=1711998123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYPO24K28JXgRV/rJkMvZAjaOK5QN2Q6jV8hhVu8B2Y=;
        b=OzV6uGNFQ7LAGbBP8jMHJJQ2rr09GEVn38kgUi5iYvqwaTWdS/anqBK105MVrhshGN
         lmhlY7st36yJzYMBmp8nlwT1vYJ5PADMuqwh79jcQ+KPpLDDH9aX1wmhE4Kiw1Vrwwmd
         nWzfv3fz/u3KASNjndDJhxgBmhsSUqbA9sOMeGla5Fc3tr4loCsb1NMd5cgvYLX1IiKM
         EVlc8VIF582lSgm63pBEehEF88oXIQNdlMjRZHudQfL9owv3TVQIRnN02ruljxXpRGgF
         Gc2N4xVpYK24vTySevtWeV1v7zGFLVPtG9XBJO9xIzVh6qG/gXjVlEd9LNcKV+5VA37U
         tZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7QC1W2nBOk+NiLzCT6Ne4b+gEkL9wgqbPHaMji2kL/JYg6I9mCeAYBaNAXkgxWL4pkEQ8pBP8TtjyADGm9mr4QjzcMRSyLLaHXdMe
X-Gm-Message-State: AOJu0YzHRc4v0FRc6vSPO0vCqtfqN/8Akyp1pjqsqKHxZwLbdSkPEa8J
	7b9I2cyC7Oy4oAUT93tdovGIZmWxT48Z3PYR8gYdjmUzhJpeV50Nv9QEG+prVaNLcjhE2XNTEfl
	sVTXxfFFLcpTCTtOvp5XilHxxpGOhelvoSHqQEQREYnWMKaTvhw61b9hpL91qgn66eOjk7WADJJ
	7mN4Ebyh+09qLDtjrPEjsybdjw0YIYzUPKl2Hj
X-Received: by 2002:a25:df06:0:b0:dcc:1c6c:430d with SMTP id w6-20020a25df06000000b00dcc1c6c430dmr5876011ybg.12.1711393323124;
        Mon, 25 Mar 2024 12:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwOUhnPn4CrHxB6F0jp8LH2BWZdgH1El3pKVdnjmorCiQCvIHub32NKbKpr4Br6xHB/xiz8s4JD1bfk4SbI0U=
X-Received: by 2002:a25:df06:0:b0:dcc:1c6c:430d with SMTP id
 w6-20020a25df06000000b00dcc1c6c430dmr5875980ybg.12.1711393322823; Mon, 25 Mar
 2024 12:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322021244.1056223-1-ming.lei@redhat.com>
In-Reply-To: <20240322021244.1056223-1-ming.lei@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Mon, 25 Mar 2024 15:01:51 -0400
Message-ID: <CAGtn9rkwd1aw=Nept2kLTsMR+mGAbCKvzM1ELieNpT4sPN4zyw@mail.gmail.com>
Subject: Re: [PATCH V5] blk-mq: don't schedule block kworker on isolated CPUs
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Andrew Theurer <atheurer@redhat.com>, 
	Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:13=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Kernel parameter of `isolcpus=3D` or 'nohz_full=3D' are used to isolate C=
PUs
> for specific task, and it isn't expected to let block IO disturb these CP=
Us.
> blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> CPUs is run for blk-mq kworker, long block IO latency can be caused.
>
> Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> WQ, the responsibility is on user because CPU is specified as WQ API
> parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> and queue_work_on(cpu).
>
> So not run blk-mq kworker on isolated CPUs by removing isolated CPUs
> from hctx->cpumask. Meantime use queue map to check if all CPUs in this
> hw queue are offline instead of hctx->cpumask, this way can avoid any
> cost in fast IO code path, and is safe since hctx->cpumask are only
> used in the two cases.
>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Tejun Heo <tj@kernel.org>
> Tesed-by: Joe Mario <jmario@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V5:
>         - fix comment
>         - add one helper for document benefit
>         - all are suggested by Jens
> V4:
>         - improve comment & commit log as suggested by Tim
> V3:
>         - avoid to check invalid cpu as reported by Bart
>         - take current cpu(to be offline, not done yet) into account
>         - simplify blk_mq_hctx_has_online_cpu()
>
> V2:
>         - remove module parameter, meantime use queue map to check if
>         all cpus in one hctx are offline
>
>
>  block/blk-mq.c | 57 +++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 555ada922cf0..06cd9c8068fc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -28,6 +28,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
>
>  #include <trace/events/block.h>
>
> @@ -2168,6 +2169,15 @@ static inline int blk_mq_first_mapped_cpu(struct b=
lk_mq_hw_ctx *hctx)
>         return cpu;
>  }
>
> +/*
> + * ->next_cpu is always calculated from hctx->cpumask, so simply use
> + * it for speeding up the check
> + */
> +static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
> +{
> +        return hctx->next_cpu >=3D nr_cpu_ids;
> +}
> +
>  /*
>   * It'd be great if the workqueue API had a way to pass
>   * in a mask and had some smarts for more clever placement.
> @@ -2179,7 +2189,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ct=
x *hctx)
>         bool tried =3D false;
>         int next_cpu =3D hctx->next_cpu;
>
> -       if (hctx->queue->nr_hw_queues =3D=3D 1)
> +       /* Switch to unbound if no allowable CPUs in this hctx */
> +       if (hctx->queue->nr_hw_queues =3D=3D 1 || blk_mq_hctx_empty_cpuma=
sk(hctx))
>                 return WORK_CPU_UNBOUND;
>
>         if (--hctx->next_cpu_batch <=3D 0) {
> @@ -3488,14 +3499,30 @@ static bool blk_mq_hctx_has_requests(struct blk_m=
q_hw_ctx *hctx)
>         return data.has_rq;
>  }
>
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -               struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> +               unsigned int this_cpu)
>  {
> -       if (cpumask_first_and(hctx->cpumask, cpu_online_mask) !=3D cpu)
> -               return false;
> -       if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cp=
u_ids)
> -               return false;
> -       return true;
> +       enum hctx_type type =3D hctx->type;
> +       int cpu;
> +
> +       /*
> +        * hctx->cpumask has to rule out isolated CPUs, but userspace sti=
ll
> +        * might submit IOs on these isolated CPUs, so use the queue map =
to
> +        * check if all CPUs mapped to this hctx are offline
> +        */
> +       for_each_online_cpu(cpu) {
> +               struct blk_mq_hw_ctx *h =3D blk_mq_map_queue_type(hctx->q=
ueue,
> +                               type, cpu);
> +
> +               if (h !=3D hctx)
> +                       continue;
> +
> +               /* this hctx has at least one online CPU */
> +               if (this_cpu !=3D cpu)
> +                       return true;
> +       }
> +
> +       return false;
>  }
>
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_nod=
e *node)
> @@ -3503,8 +3530,7 @@ static int blk_mq_hctx_notify_offline(unsigned int =
cpu, struct hlist_node *node)
>         struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
>                         struct blk_mq_hw_ctx, cpuhp_online);
>
> -       if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> -           !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +       if (blk_mq_hctx_has_online_cpu(hctx, cpu))
>                 return 0;
>
>         /*
> @@ -3912,6 +3938,8 @@ static void blk_mq_map_swqueue(struct request_queue=
 *q)
>         }
>
>         queue_for_each_hw_ctx(q, hctx, i) {
> +               int cpu;
> +
>                 /*
>                  * If no software queues are mapped to this hardware queu=
e,
>                  * disable it and free the request entries.
> @@ -3938,6 +3966,15 @@ static void blk_mq_map_swqueue(struct request_queu=
e *q)
>                  */
>                 sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
>
> +               /*
> +                * Rule out isolated CPUs from hctx->cpumask to avoid
> +                * running block kworker on isolated CPUs
> +                */
> +               for_each_cpu(cpu, hctx->cpumask) {
> +                       if (cpu_is_isolated(cpu))
> +                               cpumask_clear_cpu(cpu, hctx->cpumask);
> +               }
> +
>                 /*
>                  * Initialize batch roundrobin counts
>                  */
> --
> 2.41.0
>
>

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


