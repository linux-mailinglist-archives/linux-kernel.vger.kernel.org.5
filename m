Return-Path: <linux-kernel+bounces-80614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC3866A63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75505B21846
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DE1BDD6;
	Mon, 26 Feb 2024 07:03:12 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284981BDCE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930992; cv=none; b=aohT2w9CrdrpaizIgV51Vt99yknj3jQRJGl2nVd4u6WFHywrf9BJkL6PDJUZlvqYTdGQctdDva2EvHYnRvA3JVygZI/P1r02uG5/0MH0QnYIwucsw5vZ0QcPyNbjc+Tg2pyQ2SFjYlXl3dHmApU2PfIDn2CzIXOjJGpe0C+G0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930992; c=relaxed/simple;
	bh=1DtOKBCxpfL5fIkR2Rryk2XB5jCDrHQvAcOgOxHdaUE=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=A5qCHTGbPcn5jo/7wEodECwC3WgyjEMNMIwF49kpAIHe6y3vWT1Fwt5SPOalggbPPB+B++n7zQESiUkmXAxhh5FND3qKy+k0Pu1IvgxeF2G3Bbw6uQ0R+AymdOKYOC/klnPPxV8uuUIAz+EgqGMfwZrQqaAIrhMkytzoeh0WqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tjs4k0Y49zqjgw;
	Mon, 26 Feb 2024 15:02:30 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
	by mail.maildlp.com (Postfix) with ESMTPS id 569081400F4;
	Mon, 26 Feb 2024 15:03:06 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 15:03:05 +0800
Message-ID: <5a1d28b7-1e6e-da39-9b34-f86470163bb1@huawei.com>
Date: Mon, 26 Feb 2024 15:03:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: <liuyongqiang13@huawei.com>
CC: <arnd@arndb.de>, <keescook@chromium.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>, <rppt@linux.ibm.com>,
	<sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>, <willy@infradead.org>,
	<yanaijie@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20240223063608.2605736-1-liuyongqiang13@huawei.com>
Subject: Re: [PATCH v2] arm: flush: check if the folio is reserved for
 no-mapping addresses
Reply-To: <20240223063608.2605736-1-liuyongqiang13@huawei.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <20240223063608.2605736-1-liuyongqiang13@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500011.china.huawei.com (7.185.36.84)

Since some abuses of pfn_valid() have been reported, I check all the use 
of pfn_valid(), and find some suspicious cases.

phys_mem_access_prot() defined in arch/arm/mm/mmu.c returns 
pgprot_noncached() when pfn_valid() returns false.
I think it’s purpose is to return pgprot_noncached() when the pfn is not 
in RAM, and the use of pfn_valid() is incorrect.
Notably, phys_mem_access_prot() defined in arm64 uses 
pfn_is_map_memory() instead of pfn_valid() since commit
873ba463914c (arm64: decouple check whether pfn is in linear map from 
pfn_valid()).

Similarly, virt_addr_valid() defined in arm64 uses pfn_is_map_memory() 
instead of pfn_valid() since commit
873ba463914c (arm64: decouple check whether pfn is in linear map from 
pfn_valid()), But virt_addr_valid() still
uses pfn_valid(). Besides, the implementation of x86 also uses pfn_valid().

update_mmu_cache_range() defined in arch/arm/mm/fault-armv.c checks 
pfn_valid() and then calls __flush_dcache_folio().
This case is similar to the case reported by Yongqiang Liu, the pfn may 
not be a RAM pfn, and the system will crash in
__flush_dcache_folio() due to the kernel linear mapping is not 
established. virt_addr_valid() is used to check whether a
vrtual address is valid linear mapping. Are these uses of pfn_valid() 
incorrect?

pfn_modify_allowed() defined in arch/x86/mm/mmap.c checks pfn_valid(), 
and the comment says it is intended to check
whether the pfn is in real memory. So the use of pfn_valid() should be 
incorrent. This case is only involved when the cpu
is affected by X86_BUG_L1TF.

try_ram_remap() defined in kernel/iomem.c returns the linear address 
when three checks are passed. One of the checks is
pfn_valid(). The only caller memremap() guarantees the pfn passed to 
try_ram_remap() is in RAM, but the pfn may be in
NOMAP memory regions and is not mapped in linear mapping. commit 
260364d112bc (arm[64]/memremap: don't abuse
pfn_valid() to ensure presence of linear map) solves it by checking in 
arch_memremap_can_ram_remap(), However, if other
architectures involve this issue?

Do these suspicious case abuse pfn_valid() really? Thanks


