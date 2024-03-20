Return-Path: <linux-kernel+bounces-108260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECF88087B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029D81F22B38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B021637;
	Wed, 20 Mar 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlXzimAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F87EC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893999; cv=none; b=Ao29suBkGpRI34vkkTebU/CUa3FpS97f/QPd2kfMjfFpP+gMeyjLjgu6UZAnkiuP44t3tfmZv+p2npMRNB7Ub8wBN0kBwU1NVpdt6cJIt9KmDNoy8JHTMLhOHS4WkhWv0I4DogceoTmpr2sQovxzf9ibsQKFcr5zaUjarWnuOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893999; c=relaxed/simple;
	bh=i2+grAK2i2sZWgaizDfTkI9mNEWNsYmZcW1JadIFYpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6J/vp4ZhiwPM7tdyS+52jlqvLICA0ch6DzL9jNnAE54Pw5MjCkqq9wcSNyqVkGp7uSoT+lFqPPMqAGzfaQ1upczdqppkPAqqxyVvGs6zLb9UrWL3bevEqoTpT7UABY+Rceefwmff5oGzfjE1zSWe+UbrxL/xP5fgKjJUqRLMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlXzimAp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710893997; x=1742429997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i2+grAK2i2sZWgaizDfTkI9mNEWNsYmZcW1JadIFYpY=;
  b=UlXzimAp61m13HRiWA4e/0nT9HVXFysRUTLaRWLNLXDELzZw6OotqvmS
   +pTFp6OKwszNMRCo9LTz/FIicpiPqrMf21c1Arq76fEfcrqbT32UHEOnH
   Aq+xRg5zvFct6lG1F3Jr5KfKN0RIEycLRk0PA6XGUfGBIfj9Djo8easyu
   60cwVCtm4YHiFYfUqQ027v3yXG2xte7/fmu3PDzrxG9hE/hLA5wwl7i0Z
   XhcfpOPr9mJYVGT3dNpfUaoOczT3sPzs50uD9WV/6kWXXjhwwRpxMSyyn
   zk5LGjTnXaOqG+lnbixL5Mv4GRrNt/C4cJfOWlvLx9cmAaA3WaQYGYXrM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17202492"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="17202492"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="937062663"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="937062663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2024 17:19:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A31477F1; Wed, 20 Mar 2024 02:19:51 +0200 (EET)
Date: Wed, 20 Mar 2024 02:19:51 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <i3nxazyv2dlauias4jmoqwpjixviuduaw6bgtfv4claxtimlm3@54xmat6zqud4>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>

On Wed, Mar 20, 2024 at 10:20:50AM +1300, Huang, Kai wrote:
> 
> 
> On 20/03/2024 3:38 am, Tom Lendacky wrote:
> > On 3/19/24 06:13, Kirill A. Shutemov wrote:
> > > On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
> > > > Both SME and TDX can leave caches in incoherent state due to memory
> > > > encryption.  During kexec, the caches must be flushed before jumping to
> > > > the second kernel to avoid silent memory corruption to the
> > > > second kernel.
> > > > 
> > > > During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> > > > remote cpus when they are being stopped.  For SME, the WBINVD in
> > > > relocate_kernel() flushes the cache for the last running cpu (which is
> > > > executing the kexec).
> > > > 
> > > > Similarly, for TDX after stopping all remote cpus with cache flushed, to
> > > > support kexec, the kernel needs to flush cache for the last running cpu.
> > > > 
> > > > Make the WBINVD in the relocate_kernel() unconditional to cover both SME
> > > > and TDX.
> > > 
> > > Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.
> > 
> > Ditto for SEV-ES/SEV-SNP, a #VC is generated and crashes the guest.
> > 
> 
> Oh I forgot these.
> 
> Hi Kirill,
> 
> Then I think patch 1 will also break TDX guest after your series to enable
> multiple cpus for the second kernel after kexec()?

Well, not exactly.

My patchset overrides stop_this_cpu() with own implementation for MADT
wakeup method that doesn't have WBINVD. So the patch doesn't break
anything, but if in the future TDX (or SEV) host would use MADT wake up
method instead of IPI we will get back to the problem with missing
WBINVD.

I don't know if we care. There's no reason for host to use MADT wake up
method.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

