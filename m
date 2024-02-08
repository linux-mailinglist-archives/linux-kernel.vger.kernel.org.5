Return-Path: <linux-kernel+bounces-57768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74F84DD33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE43D1C25800
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1F6BFBB;
	Thu,  8 Feb 2024 09:44:56 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC66BB2F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385496; cv=none; b=G//XuTJBizkYuRFsvuD/C0AW3yYCbafGz93upZwR5voFVBJKZ+e5KaGuSf1UpOtkBCPDqyLX9Kv59yQ7JQ5AzfuSK3neNRO6+27/AAvP9jOpHz25l4U4etVPHaIrRKCSr9ZD16Typyy+WEqbYtUAKXZlVx5jLezPbXMCpWRKEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385496; c=relaxed/simple;
	bh=STtoSs5arH7Z7B6o8Jc5vxJ2oW35KHtTibhQ7eD7N+k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JV+uC4W3Zt3bus7bObf0i9NWDUsI82RU3gwhXgslP+KP0gt97upjt/pT7IzvdGWLbPnf2Uqgjyfau3wWwYVkM6J4iyAbyPyskKLtxfRuZdNYJKVTueXKmXGrD0f13cJJLIoIPJFUEdHh7LYZyONB5cHnaEjsPTU0yMo4ijX6kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVsR03SlZz1FKPw;
	Thu,  8 Feb 2024 17:40:12 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 23F7518001A;
	Thu,  8 Feb 2024 17:44:50 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 17:44:48 +0800
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox
	<willy@infradead.org>
CC: Will Deacon <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>, <wangkefeng.wang@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org> <ZcN1hTrAhy-B1P2_@arm.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
Date: Thu, 8 Feb 2024 17:44:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcN1hTrAhy-B1P2_@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)


在 2024/2/7 20:20, Catalin Marinas 写道:
> On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
>> On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
>>> On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
>>>> On 2024/1/26 2:06, Catalin Marinas wrote:
>>>>> On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
>>>>>> HVO was previously disabled on arm64 [1] due to the lack of necessary
>>>>>> BBM(break-before-make) logic when changing page tables.
>>>>>> This set of patches fix this by adding necessary BBM sequence when
>>>>>> changing page table, and supporting vmemmap page fault handling to
>>>>>> fixup kernel address translation fault if vmemmap is concurrently accessed.
>>>>> I'm not keen on this approach. I'm not even sure it's safe. In the
>>>>> second patch, you take the init_mm.page_table_lock on the fault path but
>>>>> are we sure this is unlocked when the fault was taken?
>>>> I think this situation is impossible. In the implementation of the second
>>>> patch, when the page table is being corrupted
>>>> (the time window when a page fault may occur), vmemmap_update_pte() already
>>>> holds the init_mm.page_table_lock,
>>>> and unlock it until page table update is done.Another thread could not hold
>>>> the init_mm.page_table_lock and
>>>> also trigger a page fault at the same time.
>>>> If I have missed any points in my thinking, please correct me. Thank you.
>>> It still strikes me as incredibly fragile to handle the fault and trying
>>> to reason about all the users of 'struct page' is impossible. For example,
>>> can the fault happen from irq context?
>> The pte lock cannot be taken in irq context (which I think is what
>> you're asking?)
> With this patchset, I think it can: IRQ -> interrupt handler accesses
> vmemmap -> faults -> fault handler in patch 2 takes the
> init_mm.page_table_lock to wait for the vmemmap rewriting to complete.
> Maybe it works if the hugetlb code disabled the IRQs but, as Will said,
> such fault in any kernel context looks fragile.
How about take a new lock with irq disabled during BBM, like:

+void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
+{
+    spin_lock_irq(NEW_LOCK);
+    pte_clear(&init_mm, addr, ptep);
+    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+    set_pte_at(&init_mm, addr, ptep, pte);
+    spin_unlock_irq(NEW_LOCK);
+}

