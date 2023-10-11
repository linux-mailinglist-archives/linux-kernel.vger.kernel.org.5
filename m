Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7047C4815
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjJKDD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbjJKDDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:03:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08085B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:03:23 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S4yCv4zFDzkY8D;
        Wed, 11 Oct 2023 10:59:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 11:03:20 +0800
Message-ID: <8fe8c652-b5c6-4e24-9847-7c3bb01279c0@huawei.com>
Date:   Wed, 11 Oct 2023 11:03:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/7] mm: convert xchg_page_access_time to
 xchg_folio_access_time()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
 <20231010064544.4162286-5-wangkefeng.wang@huawei.com>
 <ZSVDJPbt7Nz1xg7+@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZSVDJPbt7Nz1xg7+@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/10/10 20:27, Matthew Wilcox wrote:
> On Tue, Oct 10, 2023 at 02:45:41PM +0800, Kefeng Wang wrote:
>> Make xchg_page_access_time to take a folio, and rename it to
>> xchg_folio_access_time() since all callers with a folio.
> 
> You're doing this the hard way, which makes life hard for the reviewrs.
> 
> patch 1. Introduce folio->_last_cpupid
> patch 2: Add
> 
> static inline int folio_xchg_access_time(struct folio *folio, int time)
> {
> 	return xchg_page_access_time(&folio->page, time);
> }
> 
> patch 3-n: Convert callers
> Patch n+1: Remove xchg_page_access_time(), folding it into
> folio_xchg_access_time().

Ok, I will follow this way, thanks for your advise.
> 
> Similarly for page_cpupid_xchg_last / folio_cpupid_xchg_last().
> (why is this not called folio_xchg_last_cpupid?)

Fine with me, will update.

Thanks.

> 
> 
