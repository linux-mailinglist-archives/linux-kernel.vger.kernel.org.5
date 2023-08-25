Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383C787EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjHYDvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHYDvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:51:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E01BEC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:51:38 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RX5Z41yqwz1L9YM;
        Fri, 25 Aug 2023 11:50:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 11:51:35 +0800
Message-ID: <ff38c641-5b15-4b73-a4bb-9aad1a53d7c9@huawei.com>
Date:   Fri, 25 Aug 2023 11:51:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] mm: migrate: remove PageTransHuge check in
 numamigrate_isolate_page()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-2-wangkefeng.wang@huawei.com>
 <ZONay3H/RB381x8a@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZONay3H/RB381x8a@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/21 20:38, Matthew Wilcox wrote:
> On Mon, Aug 21, 2023 at 07:56:17PM +0800, Kefeng Wang wrote:
>> Since we begin to convert the numa migration code to use folio, which
>> could let us to handle arbitrary sizes of folio, so drop assert that
>> we only support PageTransHuge page(PMD size) when order > 0.
> 
> Have you looked at the implementation of PageTransHuge()?  Your
> description doesn't match what the code does.

How about change to the following description，

The assert VM_BUG_ON_PAGE(order && !PageTransHuge(page), page) is
not very usefull,

    1) for a tail/base page, order = 0, for a head page, the order > 0 &&
       PageTransHuge() is true
    2) there is a PageCompound() check and only base page is handled in
       do_numa_page(), and do_huge_pmd_numa_page() only handle PMD-mapped
       THP
    3) even though the page is a tail page, isolate_lru_page() will post
       a warning, and fail to isolate the page.
    4) and if folio migrate is supported in the future, it is probable to
       migrate the entire folio if numa fault on a tail page

so just remove the check.

Thanks
