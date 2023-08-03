Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86576E101
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjHCHN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHCHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:13:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75EFF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:13:24 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGg5Z18SSzrSCD;
        Thu,  3 Aug 2023 15:12:18 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 15:13:21 +0800
Message-ID: <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
Date:   Thu, 3 Aug 2023 15:13:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZMpKYfNWA/jNgEuL@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2023/8/2 20:21, Matthew Wilcox wrote:
> On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
>>   	err = -EACCES;
>> -	if (page_mapcount(page) > 1 && !migrate_all)
>> -		goto out_putpage;
>> +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
>> +		goto out_putfolio;
> 
> I do not think this is the correct change.  Maybe leave this line
> alone.

Ok, I am aware of the discussion about this in other mail, will not
change it(also the next two patch about this function), or wait the
new work of David.
> 
>> -	if (PageHuge(page)) {
>> -		if (PageHead(page)) {
>> -			isolated = isolate_hugetlb(page_folio(page), pagelist);
>> +	if (folio_test_hugetlb(folio)) {
>> +		if (folio_test_large(folio)) {
> 
> This makes no sense when you read it.  All hugetlb folios are large,
> by definition.  Think about what this code used to do, and what it
> should be changed to.

hugetlb folio is self large folio, will drop redundant check



