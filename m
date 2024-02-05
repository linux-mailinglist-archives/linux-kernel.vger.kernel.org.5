Return-Path: <linux-kernel+bounces-52772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE5849C80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED551C24C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E228E26;
	Mon,  5 Feb 2024 14:01:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A628E31;
	Mon,  5 Feb 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141662; cv=none; b=nAAr60vZFfolU8XN8i0RQx7V+WG37YCT0zsdyTHJdeVNAsbVBJt4mYdVvjjgJSd7hw+DlsrBQnMdklhP8+EzkzdR15GVf1PNShs8YQwdMlvMjRkjP68Lq9MTBZzDh4ajVxFvrqIvpqlH4LOF7x4wTnBZtOHM0KeLSgy1xKHlA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141662; c=relaxed/simple;
	bh=xgowrTg+bv/6Aac3oAYid5kbpWTggKw8G0dKmP7Pfac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlrVHymK2KDSoIatHm86Lls/uZoFdDiu4mtTlve/JELQaLjDSIJsEkrXn0ECnbNL3sX1r88+biOLlV2k01GNFUenKpqGumtMi1G7TY82bXnryp+hi9k8ttXrR5DQJFf9Q4JSa3OD3yKauS6cSpmzNIsfj24T3s5WhZGBBZgg6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E67211FB;
	Mon,  5 Feb 2024 06:01:41 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EB3B3F5A1;
	Mon,  5 Feb 2024 06:00:58 -0800 (PST)
Message-ID: <f27d7b45-89d9-4b5c-9bde-806b57bbe8e7@arm.com>
Date: Mon, 5 Feb 2024 14:00:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/ipmmu-vmsa: Use devm_platform_get_and_ioremap_resource() in
 ipmmu_probe()
Content-Language: en-GB
To: Markus Elfring <Markus.Elfring@web.de>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
 <51315925-21ac-427c-abea-4d652ed5280f@arm.com>
 <0c757d69-ec60-477c-a978-a94118a571a2@web.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0c757d69-ec60-477c-a978-a94118a571a2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 1:02 pm, Markus Elfring wrote:
>>>>> Thus reuse existing functionality instead of keeping duplicate source code.
>>>>
>>>> Much as I detest the get_and_ioremap_resource obfuscator, it's not even appropriate here since nothing else is using "res".
>>>
>>> I got the impression that this local variable is needed to perform
>>> a desired function call.
>>
>> Yes, the call to devm_ioremap_resource(). Which you're proposing to remove...
> 
> I propose to replace a specific function call combination
> by an other single call for a known wrapper function.
> The mentioned variable is preserved for this purpose.

No. If you believe in cleaning up code, please apply your brain and 
clean up code *meaningfully* - others seem to have managed it just fine 
(e.g. [1][2] at random from a quick search on lore). Hell, I think even 
the original now-deleted script could auto-generate a proper patch for 
situations where devm_platform_ioremap_resource() was appropriate - 
there is zero excuse for doing a *worse* job 4 years later.

If on the other hand your interest is not to actually clean up the code 
for the good of the community, but to stoke your own ego as a 
"contributor" of shitty patches that annoy people and reinforce the 
popular impression that you are in fact an AI, please stop, or at the 
very least please refrain from doing so in any areas I review or maintain.

Thanks,
Robin.

[1] https://lore.kernel.org/all/20191013152716.1830911-1-jic23@kernel.org/
[2] 
https://lore.kernel.org/all/20200412135023.3831-1-aishwaryarj100@gmail.com/

