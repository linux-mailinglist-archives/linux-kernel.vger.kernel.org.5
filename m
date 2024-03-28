Return-Path: <linux-kernel+bounces-123220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B78904A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B421C2EE06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3E82882;
	Thu, 28 Mar 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQ2k1FCd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E45FB90
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642226; cv=none; b=kPltdE2pWkh1D3i+O3hpSEFR+KdI0dljhz8V+BOyHj20XsGru7FjRjNRvDu5MY6GjZUrD3phmWCJuwml0Mm9uYvRAh6PHkNOf6RlJor8C0aUfgqLcwrpuUkVidagfJGWs6E6N8j+zEEG1MWMfim4J4XvGyUaFSaNs3dkM8wU+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642226; c=relaxed/simple;
	bh=aKCQ5vxu2dVNPk1Ajh31NOatnxvir20tZSXl26pgxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Cx6oooz7tdRDRRHeXoLkjQ3RFgC7Pix2OyyGPPB/dg2BWowZE5Crc4Wc0w2N/w7Ol0YNe9dBXYTdTIwF8QJGfubwlqOebzoVGu6w/f4tpzZHeEResN04d4xqWS3ZsS9T+9acgqc4kQIu1dqT94NhLVbj3WS0+jBANND3BRaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQ2k1FCd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711642224; x=1743178224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aKCQ5vxu2dVNPk1Ajh31NOatnxvir20tZSXl26pgxNE=;
  b=PQ2k1FCdqWrQSEeTd0j+L7jeCWQumnr88D6bpcLIwHcVdTr1YOW+rnBx
   xj5QpnMrIqsdR4cre4vxmqMNlkAvLk4h2b3ULHTSDM3WUaxscsUwOm73z
   PpUoiKvX5kOuDaDjavXhKWAfA4rVxCnqwfxJLuLhtMcohkhNTYaH8kE/Y
   Yb4C6EftbnGeuUI3sTjFiJ58lwmLeugYJmQh5hBzVoRmD79y0DA45vNiw
   AnJOwtyzUTtKnykZW/ztyaG2rIvO7+It11O493hKH0uUf6TwdXy/6DG7v
   ccyUhCDC213gbJ1eRty7LkuOgTmT9nWlmmnD1GRxo6zjVT9PZyS68FMmk
   g==;
X-CSE-ConnectionGUID: U6eOTm3pTt6QvA8tdt1Qug==
X-CSE-MsgGUID: mCn7s7GzRfm91+FrExpJJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6921471"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6921471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="937076541"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="937076541"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2024 09:10:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AC427288; Thu, 28 Mar 2024 18:10:17 +0200 (EET)
Date: Thu, 28 Mar 2024 18:10:17 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"luto@kernel.org" <luto@kernel.org>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com" <seanjc@google.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <unsk2vaqeyh4a3zckf3vd3vxuv7rgtjq7dzv2kfdqrjjy6tvkl@rg5p46djnhmy>
References: <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
 <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
 <glorzobyf42wylp57izgiukbe33c6ez5mgiwxepgn6pt2h4lr3@aqdas5q75mcb>
 <9679cc44-fb90-d1ca-7c9a-10d0f6f5d3c2@amd.com>
 <144a6a5bb6f78966611b42a526e587c3daf4fd9f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <144a6a5bb6f78966611b42a526e587c3daf4fd9f.camel@intel.com>

On Mon, Mar 25, 2024 at 01:04:47PM +0000, Huang, Kai wrote:
> On Fri, 2024-03-22 at 09:50 -0500, Tom Lendacky wrote:
> > On 3/22/24 05:40, Kirill A. Shutemov wrote:
> > > On Thu, Mar 21, 2024 at 04:02:11PM -0500, Tom Lendacky wrote:
> > > > On 3/20/24 18:10, Kirill A. Shutemov wrote:
> > > > > On Thu, Mar 21, 2024 at 09:48:28AM +1300, Huang, Kai wrote:
> > > > > > 
> > > > > > > > Hi Tom,
> > > > > > > > 
> > > > > > > > I am not aware of kexec() support status for SEV-ES/SEV-SNP guests.
> > > > > > > > Does patch 1 break them?
> > > > > > > 
> > > > > > > SNP guests can kexec with some patches that are currently in process
> > > > > > > around shared to private memory conversions. ES guests can only kexec
> > > > > > > with a single vCPU. There was a recent patch series to add support for
> > > > > > > multiple vCPUs.
> > > > > > > 
> > > > > > > Patch #1 doesn't break either ES or SNP because we still have an IDT and
> > > > > > > traditional kernel addressing in place, so the #VC can be handled.
> > > > > > 
> > > > > > How about plain SEV guest?
> > > > > > 
> > > > > > > 
> > > > > > > Whereas patch #2 has switched to identity mapping and removed the IDT,
> > > > > > > so a #VC causes a triple fault.
> > > > > > 
> > > > > > That makes sense.  Thanks.
> > > > > > 
> > > > > > Hi Kirill,
> > > > > > 
> > > > > > Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() can
> > > > > > be handled although it causes #VE, while WBINVD in relocate_kernel() will
> > > > > > just triple fault the guest?
> > > > > 
> > > > > No. We never handle WBINVD #VE. Guest cannot handle WBINVD itself and the
> > > > > only option is to ask host to do this. We cannot guarantee host will do
> > > > 
> > > > Is the WBINVD performed or ignored in that case?
> > > 
> > > We crash the guest if it tries to use WBINVD. There's no legitimate reason
> > > for it.
> > > 
> > > > > anything useful with the request. I guess it can be potential attack
> > > > > vector if host strategically ignores WBINVD to induce bad guest behaviour.
> > > > 
> > > > With SNP, memory is coherent so there isn't a need for a WBINVD within a
> > > > guest and so issuing it should not be an issue whether the hypervisor
> > > > performs the operation or not. I don't know what can happen in the case
> > > > where, say, you have a non-coherent TDISP device attached or such, but that
> > > > would be very unusual/unlikely.
> > > 
> > > Looks like SNP is in the same position as TDX.
> > > 
> > > > > And it is not good from host PoV either. If it does WBINVD on every guest
> > > > > request we get guest->host DoS attack possibility.
> > > > 
> > > > Yeah, that can happen today, regardless of the type of VM running.
> > > > 
> > > > > 
> > > > > Tom, I am curious, how do you deal with these problems?
> > > > 
> > > > If the WBINVD is being intercepted, then it will generate a #VC and we use
> > > > the GHCB protocol to communicate that back to the hypervisor to handle.
> > > 
> > > I would argue that forwarding it to hypervisor is worse than crashing. It
> > > gives false sense of doing something. Hypervisor is outside TCB and
> > > considered hostile.
> > 
> > Since the memory is coherent, it really doesn't matter what the hypervisor 
> > does in regards to WBINVD (ignore it or perform it). And the hypervisor 
> > can do anything it wants on any exit, regardless of this intercept.
> > 
> 
> I guess it makes sense to not handle #VE due to WBINVD in the sense that guest
> shouldn't do WBINVD when memory is coherent from guest's view, although it is
> harmless to make the WBINVD and let hypervisor handle it.


> 
> Anyway, the current TDX guest doesn't handle #VE due to WBINVD, so I think for
> simplicity we just don't do WBINVD in stop_this_cpu() and relocate_kernel() for
> both TDX and SNP/SEV-ES guests.
> 
> As mentioned in my earlier reply, we can achieve this by skipping WBINVD when
> the CC_ATTR_GUEST_MEM_ENCRYPT is true:
> 
> 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> 		native_wbinvd();  
> 
> (This skips WBINVD for plain SEV guest too, but this exactly is the current
> behaviour of the upstream code, so I don't see any problem.)
> 
> Alternatively, we can have a dedicated CPU feature flag such as
> X86_FEATURE_NO_WBINVD,
> 
> 	if (!boot_cpu_has(X86_FEATURE_NO_WBINVD))
> 		native_wbinvd();
> 
> Or, we can just change to our mindset to "do unconditional WBINVD, but not in
> virtualized environment":
> 
> 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> 		native_wbinvd();

ACPI_FLUSH_CPU_CACHE() uses cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
check.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

