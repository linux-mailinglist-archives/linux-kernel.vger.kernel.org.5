Return-Path: <linux-kernel+bounces-109484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58417881A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881451C21667
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7364386130;
	Wed, 20 Mar 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Acdh6tVF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A533062
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710976254; cv=none; b=YUeAUdecBzuDhZiAo2UbUAjKCZ8Tz0T65QMERZ7iYc7RNBxe1CfmtISoguV413F4LHKJNqhlupLgmPugdgs0w8HGLMEgtr9Ftm5Y00mvs+GZBBqsBA4qSFOex2qh/dKeF9y+A7ca/wZkPIXDwAYBxk4AkaXEuw8VV+GZrXdg9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710976254; c=relaxed/simple;
	bh=uyHnoY1Ad4IbbzaGorHdPkT/SJXBuz3DwhDWwpSpa7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVovOF96i9GJ9qirsN0zRjZ5scgwZvYApVj0t3fO/2wOBjuoHW5J8U6Ri0aBEeRpqQpfmu2aiTqIDKk5B/9EoIEoC96lmBqRvtsDNmj/M8tDlcsYTY7O+N+ounEG7dWXHwEIBUEsgXSz6IRpPbtneh9V0uJ9Bs9BRJHA5vCgGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Acdh6tVF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710976253; x=1742512253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyHnoY1Ad4IbbzaGorHdPkT/SJXBuz3DwhDWwpSpa7Q=;
  b=Acdh6tVFko1Fuszg5+hz45rkJav/68f9BJDOxUrR75e+Y+U5NixT61Bs
   QC37saLIgd+rjYOjN2Zyie4/mxLlo1+zzi6uxF7j3hzyRfFn4TEl5c800
   9s1ISrP1rkJWMOE01JhSUXcsLh5iT4c+kzBE3lvLkmHD515SbXmSCZV+H
   k3BjiOF462eTg41PTOEsyVl3RT9JlTcsd6zymBhuQrOmUS8JULAHAy8M7
   QCr01ONasy20K2sTnqRG8F0UeMp6mGn8ZNZ1sQ4CRA0SKKtx+Vldd4X2s
   fQEe/lHlsQ1SUq5rXRCdz1qvVpyKskGt9sd9bVM95Kf9/KQV4PzH41sG3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5804850"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5804850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 16:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="937064112"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="937064112"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2024 16:10:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 443AC12B; Thu, 21 Mar 2024 01:10:47 +0200 (EET)
Date: Thu, 21 Mar 2024 01:10:47 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>

On Thu, Mar 21, 2024 at 09:48:28AM +1300, Huang, Kai wrote:
> 
> > > Hi Tom,
> > > 
> > > I am not aware of kexec() support status for SEV-ES/SEV-SNP guests.
> > > Does patch 1 break them?
> > 
> > SNP guests can kexec with some patches that are currently in process
> > around shared to private memory conversions. ES guests can only kexec
> > with a single vCPU. There was a recent patch series to add support for
> > multiple vCPUs.
> > 
> > Patch #1 doesn't break either ES or SNP because we still have an IDT and
> > traditional kernel addressing in place, so the #VC can be handled.
> 
> How about plain SEV guest?
> 
> > 
> > Whereas patch #2 has switched to identity mapping and removed the IDT,
> > so a #VC causes a triple fault.
> 
> That makes sense.  Thanks.
> 
> Hi Kirill,
> 
> Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() can
> be handled although it causes #VE, while WBINVD in relocate_kernel() will
> just triple fault the guest?

No. We never handle WBINVD #VE. Guest cannot handle WBINVD itself and the
only option is to ask host to do this. We cannot guarantee host will do
anything useful with the request. I guess it can be potential attack
vector if host strategically ignores WBINVD to induce bad guest behaviour.

And it is not good from host PoV either. If it does WBINVD on every guest
request we get guest->host DoS attack possibility.

Tom, I am curious, how do you deal with these problems?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

