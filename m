Return-Path: <linux-kernel+bounces-153102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD18AC921
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5EF2826D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07B13BC23;
	Mon, 22 Apr 2024 09:40:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633D502B3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778839; cv=none; b=hhYIhmYY2+dXX9EkT1tVIiwWEtkyRSsX8usa+L6hkEtmbyjn9HqhDEufh+UKKKUrh8bE1WzR0lYzgc3QHOAnskE5na/P4l5gy70uHhDf7jjsR6to8Af+PTAegafte7oAjVA+BVKvODFIRBXzJNuNjPLgq6LFfYwoOUZezzzOaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778839; c=relaxed/simple;
	bh=/WR48W7qWg4v2Qz+/XQ/bjd0aFfImG9Km5LpCV+Dy6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8OzS3IDcREjOR1z4BsLvhd78KPMTdQjmRCT+nfNjC0qFZXHiLOIjwmlo6k06YhgDSOMqmRAhziuExKJJi5wCU9dGjZCPBi4ElRWYKKzGoN8GTtTgqm3sV0GYxgqeyshLNuf/XD3TvOL/tNl6usHwTBK7/i3vroLIN6kHRBTCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B349339;
	Mon, 22 Apr 2024 02:41:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757843F64C;
	Mon, 22 Apr 2024 02:40:35 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:40:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension
 `pauth'
Message-ID: <ZiYwkKLRVgvrQrnK@FVFF77S0Q05N>
References: <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
 <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
 <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>

On Mon, Apr 22, 2024 at 11:25:25AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 22, 2024, at 11:13, Mark Rutland wrote:
> > On Mon, Apr 22, 2024 at 02:04:43PM +0530, Naresh Kamboju wrote:
> > Given the minimum supported toolchain comes with an assembler that doesn't
> > necessarily support ARMv8.3, I reckon we'll either have to make NV pauth
> > support depend upon AS_HAS_ARMV8_3, or manually assemble the PACGA instruction.
> >
> > I suspect the latter is the better option.
> 
> The .config linked from the report shows
> 
> CONFIG_AS_VERSION=23101
> CONFIG_ARM64_PTR_AUTH_KERNEL=y
> CONFIG_AS_HAS_ARMV8_3=y
> 
> So it gets detected as supporting ARMv8.3. Is this the wrong
> conditional to check, or does it get misdetected for an unsupported
> assembler?

I suspect that means the 'pauth' arch extension was added after armv8.3
support, and the assembler supports `-march=armv8.3-a` but does not support
`.arch_extension pauth`. So for this code, it'd be wrong to check for
AS_HAS_ARMV8_3, unless we used `.march armv8.3-a`, but even then that'd still
mean configurations where we couldn't support this code.

I reckon manually assembing the PACGA is the best thing to do; that sidesteps
the need for either `.arch_extension pauth` or `.march armv8.3-a`, and aligns
with what we do for CONFIG_ARM64_PTR_AUTH=y generally.

Elsewhere in the kernel where we check for CONFIG_AS_HAS_ARMV8_3, we rely on
ARM64_ASM_PREAMBLE containing `.arch armv8.3-a` or a later version that implies
the presence of ARMv8.3-A instructions, and so pauth usage elsewhere is fine.

Mark.

