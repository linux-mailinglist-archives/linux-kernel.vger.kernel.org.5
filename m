Return-Path: <linux-kernel+bounces-56584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67884CC07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2D81C21598
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357B79DB8;
	Wed,  7 Feb 2024 13:51:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366077F08
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313910; cv=none; b=cyDtay/NvBiz0t6nt3rIWQjaZAKutuWK7b+59i4uPmMkBiIePOV6W+IDKLIhJ6J3V1wnhyU31PUp8feLC3oCmU1xl8OiCMnx1yvSBKBR+dpAL25vSxsHG0FvVjk81oTrNV+Jn2mI3ZSOXij+bTXWOzEz1SMGyn8rateDNNLqbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313910; c=relaxed/simple;
	bh=zexCmC4fXcwE3lcy44wNcZYTwGpTTivyKi8epTwOIFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXbqwaklr3sFVhbSQUUbIHXeYnnwsbUl3ARVOun5zSVd/yz7DFvLJoEg6v7A4BsSOqJTJBeOU8UBl9aNYURtBbV9ghjDPGi9sqczvrymc+I7dAchHuPxuBy1rq7ai+FP+4jIJfi64UaLlBfaYAq1ePHnGaY+sLLqyQKk2A7c9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C891FB;
	Wed,  7 Feb 2024 05:52:28 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543D53F5A1;
	Wed,  7 Feb 2024 05:51:45 -0800 (PST)
Date: Wed, 7 Feb 2024 13:51:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcOK7oIe2f/BFlDj@e133380.arm.com>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcEW3y0IlEctOYBA@e133380.arm.com>
 <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>
 <ZcN2XMkvqxNnsz5K@e133380.arm.com>
 <ZcOBH7ip/KMhLYGO@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOBH7ip/KMhLYGO@finisterre.sirena.org.uk>

On Wed, Feb 07, 2024 at 01:09:51PM +0000, Mark Brown wrote:
> On Wed, Feb 07, 2024 at 12:23:56PM +0000, Dave Martin wrote:
> > On Mon, Feb 05, 2024 at 05:41:47PM +0000, Mark Brown wrote:
> > > On Mon, Feb 05, 2024 at 05:11:59PM +0000, Dave Martin wrote:
> 
> > > > If the kernel is now juggling two #defines for the maximum vector size,
> > > > this feels like it may seed bitrot...
> 
> > > Ideally we'd just not have the existing define externally but it's there
> > > and it's been used.
> 
> > To clarify, is this intended as a temporary band-aid against silly
> > behaviour while a cleaner solution is found, or a permanent limitation?
> 
> Ideally we'd just make everything dynamic, other than the regset issue
> and the bitmasks used for VL enumeration we're there already.  Making
> the bitmasks dynamically sized is more painful but are also doing
> enumeration that userspace doesn't need to do.

For the bitmasks, we'd be saving (512 - 16) / 8 = 62 bytes for each of
SVE and SME (I think).

The tradeoff really didn't seem worth it...

> 
> > We'd need to change various things if the architectural max VL actually
> > grew, so no forward-portability is lost immediately if the kernel
> > adopts 16 internally, but I'm still a little concerned that people may
> > poke about in the kernel code as a reference and this will muddy the
> > waters regarding how to do the right thing in userspace (I know people
> > shouldn't, but...)
> 
> I think if we fix the ptrace regset issue we're doing a good enough job
> of just using fully dynamic sizing with no limits other than what's been
> enumerated there.  We could possibly deal with the enumberation code by
> changing it to use ZCR/SMCR_ELx_LEN_ based defines so that it's
> obviously coming from what we can possibly write to the register but
> it's a bit less clear how to do that neatly.

OK, but we still seem to have two competing approaches: clamp SVE_VQ_MAX
for kernel internal purposes, or restore the dynamic sizing of
NT_ARM_SVE based on the new regset core behaviour.

Are you saying we should or both, or otherwise which one?

Cheers
---Dave

