Return-Path: <linux-kernel+bounces-94036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC18738E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C54B21B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E95132C19;
	Wed,  6 Mar 2024 14:23:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFE13174A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735013; cv=none; b=Yd/XhEWzTz64dJ6d8D2Xdkr6zhj8Kn5nhPQ5wRmPpcvxn4O3/2pwD62qPTVZVHRiKMVeWl3Unf8MmFY3VbLAwcJcQAZ6MdZiB+3VddzvRDafrxC9UsV4Drohfs0K05Xrlh1SOs2g5p3q6sMl2HwLe9TJsqr+LlmNe44aEcxWETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735013; c=relaxed/simple;
	bh=3I676H1I0PgseTJz6rWD2dWOzdsvCFInhO0usROVwKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OnLcX7BkXgPTyImZWh41tPTr6Yb0pS8XMXz+COfUbxeDmZ/y89XHRnTvxPU/Td6qpe9wUEDU3KRYKtxFcG87kpplHuGhvBkWvZ1w615VOWPE1Wee0e+mKmw46nk+N7mklwRTiio7CCpLBccuLYBskdwulAZyYLbunP2VWj8bHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TqZNd1fPyzXhg7;
	Wed,  6 Mar 2024 22:21:05 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EB9B014011F;
	Wed,  6 Mar 2024 22:23:20 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 22:23:20 +0800
Message-ID: <44c0fb50-3a0d-428a-8310-3e8d2eb1a53c@huawei.com>
Date: Wed, 6 Mar 2024 22:23:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] mm,page_owner: Filter out stacks by a threshold
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Michal Hocko
	<mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver
	<elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>
References: <20240215215907.20121-1-osalvador@suse.de>
 <20240215215907.20121-7-osalvador@suse.de>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240215215907.20121-7-osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Hi

On 2024/2/16 5:59, Oscar Salvador wrote:
> We want to be able to filter out the stacks based on a threshold we can
> can tune.
> By writing to 'count_threshold' file, we can adjust the threshold value.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/page_owner.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e99fbf822dd6..e56c1e92eccf 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -846,6 +846,8 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
>   	return stack;
>   }
>   
> +static unsigned long page_owner_stack_threshold;
> +
>   static int stack_print(struct seq_file *m, void *v)
>   {
>   	int i, stack_count;
> @@ -858,7 +860,8 @@ static int stack_print(struct seq_file *m, void *v)
>   	entries = stack_record->entries;
>   	stack_count = refcount_read(&stack_record->count) - 1;
>   
> -	if (!nr_entries || nr_entries < 0 || stack_count < 1)
> +	if (!nr_entries || nr_entries < 0 || stack_count < 1 ||
> +	    stack_count < page_owner_stack_threshold)
>   		return 0;
>   
>   	for (i = 0; i < nr_entries; i++)
> @@ -891,6 +894,22 @@ static const struct file_operations page_owner_stack_operations = {
>   	.release	= seq_release,
>   };
>   
> +static int page_owner_threshold_get(void *data, u64 *val)
> +{
> +	*val = READ_ONCE(page_owner_stack_threshold);
> +	return 0;
> +}
> +
> +static int page_owner_threshold_set(void *data, u64 val)
> +{
> +	WRITE_ONCE(page_owner_stack_threshold, val);
> +	return 0;
> +}

no need READ/WRITE_ONCE between get/set, since simple_attr_read/write() 
with a mutex, but set and stack_print could date race
> +
> +DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
> +			&page_owner_threshold_set, "%llu");

%llu\n"

In addition, since we have a stack_list, could we add a new feature to
dump stack info with threshold with OOM notifier, because many users
directly call alloc_page family, which makes it too difficult to debug
during OOM.

Thanks

> +
> +
>   static int __init pageowner_init(void)
>   {
>   	struct dentry *dir;
> @@ -905,6 +924,8 @@ static int __init pageowner_init(void)
>   	dir = debugfs_create_dir("page_owner_stacks", NULL);
>   	debugfs_create_file("show_stacks", 0400, dir, NULL,
>   			    &page_owner_stack_operations);
> +	debugfs_create_file("count_threshold", 0600, dir, NULL,
> +			    &proc_page_owner_threshold);
>   
>   	return 0;
>   }

