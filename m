Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3ED757C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGRM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGRM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:56:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F4D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:56:50 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4zSr51RFzVjMD;
        Tue, 18 Jul 2023 20:55:24 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 20:56:46 +0800
Message-ID: <06241e10-e7f6-64c8-ef9a-1336d56b21b8@huawei.com>
Date:   Tue, 18 Jul 2023 20:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] mm/page_io: convert count_swpout_vm_event() to take
 in a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-6-zhangpeng362@huawei.com>
 <ZLVGqCwN3FxoQ7cy@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZLVGqCwN3FxoQ7cy@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
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

On 2023/7/17 21:48, Matthew Wilcox wrote:

> On Mon, Jul 17, 2023 at 09:26:01PM +0800, Peng Zhang wrote:
>> -static inline void count_swpout_vm_event(struct page *page)
>> +static inline void count_swpout_vm_event(struct folio *folio)
>>   {
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	if (unlikely(PageTransHuge(page)))
>> +	if (unlikely(folio_test_large(folio)))
>>   		count_vm_event(THP_SWPOUT);
>>   #endif
> Since this is a THP_SWPOUT event, we should do this as:
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (unlikely(PageTransHuge(page)))
> +	if (folio_test_pmd_mappable(folio))
> 		count_vm_event(THP_SWPOUT);
> -#endif

Agreed. I'll convert PageTransHuge to folio_test_pmd_mappable.

-- 
Best Regards,
Peng

