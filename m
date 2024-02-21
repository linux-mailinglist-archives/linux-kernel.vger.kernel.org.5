Return-Path: <linux-kernel+bounces-74852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3896185DD86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78622832C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813997E10F;
	Wed, 21 Feb 2024 14:05:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDF7C6C0;
	Wed, 21 Feb 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524334; cv=none; b=WIJg51dYPqH9uVDQKoEGyt+jsP0ev53STWB3SnB8FvgXUgx+jV29y0SkIrGi9d+uddR+5xPT8Zrhw7dREakO7/oNu8q1j8EuEaAqSxlkTIN+z4WW6tVSSlcRr0vCnWDqVVyyid1jCKtero0b52Xx4IK3ZzGV7AwLtM0iKoyc0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524334; c=relaxed/simple;
	bh=fa5UFx328+uy1ItN2onmayxTMv1ZPciMAR0Fx3yRX1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/kRNHE7/rfrMqYL1aKjklvR2p9UlPkdz8BX3WV5c6R4X8UR8gg1MNenRyF+R9aVIaHIDguETJe2ajhxarhRxkLuGQK17dRVUt/0IOtnH7Nl2aN6rDPaZ9IJrFiRdXxvLW5mS6tmRxYiY4hhVhRv2T2yvR7ZMw/bT7/d3Uok7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD55DFEC;
	Wed, 21 Feb 2024 06:06:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE97C3F762;
	Wed, 21 Feb 2024 06:05:27 -0800 (PST)
Date: Wed, 21 Feb 2024 14:05:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <ZdYDJPe1n5-V-AnT@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
 <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>

On Wed, Feb 21, 2024 at 01:59:03PM +0000, Mark Brown wrote:
> On Wed, Feb 21, 2024 at 01:52:38PM +0000, Mark Rutland wrote:
> > On Thu, Jan 25, 2024 at 03:11:12PM +0530, Anshuman Khandual wrote:
> 
> > Minor nit, but could we please list thse in order:
> 
> > 	BRBCR_EL1
> > 	BRBCR_EL12
> > 	BRBCR_EL2
> 
> > ... since that way the names are ordered alphnumerically, which is what we've
> > done for other groups (e.g. PIR_EL{1,12,2}), and it's the way the ARM ARM
> > happens to be ordered.
> 
> It's a good point about the sorting, though the file is currently mostly
> sorted by encoding rather than alphanumerically (similarly to how
> sysreg.h was done).

Sure, we're inconsistent. I'd just prefer that there's *some* local ordering
here, as the patch is neither ordered as above nor by encoding:

Sysreg       BRBCR_EL2       2       4       9       0       0
..
Sysreg       BRBCR_EL1       2       1       9       0       0
..
Sysreg       BRBCR_EL12      2       5       9       0       0

Mark.

