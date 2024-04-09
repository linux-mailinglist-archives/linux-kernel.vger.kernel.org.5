Return-Path: <linux-kernel+bounces-136959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B118A89DA55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CD41F21EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2A137752;
	Tue,  9 Apr 2024 13:28:12 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E63136E29
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669292; cv=none; b=e1si+t9bPgHuCIWW0SUW1k6MYvmRtKiBY8xzflgRsziXaQaZvHFpUdYYHj3Z1Uk/hdZxdJevGDfzE+wrMo4hyjDVlImGjBEIUj2c1p5yJZY02Hs3UuNcEYmPlcuslYgQfSYkVU6ii+e7k/Jv1Li3XkcMpvrioQtXzui6VIuZ5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669292; c=relaxed/simple;
	bh=Dk3z3t3XHGug3Wyd7YN1dCENsVlrnDU58Ikqk0CwKW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZU+LsRIXNYiTgE1zVFeksVrceY7EVKMZh3c5hj6I5pX0w0AaeSYq/pX97Ibta9ip5RBzkUkOl/vwfFrkVThbDpFWuxCUtYulThW9c+J3aVVNO+Rq0TsPpUmxSA5sJSlbkjZsByEeGdIJJHzpIbs/XOJVEspvj/mi1ISXN/+mJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDRZd2tsXz21kdB;
	Tue,  9 Apr 2024 21:27:05 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 739091A0172;
	Tue,  9 Apr 2024 21:28:00 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:28:00 +0800
Message-ID: <4311bf57-ea3e-4ea6-8f7b-370d9dd2dac1@huawei.com>
Date: Tue, 9 Apr 2024 21:27:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Defer enablement of static branch
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Vlastimil Babka
	<vbabka@suse.cz>
References: <20240409131715.13632-1-osalvador@suse.de>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240409131715.13632-1-osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/9 21:17, Oscar Salvador wrote:
> Kefeng Wang reported that he was seeing some memory leaks with kmemleak
> with page_owner enabled.
> The reason behind is that we enable the page_owner_inited static branch
> and then proceed with the linking of stack_list struct to dummy_stack,
> which means that exists a race window between these two steps where we
> can have pages already being allocated calling add_stack_record_to_list(),
> allocating objects and linking them to stack_list, but then we set
> stack_list pointing to dummy_stack in init_page_owner.
> Which means that the objects that have been allocated during that time
> window are unreferenced and lost.
> 
> Fix this by deferring the enablement of the branch until we have properly
> set up the list.
> 
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Closes: https://lore.kernel.org/linux-mm/74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com/
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Fixes: 4bedfb314bdd ("mm,page_owner: maintain own list of stack_records structs")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> Special thanks and kudos go to Kefeng Wang for helping me out chasing
> down this bug, as I could not reproduce it with any of my machines, and
> to Vlastimil to bring another pair of eyes, which was very helpful.
> 
The issue is found by accident when test my migrate changes, thanks for
your great job and quick response, this does pass my test, thanks ;)

>   mm/page_owner.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 9bef0b442863..742f432e5bf0 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -118,7 +118,6 @@ static __init void init_page_owner(void)
>   	register_dummy_stack();
>   	register_failure_stack();
>   	register_early_stack();
> -	static_branch_enable(&page_owner_inited);
>   	init_early_allocated_pages();
>   	/* Initialize dummy and failure stacks and link them to stack_list */
>   	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
> @@ -129,6 +128,7 @@ static __init void init_page_owner(void)
>   		refcount_set(&failure_stack.stack_record->count, 1);
>   	dummy_stack.next = &failure_stack;
>   	stack_list = &dummy_stack;
> +	static_branch_enable(&page_owner_inited);
>   }
>   
>   struct page_ext_operations page_owner_ops = {

