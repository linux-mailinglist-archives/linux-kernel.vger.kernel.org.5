Return-Path: <linux-kernel+bounces-71719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F391185A972
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33371B25548
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36237446B7;
	Mon, 19 Feb 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DE1v5gTR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D540BFD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361843; cv=none; b=gsWM29fmnpMIueU+q0Cu2wictI1vHrpy6nctlq7UjuLzFZ/9t72uxADYFTsVS+SFmvANqQyfNcGRzhLqnLXqZIEjhdnUnsxk9Mpt1JIFHsZ1gAclZjwxMv+O6YFzGy06fbVXoVuQzetoqy5kVQ+3Rocl9JT04YVAxdk+AnRFTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361843; c=relaxed/simple;
	bh=IE9yLgCLboY5cjMouYX9HJyBsFPx6jwa25FyuQUHofM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQh5wJFfGg1bbgnPagDmO9yDpBS/8TUNgp/v4h4F0M0KYirgTe5Z+onR/PQAx5OUp8ZiaeKKIeEmOsUOURXyG/Z9gCaSMPHTw/yiR691znKsyAx6Ffk1+aXFDGhFyBqFhapsDGqZqnaAhY1mdaZNNqqYWIfNFBVxZL3r5/uVTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DE1v5gTR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708361842; x=1739897842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IE9yLgCLboY5cjMouYX9HJyBsFPx6jwa25FyuQUHofM=;
  b=DE1v5gTRuR9+GxxbpjEVo+I3pFZOrvK2JFXq7Ix5hJAl8i4C/gQZV5Mt
   98xmCqTgermYt5gPPYzv1GEBxmRn8VI/6WDasZca5kzwaDxySgWi+qy1J
   Smz1+wS8Sbfmj4okxDi4x9T8TjiXNfbV1Xgs4x65JD6FFYXMcdY1ryoz0
   y+VAO2mdAtJZtDmWg/VdYYbzcJ4A1PzY/ASuGJDPNBFFJ2dHRscH5H3Rp
   IZnNlCCrHD1ANhVVjBvD0K7Vnx6xk/8rWkiL61NkGOEKHzn7W2K1NsUVt
   MD5MMY12LFItP3v2MrJa9dfrmFf7QCw0V1KsiTqYafImKTxjaKvalz/qN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13858712"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13858712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936314029"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936314029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 08:57:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 549A2305; Mon, 19 Feb 2024 18:57:16 +0200 (EET)
Date: Mon, 19 Feb 2024 18:57:16 +0200
From: "Shutemov, Kirill" <kirill.shutemov@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, "Dong, Eddie" <eddie.dong@intel.com>, 
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Message-ID: <fjiqqn6biwrtaye57dbhxk43jrbvh42cywcmt73zzp2nusmglu@ipb2fdxusyqm>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <447b491f-ae1a-85db-a862-0a2b999cd0d4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447b491f-ae1a-85db-a862-0a2b999cd0d4@amd.com>

On Fri, Feb 16, 2024 at 01:46:41PM -0600, Tom Lendacky wrote:
> > 4. Define a new guest abstraction/guest type that would be used for
> > !VMPL0/L2 guest. This allows in the future to define a unified L2 <-> L1/VMPL!0
> > <-> VMPL0 communication interface that underneath would use Intel
> > TDX/AMD SEV-SNP specified communication primitives. Out of existing Linux code,
> > this approach is followed to some initial degree by MSFT Hyper-V implementation [2].
> > It defines a new type of virtualized guest with its own initialization path and callbacks in
> >   x86_platform.guest/hyper.*. However, in our understanding noone has yet
> > attempted to define a unified abstraction for such guest, as well as unified interface.
> > AMD SEV-SNP has defined in [4] a VMPL0 <--> !VMPL0 communication interface
> >   which is AMD specific.
> 
> Can TDX create a new protocol within the SVSM that it could use?

Sure we can. But it contributes to virtualization zoo. The situation is
bad as it is. Ideally we would have a single SVSM guest type instead of
SVSM/TDX and SVSM/SEV.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

