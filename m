Return-Path: <linux-kernel+bounces-19179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91576826957
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F171C21BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62450B662;
	Mon,  8 Jan 2024 08:21:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B8B665;
	Mon,  8 Jan 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T7n761B8HzNkfT;
	Mon,  8 Jan 2024 16:20:18 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A18E6140518;
	Mon,  8 Jan 2024 16:20:53 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 16:20:53 +0800
Subject: Re: [PATCH net-next 1/6] mm/page_alloc: modify
 page_frag_alloc_align() to accept align as an argument
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
	<linux-mm@kvack.org>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-2-linyunsheng@huawei.com>
 <3f382fdcacc10cf897df9dc7f17c04271839d81a.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a0bd9da0-b7b3-a424-8280-e755a68575e9@huawei.com>
Date: Mon, 8 Jan 2024 16:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3f382fdcacc10cf897df9dc7f17c04271839d81a.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/5 23:28, Alexander H Duyck wrote:
> On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
>> napi_alloc_frag_align() and netdev_alloc_frag_align() accept
>> align as an argument, and they are thin wrappers around the
>> __napi_alloc_frag_align() and __netdev_alloc_frag_align() APIs
>> doing the align and align_mask conversion, in order to call
>> page_frag_alloc_align() directly.
>>
>> As __napi_alloc_frag_align() and __netdev_alloc_frag_align()
>> APIs are only used by the above thin wrappers, it seems that
>> it makes more sense to remove align and align_mask conversion
>> and call page_frag_alloc_align() directly. By doing that, we
>> can also avoid the confusion between napi_alloc_frag_align()
>> accepting align as an argument and page_frag_alloc_align()
>> accepting align_mask as an argument when they both have the
>> 'align' suffix.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> 
> This patch overlooks much of the main reason for having the wrappers.
> By having the in-line wrapper and passing the argument as a mask we can
> avoid having to verify the alignment value during execution time since
> it can usually be handled during compile time.

When it can not be handled during compile time, we might have a bigger
executable size for kernel, right? doesn't that may defeat some purpose of
inlining?

But from the callers of those API, it does seems the handling during compile
time is the ususal case here. Will add a __page_frag_alloc_align which is
passed with the mask the original function expected as you suggested.

> 
> By moving it into the function itself we are adding additional CPU
> overhead per page as we will have to go through and validate the
> alignment value for every single page instead of when the driver using
> the function is compiled.
> 
> The overhead may not seem like much, but when you are having to deal
> with it per page and you are processing pages at millions per second it
> can quickly start to add up.
> 
> This is essentially a code cleanup at the cost of some amount of
> performance.
> 
> .
> 

