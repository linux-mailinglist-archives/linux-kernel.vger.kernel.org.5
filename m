Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76398757C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGRM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGRM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:56:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB4D1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:56:21 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4zQJ1GN1ztRBF;
        Tue, 18 Jul 2023 20:53:12 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 20:56:17 +0800
Message-ID: <df29af76-fc8f-b4f1-4a32-a200b5d4ba31@huawei.com>
Date:   Tue, 18 Jul 2023 20:56:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] mm/page_io: use a folio in __end_swap_bio_read()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-2-zhangpeng362@huawei.com>
 <ZLVDYjdflF+3oJCG@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZLVDYjdflF+3oJCG@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2023/7/17 21:34, Matthew Wilcox wrote:

> On Mon, Jul 17, 2023 at 09:25:57PM +0800, Peng Zhang wrote:
>> +++ b/mm/page_io.c
>> @@ -58,18 +58,18 @@ static void end_swap_bio_write(struct bio *bio)
>>   
>>   static void __end_swap_bio_read(struct bio *bio)
>>   {
>> -	struct page *page = bio_first_page_all(bio);
>> +	struct folio *folio = page_folio(bio_first_page_all(bio));
> Should we have a bio_first_folio_all()?  It wouldn't save any calls to
> compound_head(), but it's slightly easier to use.

Yes, I'll convert bio_first_page_all() to bio_first_folio_all() in a v2.
Thanks.

>>   	if (bio->bi_status) {
>> -		SetPageError(page);
>> -		ClearPageUptodate(page);
>> +		folio_set_error(folio);
> I appreciate this is a 1:1 conversion, but maybe we could think about
> this a bit.  Is there anybody who checks the
> PageError()/folio_test_error() for this page/folio?

Maybe wait_dev_supers() checks the PageError() after write_dev_supers()
in fs/btrfs/disk-io.c?

>> +		folio_clear_uptodate(folio);
> Similarly ... surely the folio is already !uptodate, so we don't need to
> clear the flag?

Indeed, the folio is already !uptodate. I'll drop this line in a v2.
Thanks for your feedback.

-- 
Best Regards,
Peng

