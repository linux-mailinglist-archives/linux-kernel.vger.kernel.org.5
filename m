Return-Path: <linux-kernel+bounces-59296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADEE84F4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560D11F24014
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82E2DF7D;
	Fri,  9 Feb 2024 11:34:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182CE2E3F1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478442; cv=none; b=cNHdwWskCmqSc6QzWiux2krqc74NXZ/uIXY1p2PeT5tieCq57US4VwGBSmT9CtUgz6CcaP1EWd4Y1Vc8eS/D7cn/2+RNyfRZDXaW5WFKBAwBcjLHnQ0Oz2SiU16WSkEPs+RZoM16VZBwCmxJckcyq722HRYnBzvwNmmI1aD04Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478442; c=relaxed/simple;
	bh=PSKKtV965YJulHFsXWn3UaKzi2QezX4LHDe2jIKgaig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDqjI7Khl7NH1qRZga5leM4BGbduZmfrVzmlaLQHfUzXcA3wi1Y9GiUb3Sm0remm/PhtTr1n3JKEOozNTrN7pY8T4vEaWV/+ui5CqaC5+0c0XIn5vd8OOErE7ZgvdxboNJVrocsRF86tsehjWlUkJiRlq9tSwIY327UVuDXmqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3494DA7;
	Fri,  9 Feb 2024 03:34:38 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F42F3F762;
	Fri,  9 Feb 2024 03:33:54 -0800 (PST)
Date: Fri, 9 Feb 2024 11:33:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>, Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" <kvmarm@lists.linux.dev>
Subject: Re: [RFC PATCH] KVM: arm64: Override Microsoft Azure Cobalt 100 MIDR
 value with ARM Neoverse N2
Message-ID: <ZcYNn5LDmH1g2dDB@FVFF77S0Q05N.cambridge.arm.com>
References: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
 <ZcNSI089xqia6lho@FVFF77S0Q05N.cambridge.arm.com>
 <ed6c25dc-d5c7-4f15-8fdc-f2adf209e638@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6c25dc-d5c7-4f15-8fdc-f2adf209e638@linux.microsoft.com>

On Thu, Feb 08, 2024 at 11:16:10AM -0800, Easwar Hariharan wrote:
> On 2/7/2024 1:49 AM, Mark Rutland wrote:
> > On Tue, Feb 06, 2024 at 07:58:16PM +0000, Easwar Hariharan wrote:
> > Further, if Azure Cobalt 100 is based on ARM Neoverse N2, you presumably suffer
> > from the same errata; can you comment on that at all? e.g. are there any
> > changes in this part that *might* lead to differences in errata and/or
> > workarounds? How do the MIDR_EL1.{Variant,Revision} values compare to that of
> > Neoverse N2?
> 
> Yes, Azure Cobalt 100 suffers from the same errata as Neoverse N2. We had changes
> in the implementation, but according to our hardware folks, the Neoverse N2 errata
> we are affected by so far aren't affected by the changes made for Azure Cobalt 100.

Ok, so of the currently-known-and-mitigated errata, you'll be affected by:

	ARM64_ERRATUM_2139208
	ARM64_ERRATUM_2067961
	ARM64_ERRATUM_2253138

.. and we'll need to extend the midr_range lists for those errata to cover
Azure Cobalt 100.

From your patch, it looks like the Azure Cobalt 100 MIDR value (0x6D0FD490) is
the same as the Arm Neoverse-N2 r0p0 MIDR value (0x410FD490), except the
'Implementer' field is 0x6D ('m' in ASCII) rather than 0x41 ('A' in ASCII).

Are you happy to send a patch extending arch/arm64/include/asm/cputype.h with
the relevant ARM_CPU_IMP_* and CPU_PART_* definitions, and use those to extend
the midr_range lists for those errata?

As above, if you could make any comment on how the MIDR_EL1.{Variant,Revision}
fields map to that of Arm Neoverse-N2, it would be very helpful. It's not clear
to me whether those fields correspond directly (and so this part is based on
r0p0), or whether you have a different scheme for revision numbers. That'll
matter for correctly matching any future errata and/or future revisions of
Azure Cobalt 100.

Mark.

