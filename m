Return-Path: <linux-kernel+bounces-125189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D468921EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24AE1C24C62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540C4D110;
	Fri, 29 Mar 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7sGzsX5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031A2C19F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730909; cv=none; b=gbRG1j141ljUedRcDFT0h1jvidDaTCzhsOfj7FG9LijQc7kMwoZI+aXALnetxW/3Qc/Kiamtuia+9UDntS+gOcRDZZWGrBTidKY/OT1HxkUkzY571F14jJCdPMTk2rcZzYM6Ol1ql2ruTTbNCLtjeMbrjYxkUaidVQvHhTNGA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730909; c=relaxed/simple;
	bh=VHSFCeLmDsuoG8JZu78Wui4erUPAkz/n1mlCxxF71tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbzXTioIBMA57IqLm4h6FgaDKkTeu1IBnJd/F3NAfBv9Xjgs0VX6HejiFgpj+0+wmz6F2M+kqoRncOXR+aT4sQZ4qAFtEzA17yxnG/eqYBLLnEgoI8BxkyD+btbALVve28rYlo6Mj2DscfsHGtoBZzrLadXFqyj7gliNw65WNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7sGzsX5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711730908; x=1743266908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHSFCeLmDsuoG8JZu78Wui4erUPAkz/n1mlCxxF71tE=;
  b=k7sGzsX5crwd+fw9ENSYhKlFKR+2dnE/EnsRycLASfz6Zr+Pb6lrrDH/
   3neB3JkfjlXG0O1DCT1zO2w8PZzd1UmLm6LHxle8oiltHCmKC3lBMGdoA
   rMD3a8OhN5r1Ol7sDrXmonOfDuP2D4VjGnKKNlCbICFaLGVkxL+lEhOp1
   5kYzxWAEsc4qtGpPBY7uPjWAM6hwnSjn/JmJXNzeSmuhXC5VJBgwc2pPN
   D3V6EcPDxEGIIrABBTVKvxllPx1zINq6Dv1g4b7tZwRSUcMOVry5aAWbp
   fEsggD3irfk99LM/gWU1ZvV+LI7ybHhkEfkRlaCd/Lxgipwsxip891M2/
   w==;
X-CSE-ConnectionGUID: L0IqpdhXQ7K3hpdc4HngjQ==
X-CSE-MsgGUID: n9VN2X5UQHqVSCPmtJs8Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24385638"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24385638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="937078212"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="937078212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2024 09:48:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 59EA818F; Fri, 29 Mar 2024 18:48:21 +0200 (EET)
Date: Fri, 29 Mar 2024 18:48:21 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>

On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> 
> Will we consider making it more safe and compatible for future to guard
> against X86_FEATURE_MCE as well?
> 
> If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> not be fixed1.

Good point.

I guess we can leave it clear if it was clear. This should be easy
enough. But we might want to clear even if was set if clearing is allowed.

It would require some kind of indication that clearing MCE is fine. We
don't have such indication yet. Not sure we can reasonably future-proof
the code at this point.

But let me think more.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

