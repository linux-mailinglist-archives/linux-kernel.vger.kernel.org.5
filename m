Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C07E0355
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKCNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:07:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979A111;
        Fri,  3 Nov 2023 06:07:49 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMLYk61CXzrRsT;
        Fri,  3 Nov 2023 21:04:42 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 21:07:47 +0800
Message-ID: <88a40128-e55a-4dde-b664-99ff3ead175b@huawei.com>
Date:   Fri, 3 Nov 2023 21:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] fs/proc/page: use a folio in stable_page_flags()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, <gourry.memverge@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
 <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
 <ZUTnf/hnbPqI9HSB@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUTnf/hnbPqI9HSB@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2023/11/3 20:28, Matthew Wilcox wrote:
> On Fri, Nov 03, 2023 at 03:29:05PM +0800, Kefeng Wang wrote:
>> Replace ten compound_head() calls with one page_folio().
> 
> This is going to conflict with Gregory Price's work:
> 
> https://lore.kernel.org/linux-mm/ZUCD1dsbrFjdZgVv@memverge.com/
> 
> Perhaps the two of you can collaborate on a patch series?

Will check this patch.

> 
>>   	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
>> -	if (PageTail(page) && PageSlab(page))
>> +	if (PageTail(page) && folio_test_slab(folio))
>>   		u |= 1 << KPF_SLAB;
> 
> This doesn't make sense ...
> 

Yes, after commit dcb351cd095a ("page-flags: define behavior SL*B-
related flags on compound pages"), the slab could not be a tail,
I will drop this line.

