Return-Path: <linux-kernel+bounces-83404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F23869874
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54641C20B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298A145B2A;
	Tue, 27 Feb 2024 14:32:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61754FB1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044319; cv=none; b=LA5vNSxoh9pCD/MLyCe4u1Mj4bhlbJ/RlBbAEM4QFp5QNj7VZKHlW6yoZq5DPKAtejpnWg9TjnSF1j3tGUIt3PMjrLcTsRifto9NukOvH+8JA/hKGrkiumjnbyxO9Nmj00WTIIalDvxVHUGlZNoTIcgdV4uaVjtgtcRsZujZxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044319; c=relaxed/simple;
	bh=5s1WfC0bNWhKXd1aBpLQlibA7UpFtwbhdLkRt20XhEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0ROvORcuHERPOalOluJV77UfAZLOjfj+E/KNRafSzBQxA1ejVFPCIa9KG+/w6MjhinTPXmY4HLPU+nMvsisYM6UgeMIQOcUtOy9iUmFWfrzW6Tqe/rh6e+8QoXW69Hq40O1Wr4vFRB5VnxIF//VAU9uFg8T2tou97m2wvx84U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DABADA7;
	Tue, 27 Feb 2024 06:32:35 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94E743F762;
	Tue, 27 Feb 2024 06:31:55 -0800 (PST)
Message-ID: <602448f1-60a9-41a1-85d2-1205250985d3@arm.com>
Date: Tue, 27 Feb 2024 14:31:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per
 dev
Content-Language: en-GB
To: Howard Yen <howardyen@google.com>, Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, gregkh@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org,
 james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de>
 <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de>
 <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
 <20240223063723.GB11004@lst.de>
 <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 1:39 pm, Howard Yen wrote:
> On Fri, Feb 23, 2024 at 2:37 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
>>> The reason why I tried to propose this patch is that in the system I'm
>>> working on, where the driver utilizes the coherent reserved memory in
>>> the subsystem for DMA, which has limited memory space as its primary
>>> usage. During the execution of the driver, there is a possibility of
>>> encountering memory depletion scenarios with the primary one.
>>>
>>> To address this issue, I tried to create a patch that enables the
>>> coherent reserved memory driver to support multiple coherent reserved
>>> memory regions per device. This modification aims to provide the
>>> driver with the ability to search for memory from a secondary region
>>> if the primary memory is exhausted, and so on.
>>
>> This all seems pretty vague.  Can you point to your driver submission
>> and explain why it can't just use a larger region instead of multiple
>> smaller ones?
>>
> 
> The reason why it needs multiple regions is that in my system there is
> an always-on subsystem which includes a small size memory, and several
> functions need to run and occupy the memory from the small memory if
> they need to run on the always-on subsystem. These functions must
> allocate the memory from the small memory region, so that they can get
> benefit from the always-on subsystem. So the small memory is split for
> multiple functions which are satisfied with their generic use cases.

I don't really see how that aligns with what you've implemented, though. 
The coherent allocator doesn't have any notion of the caller's use-case, 
it's just going to allocate from wherever it happens to find space 
first. Thus even the calls which would somehow benefit from allocating 
from the "primary" region will have no way to guarantee that they will 
actually allocate from there if it's already been consumed by callers 
who didn't need that benefit but just happened to get there first.

Really that sounds like a case for having specific named memory-regions 
and managing them directly from the relevant driver, rather than trying 
to convince the generic dma-coherent abstraction to do things that don't 
really fit it. Otherwise I'd be slightly concerned that you're expecting 
to bake secret undocumented ABI into DMA API implementations where some 
particular order of allocations must guarantee a particular 
deterministic behaviour, which is really not something we want.

Thanks,
Robin.

> But in specific use cases, they required more memory than their
> pre-allocated memory region, so I tried to propose this patch to give
> it the ability to get the memory from another larger memory to solve
> the issue.
> 
> I'll upload the next version to show the modification in the driver.
> 
> ---
> Best Regards,
> 
> Howard

