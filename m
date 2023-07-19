Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19302758F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGSHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGSHr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:47:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3971FFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:47:23 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R5SX56LkJzLnsh;
        Wed, 19 Jul 2023 15:44:53 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 15:47:20 +0800
Message-ID: <526ccc57-a1c3-455a-3f4a-34cd5c517bc7@huawei.com>
Date:   Wed, 19 Jul 2023 15:47:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/6] mm/page_io: use a folio in sio_read_complete()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-3-zhangpeng362@huawei.com>
 <ZLVEyG7SZMzgY7ov@casper.infradead.org>
 <48a73879-6d25-4350-a8cb-8cee58878b1c@huawei.com>
 <ZLa8EKH/C5/7L/Oq@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZLa8EKH/C5/7L/Oq@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/7/19 0:21, Matthew Wilcox wrote:

> On Tue, Jul 18, 2023 at 08:58:17PM +0800, zhangpeng (AS) wrote:
>> On 2023/7/17 21:40, Matthew Wilcox wrote:
>>
>>> On Mon, Jul 17, 2023 at 09:25:58PM +0800, Peng Zhang wrote:
>>>> +++ b/mm/page_io.c
>>>> @@ -406,19 +406,19 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>>>>    	if (ret == sio->len) {
>>>>    		for (p = 0; p < sio->pages; p++) {
>>>> -			struct page *page = sio->bvec[p].bv_page;
>>>> +			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>>>> -			SetPageUptodate(page);
>>>> -			unlock_page(page);
>>>> +			folio_mark_uptodate(folio);
>>>> +			folio_unlock(folio);
>>>>    		}
>>> I'm kind of shocked this works today.  Usually bvecs coalesce adjacent
>>> pages into a single entry, so you need to use a real iterator like
>>> bio_for_each_folio_all() to extract individual pages from a bvec.
>>> Maybe the sio bvec is constructed inefficiently.
>>>
>>> I think Kent had some bvec folio iterators in progress?
>> I'll convert bio_first_page_all() to bio_first_folio_all() in a v2.
> That isn't my point at all.  What I'm saying is that when you call a
> function like bio_add_folio(), if @folio is physically adjacent to the
> immediately prior folio already in the bio, it will extend the bv_len
> instead of adding the new folio to the bvec.  Maybe there's nothing like
> that for sio.

Thanks for your reply! I got it.

-- 
Best Regards,
Peng

