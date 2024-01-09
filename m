Return-Path: <linux-kernel+bounces-20764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE68284EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF710282AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44D381B7;
	Tue,  9 Jan 2024 11:22:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C1381AC;
	Tue,  9 Jan 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T8T593hd4zvQPy;
	Tue,  9 Jan 2024 19:21:01 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 90CCE14011F;
	Tue,  9 Jan 2024 19:22:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 19:22:17 +0800
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for
 page_frag_alloc_align()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com>
 <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
 <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com>
 <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f138193c-30e0-b1ba-1735-5f569230724b@huawei.com>
Date: Tue, 9 Jan 2024 19:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/9 0:25, Alexander Duyck wrote:
> On Mon, Jan 8, 2024 at 12:59 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:

..

> 
>>>
>>> 2. By starting at the end and working toward zero we can use built in
>>> functionality of the CPU to only have to check and see if our result
>>> would be signed rather than having to load two registers with the
>>> values and then compare them which saves us a few cycles. In addition
>>> it saves us from having to read both the size and the offset for every
>>> page.
>>
>> I suppose the above is ok if we only use the page_frag_alloc*() API to
>> allocate memory for skb->data, not for the frag in skb_shinfo(), as by
>> starting at the end and working toward zero, it means we can not do skb
>> coalescing.
>>
>> As page_frag_alloc*() is returning va now, I am assuming most of users
>> is using the API for skb->data, I guess it is ok to drop this patch for
>> now.
>>
>> If we allow page_frag_alloc*() to return struct page, we might need this
>> patch to enable coalescing.
> 
> I would argue this is not the interface for enabling coalescing. This
> is one of the reasons why this is implemented the way it is. When you
> are aligning fragments you aren't going to be able to coalesce the
> frames anyway as the alignment would push the fragments apart.

It seems the alignment requirement is the same for the same user of a page_frag
instance, so the aligning does not seem to be a problem for coalescing?

> .
> 

