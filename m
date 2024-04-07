Return-Path: <linux-kernel+bounces-134160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFA89AE61
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108791F22904
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD8F9CC;
	Sun,  7 Apr 2024 03:59:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192EDDBD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712462379; cv=none; b=c8nioRaHG32g9ZfHI3qXt91aUs845Ad5dEZCA8vXJtC3iwj/oIn8reS6MszmxdHRo7lc8BJpx4oFyft2v2DZZ6HPGB+U6Qa/6GacRwEcsTJnb6AxRnOlFdl/H6KwO6HcaQ3K0r3feZFpix32i1DOwz9nwFP2zT6hS7YvXNc2ofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712462379; c=relaxed/simple;
	bh=KLSCh2wPQyrQ8/khykXKCUPpwYuXrNVTSzq+Is2ljSM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aeCtNDSrxk8AAnrARdVe58D9DePmPwgJmP08zMusCx1HJfrEWbvScwBUBrYXvgbrdFmOodIyBHiK20m079vkDJFfw3c805VDPobqcxUMzGBwD0OC2vZ1zKvP44T6ZYdr2PqBBIur70eZcguSHyJQUJF12fqDv84PlCtoPrDE13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VBz1g1dfvz1QCTH;
	Sun,  7 Apr 2024 11:56:55 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D3B0180073;
	Sun,  7 Apr 2024 11:59:34 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 11:59:33 +0800
Subject: Re: Machine check recovery broken in v6.9-rc1
To: "Luck, Tony" <tony.luck@intel.com>, Oscar Salvador <osalvador@suse.de>
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3> <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
 <ZhDHh_W1WZuFhsfg@localhost.localdomain>
 <ZhDMBZ2I9M72D87F@localhost.localdomain>
 <SJ1PR11MB608323D7E6113B78A35F4999FC012@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3e49dd21-0aea-c7ac-1633-91764e759bf7@huawei.com>
Date: Sun, 7 Apr 2024 11:59:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB608323D7E6113B78A35F4999FC012@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/7 8:08, Luck, Tony wrote:
>> This one is against 6.1 (previous one was against v6.9-rc2):
>> Again, compile tested only
> 
> Oscar.
> 
> Both the 6.1 and 6.9-rc2 patches make the BUG (and subsequent issues) go away.
> 
> Here's what's happening.
> 
> When the machine check occurs there's a scramble from various subsystems
> to report the memory error.
> 
> ghes_do_memory_failure() calls memory_failure_queue() which later
> calls memory_failure() from a kernel thread. Side note: this happens TWICE
> for each error. Not sure yet if this is a BIOS issue logging more than once.
> or some Linux issues in acpi/apei/ghes.c code.
> 
> uc_decode_notifier() [called from a different kernel thread] also calls
> do_memory_failure()
> 
> Finally kill_me_maybe() [called from task_work on return to the application
> when returning from the machine check handler] also calls memory_failure()
> 
> do_memory_failure() is somewhat prepared for multiple reports of the same
> error. It uses an atomic test and set operation to mark the page as poisoned.
> 
> First called to report the error does all the real work. Late arrivals take a
> shorter path, but may still take some action(s) depending on the "flags"
> passed in:
> 
>         if (TestSetPageHWPoison(p)) {
>                 pr_err("%#lx: already hardware poisoned\n", pfn);
>                 res = -EHWPOISON;
>                 if (flags & MF_ACTION_REQUIRED)
>                         res = kill_accessing_process(current, pfn, flags);
>                 if (flags & MF_COUNT_INCREASED)
>                         put_page(p);
>                 goto unlock_mutex;
>         }
> 
> In this case the last to arrive has MF_ACTION_REQUIRED set, so calls
> kill_accessing_process() ... which is in the stack trace that led to the:
> 
>    kernel BUG at include/linux/swapops.h:88!
> 
> I'm not sure that I fully understand your patch. I guess that it is making sure to
> handle the case that the page has already been marked as poisoned?
> 
> 
> Anyway ... thanks for the quick fix. I hope the above helps write a good
> commit message to get this applied and backported to stable.

Sorry for late. I was just back from my vacation.

> 
> Tested-by: Tony Luck <tony.luck@intel.com>

Thanks for both. This should be a issue introduced from commit:

0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")

hwpoison_entry_to_pfn() is replaced with swp_offset_pfn() which might not be intended to be used
with hwpoison entry:

/*
 * A pfn swap entry is a special type of swap entry that always has a pfn stored
 * in the swap offset. *They are used to represent unaddressable device memory*
 * *and to restrict access to a page undergoing migration*
 */
static inline bool is_pfn_swap_entry(swp_entry_t entry)
{
	/* Make sure the swp offset can always store the needed fields */
	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);

	return is_migration_entry(entry) || is_device_private_entry(entry) ||
	       is_device_exclusive_entry(entry);
}

I think Oscar's patch is the right fix and it will be better to amend the corresponding comment too.

Thanks.

> 
> -Tony
> 
> 
> 
> 
> 
> .
> 


