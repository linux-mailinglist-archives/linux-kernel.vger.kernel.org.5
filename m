Return-Path: <linux-kernel+bounces-79599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF48624A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8621F225C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447D364C1;
	Sat, 24 Feb 2024 11:43:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9336AF3;
	Sat, 24 Feb 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775015; cv=none; b=SPnjWPwY5DRtks1YHAQPRCnBKn2UWBaj88wM+0x0kIeJnQXdclMJsDNeVlHfH+Sf0Rg+IxorCsz9JKTDneWexEUwhvdWK+LGeg1PrfLcanL2zcgWXQoSpcEhUb6rTYU+bGaqKZlG3vMR2EzSwfQCTsQTHewCVQwFGvC+/WyxNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775015; c=relaxed/simple;
	bh=8VJckfJvcNBhFjZ7UyOVWAMSOuwa6K1jsyFc/kuZ1nI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MSD755z819rWy5CqUkm3G7g9h3FUNnu/l2rwrTL8XEVwse2vShjABXuxZP6crKZlOuW5hbkRAhXvnQFMCS8bfq1BMAQDux6uNGeAziSONPCLS9E3ikkKYmBRYGC06sFXpTKPXKv2vIDU+F3KlvpqkhETn4Ribfzde/CwSLPCi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ThlJB2rwSz1FLF6;
	Sat, 24 Feb 2024 19:38:34 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 65BE41A016B;
	Sat, 24 Feb 2024 19:43:29 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 19:43:28 +0800
Subject: Re: [PATCH v3 3/7] ACPI/IORT: Handle memory address size limits as
 limits
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
	<devicetree@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <5d52d580bf33d475053f9b05188fe3541cbe8798.1707493264.git.robin.murphy@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ab2099fd-b0b7-63d3-bdba-a4462ec230a8@huawei.com>
Date: Sat, 24 Feb 2024 19:43:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d52d580bf33d475053f9b05188fe3541cbe8798.1707493264.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/2/10 0:50, Robin Murphy wrote:
> Return the Root Complex/Named Component memory address size limit as an
> inclusive limit value, rather than an exclusive size. This saves having
> to fudge an off-by-one for the 64-bit case, and simplifies our caller.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Avoid undefined shifts (grr...)
> ---
>   drivers/acpi/arm64/dma.c  |  9 +++------
>   drivers/acpi/arm64/iort.c | 20 ++++++++++----------
>   include/linux/acpi_iort.h |  4 ++--
>   3 files changed, 15 insertions(+), 18 deletions(-)

This also makes the code easier to read,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

