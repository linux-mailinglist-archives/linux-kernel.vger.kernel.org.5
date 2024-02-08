Return-Path: <linux-kernel+bounces-57313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405E484D6E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE131284B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC41B59D;
	Thu,  8 Feb 2024 00:04:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182A51E87F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350690; cv=none; b=HR+g8YvPXakH7tjXSPrQQWw8+or1scw+Cf7e3BGiBkkq+Vy3yWOL7TsKeGwPrOhd3QKcesQzO6Zfu5c3iiOerr/vdFG8sgY3lP9qOQH+T7fvqkEqpID1EsgCY1Ht4UmXCWf3yWhvrIOau5ZtuPWjk6wcMkpB8QvqZ9CrmGFichY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350690; c=relaxed/simple;
	bh=p5zVpNRV/Kw4RpQSuCTfGevl+nGajRGf+VhjwPTrxzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lgkc6sXF9L8WfUICr86HQuoVs4yWuDTUlolVq6KgOPIsiMMtvoDZezW600huzeHJBUcnUv0ROctPuAGxgLQPskKrC80gPKdEubyO9rsbrS/h5ltJwRik45DeE+uPBpdGTqQiJeZ5g8Z7Vw94qi1U+biQlikIYwpt4bpY1Fjk3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 889451FB;
	Wed,  7 Feb 2024 16:05:29 -0800 (PST)
Received: from [10.57.49.110] (unknown [10.57.49.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372A83F64C;
	Wed,  7 Feb 2024 16:04:46 -0800 (PST)
Message-ID: <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
Date: Thu, 8 Feb 2024 00:04:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Nikhil V <quic_nprakash@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240207145656.GJ31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-07 2:56 pm, Jason Gunthorpe wrote:
> On Wed, Feb 07, 2024 at 07:56:25PM +0530, Nikhil V wrote:
>>
>>
>> On 2/1/2024 9:53 PM, Jason Gunthorpe wrote:
>>> On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:
>>>
>>>> Gentle ping to have your valuable feedback. This fix is helping us
>>>> downstream without which we see a bunch of kernel crashes.
>>>
>>> What are you expecting here? This was fixed in Linus's tree some time
>>> ago now
>>>
>>> Are you asking for the stable team to put something weird in 6.1? I
>>> don't think they generally do that?
>>>
>>> Jason
>>
>>
>> Hi @Jason,
>>
>> Considering that the issue is reported on 6.1, which is an __LTS kernel__,
>> any suggestion to fix this issue cleanly would help us a lot. Right thing
>> here would have been propagating the changes from 6.6 (like for any
>> stability issue), but considering the intrusiveness of them, is it even
>> possible?
>>
>> Just to be open about reproducibility of the issue, a bunch of them are
>> reported, both internally and by customers.
> 
> I think you need to talk to the stable maintainers not the iommu
> upstream folks. I don't well know their policy.
> 
> Frankly, I'd suggest just proposing the necessary (and tested)
> upstream patches to 6.1, however large they are, and see what Greg and
> Sasha say. This is the usual working model they have, as I understand
> it.

To be blunt, hell no. Stable is far enough from its namesake already; 
the ongoing bordering-on-ridiculous brokenness of your mainline changes 
where each "fix" keeps affecting something else is a massive NAK to 
backporting any of it, let alone 43+ patches to achieve a 2-line fix.

Nikhil, if this is truly sufficient to resolve the issues you see 
(AFAICS things end up serialised by the group mutex so probably should 
be robust enough), then I'm OK with you proposing it as a dedicated 
stable-only fix, as an "equivalent" patch per Option 3 of 
stable-kernel-rules.rst - I reckon your commit message is already pretty 
good with regards to the final point there, but I'll be happy to help 
argue the case if necessary. Just one point - is it genuinely not 
relevant to 5.15 and earlier or is it just the case that 6.1 is the 
oldest thing you're actively testing? (Apologies, I've already forgotten 
where things were that far back).

That said, I also don't think there would be any harm in applying this 
to mainline as a belt-and-braces thing either, if it helps makes a 
backport easier and Joerg doesn't mind. There's already a bunch of stuff 
I'll be cleaning up once the underlying issue behind all of this is 
properly fixed, so adding a couple more lines of code to that list is no 
big deal as far as I'm concerned.

Thanks,
Robin.

