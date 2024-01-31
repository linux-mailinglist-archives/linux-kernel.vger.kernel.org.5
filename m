Return-Path: <linux-kernel+bounces-46995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A78447A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06BA1F22292
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743713AA4D;
	Wed, 31 Jan 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFhRLlf6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561540BE7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727301; cv=none; b=VetVzZspKw4AmE4Oul+FdJJLbQcPwQDozyBdYlg+Rcq756VxkIfhkUhl7mxfkrZEQdiEqNdlOCGSuIv0NSSxUpC8qvjZn4uLfPI9xIwRZqZck5gygb0EBT8N+ZvK3IFRCtGySXIsQT54EbH9nxFkEAHWt5G7iXtJndJU1KF6Pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727301; c=relaxed/simple;
	bh=b1exTRH9trJx0myKG8w1CzTk99qlyyGiP2ip+vPOALE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULEKdP2gW8xNoL0auTVVATM1/IEP0k+jJP41bizKnlgIWZnt0KCoHYdnpnB+mPpovwhoChoTlVeL/kFQ7a+6Ey+qWU22cmbMie8E8bjjDRusFKuvCnDVEhASvFuVVqDJc9DkHLRWK5KiDKdpDoNpaAhdiLIMRDC7qCj4lfuJjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFhRLlf6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706727299; x=1738263299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1exTRH9trJx0myKG8w1CzTk99qlyyGiP2ip+vPOALE=;
  b=WFhRLlf645VaNsPSS5Rrskob7H2J/n+pWXHfpkRg1v1aCZJsP35c8hQY
   NiU7V8Gv/SI0sDEYdNv5oexFT0O630yDuSCgFys/qcLPe3Amk9v5Aze2C
   Oe6yrIcWO8crrq4dFZTabKP624ofCUAURDBP/9DTBI9x5NP1oZ+nmVs0a
   i/9oncy/wFWx6jj/rxM2tboSNT0fQ+dX4iT1/5+F0RFbSEQhUtnbhLA2W
   gEl1GyY5MfTJJpdpTBEgmYXc5N9bZWDs6H4JxLJPvYjasxjyRQ0rezeiy
   FpkgNIAm1CL0OmSTqb4Pqe+CU00V7I91j2kgU7AroggRtAqx0iR5XJBny
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25158912"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="25158912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 10:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931941232"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="931941232"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2024 10:54:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D326F1D0; Wed, 31 Jan 2024 20:52:46 +0200 (EET)
Date: Wed, 31 Jan 2024 20:52:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>

On Wed, Jan 31, 2024 at 06:57:38PM +0100, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 03:06:50PM +0200, Kirill A. Shutemov wrote:
> > The programming protocol for the PAT MSR follows the MTRR programming
> > protocol. However, this protocol is cumbersome and requires disabling
> > caching (CR0.CD=1), which is not possible on some platforms.
> > 
> > Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
> > a #VE exception.
> > 
> > Turned out the requirement to follow the MTRR programming protocol for
> > PAT programming is unnecessarily strict. The new Intel Software
> > Developer Manual[1] (December 2023) relaxes this requirement. Please
> > refer to the section titled "Programming the PAT" for more information.
> 
> How about you state that requirement here instead of referring to that
> doc which is hard to read and changes constantly?
> 
> I'd prefer to have that programming requirement spelled out here to know
> in the future what that requirement was and what "variant" was added to
> the kernel in case someone decides to relax it even more.

I summarized the requirements below: TLB has to flashed. Here's what SDM
says:

    The operating system (OS) is responsible for ensuring that changes to a
    PAT entry occur in a manner that maintains the consistency of the
    processor caches and translation lookaside buffers (TLB). It requires the
    OS to invalidate all affected TLB entries (including global entries) and
    all entries in all paging-structure caches. It may also require flushing
    of the processor caches in certain situations.

    ...

    Example of a sequence to invalidate the processor TLBs and caches (if
    necessary):

    1. If the PCIDE or PGE flag is set in CR4, flush TLBs by clearing one of
    those flags (then restore the flag via a subsequent CR4 write).

    Otherwise, flush TLBs by executing a MOV from control register CR3 to
    another register and then a MOV from that register back to CR3.

    2. In the case that there are changes to memory-type mappings for which
    cache self-snooping behavior would be problematic given the existing
    mappings (e.g., changing a cache line's memory type from WB to UC to be
    used for memory-mapped I/O), then cache flushing is also required. This
    can be done by executing CLFLUSH operations for all affected cache lines
    or by executing the WBINVD instruction (recommended only if there are a
    large number of affected mappings or if it is unknown which mappings are
    affected)

The second step is relevant for set_memory code that already does the
flushing on changing memory type.

> > The AMD documentation does not link PAT programming to MTRR.
> > 
> > The kernel only needs to flush the TLB after updating the PAT MSR. The
> > set_memory code already takes care of flushing the TLB and cache when
> > changing the memory type of a page.
> 
> So far so good. However, what guarantees that this relaxing of the
> protocol doesn't break any existing machines?

Our HW folks confirmed that the new optimized sequence works on all past
processors that support PAT.

> If anything, this patch needs to be tested on everything possible. I can
> do that on AMD hw and some old Intels, just to be sure.

Testing wouldn't hurt, but it cannot possibly prove that the new flow is
safe by testing.

> > @@ -296,13 +298,8 @@ void __init pat_bp_init(void)
> >  	/*
> >  	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
> >  	 * supported.
> > -	 * When running as TDX guest setting the PAT MSR won't work either
> > -	 * due to the requirement to set CR0.CD when doing so. Rely on
> > -	 * firmware to have set the PAT MSR correctly.
> >  	 */
> > -	if (pat_disabled ||
> > -	    cpu_feature_enabled(X86_FEATURE_XENPV) ||
> > -	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > +	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
> >  		init_cache_modes(pat_msr_val);
> >  		return;
> 
> What does that mean, now, practically?
> 
> That TDX guests virtualize the PAT MSR just like with any other guest or
> what is going on there?
> 
> This should be explicitly stated in the commit message.

PAT MST was always virtualized, but we was not able to program it as we
followed MTRR protocol that sets CR0.CD. And I covered it in the commit
message:

    Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
    a #VE exception.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

