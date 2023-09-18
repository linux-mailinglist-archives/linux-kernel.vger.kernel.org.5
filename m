Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BAB7A5660
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjIRX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:59:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF290
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:59:21 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RqMCt2DfLzrSjG;
        Tue, 19 Sep 2023 07:57:14 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 07:59:18 +0800
Message-ID: <255facf6-1d44-44eb-9d7e-5abf13f54499@huawei.com>
Date:   Tue, 19 Sep 2023 07:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: convert numa balancing functions to use a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
 <ZQhJIDXO1m5XFYH4@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZQhJIDXO1m5XFYH4@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/18 20:57, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 06:32:07PM +0800, Kefeng Wang wrote:
>> The do_numa_pages only handle non-compound page, and only PMD-mapped THP
>> is handled in do_huge_pmd_numa_page(), but large, PTE-mapped folio will
>> be supported, let's convert more numa balancing functions to use/take a
>> folio in preparation for that, no functional change intended for now.
>>
>> Kefeng Wang (6):
>>    sched/numa, mm: make numa migrate functions to take a folio
>>    mm: mempolicy: make mpol_misplaced() to take a folio
>>    mm: memory: make numa_migrate_prep() to take a folio
>>    mm: memory: use a folio in do_numa_page()
>>    mm: memory: add vm_normal_pmd_folio()
>>    mm: huge_memory: use a folio in do_huge_pmd_numa_page()
> 
> This all seems OK.  It's kind of hard to review though because you change
> the same line multiple times.  I think it works out better to go top-down
> instead of bottom-up.  That is, start with do_numa_page() and pass
> &folio->page to numa_migrate_prep.  Then do vm_normal_pmd_folio() followed
> by do_huge_pmd_numa_page().  Fourth would have been numa_migrate_prep(),
> etc.  I don't want to ask you to redo the entire series, but for future
> patch series.
> 
> Also, it's nce to do things like remove the unnecessary 'extern' from
> function declarations when you change them from page to folio.  And
> please try to stick to 80 columns; I know it's not always easy/possible.
> 

Thanks for your review and suggestion, I will keep them in mind when
sending new patch, thanks.
