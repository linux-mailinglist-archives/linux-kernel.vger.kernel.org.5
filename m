Return-Path: <linux-kernel+bounces-71430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6285A525
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A1D1F218CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F436AE5;
	Mon, 19 Feb 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcte9Ltr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74A36134
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350770; cv=none; b=EImvzW6yTRTeTF3ld//G8sTVeTXoZbL+PsRNMW+QBVD28T6QtoRsR7fnkbEYhqjJn1dR0BAfijxTVwxBQTXOYzvy+Uf5KG5pdXMXuVkkUhy1CSfjPJzTx9OydZPe7ymp2NLxpnSvosgCDEVTZFiJLPoh762eWxAmlLadn6o5oQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350770; c=relaxed/simple;
	bh=yPMBSovixa7VCIL6tvi34aVw1yfzyVwmD5bVU4sWDNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ7RmbM4mm2U/Qg4pr3kWcTivM/H8mtICiK1diRhU6bRY5PCrqd4hcDArGP+leK6JXuEE4ND2LU1iyMWZEm7Y0+xZ1frb0AS5C7s/ojRDky2f99I6zsQfNkj5VTgNmjsu/GMkyYiABhJDStx0hrU0WxK7vglea7IsFvFvenlOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcte9Ltr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708350768; x=1739886768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yPMBSovixa7VCIL6tvi34aVw1yfzyVwmD5bVU4sWDNs=;
  b=lcte9LtrzVR/a2XNInONQlzTJbiRZHhyNQjXnzYk8x3Z7AEtxjRigOF7
   lMIUiuiMu/AogGAd6rrhk+mmeX8AYyDtMkhL/2finxOINhSYvN+EeZ5qp
   7P/+HJVnu9yfPRz1n0yM/iVXotWM/4ScWMIocQBCkD48gcBI8tnGUi9ey
   XTn7KXKXO3dccMNuozpE7yb/3pz9tX/OClo3b4im86OosLUIF1/Omb8kP
   WCI1hyHF7SeRv2qxjrtYDxRSt70Ef4Y8/GSdPuMOM1CbxfrkUBm52MxVh
   nH9wTnVi7n0ImTkDHTs321WLnSqMe1b4m8Su8349QFxi4Uappooxlnmcz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2333811"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2333811"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 05:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936293708"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936293708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 05:52:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9DC35350; Mon, 19 Feb 2024 15:52:41 +0200 (EET)
Date: Mon, 19 Feb 2024 15:52:41 +0200
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
Message-ID: <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>

On Mon, Feb 19, 2024 at 01:12:32PM +0800, Baoquan He wrote:
> On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> > lookup_address() only returns correct page table level for the entry if
> > the entry is not none.
> > 
> > Make the helper to always return correct 'level'. It allows to implement
> > iterator over kernel page tables using lookup_address().
> > 
> > Add one more entry into enum pg_level to indicate size of VA covered by
> > one PGD entry in 5-level paging mode.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > ---
> >  arch/x86/include/asm/pgtable_types.h | 1 +
> >  arch/x86/mm/pat/set_memory.c         | 8 ++++----
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 0b748ee16b3d..3f648ffdfbe5 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -548,6 +548,7 @@ enum pg_level {
> >  	PG_LEVEL_2M,
> >  	PG_LEVEL_1G,
> >  	PG_LEVEL_512G,
> > +	PG_LEVEL_256T,
> >  	PG_LEVEL_NUM
> >  };
> >  
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index f92da8c9a86d..3612e3167147 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> By the way, we may need update the code comment above function
> lookup_address_in_pgd() and function lookup_address() since they don't
> reflect the latest behaviour of them.

I am not sure what part of the comment you see doesn't reflect the
behaviour. From my PoV, changed code matches the comment closer that
original.

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

