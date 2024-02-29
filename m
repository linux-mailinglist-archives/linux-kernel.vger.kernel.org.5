Return-Path: <linux-kernel+bounces-87159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A533C86D06E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5698528609F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376770AD4;
	Thu, 29 Feb 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf9cgdX6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B66CC0A;
	Thu, 29 Feb 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227334; cv=none; b=MuSRoJyGeiFHIWjONmS6zJtAwAMLzggqnX0BoDqLr7U7UMseHm8z50+9WFCJpUlF0Hba9r+2KXuFlylEIsfRE+UUSot+zTnWUoSynbQvTM06NgHBHF85hpQfRCvAwt67SZdFO4CDTYrXSk2gCC62SGipVUV72UzSB+bqzy6SdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227334; c=relaxed/simple;
	bh=5pMf8xNbpjSltvyx9wwNJBOk7UVz6y8Mo4zNiAMjkj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+O2ejS9huAsRWJHbOO00lT347As6C5Rx33LYQwHr5KxzgGnVUv07nskEIpEAh6uHKxB9AmX5PzKgGOZ8LbWTeLY+h0FY8YAmVXaGdmjkwi/YGpKECuhQ0CDoJkjUeX0g8WHf4MdgwJnati3sKOETHh2xgXANy/kNbjeCv0vD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf9cgdX6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709227332; x=1740763332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pMf8xNbpjSltvyx9wwNJBOk7UVz6y8Mo4zNiAMjkj4=;
  b=Rf9cgdX6vtSvuEl7IxTrx1WsYxFPAyCrA5vPIXoHjhP4+23g/PVXEgfs
   Z58kecbaUYTRF9gb/+TbEEB8faN94QpVu7xvH18iXRy1QwMvZgAWMri8z
   XhVbuGdP2gXVur49CugXlpch2JMnsRf1IlUPkepK86j3rGLtztvChgr01
   nrpFVoN7Czwl/ZaAsnNxg3iGJKubsb0Nf0sFoj4ls4iqXfOzMbxG2bz0P
   a63hHcGapyyXvu/WtCofuDgn1kyRpDiR7pebgPcuR6Kw9Pwv45eQNRSPs
   F62CmoF1mCV4JF8Itj5bC4u3r+1AR/uRR9w3xfp8CE6E3Wi2m5jFuLjy8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15130393"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15130393"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12585179"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:21:04 -0800
Date: Thu, 29 Feb 2024 09:21:02 -0800
From: Tony Luck <tony.luck@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Naik, Avadhut" <avadnaik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <ZeC8_jzdFnkpPVPf@agluck-desk3>
References: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>

On Wed, Feb 28, 2024 at 05:56:26PM -0800, Sohil Mehta wrote:
> A few other nits.
> 
> On 2/28/2024 3:14 PM, Tony Luck wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> > index fbe8b61c3413..a1f0a8f29cf5 100644
> > --- a/arch/x86/kernel/cpu/mce/genpool.c
> > +++ b/arch/x86/kernel/cpu/mce/genpool.c
> > @@ -16,14 +16,13 @@
> >   * used to save error information organized in a lock-less list.
> >   *
> >   * This memory pool is only to be used to save MCE records in MCE context.
> > - * MCE events are rare, so a fixed size memory pool should be enough. Use
> > - * 2 pages to save MCE events for now (~80 MCE records at most).
> > + * MCE events are rare, so a fixed size memory pool should be enough.
> > + * Allocate on a sliding scale based on number of CPUs.
> >   */
> > -#define MCE_POOLSZ	(2 * PAGE_SIZE)
> > +#define MCE_MIN_ENTRIES	80
> >  
> >  static struct gen_pool *mce_evt_pool;
> >  static LLIST_HEAD(mce_event_llist);
> > -static char gen_pool_buf[MCE_POOLSZ];
> >  
> >  /*
> >   * Compare the record "t" with each of the records on list "l" to see if
> > @@ -118,14 +117,25 @@ int mce_gen_pool_add(struct mce *mce)
> >  
> >  static int mce_gen_pool_create(void)
> >  {
> > +	int mce_numrecords, mce_poolsz;
> 
> Should order be also declared in this line? That way we can have all the
> uninitialized 'int's together.

Sure. Even with the addition of "order" the line is still short enough.

> >  	struct gen_pool *tmpp;
> >  	int ret = -ENOMEM;
> > +	void *mce_pool;
> > +	int order;
> >  
> > -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
> > +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
> 
> I didn't exactly understand why a +1 is needed here. Do you have a
> pointer to somewhere to help understand this?
> 
> Also, I think, a comment on top might be useful since this isn't obvious.

gen_pool works in power-of-two blocks. The user must pick a specific
size with the gen_pool_create() call. Internally the gen_pool code uses
a bitmap to track which blocks in the pool are allocated/free.

Looking at this specific case, sizeof(struct mce_evt_llist) is 136. So
the original version of this code picks order 7 to allocate in 128 byte
units. But this means that every allocation of a mce_evt_llist will take
two 128-byte blocks.

Net result is that the comment at the top of arch/x86/kernel/cpu/mce/genpool.c
that two pages are enough for ~80 records was wrong when written. At
that point struct mce_evt_llist was below 128, so order was 6, and each
allocation took two blocks. So two pages = 8192 bytes divided by (2 * 64)
results in 64 possible allocations.

But over time Intel and AMD added to the structure. So the current math
comes out at just 32 allocations before the pool is out of space.

Yazen provided the right answer for this. Change to use order_base_2()

> > +	tmpp = gen_pool_create(order, -1);
> >  	if (!tmpp)
> >  		goto out;
> >  
> > -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> > +	mce_numrecords = max(80, num_possible_cpus() * 4);
> 
> How about using MCE_MIN_ENTRIES here?

Oops. I meant to do that when I added the #define!

I've also added a "#define MCE_PER_CPU 4" instead of
a raw "4" in that expression.

-Tony

