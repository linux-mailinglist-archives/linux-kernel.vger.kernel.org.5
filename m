Return-Path: <linux-kernel+bounces-166752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56938B9EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E52818A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D816FF3D;
	Thu,  2 May 2024 16:54:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326616FF31
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668849; cv=none; b=ttXfz7ago0zKTyi8nCRpj7LIrz+PUZ9Lg6zM0rBmhklZdEgf1pg2yDkV/Ksn7zbDwukU8ffQBglkdXjZ5ouRhQJo4jKKlDy7pACzZ+lBRoFBqgsnyDRQ9oDJ1RgbkApdACAKrec+xd+F9LAKZ6G8HZ11nzTKac4Vzx+GaTmqZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668849; c=relaxed/simple;
	bh=l1CPckp3dTeYiSe/PHWaoMvfitR5UYB7yVRhd2wYVik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raolW9buJ1reOfdre+CtkFiw9sXB2YSiBl7aDB83MY+1o4L2Nyf6h2BHQ082JJ9SVk/VPkXTVNBdIR9itp01CqnqOmN4zZTHpM5PNmM7PXUI+V6TQjCkMOzg0UY3rXvg/wVbYpY3WYleP/pFXpokpDcdcbCL1FSOK5cV39jhQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D0A2F4;
	Thu,  2 May 2024 09:54:32 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4AA3F793;
	Thu,  2 May 2024 09:54:06 -0700 (PDT)
Message-ID: <ccb525ff-d0d0-44b1-a210-14c7670b80f0@arm.com>
Date: Thu, 2 May 2024 17:54:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, isaacmanjarres@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240501201319.586289-1-tjmercier@google.com>
 <ZjMfl2G377qexhi-@infradead.org>
 <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
 <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/05/2024 5:02 pm, T.J. Mercier wrote:
> On Thu, May 2, 2024 at 5:50 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 02/05/2024 6:07 am, Christoph Hellwig wrote:
>>> On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
>>>> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
>>>> checking if force_bounce is set for the device is not part of that
>>>> condition. Check if devices have requested to force SWIOTLB use as part
>>>> of deciding to take the existing SWIOTLB paths.
>>>
>>> This fails to explain why you'd want this somewhat surprising behavior,
>>> and why you consider it a bug fix.
>>
>> Indeed, it's rather intentional that the "swiotlb=force" argument
>> doesn't affect iommu-dma, since that's primarily for weeding out drivers
>> making dodgy assumptions about DMA addresses, and iommu-dma is
>> inherently even better at that already.
>>
>> Beyond that I think this change also seems likely to interact badly with
>> CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE flag
>> for dma-direct, but expect that an IOMMU can provide a decrypted view
>> in-place, thus bouncing in that path would be unnecessarily detrimental.
>>
>> Thanks,
>> Robin.
> 
> I encountered this while testing a change to DMA direct which makes
> sure that sg_dma_mark_swiotlb is called there like it is here. (Right
> now the SG_DMA_SWIOTLB flag is set only if dma_map_sgtable takes the
> IOMMU path, but not if SWIOTLB is used on the direct path.) While I
> agree IOMMU + force_bounce is an unusual config, I found it equally
> surprising that swiotlb=force wasn't doing what is advertised, or even
> giving a warning/error. Since the iommu-dma code is already set up for
> conditionally bouncing through SWIOTLB, it looked straightforward to
> give what's asked for in the case of swiotlb=force. If it's
> intentional that SWIOTLB options don't affect IOMMU code, then should
> we just warn about it here when it's ignored? The presence of a
> warning like that would also be a suggestion of, "you probably don't
> actually want what you're asking for with this configuration you've
> specified".

Traditionally, user-facing "SWIOTLB" refers to what is now dma-direct, 
in its context of bouncing to make DMA mappings accessible to devices 
with memory access limitations. The fact that the IOMMU implementations 
(originally Intel, now iommu-dma) also co-opted some of the SWIOTLB 
machinery for the very different purpose of isolation of memory 
*outside* non-page-aligned DMA mappings was always more of an internal 
implementation detail.

The newest use for enforcing non-coherent cacheline alignment blurs the 
boundary a little since its purpose is again largely orthogonal to those 
cases, however it's also one to which "swiotlb=force" is semantically 
kind of meaningless once you think about it (how does one forcibly align 
a buffer which is already suitably aligned?)

If there's any issue here I'd say it's only that the description in 
kernel-parameters.txt still hasn't been updated since "automatically 
used by the kernel" *did* solely imply a device DMA mask limitation.

Thanks,
Robin.

