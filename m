Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B67562D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGQMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:33:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861591;
        Mon, 17 Jul 2023 05:33:08 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4Lxk64hxzNmMv;
        Mon, 17 Jul 2023 20:29:46 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 20:33:05 +0800
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
 <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
 <20230712102603.5038980e@kernel.org>
 <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
 <20230714105214.39ad4e4d@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6c94f7b8-f553-1fce-f3f1-66cdead9e056@huawei.com>
Date:   Mon, 17 Jul 2023 20:33:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230714105214.39ad4e4d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
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

On 2023/7/15 1:52, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 20:16:34 +0800 Yunsheng Lin wrote:
>>> I should have clarified that "types.h" should also include pure
>>> function declarations (and possibly static line wrappers like
>>> pure get/set functions which only need locally defined types).  
>>
>> So "types.h" is not supposed/allowed to include any header and
>> it can include any function declarations and static line wrappers
>> which do not depend on any other header? It means we need to forward
>> declaring a lot of 'struct' type for function declarations, right?
> 
> Only those used in function prototypes. Pointers in structures 
> are somewhat special and don't require fwd declaration.

I gave it a try to split it, and something as below come out:

https://github.com/gestionlin/linux/commit/11ac8c1959f7eda06a7b987903f37212b490b292

As the 'helpers.h' is not really useful when splitting, so only
'page_pool_types.h' is added, and include 'page_pool_types.h' in
'page_pool.h', does it make sense?

As Alexander is sending a new RFC for the similar problem, I think
we need to align on which is the better way to solve the problem.
