Return-Path: <linux-kernel+bounces-79615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5D8624B7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E1CB21ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A2374F8;
	Sat, 24 Feb 2024 11:47:40 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EB29431;
	Sat, 24 Feb 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775259; cv=none; b=m2CbEaA8yFYfaB/x3bR82QuCl3mcXMqYqDTIEJDxhTWkiSRG4sIJoKo2Te0ze50FCZkM51MxVZrkzDdE7JBN8rBQ9t4R73tU36WwM7nsn9kPptCqRvggvQzhF2Qaj7ZyFSv3MbA9669zVRSIoh3pR35BPkeCH7wHm/+SuKZnWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775259; c=relaxed/simple;
	bh=9cqKCErocqPNNEG9BvS/09Xa2+C39jZH7JHgM7Zy5GA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pH9/gcaFdhcr0N+ZZpDwxy+f2VOT+8rmQ9NfwA6aQ/DdGBuO/FSysp3svFCHh5oTuYvlSXXtxLmuHAT95ueyXqEm6a1BGd7V//MTZfdrKAyMf2G+WU3J2+lFyK0Ars8kFocQ9Tn260f8PYXTJFDBF4rXdzvKbVz85nKpZSNHbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ThlSp3ShJzNllG;
	Sat, 24 Feb 2024 19:46:02 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id C97211400DD;
	Sat, 24 Feb 2024 19:47:28 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 19:47:27 +0800
Subject: Re: [PATCH v3 4/7] dma-mapping: Add helpers for dma_range_map bounds
To: Robin Murphy <robin.murphy@arm.com>
CC: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep
 Holla <sudeep.holla@arm.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <cc90d296daa52e9cfe9fdd6681c68df4773a5e6a.1707493264.git.robin.murphy@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6e837f8b-b855-99b6-6f73-721de97b3fa4@huawei.com>
Date: Sat, 24 Feb 2024 19:47:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cc90d296daa52e9cfe9fdd6681c68df4773a5e6a.1707493264.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/2/10 0:50, Robin Murphy wrote:
> Several places want to compute the lower and/or upper bounds of a
> dma_range_map, so let's factor that out into reusable helpers.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: fix warning for 32-bit builds
> ---
>   arch/loongarch/kernel/dma.c |  9 ++-------
>   drivers/acpi/arm64/dma.c    |  8 +-------
>   drivers/of/device.c         | 11 ++---------
>   include/linux/dma-direct.h  | 18 ++++++++++++++++++
>   4 files changed, 23 insertions(+), 23 deletions(-)

For the ARM64 code,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

