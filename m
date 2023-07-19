Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56EE758F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGSHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:46:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534AE43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:46:56 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R5SWZ46lmzLnss;
        Wed, 19 Jul 2023 15:44:26 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 15:46:53 +0800
Message-ID: <47ec8e1c-d7e5-8420-0ceb-60a9e71b064f@huawei.com>
Date:   Wed, 19 Jul 2023 15:46:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] mm/page_io: use a folio in __end_swap_bio_read()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-2-zhangpeng362@huawei.com>
 <ZLVDYjdflF+3oJCG@casper.infradead.org>
 <df29af76-fc8f-b4f1-4a32-a200b5d4ba31@huawei.com>
 <ZLa6z+vhK6aWYePL@casper.infradead.org>
Content-Language: en-US
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZLa6z+vhK6aWYePL@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/19 0:16, Matthew Wilcox wrote:

> On Tue, Jul 18, 2023 at 08:56:16PM +0800, zhangpeng (AS) wrote:
>>>>    	if (bio->bi_status) {
>>>> -		SetPageError(page);
>>>> -		ClearPageUptodate(page);
>>>> +		folio_set_error(folio);
>>> I appreciate this is a 1:1 conversion, but maybe we could think about
>>> this a bit.  Is there anybody who checks the
>>> PageError()/folio_test_error() for this page/folio?
>> Maybe wait_dev_supers() checks the PageError() after write_dev_supers()
>> in fs/btrfs/disk-io.c?
> How does _this_ folio end up in btrfs's write_dev_supers()?  This is a
> swap read.  The only folios which are swapped are anonymous and tmpfs.
> btrfs takes care of doing its own I/O.  wait_dev_supers() is looking
> for the error set in btrfs_end_super_write() which is the completion
> routine for write_dev_supers().  The pages involved there are attached
> to a btrfs address_space, not shmem or anon.

Thanks for your explanation!

Then I think nobody checks the PageError()/folio_test_error() for the page
in patch 1 and patch 2. I'll delete SetPageError() in a v2.

-- 
Best Regards,
Peng

