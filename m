Return-Path: <linux-kernel+bounces-163761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA88B6F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39150280E71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC913D240;
	Tue, 30 Apr 2024 10:21:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B94FC02;
	Tue, 30 Apr 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472466; cv=none; b=LNSR0Bb9CgGAElJhfK8JoV4SrPGk6VTAtzYLsA9hu37H62+2bnai69DPlVXB8djXcwOo/Z0opYpjoBEfO/wM7ocJsERf4SePaLtYK4x7n2qsvjx2Pv230sIrEX5Uja2if5uDVffY763jCe1v+ky5VMBAr5r71uz321NBnsw0Ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472466; c=relaxed/simple;
	bh=5SgGxFTDFfPD9ogt5nacJQS8JEFOELIWLGAoJWR92JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws9GuEAvCJMxIA7sGNFPJpL/5y9xcDXQFg6y/t5HpPhq+oo4J0TZ/cWgUfYdv/FPMiHLuh+BQT8eujzBGGVlP72yh601CB+ML8EIdb63Bk4L0UnXmfjxepHfFQGrX02/+4yN68SIcnLhsLwKmgGFfh3dyucRvfeUkJfykh52ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC432F4;
	Tue, 30 Apr 2024 03:21:23 -0700 (PDT)
Received: from [10.57.1.41] (unknown [10.57.1.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27C13F73F;
	Tue, 30 Apr 2024 03:20:50 -0700 (PDT)
Message-ID: <20d44077-d0a8-470a-bf6f-82683db894cf@arm.com>
Date: Tue, 30 Apr 2024 11:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
 <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru>
 <2662a5ba-3115-4fe5-9cec-bff71f703a82@arm.com>
 <CAA8EJprxLvYEP8+ggk8fw--kHaK+_QoYan4st2wWpPicHa6_+w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAA8EJprxLvYEP8+ggk8fw--kHaK+_QoYan4st2wWpPicHa6_+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-30 1:41 am, Dmitry Baryshkov wrote:
> On Tue, 30 Apr 2024 at 01:26, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2024-04-29 5:31 pm, Dmitry Baryshkov wrote:
>>> On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
>>>> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
>>>> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
>>>> which means there should be no harm in achieving the same order of
>>>> operations by running it off the back of iommu_probe_device() itself.
>>>> This then puts it in line with the x86 and s390 .probe_finalize bodges,
>>>> letting us pull it all into the main flow properly. As a bonus this lets
>>>> us fold in and de-scope the PCI workaround setup as well.
>>>>
>>>> At this point we can also then pull the call up inside the group mutex,
>>>> and avoid having to think about whether iommu_group_store_type() could
>>>> theoretically race and free the domain if iommu_setup_dma_ops() ran just
>>>> *before* iommu_device_use_default_domain() claims it... Furthermore we
>>>> replace one .probe_finalize call completely, since the only remaining
>>>> implementations are now one which only needs to run once for the initial
>>>> boot-time probe, and two which themselves render that path unreachable.
>>>>
>>>> This leaves us a big step closer to realistically being able to unpick
>>>> the variety of different things that iommu_setup_dma_ops() has been
>>>> muddling together, and further streamline iommu-dma into core API flows
>>>> in future.
>>>>
>>>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>>>>       is covered as well, with bonus side-effects as above.
>>>> v3: *Really* do that, remembering the other two probe_finalize sites too.
>>>> ---
>>>>    arch/arm64/mm/dma-mapping.c  |  2 --
>>>>    drivers/iommu/amd/iommu.c    |  8 --------
>>>>    drivers/iommu/dma-iommu.c    | 18 ++++++------------
>>>>    drivers/iommu/dma-iommu.h    | 14 ++++++--------
>>>>    drivers/iommu/intel/iommu.c  |  7 -------
>>>>    drivers/iommu/iommu.c        | 20 +++++++-------------
>>>>    drivers/iommu/s390-iommu.c   |  6 ------
>>>>    drivers/iommu/virtio-iommu.c | 10 ----------
>>>>    include/linux/iommu.h        |  7 -------
>>>>    9 files changed, 19 insertions(+), 73 deletions(-)
>>>
>>> This patch breaks UFS on Qualcomm SC8180X Primus platform:
>>>
>>>
>>> [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
>>
>> Hmm, a context fault implies that the device did get attached to a DMA
>> domain, thus has successfully been through __iommu_probe_device(), yet
>> somehow still didn't get the right DMA ops (since that "IOVA" looks more
>> like a PA to me). Do you see the "Adding to IOMMU group..." message for
>> this device, and/or any other relevant messages or errors before this
>> point?
> 
> No, nothing relevant.
> 
> [    8.372395] ufshcd-qcom 1d84000.ufshc: Adding to iommu group 6
> 
> (please ignore the timestamp, it comes before ufshc being probed).
> 
>> I'm guessing there's a fair chance probe deferral might be
>> involved as well. I'd like to understand what path(s) this ends up
>> taking through __iommu_probe_device() and of_dma_configure(), or at
>> least the number and order of probe attempts between the UFS and SMMU
>> drivers.
> 
> __iommu_probe_device() gets called twice and returns early because ops is NULL.
> 
> Then finally of_dma_configure_id() is called. The following branches are taken:
> 
> np == dev->of_node
> of_dma_get_range() returned 0
> bus_dma_limit and dma_range_map are set
> __iommu_probe_device() is called, using the `!group->default_domain &&
> !group_lis` case, then group->default_domain() is not NULL,
> In the end, iommu_setup_dma_ops() is called.
> 
> Then the ufshc probe defers (most likely the PHY is not present or
> some other device is not there yet).

Ah good, probe deferral. And indeed the half-formed hunch from last 
night grew into a pretty definite idea by this morning... patch incoming.

Thanks,
Robin.

> On the next (succeeding) try, of_dma_configure_id() is called again.
> The call trace is more or less the same, except that
> __iommu_probe_device() is not called
> 
>> I'll stare at the code in the morning and see if I can spot any
>> overlooked ways in which what I think might be happening could happen,
>> but any more info to help narrow it down would be much appreciated.
>>
>> Thanks,
>> Robin.
>>
>>> [    3.846880] ufshcd-qcom 1d84000.ufshc: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
>>> [    3.846929] host_regs: 00000000: 1587031f 00000000 00000300 00000000
>>> [    3.846935] host_regs: 00000010: 01000000 00010217 00000000 00000000
>>> [    3.846941] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
>>> [    3.846946] host_regs: 00000030: 0000000f 00000001 00000000 00000000
>>> [    3.846951] host_regs: 00000040: 00000000 00000000 00000000 00000000
>>> [    3.846956] host_regs: 00000050: 032db000 00000001 00000000 00000000
>>> [    3.846962] host_regs: 00000060: 00000000 80000000 00000000 00000000
>>> [    3.846967] host_regs: 00000070: 032dd000 00000001 00000000 00000000
>>> [    3.846972] host_regs: 00000080: 00000000 00000000 00000000 00000000
>>> [    3.846977] host_regs: 00000090: 00000016 00000000 00000000 0000000c
>>> [    3.847074] ufshcd-qcom 1d84000.ufshc: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
>>> [    4.406550] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11
>>> [    4.417953] ufshcd-qcom 1d84000.ufshc: ufshcd_async_scan failed: -11
>>>
> 
> 
> 

