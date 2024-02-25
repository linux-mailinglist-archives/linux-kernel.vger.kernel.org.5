Return-Path: <linux-kernel+bounces-80169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EF862B50
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEEA2819E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A21759F;
	Sun, 25 Feb 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTNlvJm4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E6168DC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876486; cv=none; b=IhhZWzON26O4BP/jjbMmDC/q4pTjv9DNj9DFDD+8EaDWAU3lxi8mSRcEN4tbDVpPT2lXAXXPPq2yid5CIvkm07kdKqAgi7Vld2aKMQw3OBufelkXOU3WSaUM5DGicSRm7A+3WlFR3gNPZvTnRmCBJSjQJtj0v3YaTqi3J31IFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876486; c=relaxed/simple;
	bh=a8WuHvI6h6kLGhcZUjOjqEaaYOLzg47IYOWKmjJs8cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W13GRoZ4+/Ckqf0FA7KxqL4rdRb8lxsynQGgxifo4egZwIVs97qGjp6vnqtkT2EPJ+4KWucfb1x6NtInNZyW+scsGioTy0DKV1yy3w3TCS01jfBj7JVHRPfvWqd7Dtkt73gkUgB1VaeUOLRDZXDli94gypGWrzwC12FwUEV7S0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTNlvJm4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708876483; x=1740412483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a8WuHvI6h6kLGhcZUjOjqEaaYOLzg47IYOWKmjJs8cw=;
  b=LTNlvJm4il71MKR7KW6lxlggxAIjLTTQ4Wm0NZpIFcQkVvaO1WwCRhLg
   btvOz9FSuEnucqJ8VFsgauBQa2fJ66B32xtzwanl7LFyJUn1h1GxOBSZJ
   JJHW1PU1GNXgv6zfrlaGsRkIxlyj8TCHC28xP7aRRTR9PAztM/+RMoKnM
   e6aEghrOzQNL1zN+hK30+tWfDEmhO1bueJQElw6vzUJkV2BLmDxarieVw
   85fRcWbonQTB8tvcJxDj51o0vKUnpn20qz8cxIqR244Qccutid9R97RCM
   wBm36HRE7n+u5HBueP8nIWzmk+poeSAvo42brlrMTXltj05oXPSizBQAf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3296457"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3296457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 07:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937028120"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937028120"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 07:54:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B60FB425; Sun, 25 Feb 2024 17:54:36 +0200 (EET)
Date: Sun, 25 Feb 2024 17:54:36 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 08/16] x86/tdx: Account shared memory
Message-ID: <z6dsqhxzj4beyv4vj5uq6khpt6ti4mvs3uxunvli5cvi2hgfmv@rqbyr4wlzb6f>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-9-kirill.shutemov@linux.intel.com>
 <a69a3d67-7352-4bf4-8766-a55ce97e46bd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69a3d67-7352-4bf4-8766-a55ce97e46bd@intel.com>

On Fri, Feb 23, 2024 at 11:08:18AM -0800, Dave Hansen wrote:
> On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > The kernel will convert all shared memory back to private during kexec.
> > The direct mapping page tables will provide information on which memory
> > is shared.
> > 
> > It is extremely important to convert all shared memory. If a page is
> > missed, it will cause the second kernel to crash when it accesses it.
> > 
> > Keep track of the number of shared pages. This will allow for
> > cross-checking against the shared information in the direct mapping and
> > reporting if the shared bit is lost.
> > 
> > Include a debugfs interface that allows for the check to be performed at
> > any point.
> 
> When I read this, I thought you were going to do some automatic
> checking.  Could you make it more clear here that it's 100% up to the
> user to figure out if the numbers in debugfs match and whether there's a
> problem?  This would also be a great place to mention that the whole
> thing is racy.

What about this:

  Include a debugfs interface to dump the number of shared pages in the
  direct mapping and the expected number. There is no serialization
  against memory conversion. The numbers might not match if access to the
  debugfs interface races with the conversion.

> > +static atomic_long_t nr_shared;
> > +
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> 
> Name this pte_is_decrypted(), please.

But why? pte_decrypted() is consistent with other pte helpers pte_none(),
pte_present, pte_dirty(), ...

> >  /* Called from __tdx_hypercall() for unrecoverable failure */
> >  noinstr void __noreturn __tdx_hypercall_failed(void)
> >  {
> > @@ -821,6 +829,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> >  		return -EIO;
> >  
> > +	if (enc)
> > +		atomic_long_sub(numpages, &nr_shared);
> > +	else
> > +		atomic_long_add(numpages, &nr_shared);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -896,3 +909,59 @@ void __init tdx_early_init(void)
> >  
> >  	pr_info("Guest detected\n");
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> > +{
> > +	unsigned long addr, end;
> > +	unsigned long found = 0;
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte))
> > +			found += size / PAGE_SIZE;
> > +
> > +		addr += size;
> > +
> > +		cond_resched();
> > +	}
> 
> This is totally racy, right?  Nothing prevents the PTE from
> flip-flopping all over the place.

Yes.

> > +	seq_printf(m, "Number of shared pages in kernel page tables:  %16lu\n",
> > +		   found);
> > +	seq_printf(m, "Number of pages accounted as shared:           %16ld\n",
> > +		   atomic_long_read(&nr_shared));
> > +	return 0;
> > +}
> 
> Ditto with 'nr_shared'.  There's nothing to say that the page table walk
> has anything to do with 'nr_shared' by the time we get down here.
> 
> That's not _fatal_ for a debug interface, but the pitfalls need to at
> least be discussed.  Better yet would be to make sure this and the cpa
> code don't stomp on each other.

Serializing is cumbersome here. I can also just drop the interface.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

