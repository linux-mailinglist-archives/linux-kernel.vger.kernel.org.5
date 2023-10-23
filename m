Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C797D366D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjJWM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:26:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D647100;
        Mon, 23 Oct 2023 05:26:40 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDZ8R0r84zVlwb;
        Mon, 23 Oct 2023 20:22:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 20:26:34 +0800
Subject: Re: [PATCH net-next v12 1/5] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <20231020095952.11055-1-linyunsheng@huawei.com>
 <20231020095952.11055-2-linyunsheng@huawei.com> <ZTZcTrTy9ulPast5@hades>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4da09821-d964-924f-470b-e5c1de18eecf@huawei.com>
Date:   Mon, 23 Oct 2023 20:26:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ZTZcTrTy9ulPast5@hades>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/23 19:43, Ilias Apalodimas wrote:
> Hi Yunsheng, 
> 
> [...]
> 
>> +	 * 1. 'n == 1': no need to actually overwrite it.
>> +	 * 2. 'n != 1': overwrite it with one, which is the rare case
>> +	 *              for pp_frag_count draining.
>>  	 *
>> -	 * The main advantage to doing this is that an atomic_read is
>> -	 * generally a much cheaper operation than an atomic update,
>> -	 * especially when dealing with a page that may be partitioned
>> -	 * into only 2 or 3 pieces.
>> +	 * The main advantage to doing this is that not only we avoid a atomic
>> +	 * update, as an atomic_read is generally a much cheaper operation than
>> +	 * an atomic update, especially when dealing with a page that may be
>> +	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
>> +	 * handling by ensuring all pages have partitioned into only 1 piece
>> +	 * initially, and only overwrite it when the page is partitioned into
>> +	 * more than one piece.
>>  	 */
>> -	if (atomic_long_read(&page->pp_frag_count) == nr)
>> +	if (atomic_long_read(&page->pp_frag_count) == nr) {
>> +		/* As we have ensured nr is always one for constant case using
>> +		 * the BUILD_BUG_ON(), only need to handle the non-constant case
>> +		 * here for pp_frag_count draining, which is a rare case.
>> +		 */
>> +		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
>> +		if (!__builtin_constant_p(nr))
>> +			atomic_long_set(&page->pp_frag_count, 1);
> 
> Aren't we changing the behaviour of the current code here? IIRC is
> atomic_long_read(&page->pp_frag_count) == nr we never updated the atomic
> pp_frag_count and the reasoning was that the next caller can set it
> properly. 

If the next caller is calling the page_pool_alloc_frag(), then yes,
because page_pool_fragment_page() will be used to reset the
page->pp_frag_count, so it does not really matter what is the value
of page->pp_frag_count when we are recycling a page.

If the next caller is calling page_pool_alloc_pages() directly without
fragmenting a page, the above code is used to ensure that pp_frag_count
is always one when page_pool_alloc_pages() fetches a page from pool->alloc
or pool->ring, because page_pool_fragment_page() is not used to reset the
page->pp_frag_count for page_pool_alloc_pages() and we have removed the
per page_pool PP_FLAG_PAGE_FRAG in page_pool_is_last_frag().

As we don't know if the caller is page_pool_alloc_frag() or
page_pool_alloc_pages(), so the above code ensure the page in pool->alloc
or pool->ring always have the pp_frag_count being one.


> 
>> +
>>  		return 0;
>> +	}
>>  
>>  	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
>>  	WARN_ON(ret < 0);
>> +
>> +	/* We are the last user here too, reset pp_frag_count back to 1 to
>> +	 * ensure all pages have been partitioned into 1 piece initially,
>> +	 * this should be the rare case when the last two fragment users call
>> +	 * page_pool_defrag_page() currently.
>> +	 */
>> +	if (unlikely(!ret))
>> +		atomic_long_set(&page->pp_frag_count, 1);
>> +
>>  	return ret;
>>  }
>>  
>  
>  [....]
> 
>  Thanks
>  /Ilias
> 
> .
> 
