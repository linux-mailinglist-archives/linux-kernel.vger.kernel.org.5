Return-Path: <linux-kernel+bounces-74874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375285DF36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563DDB2C547
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4727CF2D;
	Wed, 21 Feb 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpjYdbGP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8927C09A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524936; cv=none; b=PBTvki+17Nq6H5vEvQjMWQV+HkNwpPCo9yqtBACI3vM/NbdUpfU8dx3JRcdwaQjUPjcnhhr4NSQ078CBAVnOSVOxknV6pSvPwEKBCLnwX1bTw3Z3I3cXswRY/4iJVTALIqaGSiUxqtqpSQm0IMuPSZlrDoE66pLEsKMe9AOQsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524936; c=relaxed/simple;
	bh=/vYbdGx/biRaDTrw8g8KGes/oIyLAhiiHJyRW4pxB+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta3DZk4ov3Sq5kOIkMZ9Ju8MDY/rGY48uXnVysa0JxyKb3iGEDLrkmEJYXy745295tGd04SpYJKhs8ezVIrwzOix19U9WbjySwcyDkdfPU1d5SxyAh70ibuKnbzdCaU6U9xMIkRosr6ueeqPFISPHC8lJ+LrfZRK32TEcv/bMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpjYdbGP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708524934; x=1740060934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/vYbdGx/biRaDTrw8g8KGes/oIyLAhiiHJyRW4pxB+Y=;
  b=lpjYdbGPaZPL7tjqptdduzJ2ckcHht0Yrn5LbBpdqyLNTjazF5RUJWzh
   LeT7osONuHngXyP35I9g/q19Q7H0KnolkNI43DpSznjxzX0zp0HO4n50h
   h4Z+6Plv8yVECdjxs7J7PICs+urOLpz/F9Y+oiQu3Bt8OCNuiZa5fAtTm
   11udXFtdD5qiukSJfavgWdBZ2TbByuK+kaQoJ751qCGnm0mkW32/M/JoC
   fH5iAaFQsyafOPtiRo48nAN0AoEmlK3UMasDe66tkHuxsci0o/yD5Wxn9
   t3I/QoJlGIUpIPpBfiqKgUw1SzA2mknV/OlHSAsApKWTWnEKA80ANZuUU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6500408"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6500408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936650868"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="936650868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 06:15:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CEA572AB; Wed, 21 Feb 2024 16:15:27 +0200 (EET)
Date: Wed, 21 Feb 2024 16:15:27 +0200
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
Message-ID: <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdVh6efExdt687YY@MiWiFi-R3L-srv>

On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 3612e3167147..425ff6e192e6 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> >  
> >  /*
> >   * Lookup the page table entry for a virtual address in a specific pgd.
> > - * Return a pointer to the entry and the level of the mapping.
> > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > + * the entry is none) and level of the entry.
>                        ^ this right parenthesis may need be moved to the end.
> 
> 
> =======
>  * Return a pointer to the entry and the level of the mapping (or NULL if
>  * the entry is none and level of the entry).
> =======

Emm.. I like my variant more. We return level regardless if the entry none
or not. I don't see a reason to repeat it twice.

> >   */
> >  pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >  			     unsigned int *level)
> > @@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >   * Lookup the page table entry for a virtual address. Return a pointer
> >   * to the entry and the level of the mapping.
> >   *
> > - * Note: We return pud and pmd either when the entry is marked large
> > - * or when the present bit is not set. Otherwise we would return a
> > - * pointer to a nonexisting mapping.
> > + * Note: the function returns p4d, pud and pmd either when the entry is marked
>                                           ~~~
>                                            ^ s/and/or/

Fair enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

