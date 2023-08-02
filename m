Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD976CBD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjHBLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjHBLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:36:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1729211E;
        Wed,  2 Aug 2023 04:36:20 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG8zS3ndtz1GDP2;
        Wed,  2 Aug 2023 19:35:16 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 19:36:18 +0800
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-6-aleksander.lobakin@intel.com>
 <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
 <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
 <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
 <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <03124fbf-1b47-99e1-d9a5-a9251890f6e7@huawei.com>
Date:   Wed, 2 Aug 2023 19:36:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/1 21:36, Alexander Lobakin wrote:

>>
>> It just seems odd to me that dma_map and page_frag is duplicated as we
>> seems to have the same info in the page_pool->p.flags.
> 
> It's just because we copy the whole &page_pool_params passed by the
> driver. It doesn't look good to me to define a new structure and copy
> the values field-by-field just to avoid duplicating 3 bits :s
> 
>>
>> What about:
>> In [PATCH net-next 4/9] page_pool: shrink &page_pool_params a tiny bit,
>> 'flags' is bit-field'ed with 'dma_dir', what about changing 'dma_dir'
>> to be bit-field'ed with 'dma_sync_act', so that page_pool->p.flags stays
>> the same as before, and 'dma_map' & 'page_frag' do not seems be really
>> needed as we have the same info in page_pool->p.flags?
> 
> Not sure I follow :z ::dma_dir is also passed by the driver, so we can't
> drop it from the params struct.

My bad, I missed that dma_dir is in the params struct.
