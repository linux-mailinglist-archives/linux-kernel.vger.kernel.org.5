Return-Path: <linux-kernel+bounces-51996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF32849285
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C551F21602
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D29468;
	Mon,  5 Feb 2024 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jt+T+wjw"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE978F47
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101423; cv=none; b=fyor/RTM/5HHJ/cUVkIin1Uap6qfEeWCNqZO4b3LB+WPQLFnsFu1PNiclh/temf2VxZBkA4A8lt/MwS3bTpTcLsxshLQjURuqR5xqaU75YUBj+XTUlJQFz/IT05eXvuDx/h0xfyiUmgcX5WIB+hPosKG1yjyGQsTlxDz4g2iv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101423; c=relaxed/simple;
	bh=/+eNhUX5Da15gfgQrb2hDNqaoiKofc+mK/1pSJDmibc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPZSKj5+8PHEy3cuSCCcVXuaWEQiHmmxpNUXN2XwiN08iS2GXLXYxq1HASxxy9HYV1n/YSBc9XiXuLPazVABUJu1uJRZER7f86Yeaf5vF2QQQcI/SQjRN/GRFcSBOx7d+TxRa2ZH5PyioVc3u9GiJ1W8IqMQE6i2pI5bLFdDPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jt+T+wjw; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707101418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=t0gk3xBIxgK8STj8RToaRUAGDh+0bUS8n9Avz3FOyak=;
	b=jt+T+wjwnAsHod4w78hjPtemo/SM4xuCyDPPxKW0FM0iamlRTHeAb0EwfLgLSKU9dQWeWv/IMg4JNvDg7VkQCWXCtNGyNhST8qQL7gL3Zt1gEhORwdkOaE02hkfsRl6c1ltMSG78ZvMJFH0YGrU1Ww0c7ikMIep8esoTALdRzrc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W02DprY_1707101415;
Received: from 30.97.56.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W02DprY_1707101415)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 10:50:16 +0800
Message-ID: <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
Date: Mon, 5 Feb 2024 10:50:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zby7-dTtPIy2k5pj@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/2024 5:55 PM, Michal Hocko wrote:
> On Fri 02-02-24 17:29:02, Baolin Wang wrote:
>> On 2/2/2024 4:17 PM, Michal Hocko wrote:
> [...]
>>>> Agree. So how about below changing?
>>>> (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
>>>> can ensure consistent behavior in handling hugetlb.
>>>
>>> I can see two cases here. alloc_contig_range which is an internal kernel
>>> user and then we have memory offlining. The former shouldn't break the
>>> per-node hugetlb pool reservations, the latter might not have any other
>>> choice (the whole node could get offline and that resembles breaking cpu
>>> affininty if the cpu is gone).
>>
>> IMO, not always true for memory offlining, when handling a free hugetlb, it
>> disallows fallbacking, which is inconsistent.
> 
> It's been some time I've looked into that code so I am not 100% sure how
> the free pool is currently handled. The above is the way I _think_ it
> should work from the usability POV.

Please see alloc_and_dissolve_hugetlb_folio().

>> Not only memory offlining, but also the longterm pinning (in
>> migrate_longterm_unpinnable_pages()) and memory failure (in
>> soft_offline_in_use_page()) can also break the per-node hugetlb pool
>> reservations.
> 
> Bad
> 
>>> Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
>>> users expectations but hugetlb migration already tries hard to allocate
>>> a replacement hugetlb so the system must be under a heavy memory
>>> pressure if that fails, right? Is it possible that the hugetlb
>>> reservation is just overshooted here? Maybe the memory is just terribly
>>> fragmented though?
>>>
>>> Could you be more specific about numbers in your failure case?
>>
>> Sure. Our customer's machine contains serveral numa nodes, and the system
>> reserves a large number of CMA memory occupied 50% of the total memory which
>> is used for the virtual machine, meanwhile it also reserves lots of hugetlb
>> which can occupy 50% of the CMA. So before starting the virtual machine, the
>> hugetlb can use 50% of the CMA, but when starting the virtual machine, the
>> CMA will be used by the virtual machine and the hugetlb should be migrated
>> from CMA.
> 
> Would it make more sense for hugetlb pages to _not_ use CMA in this
> case? I mean would be better off overall if the hugetlb pool was
> preallocated before the CMA is reserved? I do realize this is just
> working around the current limitations but it could be better than
> nothing.

In this case, the CMA area is large and occupies 50% of the total 
memory. The purpose is that, if no virtual machines are launched, then 
CMA memory can be used by hugetlb as much as possible. Once the virtual 
machines need to be launched, it is necessary to allocate CMA memory as 
much as possible, such as migrating hugetlb from CMA memory.

After more thinking, I think we should still drop the __GFP_THISNODE 
flag in alloc_and_dissolve_hugetlb_folio(). Firstly, not only it 
potentially cause CMA allocation to fail, but it might also cause memory 
offline to fail like I said in the commit message. Secondly, there have 
been no user reports complaining about breaking the per-node hugetlb 
pool, although longterm pinning, memory failure, and memory offline can 
potentially break the per-node hugetlb pool.

>> Due to several nodes in the system, one node's memory can be exhausted,
>> which will fail the hugetlb migration with __GFP_THISNODE flag.
> 
> Is the workload NUMA aware? I.e. do you bind virtual machines to
> specific nodes?

Yes, the VM can bind nodes.

