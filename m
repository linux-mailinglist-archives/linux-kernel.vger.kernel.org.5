Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEB7BF952
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjJJLKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJJLKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:10:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4BAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:10:44 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Y6K2h9zzrTR8;
        Tue, 10 Oct 2023 19:08:09 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 19:10:42 +0800
Message-ID: <351ca47e-e981-4697-8a2d-10c65de93aa6@huawei.com>
Date:   Tue, 10 Oct 2023 19:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
 <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
 <87il7ehoxh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <87il7ehoxh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/10 16:17, Huang, Ying wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> 
>> At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
>> them don't support numa balancing, and the page struct is aligned
>> to _struct_page_alignment, it is safe to move _last_cpupid before
>> 'virtual' in page, meanwhile, add it into folio, which make us to
>> use folio->_last_cpupid directly.
> 
> Add BUILD_BUG_ON() to check this automatically?

The WANT_PAGE_VIRTUAL and LAST_CPUPID_NOT_IN_PAGE_FLAGS are not
conflict, the check is to make sure that the re-order the virtual
and _last_cpupid is minimal impact, and there is a build warning in
mm/memory.c when the LAST_CPUPID_NOT_IN_PAGE_FLAGS is enabled, so I
don't think we need a new BUILD_BUG_ON here.

Thanks.

> 
> --
> Best Regards,
> Huang, Ying
