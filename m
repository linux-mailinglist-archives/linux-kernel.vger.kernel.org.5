Return-Path: <linux-kernel+bounces-122496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4B88F884
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81B21F25E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72750A79;
	Thu, 28 Mar 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFqhem1N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C223765;
	Thu, 28 Mar 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610606; cv=none; b=C/FTcnYIzyiYCMblDUQjd/H5xah2ojUTdyZG3mtWTE/NcdOJSmnzz4e9QtamRHBptUfk1oY4A8E0kpcqJCp1UAVk7pQUde9O/cdWeW95IkuZFFZfCfV+RrTBWLEMIOWqHxmPwCVANj/t6LyF1RsyU8sk7L+Pz6axPBmJ0nc1Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610606; c=relaxed/simple;
	bh=/DBxafWugaS+NBr6xZbPt8hjTlXm4/2YAaTmuUh1cZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIHcCASN1s2R22WjbbCTVytXh5NgenUvfXCinLB0r0zdSvwUJeA7rzcXFt3QOUsZfb9GEqKbZajZFcTjCQ3cPE9nyYQn+Gu+mJiEeRUU5mL0gV8mDTmtypTrDcBulHwoZG0QzgHsNN84pmW0XlrvxXCitnhC3YKXdApVyUALGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFqhem1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3783C433F1;
	Thu, 28 Mar 2024 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610605;
	bh=/DBxafWugaS+NBr6xZbPt8hjTlXm4/2YAaTmuUh1cZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pFqhem1NuQqwdqGi1ZzFQJiSsiRlvCNmU7jGrMuOnW9hR5gpfucNViiQE7H4oyTtm
	 x+YScXd4cWxvazuXIQaniANGZThfNtaPKLbtMCNo118Tov7oPCe8GHU3D7kBCwsfZJ
	 vuKVAQPKh341NX+txC7FmOMTqMU2uImO8v9YYodrnLZW2gqH3JjTar3XBGG9U+X70W
	 ABZk1qWqRBtmbhfJzpVZkyQ6xNzCXWy94XPWA115HyrHYxaoZlWTyDE3xRtd5cz66i
	 0MDHN2OOk+7AwtACuayYVnUhvBdjbcu/7d2gxbUgwk8upmPdf9ygJznfYUDj4nf7nx
	 QY76hjhcSRvBg==
Message-ID: <03ed6449-eb57-4a55-b2bf-ecbb9787feca@kernel.org>
Date: Thu, 28 Mar 2024 16:23:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Yihang Li <liyihang9@huawei.com>, Christoph Hellwig <hch@infradead.org>,
 John Garry <john.g.garry@oracle.com>
Cc: yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com, prime.zeng@huawei.com,
 yangxingui@huawei.com
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
 <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
 <ZgUPpwhkE9bRwHec@infradead.org>
 <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <75df3e2d-10c3-5370-3cd8-fe2fb0ff2acc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 15:59, Yihang Li wrote:
> 
> 
> On 2024/3/28 14:35, Christoph Hellwig wrote:
>> On Tue, Mar 26, 2024 at 01:32:09PM +0000, John Garry wrote:
>>>>> +	u8 *p;
>>>>> +
>>>>> +	size = ALIGN(size, ARCH_DMA_MINALIGN);
>>>
>>>
>>> If this is a hisi_sas requirement, then why use ARCH_DMA_MINALIGN and not
>>> 16B as minimum alignment?
>>>
>>> Or are we really talking about an arch requirement?
>>
>> One thing is that we should never allocate unaligned memory for
>> anything DMA mapped, or data will be corrupted by non-coherent DMA.
>> So ARCH_DMA_MINALIGN needs to be here.  If specific hardware has
>> further requirements we'll need to communicated it through a field
>> or op vector.
> 
> Got it. Looks like it's still going to be aligned to ARCH_DMA_MINALIGN.

But I thought that the original issue was that some arch have ARCH_DMA_MINALIGN
down to 8B but hisi driver needs at least 16 ?

So in the end, you need something like:

	size = ALIGN(size, max(16, ARCH_DMA_MINALIGN));

no ?

And define a macro for the "16" value to document it.
Something like:

#define SAS_SMP_REQ_ALIGN	16

Not sure about the name... Naming is hard :)

> 
> Thanks,
> Yihang
> 
>>
>>
>> .
>>

-- 
Damien Le Moal
Western Digital Research


