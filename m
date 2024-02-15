Return-Path: <linux-kernel+bounces-66818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363338561D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687811C20627
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B112BF05;
	Thu, 15 Feb 2024 11:36:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DE1EF1D;
	Thu, 15 Feb 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997008; cv=none; b=X6hXGz3Ttaz4RI1jOLlJLX+OjvkUYnwMevemO/w3BnFCiux61i343Yx8TA0OzaNWSQKNRZCzdoHDqOzCSEYpkzAea4zY87Kjxw8ioCQhAw6DT3l2ryTjDV608juWj+guiTGQavpugCD4i83TocZi0EcCg2LgwP/yMN4cz3AY7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997008; c=relaxed/simple;
	bh=XIkDs6gXOoQBSmrBWGt6tw2dOXe9NdTa7wBQ3lRFzNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUk7z5l2eP59QpqG59oEErC+6NdB1o8qAFta1DLnqIdm2h1PJCJ6v9LJlHT/hCHZXPKo94vnXJjsjHYMjmgQxEvuK/7yB9FdP3+37ZAZ4/7yPZ9newpTvWfniBFXoWZ/At+CDXnlR2W7eDKgYjlyHI5yaGprTXG+o/exE2AQMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BD3DA7;
	Thu, 15 Feb 2024 03:37:27 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91AC3F7B4;
	Thu, 15 Feb 2024 03:36:36 -0800 (PST)
Message-ID: <e0be48b9-4871-4124-9d71-8bb7f46ca141@arm.com>
Date: Thu, 15 Feb 2024 11:36:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] dma: avoid redundant calls for sync
 operations
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-3-aleksander.lobakin@intel.com>
 <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com> <20240215050857.GC4861@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240215050857.GC4861@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 5:08 am, Christoph Hellwig wrote:
> On Wed, Feb 14, 2024 at 05:55:23PM +0000, Robin Murphy wrote:
>>>    #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
>>> +#define DMA_F_CAN_SKIP_SYNC		BIT(1)
>>
>> Yuck, please be consistent - either match the style of the existing code,
>> or change that to BIT(0) as well.
> 
> Just don't use BIT() ever.  It doesn't save any typing and creates a
> totally pointless mental indirection.
> 
>> I guess this was the existing condition from dma_need_sync(), but now it's
>> on a one-off slow path it might be nice to check the sync_sg_* ops as well
>> for completeness, or at least comment that nobody should be implementing
>> those without also implementing the sync_single_* ops.
> 
> Implementing only one and not the other doesn't make any sense.  Maybe
> a debug check for that is ok, but thing will break badly if they aren't
> in sync anyway.

In principle we *could* have an implementation which used bouncing 
purely to merge coherent scatterlist segments, thus didn't need to do 
anything for single mappings. I agree that it wouldn't seem like a 
particularly realistic thing to do these days, but I don't believe the 
API rules it out, so it might be nice to enforce that assumption 
somewhere if we are actually relying on it (although I also concur that 
this may not necessarily be the ideal place to do that in general).

Thanks,
Robin.

