Return-Path: <linux-kernel+bounces-79589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233ED862488
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E42283E59
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913D288DB;
	Sat, 24 Feb 2024 11:32:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E125565;
	Sat, 24 Feb 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774345; cv=none; b=nMbYfGaM+8TwjhFi6A59dIzm3tBHpXxfzR4bxsflG5ykS3rk7PYijXjxDhM1sPDHInvX/6VdhSlkjKbF3gxx+Pkkrl5KsLvupLMn+m9yNmuRisnEjSEUZEfK5LY3e7238JTQA9cR1CckD8/Ta2qgVBLhR07b3shXZsqk9/vZt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774345; c=relaxed/simple;
	bh=qiUyNOxOsyW8Q0pv98stm8EGK98wmzKW8rG06TDEmOM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mxc7NSJlPtlC12JV67mWQyg9cFsZCWBn08NOk+aE3h4vOr5Bg4J23JAp2WSgTgx+IkD3v3EMSf+73x2IMfFUt1HZgBSY1tyYb4O857kdROv1NasTWRjxxVqkhXMwTKlviLLMLXUKthVtvcI3xjKIFZt68Ri2W8MMb99LUXMHIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Thl6S0htHz1h0Ct;
	Sat, 24 Feb 2024 19:30:08 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E0851A016B;
	Sat, 24 Feb 2024 19:32:19 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 19:32:18 +0800
Subject: Re: [PATCH v3 0/7] dma-mapping: Simplify arch_setup_dma_ops()
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
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
	<devicetree@vger.kernel.org>
References: <cover.1707493264.git.robin.murphy@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1ae0973c-a440-3f12-6d78-e780ddc0a16d@huawei.com>
Date: Sat, 24 Feb 2024 19:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1707493264.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/2/10 0:49, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1702486837.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v3, rebased and fixing the thinko from v2, so unless anything
> else has changed behind my back I hope it's good to go (via the IOMMU
> tree, as mentioned before).

Compiled with/without ACPI enabled, and test this patch set on an
ARM64 server with ACPI booting, looks good.

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

