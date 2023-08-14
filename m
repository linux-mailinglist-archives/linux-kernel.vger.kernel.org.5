Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53077B482
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjHNIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjHNIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:44:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F291739
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:43:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPSX33x3Lz2BdG3;
        Mon, 14 Aug 2023 16:40:19 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 16:43:14 +0800
Subject: Re: [PATCH 3/4] sched: fix sched_numa_find_nth_cpu() in CPU-less case
To:     Yury Norov <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guenter Roeck <linux@roeck-us.net>
References: <20230810162442.9863-1-yury.norov@gmail.com>
 <20230810162442.9863-4-yury.norov@gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <7c24e857-fe86-4c2a-68bc-58152bac1f39@huawei.com>
Date:   Mon, 14 Aug 2023 16:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230810162442.9863-4-yury.norov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On 2023/8/11 0:24, Yury Norov wrote:
> When the node provided by user is CPU-less, corresponding record in
> sched_domains_numa_masks is not set. Trying to dereference it in the
> following code leads to kernel crash.
> 
> To avoid it, start searching from the nearest node with CPUs.
> 
> Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
> Reported-by: Yicong Yang <yangyicong@hisilicon.com>
> Closes: https://lore.kernel.org/lkml/CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com/T/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/ZMHSNQfv39HN068m@yury-ThinkPad/T/#mf6431cb0b7f6f05193c41adeee444bc95bf2b1c4
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
> 
> This has been discovered and fixed by Yicong Yang:
> 
> https://lore.kernel.org/lkml/CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com/T/
> 
> When discovering Guenter's failure report for sparc64, I found it's due to
> the same problem. And while fixing, I found an opportunity to generalize
> nearest NUMA node search and avoid code duplication.
> 
> Yicong, if you like this approach, please feel free to add your co-developed-by
> or any appropriate tags.
> 

Looks fine to me. One nit below.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

>  kernel/sched/topology.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..66b387172b6f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2113,10 +2113,14 @@ static int hop_cmp(const void *a, const void *b)
>   */
>  int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  {
> -	struct __cmp_key k = { .cpus = cpus, .node = node, .cpu = cpu };
> +	struct __cmp_key k = { .cpus = cpus, .cpu = cpu };
>  	struct cpumask ***hop_masks;
>  	int hop, ret = nr_cpu_ids;
>  
> +	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
> +	node = numa_nearest_node(node, N_CPU);
> +	k.node = node;
> +

We may also have problem if node == NUMA_NO_NODE, is it better to mention this
in the function comment or check it before we going on? Currently this function
is only used in cpumask_local_spread() and the caller has already checked it, but
considering this is an export function so somebody may use it directly.

I wondering whether we should put this block within the protection of rcu_read_lock()
for some issues like hotplug or not. Is it possible if @node become CPU-less subsequently?

>  	rcu_read_lock();
>  
>  	k.masks = rcu_dereference(sched_domains_numa_masks);
> 
