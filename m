Return-Path: <linux-kernel+bounces-138105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B64889ECAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C21B22DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57313D293;
	Wed, 10 Apr 2024 07:52:20 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B613D26E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735539; cv=none; b=CJkM5AC924ltZ/uO+gUNWAsVke6nSyksCpRq5GExQFOsukWK1h2YqB+oo8FaTS4vtm7rR7u7EJIZmLRPdfhoBrDBHzr6EdORpIAIaV8B8hEtKe2Euz+YGnjYAPnXCFJRV/OpSrzOJGEYu+9i2zGVcNxGrBgUveUc7H/E8xjHp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735539; c=relaxed/simple;
	bh=I/V05aiGaG9DgCuWQfpuJZjIjOPLnQWzeU4KSMRGet4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ov1Vmy6U9HpYBxYwaJg9+SaBfclt4GWx71zoz+u9kDlnJzZJGmrOEPtUqY+fFPuDWV0jzEj6xS1izywNSnfv0M6Cif4pLx/xqq2iP3/4ezJQFrHpRJOI6S7TEtgrFG84+yy1RCSbm1mOnYVWTzVGxArkv99vZICvXswfyR9NF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDw2W64L9z29dP9;
	Wed, 10 Apr 2024 15:49:23 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id A34C81A0172;
	Wed, 10 Apr 2024 15:52:15 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:52:15 +0800
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Oscar Salvador <osalvador@suse.de>
CC: <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
 <ZhVMThr9TNeP6SWj@localhost.localdomain>
 <ZhVoatdJZ1RWu2r3@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <13aa38af-46a1-3894-32bd-c3eb6ef67359@huawei.com>
Date: Wed, 10 Apr 2024 15:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhVoatdJZ1RWu2r3@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/10 0:10, Oscar Salvador wrote:
> On Tue, Apr 09, 2024 at 04:10:22PM +0200, Oscar Salvador wrote:
>> On Sun, Apr 07, 2024 at 04:54:56PM +0800, Miaohe Lin wrote:
>>> In short, below scene breaks the lock dependency chain:
>>>
>>>  memory_failure
>>>   __page_handle_poison
>>>    zone_pcp_disable -- lock(pcp_batch_high_lock)
>>>    dissolve_free_huge_page
>>>     __hugetlb_vmemmap_restore_folio
>>>      static_key_slow_dec
>>>       cpus_read_lock -- rlock(cpu_hotplug_lock)
>>>
>>> Fix this by calling drain_all_pages() instead.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

> 
> On a second though,
> 
> disabling pcp via zone_pcp_disable() was a deterministic approach.
> Now, with drain_all_pages() we drain PCP queues to buddy, but nothing
> guarantees that those pages do not end up in a PCP queue again before we
> the call to take_page_off_budy() if we
> need refilling, right?

AFAICS, iff check_pages_enabled static key is enabled and in hard offline mode,
check_new_pages() will prevent those pages from ending up in a PCP queue again
when refilling PCP list. Because PageHWPoison pages will be taken as 'bad' pages
and skipped when refill PCP list.

> 
> I guess we can live with that because we will let the system know that we
> failed to isolate that page.

We're trying best to isolate that page anyway. :)

Thanks for your thought.
.

> 
> 


