Return-Path: <linux-kernel+bounces-31269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52186832B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86AAB232A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E11653E00;
	Fri, 19 Jan 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UzeW2rWQ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CF53E22
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675560; cv=none; b=GmmviuPtRxcTaoap7gG2aD0UIgJKVEQHF4ukvNOY4wDwwceNER6ErBVxT3/d7vDNMUy/m4Eqfzi98lBFHlE7dzkEdkl0QFw76cwz8Gg9Pl4JT1N4si734sY+MauKA0an6mgEcqlUb/CvPiLvB7VaQi28cJMwx01r29vm3XSxOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675560; c=relaxed/simple;
	bh=uXIL0jESnugspLmwRlY37WYBzsNGvLJzSoz+8nVRU50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6BjdXbRmdHcu+u2e/lX29VwiG8ljl7RSKTxwiRSgna8/htDzHrnq1/3Q8iWD9nmZ8kcwAQ0yfERdmV+5tHffuFpAfPd7qpQduwhaBfvTIx24m41NuNDtH6lxs416nM7vuxP8u0BaszkwXczl0qCsUMNXlcAmd7roNt2e0iosYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UzeW2rWQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1969573f-586e-4011-89ec-ac87281662aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705675556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn3+4lwprQBJM5nGY6FbzVrKjbGN9xFNXBt6g7Xu+1w=;
	b=UzeW2rWQdKOWMi0qkrmRp3lqMEqSn71kEZjmF3Hb5LES9S0eu84aZtzHUS20vCM9nN1dCW
	imeCr6sbBg9cpBsntHhqzpI4Wo57k7fYBYiuhhUbr0gg40B5v0XNYVl64khhQFr5m4DJl6
	7r+9lEmYuIsT/c3fZbq+U89yNCvT/Vw=
Date: Fri, 19 Jan 2024 22:45:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 David Rientjes <rientjes@google.com>, David Hildenbrand <david@redhat.com>,
 ligang.bdlg@bytedance.com, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-8-gang.li@linux.dev>
 <f11526d6-463a-4e1a-979e-a93de1a24617@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <f11526d6-463a-4e1a-979e-a93de1a24617@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/18 22:22, Kefeng Wang wrote:
> On 2024/1/18 20:39, Gang Li wrote:
>>   include/linux/hugetlb.h |  2 +-
>>   mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++++++--------
>>   2 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index c1ee640d87b1..77b30a8c6076 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -178,7 +178,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct 
>> vm_area_struct *vma,
>>   struct address_space *hugetlb_page_mapping_lock_write(struct page 
>> *hpage);
>>   extern int sysctl_hugetlb_shm_group;
>> -extern struct list_head huge_boot_pages;
>> +extern struct list_head huge_boot_pages[MAX_NUMNODES];
> 
> Hi, please update arch/powerpc/mm/hugetlbpage.c too, since it
> was used in ppc.
> 

Thanks, will do

