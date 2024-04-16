Return-Path: <linux-kernel+bounces-146383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCBE8A6496
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FB28367D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4F7602B;
	Tue, 16 Apr 2024 07:13:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155D39863
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251587; cv=none; b=htveLRT71ic41OezoGJU5zSsEB11rO6BRNxU4myTYJRoHdsLORAU8klDkL0F7gUO23jqA5p+fR01cWK+4KlWRlb40AsmyvqSDmVP1QmtUCBGpbP+jxTg50rG+0s30wm2RZuTBKcmu/ivqUvBmTP9Ak90FgRir6S3bBVVrquBwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251587; c=relaxed/simple;
	bh=wdBCqomTv0Itl5wccY1fTUKRkBSjyLIkCcSkicbtDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A9hlPv1K5f3t0QMqACbN6hmghu3x3coIeY7qBqqZg1ACA9dBK2aggahYvQ+YS/p8E1efpUd++K1Pt0ebNfljwbVStiCtep5DjdUqfWEsPM63Y57OBZ3uswQSa/i77WUAt9Hb7JEBeaJzQkcWTWvtqJVblFaH6rh0KZPBmbYlyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJZwm5Phnz1GGjC;
	Tue, 16 Apr 2024 15:12:08 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B0561A016F;
	Tue, 16 Apr 2024 15:13:01 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 15:13:00 +0800
Message-ID: <de5ca0cf-e868-a415-83e7-19d5cdf2aaad@huawei.com>
Date: Tue, 16 Apr 2024 15:13:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched: Improve the accuracy of sched_stat_wait statistics
 for rt and dl
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <qianjun.kernel@gmail.com>,
	<laoar.shao@gmail.com>
References: <20240322081521.2687856-1-zhangqiao22@huawei.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240322081521.2687856-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500001.china.huawei.com (7.192.104.163)

ping.

在 2024/3/22 16:15, Zhang Qiao 写道:
> Where commit b9c88f752268 ("sched/fair: Improve the accuracy of
> sched_stat_wait statistics") fixed a wrong scenairio for cfs schedstat.
> 
> This wrong scenario is also present for the RT task. For avoiding this
> scenario, add wait_start check in __update_stats_wait_end();
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/fair.c  |  9 ---------
>  kernel/sched/stats.c | 11 ++++++++++-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..36c81fe0086b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1208,15 +1208,6 @@ update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  
>  	stats = __schedstats_from_se(se);
>  
> -	/*
> -	 * When the sched_schedstat changes from 0 to 1, some sched se
> -	 * maybe already in the runqueue, the se->statistics.wait_start
> -	 * will be 0.So it will let the delta wrong. We need to avoid this
> -	 * scenario.
> -	 */
> -	if (unlikely(!schedstat_val(stats->wait_start)))
> -		return;
> -
>  	if (entity_is_task(se))
>  		p = task_of(se);
>  
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 857f837f52cb..7077eb490c09 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -20,8 +20,17 @@ void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
>  void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
>  			     struct sched_statistics *stats)
>  {
> -	u64 delta = rq_clock(rq) - schedstat_val(stats->wait_start);
> +	u64 delta;
>  
> +	/*
> +	 * When the sched_schedstat changes from 0 to 1, some sched se
> +	 * maybe already in the runqueue, the stats->wait_start will be 0.
> +	 * So it will let the delta wrong. We need to avoid this scenario.
> +	 */
> +	if (unlikely(!schedstat_val(stats->wait_start)))
> +		return;
> +
> +	delta = rq_clock(rq) - schedstat_val(stats->wait_start);
>  	if (p) {
>  		if (task_on_rq_migrating(p)) {
>  			/*
> 

