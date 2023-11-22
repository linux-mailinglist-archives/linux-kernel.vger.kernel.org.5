Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881267F3E49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjKVGla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjKVGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:41:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965A97
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:41:24 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SZs3k4b9CzRjZZ;
        Wed, 22 Nov 2023 14:37:06 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 22 Nov 2023 14:41:21 +0800
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap
 space
To:     Michal Hocko <mhocko@suse.com>
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka>
CC:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
Date:   Wed, 22 Nov 2023 14:41:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ZVyp5eETLTT0PCYj@tiehlicka>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/21 21:00, Michal Hocko wrote:
> On Tue 21-11-23 17:06:24, Liu Shixin wrote:
>
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> is skipped and do not count, the scan of pages in isolate_lru_folios() can
> eventually lead to hung task, just as Sachin reported [2].
> I find this paragraph really confusing! I guess what you meant to say is
> that a real swapcache_only is problematic because it can end up not
> making any progress, correct? 
This paragraph is going to explain why checking swapcache_only after scan += nr_pages;
>
> AFAIU you have addressed that problem by making swapcache_only anon LRU
> specific, right? That would be certainly more robust as you can still
> reclaim from file LRUs. I cannot say I like that because swapcache_only
> is a bit confusing and I do not think we want to grow more special
> purpose reclaim types. Would it be possible/reasonable to instead put
> swapcache pages on the file LRU instead?
It looks like a good idea, but I'm not sure if it's possible. I can try it, is there anything to
pay attention to?

Thanks,

