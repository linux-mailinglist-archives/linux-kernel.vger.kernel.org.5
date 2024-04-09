Return-Path: <linux-kernel+bounces-136107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226D89D013
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F4A1C2410F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AF4F5FE;
	Tue,  9 Apr 2024 01:55:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C44F5E6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627751; cv=none; b=U/stSp5luHONg90Msbwu4zrAVu7EP5WCZsuqOYuWG+U8UgMNCb4Cz60v+z5qBi9p7UFXLcs+MrUs14dlYYTvGfx/UOomfMiiZNb7LTW84Asc+/OegISyMv4jhTyF46MCmDsPjOz+GzZOSdIPug6bKGmicoeFKwSD9hwnkyw1tXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627751; c=relaxed/simple;
	bh=QrWo7VVMPlVdZGBAfIR9p/74O2Cx2ajkw1xngK+YWt8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jDbpqZkB2B6/gc1FgQegykBiWBD7Mnpf/42syBgRFb6WY1om7AJZQFCR8MyPh7KXN8ZxbmJ8fvyYFRxOdSzDmAQx+Eq0lcYcMfNR+cC9eB7y6y6WnvrfUbqeTVFHt4wOKsX2e4HazWXP4S+8pvHKBvHWlRu0cnBcgfRuuXHffoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VD89r6mytztRxm;
	Tue,  9 Apr 2024 09:53:04 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A210140124;
	Tue,  9 Apr 2024 09:55:46 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 09:55:46 +0800
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Andrew Morton <akpm@linux-foundation.org>
CC: <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
 <20240408122955.82183316d06cfe32fbacad0e@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7a0bdaac-73cc-fb90-d323-aa68444c7e54@huawei.com>
Date: Tue, 9 Apr 2024 09:55:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240408122955.82183316d06cfe32fbacad0e@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/9 3:29, Andrew Morton wrote:
> On Sun, 7 Apr 2024 16:54:56 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When I did hard offline test with hugetlb pages, below deadlock occurs:
>>
>> ...
>>
>> Fix this by calling drain_all_pages() instead.
> 
> Thanks.  I propose
> 
> Fixes: 510d25c92ec4a ("mm/hwpoison: disable pcp for page_handle_poison()")

IMHO this issue won't occur until commit a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key").
As it introduced rlock(cpu_hotplug_lock) in dissolve_free_huge_page() code path while lock(pcp_batch_high_lock) is already
in the __page_handle_poison(). So it might be more appropriate to use:

Fixes: a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")

> Cc: <stable@vger.kernel.org>

Thanks for doing this.

> 
> .
> 


