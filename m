Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4345F76E0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHCHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHCHIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:08:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52421BF1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:08:14 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGfyp6XGKzVjr7;
        Thu,  3 Aug 2023 15:06:26 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 15:08:10 +0800
Message-ID: <2f6c2ddb-b1a7-7152-bb7c-a5dcaf61ce36@huawei.com>
Date:   Thu, 3 Aug 2023 15:08:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] mm: migrate: convert numamigrate_isolate_page() to
 numamigrate_isolate_folio()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-3-wangkefeng.wang@huawei.com>
 <ZMpMfQUktateeN1D@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZMpMfQUktateeN1D@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
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



On 2023/8/2 20:30, Matthew Wilcox wrote:
> On Wed, Aug 02, 2023 at 05:53:44PM +0800, Kefeng Wang wrote:
>> -static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>> +static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>>   {
>> -	int nr_pages = thp_nr_pages(page);
>> -	int order = compound_order(page);
>> +	int nr_pages = folio_nr_pages(folio);
>> +	int order = folio_order(folio);
>>   
>> -	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>> +	VM_BUG_ON_FOLIO(order && !folio_test_pmd_mappable(folio), folio);
> 
> I don't know why we have this assertion.  I would be inclined to delete
> it as part of generalising the migration code to handle arbitrary sizes
> of folio, rather than assert that we only support PMD size folios.

Ok, will drop it.
> 
>>   	/* Do not migrate THP mapped by multiple processes */
>> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
>> +	if (folio_test_pmd_mappable(folio) && folio_estimated_sharers(folio) > 1)
>>   		return 0;
> 
> I don't know if this is the right logic.  We've willing to move folios
> mapped by multiple processes, as long as they're smaller than PMD size,
> but once they get to PMD size they're magical and can't be moved?

It seems that the logical is introduced by commit 04fa5d6a6547 ("mm:
migrate: check page_count of THP before migrating") and refactor by
340ef3902cf2 ("mm: numa: cleanup flow of transhuge page migration"),


   "Hugh Dickins pointed out that migrate_misplaced_transhuge_page() does
   not check page_count before migrating like base page migration and
   khugepage.  He could not see why this was safe and he is right."

For now, there is no migrate_misplaced_transhuge_page() and base/thp
page migrate's path is unified, there is a check(for old/new kernel) in 
migrate_misplaced_page(),

  "Don't migrate file pages that are mapped in multiple processes
  with execute permissions as they are probably shared libraries."

We could drop the above check in numamigrate_isolate_page(), but
according to 04fa5d6a6547, maybe disable migrate page shared by
multi-process during numa balance for both base/thp page.


> 
> 
