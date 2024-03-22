Return-Path: <linux-kernel+bounces-111313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E1886A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884051F23629
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62633D3A7;
	Fri, 22 Mar 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4Z/+qjF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057447E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104060; cv=none; b=Fslqt42mCheSe05FEUhG7HbDgJ8oiSDKlixt/BHdlOP8PMrNeAnXq9pbf+eI8nip/QPbCAYc97qkfPwBrHvCPcPpyytiy2gb7Sk1aYDux3sFD6H7FXgqeIulgDhEsNxNr13mw8chMG0dBy7w5Ec9X4BQ+7q3RnVelWXOuacMr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104060; c=relaxed/simple;
	bh=5MTvfMWqDn2NOQHv+kCQswKZDd2zZibpEq+2z++Z7oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS48yy3h58t4eE2S1UALn4mQqBGnj1weFMrdlhOG1PLeC9K7AZjLOyHlwQYxFM6hHyyHLmu9t6Sr2K127j9k6baAvr1qZooyIMK5bhpLl1+7mjLFPAzyFFEDcD2sFx2ydetXig8TO19nTQwHYixCfITXcMTpALzkADUL0sieVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4Z/+qjF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711104059; x=1742640059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5MTvfMWqDn2NOQHv+kCQswKZDd2zZibpEq+2z++Z7oo=;
  b=A4Z/+qjFYKMiO19cENxgXjiSFZgmpPyz/e5EzGx1m5j8iDOlwn7/sp5M
   NCTH2q8bka3RjRNxyOJoecQJ+PBqqRaLj9/upF0HtTEhe/hqfZNARH9IA
   TfW0dyTcGwhSn2rTqbYyqL8ifc+xh/kHXljGT84A8ARfnw5z51DyXU1cQ
   1zv3KeZRB+hNBpaH7kh/sP9y0zpt2khodZj6okZegmCvhf1YVWTbrwk7K
   C1OG0npDsuaf5Zw7c2Yph5+hE7NhWZIqkfsTTDapfXDfxcwgblBbldLs6
   vLhAKrIIKTzCLgNj9oK4siaLPU+1fBY3x9PPtWhgAdiUUDyGaXp+wLlTN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6000982"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6000982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066540"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066540"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2024 03:40:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0537DA1; Fri, 22 Mar 2024 12:40:52 +0200 (EET)
Date: Fri, 22 Mar 2024 12:40:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
 <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>

On Thu, Mar 21, 2024 at 04:02:11PM -0500, Tom Lendacky wrote:
> On 3/20/24 18:10, Kirill A. Shutemov wrote:
> > On Thu, Mar 21, 2024 at 09:48:28AM +1300, Huang, Kai wrote:
> > > 
> > > > > Hi Tom,
> > > > > 
> > > > > I am not aware of kexec() support status for SEV-ES/SEV-SNP guests.
> > > > > Does patch 1 break them?
> > > > 
> > > > SNP guests can kexec with some patches that are currently in process
> > > > around shared to private memory conversions. ES guests can only kexec
> > > > with a single vCPU. There was a recent patch series to add support for
> > > > multiple vCPUs.
> > > > 
> > > > Patch #1 doesn't break either ES or SNP because we still have an IDT and
> > > > traditional kernel addressing in place, so the #VC can be handled.
> > > 
> > > How about plain SEV guest?
> > > 
> > > > 
> > > > Whereas patch #2 has switched to identity mapping and removed the IDT,
> > > > so a #VC causes a triple fault.
> > > 
> > > That makes sense.  Thanks.
> > > 
> > > Hi Kirill,
> > > 
> > > Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() can
> > > be handled although it causes #VE, while WBINVD in relocate_kernel() will
> > > just triple fault the guest?
> > 
> > No. We never handle WBINVD #VE. Guest cannot handle WBINVD itself and the
> > only option is to ask host to do this. We cannot guarantee host will do
> 
> Is the WBINVD performed or ignored in that case?

We crash the guest if it tries to use WBINVD. There's no legitimate reason
for it.

> > anything useful with the request. I guess it can be potential attack
> > vector if host strategically ignores WBINVD to induce bad guest behaviour.
> 
> With SNP, memory is coherent so there isn't a need for a WBINVD within a
> guest and so issuing it should not be an issue whether the hypervisor
> performs the operation or not. I don't know what can happen in the case
> where, say, you have a non-coherent TDISP device attached or such, but that
> would be very unusual/unlikely.

Looks like SNP is in the same position as TDX.

> > And it is not good from host PoV either. If it does WBINVD on every guest
> > request we get guest->host DoS attack possibility.
> 
> Yeah, that can happen today, regardless of the type of VM running.
> 
> > 
> > Tom, I am curious, how do you deal with these problems?
> 
> If the WBINVD is being intercepted, then it will generate a #VC and we use
> the GHCB protocol to communicate that back to the hypervisor to handle.

I would argue that forwarding it to hypervisor is worse than crashing. It
gives false sense of doing something. Hypervisor is outside TCB and
considered hostile.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

