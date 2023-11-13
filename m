Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0C7E9BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKMMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKMMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:10:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC509D75
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:10:37 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STSnq4tmgzPpGl;
        Mon, 13 Nov 2023 20:06:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 20:10:34 +0800
Message-ID: <70973a55-63a0-4a85-abe5-d8681fdb3886@huawei.com>
Date:   Mon, 13 Nov 2023 20:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/13 18:53, David Hildenbrand wrote:
> On 13.11.23 11:45, Baolin Wang wrote:
>> Currently, the file pages already support large folio, and supporting for
>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>> code are converted to use a folio by previous thread[2], and the 
>> migrate_pages
>> function also already supports the large folio migration.
>>
>> So now I did not see any reason to continue restricting NUMA balancing 
>> for
>> large folio.
> 
> I recall John wanted to look into that. CCing him.
> 
> I'll note that the "head page mapcount" heuristic to detect sharers will
> now strike on the PTE path and make us believe that a large folios is
> exclusive, although it isn't.
> 
> As spelled out in the commit you are referencing:
> 
> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date:   Thu Sep 21 15:44:14 2023 +0800
> 
>      mm: memory: use a folio in do_numa_page()
>      Numa balancing only try to migrate non-compound page in 
> do_numa_page(),
>      use a folio in it to save several compound_head calls, note we use
>      folio_estimated_sharers(), it is enough to check the folio sharers 
> since
>      only normal page is handled, if large folio numa balancing is 
> supported, a
>      precise folio sharers check would be used, no functional change 
> intended.
> 
> 
> I'll send WIP patches for one approach that can improve the situation 
> soonish.

When convert numa balance to use folio, I make similar change, it works
with large anon folio(test with v5), but David's precise folio sharers
should be merged firstly, also if a large folio shared by many process,
we maybe split it, don't sure about it, this need some evaluation.
