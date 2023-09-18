Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEBF7A499E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjIRLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbjIRLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:16:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5FA115;
        Mon, 18 Sep 2023 04:15:18 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq2FJ6jwxzVl00;
        Mon, 18 Sep 2023 19:12:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 19:15:15 +0800
Subject: Re: [PATCH net-next v8 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
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
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e7f2d1b1-49fe-cf8d-eb96-c5ddf52903a0@huawei.com>
Date:   Mon, 18 Sep 2023 19:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/9/14 23:17, Paolo Abeni wrote:
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -376,6 +376,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>>  {
>>  	page->pp = pool;
>>  	page->pp_magic |= PP_SIGNATURE;
>> +
>> +	/* Ensuring all pages have been split into one big frag initially:
>> +	 * page_pool_set_pp_info() is only called once for every page when it
>> +	 * is allocated from the page allocator and page_pool_fragment_page()
>> +	 * is dirtying the same cache line as the page->pp_magic above, so
>> +	 * the overhead is negligible.
>> +	 */
>> +	page_pool_fragment_page(page, 1);
>>  	if (pool->p.init_callback)
>>  		pool->p.init_callback(page, pool->p.init_arg);
>>  }
> 
> I think it would be nice backing the above claim with some benchmarks.
> (possibly even just a micro-benchmark around the relevant APIs)
> and include such info into the changelog message.

Sure, will adjust Jesper's below micro-benchmark to test it:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

Please let me know if there is other better idea to do the
micro-benchmark in your mind, thanks.

> 
> Cheers,
> 
> Paolo
> 
> .
> 
