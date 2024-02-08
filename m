Return-Path: <linux-kernel+bounces-57375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1884D7A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6431F2346E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE114AB2;
	Thu,  8 Feb 2024 01:37:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695651E892
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356277; cv=none; b=tlwL9yBMLLGxQpg1DujceN1UAWgxpoEXsz3Bm1DVEA4OSbS2LMYQTKH17O+2qoeG599PyPwQzdSA4M6F/HOojlCvN/s84vmBPJyDl1+KGv/cBtGB4bLO4wFuWvbi+4H3XKe/2uG4Xn0XLIfR3BX+wnkA4jHup8zrjttaBev5SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356277; c=relaxed/simple;
	bh=lKskRSqdpwDtfSHdA8bWSaWTaPHpv0h2RtVrX+6X+B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDnxuhk37qDVQvuOPM2QbWBEf/trhWRIp3yWVpqMT7SJurGScZiDHgUHXxW+J5m32RpjANT3gBNf8awXmWXFEFujZEnf4Wn6GEWMX0FmcMOG2E0xKBX42LN1SJWDq3YqXLH3Ddv30PboXdULWaudbPp17YnF7Bnz7QkZcNqD3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D45371FB;
	Wed,  7 Feb 2024 17:38:36 -0800 (PST)
Received: from [10.57.49.110] (unknown [10.57.49.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC6F3F762;
	Wed,  7 Feb 2024 17:37:53 -0800 (PST)
Message-ID: <a93e93dd-5cb8-48ee-bf8d-b3bbb19507d6@arm.com>
Date: Thu, 8 Feb 2024 01:37:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nikhil V <quic_nprakash@quicinc.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Charan Teja Kalla
 <quic_charante@quicinc.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
 <20240208011305.GM31743@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240208011305.GM31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 1:13 am, Jason Gunthorpe wrote:
> On Thu, Feb 08, 2024 at 12:04:44AM +0000, Robin Murphy wrote:
>>> Frankly, I'd suggest just proposing the necessary (and tested)
>>> upstream patches to 6.1, however large they are, and see what Greg and
>>> Sasha say. This is the usual working model they have, as I understand
>>> it.
>>
>> To be blunt, hell no. Stable is far enough from its namesake already; the
>> ongoing bordering-on-ridiculous brokenness of your mainline changes where
> 
> What on earth are you even talking about? POWER?

I mean you're literally getting bug reports for your fix for your fix 
for your grand idea, so what should we figure, that reality not aligning 
with your expectations is all reality's fault?

>> That said, I also don't think there would be any harm in applying this to
>> mainline as a belt-and-braces thing either,
> 
> Really?

"at 12:04:44AM +0000, Robin Murphy wrote:"

It's late, I should have gone to bed hours ago, so I apologise for any 
lack of clarity; that was very much meant to be an implication of 
agreement with the overall approach, not the exact patch as is, which if 
you read the rest of my response you will see I still had questions 
about and did not formally ack or review.

> Now that you've made me look, this patch breaks the
> iommu_group_store_type() flow both on latest and on v6.1 from what I
> can see.
> 
> On v6.1:
> 
> iommu_change_dev_def_domain():
>    
>          prev_dom = group->default_domain;
>          if (!prev_dom) {
>                  ret = -EINVAL;
>                  goto out;
>          }
> [..]
>          /* Sets group->default_domain to the newly allocated domain */
>          ret = iommu_group_alloc_default_domain(dev->bus, group, type);
>          if (ret)
>                  goto out;
> 
> But this patch changes iommu_group_alloc_default_domain() to succeed
> always without doing anythiing.
> 
> So this patch needs some fixing.

Hurrah! Please apply that kind of rigour to your own patches also.

Thanks,
Robin.

[ you get two responses this week since I admit I ran out of patience 
and motivation to finish last week's on time ]

