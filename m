Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269117518DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjGMGfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGMGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:35:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B21BEB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:35:20 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1lFs6sB4zrRlj;
        Thu, 13 Jul 2023 14:34:41 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 14:35:18 +0800
CC:     <yangyicong@hisilicon.com>, Ricardo Neri <ricardo.neri@intel.com>,
        Tim Chen <tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/topology: Align group flags when removing
 degenerate domain
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230713013133.2314153-1-yu.c.chen@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9a9cdf48-816f-56aa-6e0f-1d89d5c5cbd2@huawei.com>
Date:   Thu, 13 Jul 2023 14:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230713013133.2314153-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 9:31, Chen Yu wrote:
> The flags of the child of a given scheduling domain are used to initialize
> the flags of its scheduling groups. When the child of a scheduling domain
> is degenerated, the flags of its local scheduling group need to be updated
> to align with the flags of its new child domain.
> 
> The flag SD_SHARE_CPUCAPACITY was aligned in
> Commit bf2dc42d6beb ("sched/topology: Propagate SMT flags when removing degenerate domain").
> Further generalize this alignment so other flags can be used later, such as
> in cluster-based task wakeup. [1]

Currently I only update the cluster flags on my current testing branch. It'll be even better to
align all flags for possible usage. Will rebase on this one.

> 
> Link: https://lore.kernel.org/lkml/20230530115527.GC156198@hirez.programming.kicks-ass.net #1
> Suggested-by: Ricardo Neri <ricardo.neri@intel.com>
> Reported-by: Yicong Yang <yangyicong@huawei.com>
> Closes: https://lore.kernel.org/lkml/ce714341-af58-2522-69a8-321f02c82893@huawei.com/
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  kernel/sched/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..ff02d7deec0c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -722,8 +722,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  
>  			if (parent->parent) {
>  				parent->parent->child = tmp;
> -				if (tmp->flags & SD_SHARE_CPUCAPACITY)
> -					parent->parent->groups->flags |= SD_SHARE_CPUCAPACITY;
> +				parent->parent->groups->flags = tmp->flags;
>  			}
>  
>  			/*
> 
