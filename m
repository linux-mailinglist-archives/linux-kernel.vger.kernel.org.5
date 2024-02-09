Return-Path: <linux-kernel+bounces-59848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700584FC78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C0E1C25990
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9A80C18;
	Fri,  9 Feb 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LMsKF6Xg"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE66BB22
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505120; cv=none; b=Tr5bA9WsMA+BdmUfnnOJsxIjOxxlpxHAkXwmvYCC35jYjxDnN10Kx0r1NeLpqLXB1exhx4PFS+amNfq1V7eNJXbHvxV0F5eXsPtlhlbHw7DyFuCWqi7EQ8r7tT3GjjbDDjohSTL5mMxdTmt4aam+40BlrkG2nTa9O0h1E/TpD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505120; c=relaxed/simple;
	bh=5uTKkg6MIbxxiUTeAtoiPotgK0/CeWUJqQ48BeNPQrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/iA/p0PINxs2MnUpMezQyMjLYoMyUYgECWRO1Xc8vkFo7MJdwtd/ZAgUzsETCvmur/MnZXMJMRQi2AscDmdPVeZeN99o1nQHPDjg4q1yWI28q3t+EsjZHCtdhG0hjf30pFK7HEOAOyaJGU00p5u0d23VYyjvzBL5FfiOzUe2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LMsKF6Xg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.200.159] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id CFD3120B2000;
	Fri,  9 Feb 2024 10:58:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFD3120B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707505118;
	bh=CrUcm3Z/FRbdc3NNdp4+dNbyUDn4m5ZmrpvJXh/X+7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LMsKF6Xg4IguZ6h/+LUCdvTxe+8L5lh3t0xuDRZLKvtC0AP7N1wxM4ptXb4DI/XuP
	 aiV6j60Ssdr3XgW8medIOPGkp3cyUAS394lMmfjlCfXQ5UOhcVOEfcQkClfP2gTUuJ
	 1cSFPJJ9aaUrvpZ7zJYWu72PyDBf/fwyc8gG8bMQ=
Message-ID: <542e7f15-3898-4396-a8ff-7972d3308132@linux.microsoft.com>
Date: Fri, 9 Feb 2024 10:58:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: arm64: Override Microsoft Azure Cobalt 100 MIDR
 value with ARM Neoverse N2
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)"
 <kvmarm@lists.linux.dev>
References: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
 <ZcNSI089xqia6lho@FVFF77S0Q05N.cambridge.arm.com>
 <ed6c25dc-d5c7-4f15-8fdc-f2adf209e638@linux.microsoft.com>
 <ZcYNn5LDmH1g2dDB@FVFF77S0Q05N.cambridge.arm.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <ZcYNn5LDmH1g2dDB@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/2024 3:33 AM, Mark Rutland wrote:
> On Thu, Feb 08, 2024 at 11:16:10AM -0800, Easwar Hariharan wrote:
>> On 2/7/2024 1:49 AM, Mark Rutland wrote:
>>> On Tue, Feb 06, 2024 at 07:58:16PM +0000, Easwar Hariharan wrote:
>>> Further, if Azure Cobalt 100 is based on ARM Neoverse N2, you presumably suffer
>>> from the same errata; can you comment on that at all? e.g. are there any
>>> changes in this part that *might* lead to differences in errata and/or
>>> workarounds? How do the MIDR_EL1.{Variant,Revision} values compare to that of
>>> Neoverse N2?
>>
>> Yes, Azure Cobalt 100 suffers from the same errata as Neoverse N2. We had changes
>> in the implementation, but according to our hardware folks, the Neoverse N2 errata
>> we are affected by so far aren't affected by the changes made for Azure Cobalt 100.
> 
> Ok, so of the currently-known-and-mitigated errata, you'll be affected by:
> 
> 	ARM64_ERRATUM_2139208
> 	ARM64_ERRATUM_2067961
> 	ARM64_ERRATUM_2253138
> 
> ... and we'll need to extend the midr_range lists for those errata to cover
> Azure Cobalt 100.
> 
>>From your patch, it looks like the Azure Cobalt 100 MIDR value (0x6D0FD490) is
> the same as the Arm Neoverse-N2 r0p0 MIDR value (0x410FD490), except the
> 'Implementer' field is 0x6D ('m' in ASCII) rather than 0x41 ('A' in ASCII).
> 
> Are you happy to send a patch extending arch/arm64/include/asm/cputype.h with
> the relevant ARM_CPU_IMP_* and CPU_PART_* definitions, and use those to extend
> the midr_range lists for those errata?

Yes.

> 
> As above, if you could make any comment on how the MIDR_EL1.{Variant,Revision}
> fields map to that of Arm Neoverse-N2, it would be very helpful. It's not clear
> to me whether those fields correspond directly (and so this part is based on
> r0p0), or whether you have a different scheme for revision numbers. That'll
> matter for correctly matching any future errata and/or future revisions of
> Azure Cobalt 100.
> 

Thanks for the clarifying detail on your question. Azure Cobalt 100 is indeed based
on r0p0 of the Neoverse N-2 and we have not used a different scheme than Neoverse N2
for the Variant and Revision fields.


> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


