Return-Path: <linux-kernel+bounces-81246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B8867290
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787F22896DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684421DA20;
	Mon, 26 Feb 2024 11:05:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80591D52D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945530; cv=none; b=CvrLMpzw04kNcN8QaTRfpC7Hp476r9MD04u+CybUj1SPqqbrbUhGv3wqgFeg9Xb3taW6P+I4YEhwZ/wH6PU3dFhE6twXGlGcXBYA4NQ/b9unhttQ136Up0rEW4SlXaoyIWoo/amc5SGxswPwJXmGIJukAiB7MQ6nZJxBEU8UvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945530; c=relaxed/simple;
	bh=Dpvh1u6uIHD3zL72KLsDUAqLNGDPN7ZtBbRRizpzWpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFfQ468zJgZDz7mKOPkaPZVvrpMh4mZtPyGHvEP5Zk/zHrqBSMKrOLbep6G661CywVEJd/Wqy9AU3jL1LphWLVL6tAy8XFIUB7RqoccrFeAEA4nRNVG4iCDFIP25ABmMKaV33+GY04i7CsiJeTsX+dphR0Y09c5ZHsRxKoyptLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B9CDA7;
	Mon, 26 Feb 2024 03:06:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC98B3F6C4;
	Mon, 26 Feb 2024 03:05:23 -0800 (PST)
Date: Mon, 26 Feb 2024 11:04:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	broonie@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf
 breakpoint macros
Message-ID: <ZdxwTkUALQfqjagf@FVFF77S0Q05N>
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
 <20240223125224.GC10641@willie-the-truck>
 <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>

On Mon, Feb 26, 2024 at 08:19:39AM +0530, Anshuman Khandual wrote:
> On 2/23/24 18:22, Will Deacon wrote:
> > On Fri, Feb 23, 2024 at 05:01:02PM +0530, Anshuman Khandual wrote:
> >> Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
> >> macros are used interchangeably to convert event->attr.bp_len and platform
> >> breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
> >> deriving one from the other. This does not cause any functional changes.
> >>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This applies on v6.8-rc5
> >>
> >>  arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> >> index 35225632d70a..1ab9fc865ddd 100644
> >> --- a/arch/arm64/kernel/hw_breakpoint.c
> >> +++ b/arch/arm64/kernel/hw_breakpoint.c
> >> @@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
> >>  
> >>  	switch (hbp_len) {
> >>  	case ARM_BREAKPOINT_LEN_1:
> >> -		len_in_bytes = 1;
> >> +		len_in_bytes = HW_BREAKPOINT_LEN_1;
> > 
> > I don't think we should do this. The HW_BREAKPOINT_LEN_* definitions are
> > part of the user ABI and, although they correspond to the length in bytes,
> > that's not necessarily something we should rely on.
> 
> Why should not we rely on the user ABI macros if these byte lengths were
> initially derived from them. 

Why should we change the clear:
	
	len_in_bytes = 1;

.. to the longer, and less clear:

	len_in_bytes = HW_BREAKPOINT_LEN_1;

.. ?

> But also there are similar conversions in arch_bp_generic_fields().

Those are specifically for converting from the rch_hw_breakpoint_ctrl encodings
to the perf_event_attr encodings. There we don't care about the specific value
of the byte, just that we're using the correct encoding.

> These hard coded raw byte length numbers seems cryptic, where as in reality
> these are just inter converted from generic HW breakpoints lengths.

There are three distinct concepts here:

1. The length in bytes, as returned above by get_hbp_len()

2. The length as encoded in the ARM_BREAKPOINT_LEN_* encoding

3. The length as encoded in the HW_BREAKPOINT_LEN_* encoding.

I think you're arguing that since 1 and 3 happen to have the values we should
treat them as the same thing. I think that Will and I believe that they should
be kept distinct because they are distinct concepts.

I don't think this needs to change, and can be left as-is.

Mark.

