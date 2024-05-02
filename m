Return-Path: <linux-kernel+bounces-166470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561208B9B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB79D1F217EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2E82483;
	Thu,  2 May 2024 12:50:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71BB6A8AC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654252; cv=none; b=us2LSeTRos9thP+tvS+arp7xz1G0+N3rkJp5Vvw51q7JPsrNwH0dR5p4fCEj69Ffu5lmHMNrWqTGEBbeJjTvx2cDuYCWNELVHZzyXI7aKfdQrfunuLXDwF7CtJS06+xbndzeoLxt9Ct05ap4QqAcR3rao5haMtFzfgVM/8hNuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654252; c=relaxed/simple;
	bh=m/a0B/l1IBvnIQwe/oxF5PawDKzGaXpKpMSPcwifgEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+bbKU9Xefdo57K5F4q7lCrftFzIXs4dhDTWLwYOamXrStolVD5577sdVmV+dXXkE9Yls2uN3VVuFe6gczWYfUaA770W5JJaxySSVLEkUDeq/hlGbsl5x5PJs/TBOsBG7ld2EAUperjiXDLAO2xH+IyJDZTJt7zgTfwng/p1bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94402F4;
	Thu,  2 May 2024 05:51:14 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02FD23F71E;
	Thu,  2 May 2024 05:50:47 -0700 (PDT)
Message-ID: <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
Date: Thu, 2 May 2024 13:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: Christoph Hellwig <hch@infradead.org>, "T.J. Mercier"
 <tjmercier@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, isaacmanjarres@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240501201319.586289-1-tjmercier@google.com>
 <ZjMfl2G377qexhi-@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZjMfl2G377qexhi-@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2024 6:07 am, Christoph Hellwig wrote:
> On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
>> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
>> checking if force_bounce is set for the device is not part of that
>> condition. Check if devices have requested to force SWIOTLB use as part
>> of deciding to take the existing SWIOTLB paths.
> 
> This fails to explain why you'd want this somewhat surprising behavior,
> and why you consider it a bug fix.

Indeed, it's rather intentional that the "swiotlb=force" argument 
doesn't affect iommu-dma, since that's primarily for weeding out drivers 
making dodgy assumptions about DMA addresses, and iommu-dma is 
inherently even better at that already.

Beyond that I think this change also seems likely to interact badly with 
CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE flag 
for dma-direct, but expect that an IOMMU can provide a decrypted view 
in-place, thus bouncing in that path would be unnecessarily detrimental.

Thanks,
Robin.

