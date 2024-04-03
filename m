Return-Path: <linux-kernel+bounces-130235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C108975C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18AB1F213EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CB5152172;
	Wed,  3 Apr 2024 16:58:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73E1514F6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163533; cv=none; b=AKP4gz36UaZ1FZM3cZq/DF/P5mxSYLkeD/cyhqW8y6qs9xB6uUDAnusukDtDDn+rvJ/Q+N4imQaZDXR+tflThBeEA5+9kuscsX/yZCbWxB1NoR9MX81qF8PcR9b/UvhpbytRIAUkBxg/UoX52EF01xQ94sV7xwJfNH086by8zTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163533; c=relaxed/simple;
	bh=7VwqYKFNF/DpXJhubaLW94Yg1HPcTUhPVuRncO3Zdrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyGLufumIOMaDyYbn2h2MCTE4EDMVUetQrwXcUktkT+U/yl6wBVl1R/9SLd/++9Hr/ZcFYUHZ8LFpH4LGp22t15fgfNvGCRDVqx1/Ynu6wUrGq4HLvpCNqnpBxbdoKaXJnqQb1qOwakfsrNMwGxVl4qhlfwtKOlSsOoOu+FjWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E011688;
	Wed,  3 Apr 2024 09:59:22 -0700 (PDT)
Received: from [10.57.54.62] (unknown [10.57.54.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5373F64C;
	Wed,  3 Apr 2024 09:58:49 -0700 (PDT)
Message-ID: <69d3bcc5-5b5b-4b52-93fe-4a095e7ccdc6@arm.com>
Date: Wed, 3 Apr 2024 17:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] swiotlb: add a KUnit test suite
Content-Language: en-GB
To: Linu Cherian <lcherian@marvell.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Will Deacon <will@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <20240313092740.192-1-petrtesarik@huaweicloud.com>
 <20240326030851.GA64024@hyd1403.caveonetworks.com>
 <20240326130635.64fb3a98@meshulam.tesarici.cz>
 <PH0PR18MB50024739F4DCF8FCEB6F0CADCE3D2@PH0PR18MB5002.namprd18.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR18MB50024739F4DCF8FCEB6F0CADCE3D2@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-03 3:19 pm, Linu Cherian wrote:
[...]
>>> Should we not try this on a buffer that is mapped with DMA_FROM_DEVICE ?
>>
>> I'm afraid I don't follow.
>>
>> AFAICT the direction is a property of the sync operation. In fact,
>> swiotlb_tbl_map_single() does not even use its direction parameter at all.
>> Removing that parameter is already on my TODO list of cleanups.
>>
> 
> Okay. Got it.
> 
>> swiotlb_map() uses its direction parameter only to perform the initial arch
>> sync if DMA is non-coherent.
>>
>> OTOH I may be missing some high-level logical concepts which do not
>> correspond to any actual code in the swiotlb implementation, so my use is still
>> wrong.
>>
> 
> Just thought that the keeping the DMA direction consistent for the map and sync would be more aligned to typical use case.
> For example, a buffer used for transmit in case of networking. OTOH, since the API by itself doesn't have such constraints on the direction parameter, may be it makes sense to test those scenarios.

Right, SWIOTLB exists to serve the DMA API, so it makes more sense to me 
to test it in the context of valid DMA API usage than to make up 
scenarios that aren't representative of real-world usage. The direction 
is a property of the whole DMA mapping itself, and thus must be passed 
consistently for every operation on a given mapping.

Yes, there is some internal trickery once we get down to the level of 
calling swiotlb_bounce() itself, but if we're driving the tests through 
the higher-level public interface then I'd prefer to see that used as 
expected. Given the whole partial-write-transparency business, the most 
significant effect of direction should just be that of DMA_TO_DEVICE 
skipping the copy-out for unmap and sync_for_cpu, so for the sake of 
coverage you may as well just use DMA_BIDIRECTIONAL everywhere.

Thanks,
Robin.

