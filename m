Return-Path: <linux-kernel+bounces-87207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125E86D116
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05462B21D84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139CA70AF7;
	Thu, 29 Feb 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d17RTBnL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348241C77;
	Thu, 29 Feb 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228859; cv=none; b=nT0pf/kMraCOY8g71xmYMsdB+txX+sNvaa0bzSSUWeV60J6mrZCblaKKlr8w/zZ9TgXFiSS4CoSF/L5fAYuqLFrtbK96omWLzmWN00fMH+CnU0HVqm9ZPPPl87dbQ7F1nK7bk9xC0I0nFoJRPUMxGPz6ww22pPtM+qABgE0Z4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228859; c=relaxed/simple;
	bh=zOm8v0xgvoTy0+JJYPF0SRtMmSadzTUnyE6CXTv40rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjsX7xiOwNhW8asaK5/d8O+hTO+fB+SnNBqtITBto/iUwrKVPhXHDoGUaHaP9vtheUCwUs96WY94WRZwUTG5VR8RXfxvHm2o3hKjUy1Spbv7Ur0+/0WTxc5Yc56s+wTevWL3yqf0gjXSfIfrLCpdo6KjJ3vqoyhX/44bfRA+YIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d17RTBnL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709228858; x=1740764858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zOm8v0xgvoTy0+JJYPF0SRtMmSadzTUnyE6CXTv40rw=;
  b=d17RTBnLla4bqkwx8klURgWU2o4H4pH3w36BNhvworBST1HbGmMR/8Lx
   C7GjB3fodcCrG5kRTc237rEj0lc39/j3PQuqIREwwWwZXKF58GoDof4Co
   yInFQp5g3sMeaMEJGrvKrR80W2jTEqWhHmRi3cm7pH37LYf3ANBOPJ1gO
   IKATytS6NMZxT122TW2CeI3/nSQ8oSA54bvt+DmiCDNUfN5It5VNI/VZd
   D9TVXxZXjC6zz3zjb2ofuskYtBREyyaoYH4agLXT+X1CLrVTkED6ZoO4+
   BOQhmuFlWjhQB3mXjt0EgCxr84rVJIxNqbcQFi9+lMxlSVGlWqyvIbAoe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7498320"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7498320"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:47:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8033487"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:47:26 -0800
Date: Thu, 29 Feb 2024 09:47:24 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <ZeDDLLQWPyyZve_s@agluck-desk3>
References: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
 <20240229083951.GAZeBC1yS3MPonWwKv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229083951.GAZeBC1yS3MPonWwKv@fat_crate.local>

On Thu, Feb 29, 2024 at 09:39:51AM +0100, Borislav Petkov wrote:
> On Thu, Feb 29, 2024 at 12:42:38AM -0600, Naik, Avadhut wrote:
> > Somewhat confused here. Weren't we also exploring ways to avoid
> > duplicate records from being added to the genpool? Has something
> > changed in that regard?
> 
> You can always send patches proposing how *you* think this duplicate
> elimination should look like and we can talk. :)
> 
> I don't think anyone would mind it if done properly but first you'd need
> a real-life use case. As in, do we log sooo many duplicates such that
> we'd want to dedup?

There are definitly cases where dedup will not help. If a row fails in a
DIMM there will be a flood of correctable errors with different addresses
(depending on number of channels in the interleave schema for a system
this may be dozens or hundreds of distinct addresses).

Same for other failures in structures like column and rank.

As to "real-life" use cases. A search on Lore for "MCE records pool
full!" only finds threads about modifications to this code. So the
general population of Linux developers isn't seeing this.

But a search in my internal e-mail box kicks up a dozen or so distinct
hits from internal validation teams in just the past year. But those
folks are super-dedicated to finding corner cases. Just this morning I
got a triumphant e-mail from someone who reproduced an issue "after 1.6
million error injections".

I'd bet that large cloud providers with system numbered in the hundreds
of thousands see the MCE pool exhausted from time to time.

Open question is "How many error records do you need to diagnose the
cause of various floods of errors?"

I'm going to say that the current 32 (see earlier e-mail today to
Sohil https://lore.kernel.org/all/ZeC8_jzdFnkpPVPf@agluck-desk3/ )
isn't enough for big systems. It may be hard to distinguish between
the various bulk fail modes with just that many error logs.

-Tony

