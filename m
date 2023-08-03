Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029876ED82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjHCPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjHCPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:04:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2198FEA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:04:24 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGsVG3JpXzNmZN;
        Thu,  3 Aug 2023 23:00:54 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 23:04:20 +0800
Message-ID: <526b8b11-9d7e-0980-f7c8-6ad4222e2f92@huawei.com>
Date:   Thu, 3 Aug 2023 23:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
 <20230803060646.GA87850@ziqianlu-dell>
 <20230803134106.GA130558@ziqianlu-dell>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230803134106.GA130558@ziqianlu-dell>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/3 21:41, Aaron Lu wrote:
> On Thu, Aug 03, 2023 at 02:06:46PM +0800, Aaron Lu wrote:
>> On Wed, Aug 02, 2023 at 07:54:38PM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>>
>>>> How to reproduce:
>>>>
>>>> Had 24 CPU Alderlake 16GB debian12 system running with default kernel (from makecondig) on 6.5-rc4, exercised with no swap to start with.
>>>>
>>>> using stress-ng tip commit 0f2ef02e9bc5abb3419c44be056d5fa3c97e0137
>>>> (see https://github.com/ColinIanKing/stress-ng )
>>>>
>>>> build and run stress-ng for say 60 minutes:
>>>>
>>>> ./stress-ng --cpu-online 50 --brk 50 --swap 50 --vmstat 1 -t 60m
>>>>
>>>> Will hang in mm/swapfile.c:718 add_to_avail_list+0x93/0xa0
>>>>
>>>> See attached file for an image of the console on the hang (I'm trying to get the full stack dump).
>>>
>>> See Bugzilla for the full thread and attached console image.
>>>
>>> FWIW, I have to forward this bug report to the mailing lists because
>>> Thorsten noted that many developers don't take a look on Bugzilla
>>> (see the BZ thread).
>>
>> Thanks.
>>
>> I can reproduce this issue using below cmdline:
>> $ sudo ./stress-ng --brk 50 --swap 5 --vmstat 1 -t 60m
>>
>> I'll investigate what is happening.
> 
> Hi Colin,
> 
> Can you try the below diff on top of v6.5-rc4? It works for me here
> although I got the warn in a different place in get_swap_pages():
> 
>                          WARN(!si->highest_bit,
>                               "swap_info %d in list but !highest_bit\n",
>                               si->type);
> 
> I think the warn you got in add_to_avail_list() due to the swap device
> is already in the list is similar, see below explanation.
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8e6dde68b389..cb7e93ec1933 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2330,7 +2330,8 @@ static void _enable_swap_info(struct swap_info_struct *p)
>   	 * swap_info_struct.
>   	 */
>   	plist_add(&p->list, &swap_active_head);
> -	add_to_avail_list(p);
> +	if (p->highest_bit)
> +		add_to_avail_list(p);
>   }

There is a patch in next,

commit bdfc7028681ddbce5ab08f4888d157a981060544
Author: Ma Wupeng <mawupeng1@huawei.com>
Date:   Tue Jun 27 20:08:33 2023 +0800

     swap: stop add to avail list if swap is full



>   
>   static void enable_swap_info(struct swap_info_struct *p, int prio,
> 
> The finding is, if a swap device failed to be swapoff, then it will be
> reinsert_swap_info() -> _enable_swap_info() -> add_to_avail_list(). The
> problem is, this swap device may run out of space with its highest_bit
> being 0 and shouldn't be added to avail list. In your case, once its
> highest_bit becomes non-zero, it will go through add_to_avail_list()
> and since it's already in the list, thus the warn.
> 
> If it works for you, I'll prepare a patch. Thanks.
> 
