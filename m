Return-Path: <linux-kernel+bounces-163915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B48B75CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CD41F22E14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0C171094;
	Tue, 30 Apr 2024 12:33:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9213F43D;
	Tue, 30 Apr 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480416; cv=none; b=jd63u0s0r7LcQKQ1BzsavQNLzKucYwjiltVil678WUqLAlCKMweqeS81q/lQYvU8IcZvHAZ+iEFQkthv2I+WysEIAHShBaWZ/oES74FNyq86E9faJ2ZdK0PRsaGqlpNQEKHOYv8PAsloUCJQFWRvNGDdyjkmDFqQJIGSxgJ4f8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480416; c=relaxed/simple;
	bh=XCtNuj3lTXBimhOP7jPh4zKAQ74LdIqixQXmV3pfcfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pixCCbdDr9KhWApF6ni1bZQfQjtfUzi/OFcuoeS9gfOWJD/aq1lcO3ywqYbIRVLoEKv+BfmG4S2KbJedDU7Qs/JjSexX1IWLxWGIBKMcIgvAs3kKVJPGP+ZuiA0DRVm/unSwFRD7icz0J3N2oJxeariFG6c/vO8guPsOL6q1p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DCD52F4;
	Tue, 30 Apr 2024 05:33:59 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59BDC3F73F;
	Tue, 30 Apr 2024 05:33:28 -0700 (PDT)
Message-ID: <1e691960-bc52-4e5c-89d7-ecd3f7dc9f56@arm.com>
Date: Tue, 30 Apr 2024 13:33:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
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
 <CAA8EJprL8NbNfOvp17hrHoVNkKBpD39xfeu+STm6m9VObF2n9Q@mail.gmail.com>
 <ebc8813c-74eb-49d1-b8d0-a6f1821f711a@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ebc8813c-74eb-49d1-b8d0-a6f1821f711a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/04/2024 1:23 pm, Konrad Dybcio wrote:
> On 29.04.2024 11:26 PM, Dmitry Baryshkov wrote:
>> On Mon, 29 Apr 2024 at 19:31, Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>
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
>>>>      is covered as well, with bonus side-effects as above.
>>>> v3: *Really* do that, remembering the other two probe_finalize sites too.
>>>> ---
>>>>   arch/arm64/mm/dma-mapping.c  |  2 --
>>>>   drivers/iommu/amd/iommu.c    |  8 --------
>>>>   drivers/iommu/dma-iommu.c    | 18 ++++++------------
>>>>   drivers/iommu/dma-iommu.h    | 14 ++++++--------
>>>>   drivers/iommu/intel/iommu.c  |  7 -------
>>>>   drivers/iommu/iommu.c        | 20 +++++++-------------
>>>>   drivers/iommu/s390-iommu.c   |  6 ------
>>>>   drivers/iommu/virtio-iommu.c | 10 ----------
>>>>   include/linux/iommu.h        |  7 -------
>>>>   9 files changed, 19 insertions(+), 73 deletions(-)
>>>
>>> This patch breaks UFS on Qualcomm SC8180X Primus platform:
>>>
>>>
>>> [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
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
>>
>> Just to confirm: reverting f091e93306e0 ("dma-mapping: Simplify
>> arch_setup_dma_ops()") and b67483b3c44e ("iommu/dma: Centralise
>> iommu_setup_dma_ops()" fixes the issue for me. Please ping me if you'd
>> like me to test a fix.
> 
> This also triggers a different issue (that also comes down to "ufs bad") on
> another QC platform (SM8550):
> 
> [    4.282098] scsi host0: ufshcd
> [    4.315970] ufshcd-qcom 1d84000.ufs: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
> [    4.330155] host_regs: 00000000: 3587031f 00000000 00000400 00000000
> [    4.343955] host_regs: 00000010: 01000000 00010217 00000000 00000000
> [    4.356027] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
> [    4.370136] host_regs: 00000030: 0000000f 00000003 00000000 00000000
> [    4.376662] host_regs: 00000040: 00000000 00000000 00000000 00000000
> [    4.383192] host_regs: 00000050: 85109000 00000008 00000000 00000000
> [    4.389719] host_regs: 00000060: 00000000 80000000 00000000 00000000
> [    4.396245] host_regs: 00000070: 8510a000 00000008 00000000 00000000
> [    4.402773] host_regs: 00000080: 00000000 00000000 00000000 00000000
> [    4.409298] host_regs: 00000090: 00000016 00000000 00000000 0000000c
> [    4.415900] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x8851093e0, fsynr=0x3b0001, cbfrsynra=0x60, cb=2
> [    4.416135] ufshcd-qcom 1d84000.ufs: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
> [    4.951750] ufshcd-qcom 1d84000.ufs: ufshcd_verify_dev_init: NOP OUT failed -11
> [    4.960644] ufshcd-qcom 1d84000.ufs: ufshcd_async_scan failed: -11
> 
> Reverting the commits Dmitry mentioned also fixes this.

Yeah, It'll be the same thing - doesn't really matter exactly *how* the 
UFS goes wrong due to the SMMU blocking it, the issue is that the SMMU 
is erroneously blocking it in the first place due to a DMA ops mixup. 
Fix is now here:

https://lore.kernel.org/linux-iommu/d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com/

Thanks,
Robin.

