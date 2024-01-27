Return-Path: <linux-kernel+bounces-41067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BD83EB26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6412D28631B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD313AE2;
	Sat, 27 Jan 2024 05:04:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0C33D5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331862; cv=none; b=tRKxOp3Qy/KyZOBk/6uow8GTAlDQn78GwSq2S44Y9odzQ6277DAbxlDrMqXIaq7Tf6yOoyP/FvBh6TvTpe894lU5G8JHFKxxMhjHqOS7r1PsX1Qjyt1RK9aM6QE6iR3qp6+DS25RnHxIsM6HxhT2yU6CEtaMW2l/AwFYSgsmJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331862; c=relaxed/simple;
	bh=J2unJM+3mMjNZeHB7lKLolhX8D8xRXo3BGhcnnVVfHA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D44ylbyML8v6YXoLoWUm+e2F5ai27un3re+lv7bAvWZidEYpZBuzOA2L2xfqX6Qs4KVhQ7OCIULMf8m6zy8w7Mp/glygIGHDHf7vSM1OpMYme/atGHPzYlhkGW+yaa+oA6kvPQLswUFI4NktpS3h7oN17geHQc9eGT1NhCoahK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TMMrK55wkzvVNC;
	Sat, 27 Jan 2024 13:02:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id DECCE140153;
	Sat, 27 Jan 2024 13:04:16 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 13:04:15 +0800
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <will@kernel.org>, <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
Date: Sat, 27 Jan 2024 13:04:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbKjHHeEdFYY1xR5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)


On 2024/1/26 2:06, Catalin Marinas wrote:
> On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
>> HVO was previously disabled on arm64 [1] due to the lack of necessary
>> BBM(break-before-make) logic when changing page tables.
>> This set of patches fix this by adding necessary BBM sequence when
>> changing page table, and supporting vmemmap page fault handling to
>> fixup kernel address translation fault if vmemmap is concurrently accessed.
> I'm not keen on this approach. I'm not even sure it's safe. In the
> second patch, you take the init_mm.page_table_lock on the fault path but
> are we sure this is unlocked when the fault was taken?
I think this situation is impossible. In the implementation of the 
second patch, when the page table is being corrupted
(the time window when a page fault may occur), vmemmap_update_pte() 
already holds the init_mm.page_table_lock,
and unlock it until page table update is done.Another thread could not 
hold the init_mm.page_table_lock and
also trigger a page fault at the same time.
If I have missed any points in my thinking, please correct me. Thank you.
> Basically you can
> get a fault anywhere something accesses a struct page.
>
> How often is this code path called? I wonder whether a stop_machine()
> approach would be simpler.
As long as allocating or releasing hugetlb is called.  We cannot limit 
users to only allocate or release hugetlb
when booting or not running any workload on all other cpus, so if use 
stop_machine(), it will be triggered
8 times every 2M and 4096 times every 1G, which is probably too expensive.
I saw that on the X86, in order to improve performance, optimizations 
such as batch tlb flushing have been done,
means that some users are concerned about the performance of hugetlb 
allocation:
https://lwn.net/ml/linux-kernel/20230905214412.89152-1-mike.kravetz@oracle.com/ 

> Andrew, I'd suggest we drop these patches from the mm tree for the time
> being. They haven't received much review from the arm64 folk. Thanks.
>

