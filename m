Return-Path: <linux-kernel+bounces-76659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3EC85FAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E731F28657
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659371386A1;
	Thu, 22 Feb 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UI2dxVYn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D52134CFC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610678; cv=none; b=ACX7E5S769tXsCKKueHUyPv0A0GwkuX+WzUnx2N75SYkCfMhB1xaSGzu2LJJOR//2m+OU33yC+hjUdtTPv1pRsNS8y/bMex4WnVJi/zsZHDxHzNWvh3X8J9uEjPPu8VWL3gGybuF65UGQ20Dfaj/EiDYxUbydzvY+P42O8wO/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610678; c=relaxed/simple;
	bh=E75gomph1S/AxYryUcEMcOovIP7yR0F0aFziV9Jmk+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCzN1L8blyzkY/2iy9YH+8Wk8G5soHdo2E9mHvPNgEEvRh6IaI8u38XUZVouBbBvOQNzZUyOSVs8UiBhEZuL9wvM3JB7LqOxtw6JL0Lf5jukIE72YwZTGGicm+mwRiA0Eu2aozAqLkJ8FFZMhAMppU06p65o8M2w1docvnyY+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UI2dxVYn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708610677; x=1740146677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E75gomph1S/AxYryUcEMcOovIP7yR0F0aFziV9Jmk+c=;
  b=UI2dxVYnk4gaIKmiL5ioesUckdHm3EbegcuLjCOSJAOMCUB3Qo+L4Inc
   V/+CSWlWRaZC9RUEhc9revGXd9v7kWBRZaUEiMfTntsv9cXAzbQUTbqwA
   kDGYcYmkS+DPIeLc2d8KWaI7h3JDGm3B63PubYSYpMZtESwq3QjLvhaqd
   wUvb9zzRGJGvrP4ztWvlEc+DnRghw2/X0w+ffEY3rLWV8LSW6dCfJ7HAO
   qzVRRcMHRq/7PC54dE+fzJ4ix109o/gvzPIohWZNcvCQBGUrPPbWvZTZL
   HMc/IhF0DvPKfrmiI/8WAKDwY94vB6Vfy/NBlw4ETPCK54qZmkQqUifJu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6613715"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6613715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936853749"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936853749"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 06:04:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 353C1458; Thu, 22 Feb 2024 16:04:17 +0200 (EET)
Date: Thu, 22 Feb 2024 16:04:17 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <k33hshbceai3tb7qe6id6kx3iqf7kjhlyvdijvmuf6knv32krs@kwo3m7dkn5sm>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
 <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
 <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>

On Thu, Feb 22, 2024 at 07:01:41PM +0800, Baoquan He wrote:
> On 02/21/24 at 04:15pm, Kirill A. Shutemov wrote:
> > On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > index 3612e3167147..425ff6e192e6 100644
> > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> > > >  
> > > >  /*
> > > >   * Lookup the page table entry for a virtual address in a specific pgd.
> > > > - * Return a pointer to the entry and the level of the mapping.
> > > > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > > > + * the entry is none) and level of the entry.
> > >                        ^ this right parenthesis may need be moved to the end.
> > > 
> > > 
> > > =======
> > >  * Return a pointer to the entry and the level of the mapping (or NULL if
> > >  * the entry is none and level of the entry).
> > > =======
> > 
> > Emm.. I like my variant more. We return level regardless if the entry none
> > or not. I don't see a reason to repeat it twice.
> 
> 
>  * Lookup the page table entry for a virtual address in a specific pgd.
>  * Return a pointer to the entry and the level of the mapping (or NULL if
>  * the entry is none) and level of the entry.
> 
> Hmm, I am confused. Why do we need to stress the level of the mapping
> and level of the entry? Wondering what is the difference. I must miss
> something.

My bad. This is way I meant to write:

 * Lookup the page table entry for a virtual address in a specific pgd.
 * Return a pointer to the entry (or NULL if the entry does not exist) and
 * the level of the entry.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

