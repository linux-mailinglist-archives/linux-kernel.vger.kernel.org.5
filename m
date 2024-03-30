Return-Path: <linux-kernel+bounces-125563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF18928BC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5441F225E7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1E1C3D;
	Sat, 30 Mar 2024 01:19:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9315A5;
	Sat, 30 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711761591; cv=none; b=LCC5ZHnKkaGMEUBh5cK26pjw46vqdNKtq5rQ6pgWwr+eiIhaF03ZmUT7aBBse+4KijKCXdLUI/jninUfAr7isbe6UBmP20vsxvhSnXFuWpQSyACu6ihmcB/FMAEb7sORyfmY2r5WDUdG4tEBcRjA+mFr2HsVqAkBtE5Psg+9Yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711761591; c=relaxed/simple;
	bh=SzSwPqnfalelzzooJos0UDdLGmQNrWe+krnbkhcDrLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NGVqP4OqPVZRQde6eTIZyy+6NrRvPGUF64Yttvfyr2BZpfiqtl7w/Gq2tc2BWJ8+6eTb9w7r16/EhkEiQ31e35gj+bTAuaFB/cpcW64vGuEh4h+d8K48HxP8EorQCV9WHtTgmZDLAh/ap1gKptKil/lfv+o9yQzDmk88v3a+y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V5ztt1rQtzbdZy;
	Sat, 30 Mar 2024 09:18:46 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 423D3140382;
	Sat, 30 Mar 2024 09:19:39 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 09:19:38 +0800
Message-ID: <8c424dfd-8ca0-6614-903f-a37dac818d27@huawei.com>
Date: Sat, 30 Mar 2024 09:19:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Content-Language: en-US
To: Dexuan Cui <decui@microsoft.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<mhklinux@outlook.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240329192809.17318-1-decui@microsoft.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/3/30 3:28, Dexuan Cui wrote:

> Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
> io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
> which is actually a negative number if we use "%ld" to print the number.
>
> When swiotlb_create_default_debugfs() is running from late_initcall,
> mem->total_used may already be non-zero, because the storage driver
> may have already started to perform I/O operations: if the storage
> driver is built-in, its probe() callback is called before late_initcall.
>
> swiotlb_create_debugfs_files() should not blindly set mem->total_used
> and mem->used_hiwater to 0; actually it doesn't have to initialize the
> fields at all, because the fields, as part of the global struct
> io_tlb_default_mem, have been implicitly initialized to zero.
>
> Also don't explicitly set mem->transient_nslabs to 0.
>
> Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water marks in debugfs")
> Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient pool usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: ZhangPeng<zhangpeng362@huawei.com>

-- 
Best Regards,
Peng


