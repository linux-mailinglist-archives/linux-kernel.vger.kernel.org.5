Return-Path: <linux-kernel+bounces-117357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AD88AA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799B71FA06FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95B125BA;
	Mon, 25 Mar 2024 15:24:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882801B95B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380282; cv=none; b=bVP6SIHyhCtFOOCMGn5gFfbMDiWjpt7bg/sCDoAlIC1vUV2yph1q0RBS99YE9oe40tByqywU0C/dJ3zmTLUwGtCHPkLL/OHwjw+1097RPkTHryF/Lh7kIzMvQC/6tMuAUcbXI9o0ZJeju+s0cFdo9jH0IimMFqld2ApjOkiZICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380282; c=relaxed/simple;
	bh=syzKgDeLyYIAXjh7NmgB2At8G8Zh2reAEcwgbzqURQk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sbJUDxy/5Co97zkjMQQU9Y4obdnA29skxNj7R3NBcNP1Fom10ge1ouEI13moLMyJc4WMfwVCIXG0Ij1mhgIN5kiQWrx+B3JK88nfp9tSD/gqxg7Cd21NTJ1wJoFZgvmdCR5rDqTiLxc2dH1d+ppOyLM9M9kDDeP0WiKqSfxXfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3Gqz73GmzXjkc;
	Mon, 25 Mar 2024 23:21:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AFB9140ABF;
	Mon, 25 Mar 2024 23:24:36 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 23:24:35 +0800
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: David Rientjes <rientjes@google.com>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox
	<willy@infradead.org>, <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<wangkefeng.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Yu Zhao
	<yuzhao@google.com>, Yosry Ahmed <yosryahmed@google.com>, Sourav Panda
	<souravpanda@google.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org> <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck>
 <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com>
Date: Mon, 25 Mar 2024 23:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

On 2024/3/14 7:32, David Rientjes wrote:

> On Thu, 8 Feb 2024, Will Deacon wrote:
>
>>> How about take a new lock with irq disabled during BBM, like:
>>>
>>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
>>> +{
>>> +     (NEW_LOCK);
>>> +    pte_clear(&init_mm, addr, ptep);
>>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>> +    set_pte_at(&init_mm, addr, ptep, pte);
>>> +    spin_unlock_irq(NEW_LOCK);
>>> +}
>> I really think the only maintainable way to achieve this is to avoid the
>> possibility of a fault altogether.
>>
>> Will
>>
>>
> Nanyong, are you still actively working on making HVO possible on arm64?
>
> This would yield a substantial memory savings on hosts that are largely
> configured with hugetlbfs.  In our case, the size of this hugetlbfs pool
> is actually never changed after boot, but it sounds from the thread that
> there was an idea to make HVO conditional on FEAT_BBM.  Is this being
> pursued?
>
> If so, any testing help needed?
I'm afraid that FEAT_BBM may not solve the problem here, because from 
Arm ARM,
I see that FEAT_BBM is only used for changing block size. Therefore, in 
this HVO feature,
it can work in the split PMD stage, that is, BBM can be avoided in 
vmemmap_split_pmd,
but in the subsequent vmemmap_remap_pte, the Output address of PTE still 
needs to be
changed. I'm afraid FEAT_BBM is not competent for this stage. Perhaps my 
understanding
of ARM FEAT_BBM is wrong, and I hope someone can correct me.
Actually, the solution I first considered was to use the stop_machine 
method, but we have
products that rely on /proc/sys/vm/nr_overcommit_hugepages to 
dynamically use hugepages,
so I have to consider performance issues. If your product does not 
change the amount of huge
pages after booting, using stop_machine() may be a feasible way.
So far, I still haven't come up with a good solution.

