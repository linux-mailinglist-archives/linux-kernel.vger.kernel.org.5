Return-Path: <linux-kernel+bounces-128355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A858959C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7692863F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7015920E;
	Tue,  2 Apr 2024 16:33:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C62158214
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075581; cv=none; b=gctTZb+MzbXprxbRKwVflZhX1tLuCtvoXq14lKwMXW0Un8lQeT/ScuwLeM/2WsKX59tXn4zE1ufQXKuUblkzrV5bO2sr8s/BG4zjZBoUiadGoKxT0/V2kvMNILvI8R547uUNWsxxV9J2gEYWLy9AEMaLbqAj2f7LGijRHW1ZD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075581; c=relaxed/simple;
	bh=8ft5cAT3h96pvAWq8Rdilwr2A6Dd7vQvMP4oRbhVZ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQbn74O/qcICfzkNEBRybAJJ6Fe3HpMesh4mZ2cpWWea3iSca+AhBfvysvE/N71XSF8oIMOLGy/tv3k25jxhFlfkJgp4kZyPTR9mH59ty7ou9ufDW1pJUBes75omynuQ9lpFZAj+5dtpYaweda1o7fdO+BTbd57GafGtX+bwK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918151007;
	Tue,  2 Apr 2024 09:33:30 -0700 (PDT)
Received: from [10.1.28.13] (010265703453.arm.com [10.1.28.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01923F64C;
	Tue,  2 Apr 2024 09:32:57 -0700 (PDT)
Message-ID: <67afde12-3fed-4298-9c5e-fbb4819c52a8@arm.com>
Date: Tue, 2 Apr 2024 17:32:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
To: Will Deacon <will@kernel.org>
Cc: Tyler Hicks <code@tyhicks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <ZfKsAIt8RY/JcL/V@sequoia> <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
 <5b19ab13-a7a0-48e2-99a4-357a9f4aeafa@arm.com>
 <20240322155157.GD5634@willie-the-truck>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240322155157.GD5634@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-22 3:51 pm, Will Deacon wrote:
> On Tue, Mar 19, 2024 at 06:17:39PM +0000, Robin Murphy wrote:
>> In terms of the shutdown behaviour, I think it actually works out as-is. For
>> the normal case we haven't touched GBPA, so we are truly returning to the
>> boot-time condition; in the unexpected case where SMMUEN was already enabled
>> then we'll go into an explicit GPBA abort state, but that seems a
>> not-unreasonable compromise for not preserving the entire boot-time Stream
>> Table etc., whose presence kind of implies it wouldn't have been bypassing
>> everything anyway.
>>
>> The more I look at the remaining aspect of disable_bypass for controlling
>> broken-DT behaviour the more I suspect it can't actually be useful either
>> way, especially not since default domains. I have no memory of what my
>> original reasoning might have been, so I'm inclined to just rip that all out
>> and let probe fail. I see no reason these days not to expect a broken DT to
>> leads to a broken system, especially not now with DTSchema validation.
> 
> That sounds reasonable to me, although we may end up having to back it
> out if we regress systems with borked firmware :(
> 
>> Then there's just the kdump warning it suppresses, of which I also have no
>> idea why it's there either, but apparently that one's on you :P
> 
> I think _that_ one is because the previous (crashed) kernel won't have
> torn anything down, so there could be active DMA using translations in
> the SMMU. In that case, the crashkernel (which is running from some
> carveout) may find the SMMU enabled, but it really can't stick it into
> bypass mode because that's likely to corrupt random memory. So in that
> case, we do stick it into abort before we reinitialise it and then we
> disabling fault reporting altogether to avoid the log spam:
> 
> 	if (is_kdump_kernel())
> 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN)

Oh, I know why we do what we do for the kdump situation in general - it 
was merely the matter of why we chose to demand that the user explicitly 
tells us to do what we know is the right thing (and scream at them if 
they don't), rather than to just go ahead and do the right thing anyway.

(the significance of disable_bypass for kdump is after we turn the SMMU 
back on from GBPA Abort state - we don't want any ongoing traffic being 
able to inadvertently bypass via an STE config either)

Cheers,
Robin.

