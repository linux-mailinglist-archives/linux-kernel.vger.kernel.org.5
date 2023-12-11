Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521980DE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjLKWWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKWWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:22:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6660AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702333329; x=1733869329;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NjBAJdZtEPzflWo/C+hNJjt8+fIgGubvNDTl9Bjsb0Q=;
  b=mJEkrtfKYdBNRoapSXZoRdKnnzArl0FsaMAKiAqmxFLZkls+kK0AyfXF
   kSOCZe3ywcvmWr0sRNRY6LZy4qq4Gv5RpjZunbJrBi8m0ZY3ZJsP7/l9k
   ouiWhanRcM/2iN9YU7owb8Lm+qfV8vjHg0h2Gwaldz/75fyBGPU4WVrhu
   LrS9sGX9YhtfZUkyPUhsn6//Y5Jp/c8zv66WG4yxWPyZ9wOEaE2igjrVA
   n7vig1QMatbzvIaf7TdUkpSQafQ62dgRsHarMs5u3WtLQ+DVCkpOFhgjw
   du0o54tQBU1sRQB3qm6+C8iFz3Xt+GhnUnLfIcdUyJCFh3BdQFO6DFIWz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8080299"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8080299"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104646933"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104646933"
Received: from jjschmit-mobl1.amr.corp.intel.com (HELO [10.209.8.245]) ([10.209.8.245])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:22:08 -0800
Message-ID: <471d24f71cc531448572e2fc5964f1231e7ef7b3.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     WangJinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     stone.xulei@xfusion.com
Date:   Mon, 11 Dec 2023 14:22:07 -0800
In-Reply-To: <202312101719+0800-wangjinchao@xfusion.com>
References: <202312101719+0800-wangjinchao@xfusion.com>
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

On Sun, 2023-12-10 at 17:21 +0800, WangJinchao wrote:
> 1. The code below is duplicated in two for loops and need to be
>    consolidated
> 2. Fix the bug where a se's on_rq is true but its parent is not

In the current code, If a se is already on a rq, all the parents would have=
 already been
on rq too.  I don't think there's a case where se's on_rq and parent
is not for the current code before your patch.  Otherwise the child
would never get scheduled. I don't think we have seen such bug being
reported.

>=20
> ```c
> 		cfs_rq->h_nr_running++;
> 		cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
>=20
> 		if (cfs_rq_is_idle(cfs_rq))
> 			idle_h_nr_running =3D 1;
>=20
> 		/* end evaluation on encountering a throttled cfs_rq */
> 		if (cfs_rq_throttled(cfs_rq))
> 			goto enqueue_throttle;
> ```
>=20
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>  kernel/sched/fair.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..e1373bfd4f2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6681,30 +6681,15 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> =20
>  	for_each_sched_entity(se) {
> -		if (se->on_rq)
> -			break;
>  		cfs_rq =3D cfs_rq_of(se);
> -		enqueue_entity(cfs_rq, se, flags);
> -
> -		cfs_rq->h_nr_running++;
> -		cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
> -
> -		if (cfs_rq_is_idle(cfs_rq))
> -			idle_h_nr_running =3D 1;
> -
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
> -
> -		flags =3D ENQUEUE_WAKEUP;
> -	}
> -
> -	for_each_sched_entity(se) {
> -		cfs_rq =3D cfs_rq_of(se);
> -
> -		update_load_avg(cfs_rq, se, UPDATE_TG);
> -		se_update_runnable(se);
> -		update_cfs_group(se);
> +		if (se->on_rq) {
> +			update_load_avg(cfs_rq, se, UPDATE_TG);
> +			se_update_runnable(se);
> +			update_cfs_group(se);
> +		} else {
> +			enqueue_entity(cfs_rq, se, flags);
> +			flags =3D ENQUEUE_WAKEUP;
> +		}

The code change looks like a reasonable simplification.  Logic
is the same as the old code, assuming that once a se's on_rq flag
is true, all its parents are too.

Thanks.

Tim

> =20
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;

