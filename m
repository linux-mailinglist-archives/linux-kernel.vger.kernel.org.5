Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741247A639C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjISMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjISMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:47:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27149E40;
        Tue, 19 Sep 2023 05:47:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RqhFq3kSyzrSxq;
        Tue, 19 Sep 2023 20:45:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 20:47:08 +0800
Subject: Re: [PATCH net-next v8 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-3-linyunsheng@huawei.com>
 <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
 <e7f2d1b1-49fe-cf8d-eb96-c5ddf52903a0@huawei.com>
Message-ID: <bf2591f8-7b3c-4480-bb2c-31dc9da1d6ac@huawei.com>
Date:   Tue, 19 Sep 2023 20:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e7f2d1b1-49fe-cf8d-eb96-c5ddf52903a0@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/18 19:15, Yunsheng Lin wrote:
> On 2023/9/14 23:17, Paolo Abeni wrote:
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -376,6 +376,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>>>  {
>>>  	page->pp = pool;
>>>  	page->pp_magic |= PP_SIGNATURE;
>>> +
>>> +	/* Ensuring all pages have been split into one big frag initially:
>>> +	 * page_pool_set_pp_info() is only called once for every page when it
>>> +	 * is allocated from the page allocator and page_pool_fragment_page()
>>> +	 * is dirtying the same cache line as the page->pp_magic above, so
>>> +	 * the overhead is negligible.
>>> +	 */
>>> +	page_pool_fragment_page(page, 1);
>>>  	if (pool->p.init_callback)
>>>  		pool->p.init_callback(page, pool->p.init_arg);
>>>  }
>>
>> I think it would be nice backing the above claim with some benchmarks.
>> (possibly even just a micro-benchmark around the relevant APIs)
>> and include such info into the changelog message.
> 
> Sure, will adjust Jesper's below micro-benchmark to test it:
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c
> 
> Please let me know if there is other better idea to do the
> micro-benchmark in your mind, thanks.

As I am testing in arm64, and Jesper's micro-benchmark is only
work on x86, so I adjust some functions in time_bench.h, mainly
use get_cycles() instead hard-coded asm in tsc_start_clock()/
tsc_stop_clock(), and return 0 in p_rdpmc()/pmc_clk().

using the below cmd:
taskset -c 0 insmod ./bench_page_pool_simple.ko

For tasklet_page_pool01_fast_path before this patchset:
3 cycles(tsc) 31.171 ns
3 cycles(tsc) 31.171 ns
3 cycles(tsc) 31.172 ns

For tasklet_page_pool01_fast_path after this patchset:
2 cycles(tsc) 27.496 ns
2 cycles(tsc) 27.484 ns
2 cycles(tsc) 27.514 ns

It seem above difference is within the standard deviation,
see more raw performance data in [1] & [2].

I also tested how much time it takes to use frag API to allocate
a whole page for tasklet_page_pool01_fast_path:
7 cycles(tsc) 71.179 ns
7 cycles(tsc) 75.987 ns
7 cycles(tsc) 75.795 ns

It seems make sense to unify frag_count handling so that the driver
can both use frag API and non-frag API with least memory utilization
and performance penalty if the driver doesn't know the size of memory
it need beforehand.

Please let me know if there is any other testing that needed.

1. raw performance data before this patchset

root@(none)$ taskset -c 0 insmod ./bench_page_pool_simple.ko
[   70.650364] bench_page_pool_simple: Loaded
[   70.692958] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038495410 sec time_interval:38495410) - (invoke count:100000000 tsc_interval:3849532)
[   71.287361] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577120890 sec time_interval:577120890) - (invoke count:100000000 tsc_interval:57712083)
[   71.451202] time_bench: Type:lock Per elem: 1 cycles(tsc) 14.621 ns (step:0) - (measurement period time:0.146210990 sec time_interval:146210990) - (invoke count:10000000 tsc_interval:14621094)
[   71.468329] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[   72.050743] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 57.310 ns (step:0) - (measurement period time:0.573106430 sec time_interval:573106430) - (invoke count:10000000 tsc_interval:57310638)
[   72.069422] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[   72.648953] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.031 ns (step:0) - (measurement period time:0.570316730 sec time_interval:570316730) - (invoke count:10000000 tsc_interval:57031667)
[   72.667630] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[   74.362804] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 168.631 ns (step:0) - (measurement period time:1.686315810 sec time_interval:1686315810) - (invoke count:10000000 tsc_interval:168631576)
[   74.381828] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[   74.389739] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[   74.710586] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 3 cycles(tsc) 31.172 ns (step:0) - (measurement period time:0.311721410 sec time_interval:311721410) - (invoke count:10000000 tsc_interval:31172132)
[   74.729869] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[   75.257671] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.876 ns (step:0) - (measurement period time:0.518763020 sec time_interval:518763020) - (invoke count:10000000 tsc_interval:51876297)
[   75.276867] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[   77.005755] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 172.020 ns (step:0) - (measurement period time:1.720203240 sec time_interval:1720203240) - (invoke count:10000000 tsc_interval:172020318)

root@(none)$ taskset -c 0 insmod ./bench_page_pool_simple.ko
[  136.690195] bench_page_pool_simple: Loaded
[  136.732787] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038494310 sec time_interval:38494310) - (invoke count:100000000 tsc_interval:3849423)
[  137.327204] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577134850 sec time_interval:577134850) - (invoke count:100000000 tsc_interval:57713479)
[  137.491072] time_bench: Type:lock Per elem: 1 cycles(tsc) 14.624 ns (step:0) - (measurement period time:0.146240840 sec time_interval:146240840) - (invoke count:10000000 tsc_interval:14624079)
[  137.508195] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  138.089672] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 57.217 ns (step:0) - (measurement period time:0.572173750 sec time_interval:572173750) - (invoke count:10000000 tsc_interval:57217369)
[  138.108348] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  138.689834] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.227 ns (step:0) - (measurement period time:0.572271320 sec time_interval:572271320) - (invoke count:10000000 tsc_interval:57227127)
[  138.708511] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  140.405334] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 168.796 ns (step:0) - (measurement period time:1.687964470 sec time_interval:1687964470) - (invoke count:10000000 tsc_interval:168796441)
[  140.428060] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  140.435970] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  140.756813] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 3 cycles(tsc) 31.171 ns (step:0) - (measurement period time:0.311719350 sec time_interval:311719350) - (invoke count:10000000 tsc_interval:31171926)
[  140.776096] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  141.300653] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.551 ns (step:0) - (measurement period time:0.515517680 sec time_interval:515517680) - (invoke count:10000000 tsc_interval:51551762)
[  141.319853] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  143.009275] time_bench: Type:tasklet_page_pool03_slow Per elem: 16 cycles(tsc) 168.073 ns (step:0) - (measurement period time:1.680733640 sec time_interval:1680733640) - (invoke count:10000000 tsc_interval:168073359)

root@(none)$ taskset -c 0 insmod ./bench_page_pool_simple.ko
[  174.946152] bench_page_pool_simple: Loaded
[  174.988745] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038495340 sec time_interval:38495340) - (invoke count:100000000 tsc_interval:3849520)
[  175.583180] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577154420 sec time_interval:577154420) - (invoke count:100000000 tsc_interval:57715437)
[  175.747009] time_bench: Type:lock Per elem: 1 cycles(tsc) 14.620 ns (step:0) - (measurement period time:0.146200740 sec time_interval:146200740) - (invoke count:10000000 tsc_interval:14620070)
[  175.764131] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  176.345767] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 57.233 ns (step:0) - (measurement period time:0.572333700 sec time_interval:572333700) - (invoke count:10000000 tsc_interval:57233364)
[  176.364446] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  176.944547] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.088 ns (step:0) - (measurement period time:0.570887110 sec time_interval:570887110) - (invoke count:10000000 tsc_interval:57088706)
[  176.963225] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  178.656473] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 168.438 ns (step:0) - (measurement period time:1.684389720 sec time_interval:1684389720) - (invoke count:10000000 tsc_interval:168438965)
[  178.675492] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  178.683405] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  179.004242] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 3 cycles(tsc) 31.171 ns (step:0) - (measurement period time:0.311712990 sec time_interval:311712990) - (invoke count:10000000 tsc_interval:31171291)
[  179.023526] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  179.550221] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.765 ns (step:0) - (measurement period time:0.517655870 sec time_interval:517655870) - (invoke count:10000000 tsc_interval:51765580)
[  179.569417] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  181.292780] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 171.467 ns (step:0) - (measurement period time:1.714677840 sec time_interval:1714677840) - (invoke count:10000000 tsc_interval:171467778)

2. raw performance data after this patchset

root@(none)$ taskset -c 0 insmod ./bench_page_pool_simple.ko
[   92.210702] bench_page_pool_simple: Loaded
[   92.253767] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.389 ns (step:0) - (measurement period time:0.038968350 sec time_interval:38968350) - (invoke count:100000000 tsc_interval:3896825)
[   92.848206] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577158660 sec time_interval:577158660) - (invoke count:100000000 tsc_interval:57715860)
[   93.015899] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.006 ns (step:0) - (measurement period time:0.150063860 sec time_interval:150063860) - (invoke count:10000000 tsc_interval:15006381)
[   93.033022] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[   93.596905] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 55.458 ns (step:0) - (measurement period time:0.554580560 sec time_interval:554580560) - (invoke count:10000000 tsc_interval:55458050)
[   93.615583] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[   94.207234] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 58.243 ns (step:0) - (measurement period time:0.582437650 sec time_interval:582437650) - (invoke count:10000000 tsc_interval:58243758)
[   94.225912] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[   95.860315] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 162.554 ns (step:0) - (measurement period time:1.625544130 sec time_interval:1625544130) - (invoke count:10000000 tsc_interval:162554407)
[   95.879337] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[   95.887249] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[   96.171343] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 27.496 ns (step:0) - (measurement period time:0.274969220 sec time_interval:274969220) - (invoke count:10000000 tsc_interval:27496914)
[   96.190627] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[   96.713599] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.393 ns (step:0) - (measurement period time:0.513932220 sec time_interval:513932220) - (invoke count:10000000 tsc_interval:51393217)
[   96.732796] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[   98.456894] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 171.541 ns (step:0) - (measurement period time:1.715412930 sec time_interval:1715412930) - (invoke count:10000000 tsc_interval:171541286)

root@(none)$ taskset -c 0 insmod ./bench_page_pool_simple.ko
[  163.266630] bench_page_pool_simple: Loaded
[  163.309219] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038494410 sec time_interval:38494410) - (invoke count:100000000 tsc_interval:3849426)
[  163.903651] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577150320 sec time_interval:577150320) - (invoke count:100000000 tsc_interval:57715025)
[  164.071342] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.006 ns (step:0) - (measurement period time:0.150062900 sec time_interval:150062900) - (invoke count:10000000 tsc_interval:15006285)
[  164.088461] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  164.652649] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 55.488 ns (step:0) - (measurement period time:0.554886720 sec time_interval:554886720) - (invoke count:10000000 tsc_interval:55488665)
[  164.671327] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  165.263541] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 58.299 ns (step:0) - (measurement period time:0.582999800 sec time_interval:582999800) - (invoke count:10000000 tsc_interval:58299973)
[  165.282218] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  166.917289] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 162.621 ns (step:0) - (measurement period time:1.626211550 sec time_interval:1626211550) - (invoke count:10000000 tsc_interval:162621149)
[  166.936545] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  166.944456] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  167.228428] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 27.484 ns (step:0) - (measurement period time:0.274847160 sec time_interval:274847160) - (invoke count:10000000 tsc_interval:27484709)
[  167.247711] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  167.771686] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.493 ns (step:0) - (measurement period time:0.514934110 sec time_interval:514934110) - (invoke count:10000000 tsc_interval:51493406)
[  167.790883] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  169.517320] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 171.775 ns (step:0) - (measurement period time:1.717751440 sec time_interval:1717751440) - (invoke count:10000000 tsc_interval:171775139)

taskset -c 0 insmod ./bench_page_pool_simple.ko
[  203.494623] bench_page_pool_simple: Loaded
[  203.537239] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038493730 sec time_interval:38493730) - (invoke count:100000000 tsc_interval:3849355)
[  204.131650] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577129200 sec time_interval:577129200) - (invoke count:100000000 tsc_interval:57712915)
[  204.299329] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150052320 sec time_interval:150052320) - (invoke count:10000000 tsc_interval:15005228)
[  204.316447] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  204.843709] time_bench: Type:no-softirq-page_pool01 Per elem: 5 cycles(tsc) 51.796 ns (step:0) - (measurement period time:0.517960340 sec time_interval:517960340) - (invoke count:10000000 tsc_interval:51796028)
[  204.862388] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  205.456260] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 58.465 ns (step:0) - (measurement period time:0.584658150 sec time_interval:584658150) - (invoke count:10000000 tsc_interval:58465807)
[  205.474940] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  207.109889] time_bench: Type:no-softirq-page_pool03 Per elem: 16 cycles(tsc) 162.609 ns (step:0) - (measurement period time:1.626090490 sec time_interval:1626090490) - (invoke count:10000000 tsc_interval:162609042)
[  207.132545] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  207.140457] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  207.424723] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 27.514 ns (step:0) - (measurement period time:0.275141610 sec time_interval:275141610) - (invoke count:10000000 tsc_interval:27514155)
[  207.444006] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  207.967963] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 51.491 ns (step:0) - (measurement period time:0.514916640 sec time_interval:514916640) - (invoke count:10000000 tsc_interval:51491659)
[  207.987160] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  209.712648] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 171.680 ns (step:0) - (measurement period time:1.716802930 sec time_interval:1716802930) - (invoke count:10000000 tsc_interval:171680285)

3. raw performance data for frag API after this patchset
root@(none)$ taskset -c 0 insmod ./bench_page_pool_frag.ko
[ 5981.070839] bench_page_pool_frag: Loaded
[ 5981.113253] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038492620 sec time_interval:38492620) - (invoke count:100000000 tsc_interval:3849248)
[ 5981.707686] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577150800 sec time_interval:577150800) - (invoke count:100000000 tsc_interval:57715075)
[ 5981.875360] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.004 ns (step:0) - (measurement period time:0.150047290 sec time_interval:150047290) - (invoke count:10000000 tsc_interval:15004725)
[ 5981.892479] bench_page_pool_frag: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[ 5983.030870] time_bench: Type:no-softirq-page_pool01 Per elem: 11 cycles(tsc) 112.926 ns (step:0) - (measurement period time:1.129261630 sec time_interval:1129261630) - (invoke count:10000000 tsc_interval:112926158)
[ 5983.049896] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[ 5984.085723] time_bench: Type:no-softirq-page_pool02 Per elem: 10 cycles(tsc) 102.678 ns (step:0) - (measurement period time:1.026786610 sec time_interval:1026786610) - (invoke count:10000000 tsc_interval:102678656)
[ 5984.104749] bench_page_pool_frag: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[ 5986.210648] time_bench: Type:no-softirq-page_pool03 Per elem: 20 cycles(tsc) 209.721 ns (step:0) - (measurement period time:2.097213570 sec time_interval:2097213570) - (invoke count:10000000 tsc_interval:209721350)
[ 5986.229668] bench_page_pool_frag: pp_tasklet_handler(): in_serving_softirq fast-path
[ 5986.237406] bench_page_pool_frag: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[ 5986.958155] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 7 cycles(tsc) 71.179 ns (step:0) - (measurement period time:0.711798570 sec time_interval:711798570) - (invoke count:10000000 tsc_interval:71179850)
[ 5986.977439] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[ 5987.947411] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 9 cycles(tsc) 96.110 ns (step:0) - (measurement period time:0.961105800 sec time_interval:961105800) - (invoke count:10000000 tsc_interval:96110574)
[ 5987.966608] bench_page_pool_frag: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[ 5990.018801] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 204.368 ns (step:0) - (measurement period time:2.043681900 sec time_interval:2043681900) - (invoke count:10000000 tsc_interval:204368185)

root@(none)$ taskset -c 0 insmod ./bench_page_pool_frag.ko
[10101.778903] bench_page_pool_frag: Loaded
[10101.821317] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038491670 sec time_interval:38491670) - (invoke count:100000000 tsc_interval:3849157)
[10102.415720] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577120320 sec time_interval:577120320) - (invoke count:100000000 tsc_interval:57712027)
[10102.583401] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150052570 sec time_interval:150052570) - (invoke count:10000000 tsc_interval:15005251)
[10102.600521] bench_page_pool_frag: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[10103.780027] time_bench: Type:no-softirq-page_pool01 Per elem: 11 cycles(tsc) 117.037 ns (step:0) - (measurement period time:1.170377390 sec time_interval:1170377390) - (invoke count:10000000 tsc_interval:117037734)
[10103.799052] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[10104.879716] time_bench: Type:no-softirq-page_pool02 Per elem: 10 cycles(tsc) 107.162 ns (step:0) - (measurement period time:1.071623350 sec time_interval:1071623350) - (invoke count:10000000 tsc_interval:107162329)
[10104.898741] bench_page_pool_frag: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[10107.050254] time_bench: Type:no-softirq-page_pool03 Per elem: 21 cycles(tsc) 214.282 ns (step:0) - (measurement period time:2.142827400 sec time_interval:2142827400) - (invoke count:10000000 tsc_interval:214282734)
[10107.072799] bench_page_pool_frag: pp_tasklet_handler(): in_serving_softirq fast-path
[10107.080540] bench_page_pool_frag: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[10107.849370] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 7 cycles(tsc) 75.987 ns (step:0) - (measurement period time:0.759878270 sec time_interval:759878270) - (invoke count:10000000 tsc_interval:75987820)
[10107.868653] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[10108.884336] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 10 cycles(tsc) 100.681 ns (step:0) - (measurement period time:1.006815920 sec time_interval:1006815920) - (invoke count:10000000 tsc_interval:100681587)
[10108.903880] bench_page_pool_frag: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[10111.002467] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 209.007 ns (step:0) - (measurement period time:2.090076740 sec time_interval:2090076740) - (invoke count:10000000 tsc_interval:209007670)

root@(none)$ taskset -c 0 insmod ./bench_page_pool_frag.ko
[10135.250815] bench_page_pool_frag: Loaded
[10135.293228] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.384 ns (step:0) - (measurement period time:0.038491560 sec time_interval:38491560) - (invoke count:100000000 tsc_interval:3849145)
[10135.887668] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577159960 sec time_interval:577159960) - (invoke count:100000000 tsc_interval:57715991)
[10136.055343] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.004 ns (step:0) - (measurement period time:0.150047050 sec time_interval:150047050) - (invoke count:10000000 tsc_interval:15004701)
[10136.072462] bench_page_pool_frag: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[10137.255828] time_bench: Type:no-softirq-page_pool01 Per elem: 11 cycles(tsc) 117.423 ns (step:0) - (measurement period time:1.174238030 sec time_interval:1174238030) - (invoke count:10000000 tsc_interval:117423797)
[10137.274854] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[10138.356896] time_bench: Type:no-softirq-page_pool02 Per elem: 10 cycles(tsc) 107.300 ns (step:0) - (measurement period time:1.073001550 sec time_interval:1073001550) - (invoke count:10000000 tsc_interval:107300149)
[10138.375920] bench_page_pool_frag: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[10140.534446] time_bench: Type:no-softirq-page_pool03 Per elem: 21 cycles(tsc) 214.984 ns (step:0) - (measurement period time:2.149840170 sec time_interval:2149840170) - (invoke count:10000000 tsc_interval:214984011)
[10140.553464] bench_page_pool_frag: pp_tasklet_handler(): in_serving_softirq fast-path
[10140.561202] bench_page_pool_frag: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[10141.328108] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 7 cycles(tsc) 75.795 ns (step:0) - (measurement period time:0.757955870 sec time_interval:757955870) - (invoke count:10000000 tsc_interval:75795580)
[10141.347392] bench_page_pool_frag: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[10142.362664] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 10 cycles(tsc) 100.640 ns (step:0) - (measurement period time:1.006406390 sec time_interval:1006406390) - (invoke count:10000000 tsc_interval:100640634)
[10142.382208] bench_page_pool_frag: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[10144.479816] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 208.909 ns (step:0) - (measurement period time:2.089097170 sec time_interval:2089097170) - (invoke count:10000000 tsc_interval:208909713

> 
>>
>> Cheers,
>>
>> Paolo
>>
>> .
>>
> 
> 
> .
> 
