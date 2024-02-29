Return-Path: <linux-kernel+bounces-87168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE386D093
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5595128A06E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F095A70ACC;
	Thu, 29 Feb 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE/bZrx8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53785E082;
	Thu, 29 Feb 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227620; cv=none; b=potryGPIIHOjjs50krfXwEoN/rMKE0C/+rbdZV1Hj30NapaTHfTPRR8wy+YGnHKlkLn4dSorPGMMLtor1wevqQoD/zYtFxpvgCV1sIY5LkacCJawPJZgJ5Jx6wx7ZNqh4tH/LpeE2RlzLf7GHnokc7ARItkdx/AShKttRrC6Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227620; c=relaxed/simple;
	bh=/JaDBH1RUWq1bA062JryjFL4ALd2l03adAlP7w/617s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1pZYdJUPWS6iMnuJCzTUmli+Slig/2VjLrZaUYomY8k7uUNKF+mZJzFKARedL08XtuUh5p/mBP9rvjjc7uPVHgXD7s3zvQ35NEdKHiVv6D955ZO/R78O8xyQMRSWhpSCuL/uOOIzoidTKZPsC8iv6N0U8uUzPHBNWTOBtiGVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE/bZrx8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709227619; x=1740763619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/JaDBH1RUWq1bA062JryjFL4ALd2l03adAlP7w/617s=;
  b=iE/bZrx8WtZ7QF16L0fruAOK8FXRB00cK6Ryx/O7dTVlgV7vwOjpBjSU
   COZOM7go0WX9RYk7Ch7A7EFrzSmKYjs/a75eFK5FavfiSjG5UmJ79EyVY
   D+AZm4ta8c5ks5KYsgd5PXvXcoWQaBcqWLwG2VnpIDYnEvLO1Oc61ehad
   YA7uPFnf4U6rYT7QfTY3/3jd+JhszQ6yoV9dH5qNAy0CAhU5se+BxNAqM
   60WDqkbACjVIGdqApgO8xMiijaZ3JxDcz50w3NvxyQB/o/MEg0Usl+HrS
   M+pExvvYPpLAZm/FckLWdtFq9MrcTzKf4ZuoN6Y/6+KI1i25gmt6hbsEc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3600313"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3600313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7820865"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:26:58 -0800
Date: Thu, 29 Feb 2024 09:26:56 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <ZeC-YGnnYAMh5kPn@agluck-desk3>
References: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>

On Thu, Feb 29, 2024 at 12:42:38AM -0600, Naik, Avadhut wrote:
> Hi,
> 
> On 2/28/2024 17:14, Tony Luck wrote:
> > Systems with a large number of CPUs may generate a large
> > number of machine check records when things go seriously
> > wrong. But Linux has a fixed buffer that can only capture
> > a few dozen errors.
> > 
> > Allocate space based on the number of CPUs (with a minimum
> > value based on the historical fixed buffer that could store
> > 80 records).
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > 
> > Discussion earlier concluded with the realization that it is
> > safe to dynamically allocate the mce_evt_pool at boot time.
> > So here's a patch to do that. Scaling algorithm here is a
> > simple linear "4 records per possible CPU" with a minimum
> > of 80 to match the legacy behavior. I'm open to other
> > suggestions.
> > 
> > Note that I threw in a "+1" to the return from ilog2() when
> > calling gen_pool_create(). From reading code, and running
> > some tests, it appears that the min_alloc_order argument
> > needs to be large enough to allocate one of the mce_evt_llist
> > structures.
> > 
> > Some other gen_pool users in Linux may also need this "+1".
> > 
> 
> Somewhat confused here. Weren't we also exploring ways to avoid
> duplicate records from being added to the genpool? Has something
> changed in that regard?

I'm going to cover this in the reply to Boris.

> > +	mce_numrecords = max(80, num_possible_cpus() * 4);
> > +	mce_poolsz = mce_numrecords * (1 << order);
> > +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> 
> To err on the side of caution, wouldn't kzalloc() be a safer choice here?

Seems like too much caution. When mce_gen_pool_add() allocates
an entry from the pool it does:

	memcpy(&node->mce, mce, sizeof(*mce));
	llist_add(&node->llnode, &mce_event_llist);

between those two lines, every field in the struct mce_evt_llist
is written (including any holes in the struct mce part of the structure).

-Tony

