Return-Path: <linux-kernel+bounces-87158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F886D06C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54F01F2347B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4006CC00;
	Thu, 29 Feb 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZEA4Vnz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485994AECF;
	Thu, 29 Feb 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227331; cv=none; b=oFZ9f7OxEt6OwBufXJ6y5R5em4zPDQZfvmvNY6i47e7JK/nvnTSyMWHrgonne/4Alp4y6L66SaewmyNuDQ85Y5CkHc7y9ppBeWbw7y1ksuz6q1qtKsbsm7qr8bScdWxctVJySuB2XXqUFd/t/7vGWasPUV2UvFmkVyiVC/wZdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227331; c=relaxed/simple;
	bh=HYuJGx/Bb8kUZUxyWYdQ8U03zRNKrbpN8+GXzIkmFQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvdXGBTs4uXKnWHvzrCrsKG1a1DyS5nV/4nOENchtiVNZLCyTlI2snQvJyeVZgSTT2ohbxhk6ilOjQIXl3vg4QkxYe8sRgh80doNo70OALzgjp9NjE09p6zFkGCJKiaGAkUFUZzWXHxTR5YJ4rzpKB1Uv7XfbjF47+qGK2Z7ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZEA4Vnz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709227327; x=1740763327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYuJGx/Bb8kUZUxyWYdQ8U03zRNKrbpN8+GXzIkmFQ0=;
  b=cZEA4Vnz/W5jwk9GL0fOI8dKiRCNfcznyIOAJrVQmIDGYBv9PTu/mAAW
   mg6zy/FSP5bQCpMjpCb5B6Tdu+U1UK+pvxr2IYphsFAFgpqlQvk0PO4Ix
   s3Jl6aclBvEZ0Cwu/pGXQaA/nEIkg0LDoGt5eT8i4Rnn2mbdjOPXacDeO
   R0FHPX9EGuODCIQYdnhZ6VC59pKXbdRJqv4vBYikpa9YDHZB4Uk96GhJ5
   9qQE304x1CPTebMZGTjhJcK8L02VVnZ+GgBcZm8V9tMtM673H8CMv8fR4
   e0ajSXYI2OtbvuQhE85WcHruZQrnkDH/erqnH4X4J2D8KarQZujY4CF9R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3599384"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3599384"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7820421"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:22:06 -0800
Date: Thu, 29 Feb 2024 09:22:05 -0800
From: Tony Luck <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Borislav Petkov <bp@alien8.de>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <ZeC9PRltlRYBNS0I@agluck-desk3>
References: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
 <b019fb64-fde5-4ade-964b-03a3a217dfd2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b019fb64-fde5-4ade-964b-03a3a217dfd2@amd.com>

On Thu, Feb 29, 2024 at 10:49:18AM -0500, Yazen Ghannam wrote:
> On 2/28/2024 8:56 PM, Sohil Mehta wrote:
> > > +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
> > 
> > I didn't exactly understand why a +1 is needed here. Do you have a
> > pointer to somewhere to help understand this?
> > 
> > Also, I think, a comment on top might be useful since this isn't obvious.
> > 
> 
> Would order_base_2() work here? It automatically rounds up to the next power.

Yes!  That's exactly what is needed here. Thanks!

-Tony

