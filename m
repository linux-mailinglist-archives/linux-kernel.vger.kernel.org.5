Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040E7BC501
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbjJGG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbjJGG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:26:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1ACC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:26:36 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S2ZvY0h7RztTQg;
        Sat,  7 Oct 2023 14:22:01 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 14:26:33 +0800
Subject: Re: [PATCH v6] mm: vmscan: try to reclaim swapcache pages if no swap
 space
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20230915083417.3190512-1-liushixin2@huawei.com>
 <20231004091853.9be5aa562f65e0305e06b14c@linux-foundation.org>
CC:     Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <38420ca8-9c83-bb06-041f-ce1cf1f084ef@huawei.com>
Date:   Sat, 7 Oct 2023 14:26:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231004091853.9be5aa562f65e0305e06b14c@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/5 0:18, Andrew Morton wrote:
> On Fri, 15 Sep 2023 16:34:17 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> When spaces of swap devices are exhausted, only file pages can be
>> reclaimed.  But there are still some swapcache pages in anon lru list.
>> This can lead to a premature out-of-memory.
>>
>> The problem is found with such step:
>>
>>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>>  memory limit, then runs an program to allocates about 15MB memory.
>>
>> The problem occurs occasionally, which may need about 100 times [1].
>>
>> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
>> If the number is not zero, return true and set swapcache_only to 1.
>> When scan anon lru list in swapcache_only mode, non-swapcache pages will
>> be skipped to isolate in order to accelerate reclaim efficiency.
>>
>> However, in swapcache_only mode, the scan count still increased when scan
>> non-swapcache pages because there are large number of non-swapcache pages
>> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
>> is skipped and do not count, the scan of pages in isolate_lru_folios() can
>> eventually lead to hung task, just as Sachin reported [2].
>>
>> By the way, since there are enough times of memory reclaim before OOM, it
>> is not need to isolate too much swapcache pages in one times.
>>
> mhocko earlier suspected this might impact global reclaim.  Have you
> looked into that further?
> .
Alreadly test the case of global reclaim using ltp testcases. In previous version,
the reclaim can stall in isolate_lru_folios() because I didn't count non-swapcache
pages into scan so it will waste too much times scanning non-swapcache pages.
In this version, I count non-swapcache pages into scan too and terminate when
scan reaches the threshold. So it will not stall in reclaim now.

