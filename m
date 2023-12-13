Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89029812390
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjLMXuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjLMXtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:49:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE611706;
        Wed, 13 Dec 2023 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702510922; x=1734046922;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+5iDCU7DbwktxKyDlESN+UlNCEP1MxDBSSpuUEvbSJE=;
  b=Km7I83VX4Tl6H+YnYyF0w2+VDM/zrv2EME6UuGe4GCsJGZNPutYfa2RX
   4QvQ7xAogrJDnXXX7OeOuTVivO8fGkgoavS0zqyCbyIJlLlE/jkwdCSxl
   jWUdZkLgUGGNw38Brl/WLln9e52o9C/979CtR/wKpr2df/pBJ3Vv/sz22
   vFtMKhLbZDXOznhvFk+07ZZAbHsUzwOixV1Y602Qj57R+fcCEic5/lj4L
   hO+/BGP9LEVt903ALjol9VD98YgRx00hSrh0xCu8xdT+rRtyLLfIdfBhf
   CbCkxjqK0vmxw/9PjwvuVQzFKoxUnbZe/9W6CB9CXEA22WfKCeUIC8Abc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="374547880"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="374547880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="17696317"
Received: from wanghuan-mobl1.amr.corp.intel.com (HELO [10.212.178.119]) ([10.212.178.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:42:02 -0800
Message-ID: <168860292b4594121b8fde42c01fefc27be19f55.camel@linux.intel.com>
Subject: Re: [PATCH V3] blk-mq: don't schedule block kworker on isolated CPUs
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Wed, 13 Dec 2023 15:42:00 -0800
In-Reply-To: <20231025025737.358756-1-ming.lei@redhat.com>
References: <20231025025737.358756-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 10:57 +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=3D` or 'nohz_full=3D' are used for isolatin=
g CPUs
> for specific task, and user often won't want block IO to disturb these CP=
Us,
Suggest breaking up this long sentence to make reading easier.

for specific tasks.  Users do not want block I/O operations to disturb thes=
e CPUS,
> also long IO latency may be caused if blk-mq kworker is scheduled on thes=
e

as long I/O latency could delay intended tasks if blk-mq kworker is schedul=
ed on these=20

> isolated CPUs.
>=20
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
>=20
> So don't not run block kworker on isolated CPUs by ruling out isolated CP=
Us
So don't run block kworker on isolated CPUs by removing isolated CPUs

> from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> all CPUs in this hw queue are offline, this way can avoid any cost in fas=
t
> IO code path.
>=20
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>=20
> V3:
> 	- avoid to check invalid cpu as reported by Bart
> 	- take current cpu(to be offline, not done yet) into account
> 	- simplify blk_mq_hctx_has_online_cpu()
>=20
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline
>=20
>  block/blk-mq.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..4556978ce71b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
> =20
>  #include <trace/events/block.h>
> =20
> @@ -2158,7 +2159,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_c=
tx *hctx)
>  	bool tried =3D false;
>  	int next_cpu =3D hctx->next_cpu;
> =20
> -	if (hctx->queue->nr_hw_queues =3D=3D 1)
> +	/*
> +	 * In case of single queue or no allowed CPU for scheduling
> +	 * worker, don't bound our worker with any CPU
> +	 */
> +	if (hctx->queue->nr_hw_queues =3D=3D 1 || next_cpu >=3D nr_cpu_ids)
>  		return WORK_CPU_UNBOUND;
> =20
>  	if (--hctx->next_cpu_batch <=3D 0) {
> @@ -3459,14 +3464,30 @@ static bool blk_mq_hctx_has_requests(struct blk_m=
q_hw_ctx *hctx)
>  	return data.has_rq;
>  }
> =20
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -		struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> +		unsigned int this_cpu)
>  {
> -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) !=3D cpu)
> -		return false;
> -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> -		return false;
> -	return true;
> +	enum hctx_type type =3D hctx->type;
> +	int cpu;
> +
> +	/*
> +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
> +	 * might submit IOs on these isolated CPUs, so use queue map to
> +	 * check if all CPUs mapped to this hctx are offline
> +	 */
> +	for_each_online_cpu(cpu) {
> +		struct blk_mq_hw_ctx *h =3D blk_mq_map_queue_type(hctx->queue,
> +				type, cpu);
> +
> +		if (h !=3D hctx)
> +			continue;
> +
> +		/* this current CPU isn't put offline yet */
> +		if (this_cpu !=3D cpu)
> +			return true;
> +	}
> +
> +	return false;
>  }
> =20
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_nod=
e *node)
> @@ -3474,8 +3495,7 @@ static int blk_mq_hctx_notify_offline(unsigned int =
cpu, struct hlist_node *node)
>  	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
>  			struct blk_mq_hw_ctx, cpuhp_online);
> =20
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> -	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
>  		return 0;
> =20
>  	/*
> @@ -3883,6 +3903,8 @@ static void blk_mq_map_swqueue(struct request_queue=
 *q)
>  	}
> =20
>  	queue_for_each_hw_ctx(q, hctx, i) {
> +		int cpu;
> +
>  		/*
>  		 * If no software queues are mapped to this hardware queue,
>  		 * disable it and free the request entries.
> @@ -3909,6 +3931,15 @@ static void blk_mq_map_swqueue(struct request_queu=
e *q)
>  		 */
>  		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
> =20
> +		/*
> +		 * rule out isolated CPUs from hctx->cpumask for avoiding to

s/for avoiding to run/to avoid running/

> +		 * run wq worker on isolated CPU
> +		 */
> +		for_each_cpu(cpu, hctx->cpumask) {
> +			if (cpu_is_isolated(cpu))
> +				cpumask_clear_cpu(cpu, hctx->cpumask);
> +		}
> +
>  		/*
>  		 * Initialize batch roundrobin counts
>  		 */

Thanks.

Tim
