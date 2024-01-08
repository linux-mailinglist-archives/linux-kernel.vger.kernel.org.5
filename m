Return-Path: <linux-kernel+bounces-19328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27460826B74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88001F22B31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403113AED;
	Mon,  8 Jan 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2E69y5g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89713ADC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704709042; x=1736245042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMOz/zIu+0whcXBIOPFjSv94Cgq9Vj6+RGisnpMjR4s=;
  b=Q2E69y5gxk+x8HO0BjJSkdG/tWp0LMIUuoK+dsWt5T1uxlYN3bY19yuO
   +YwX0kEXlop4S4IsALmJC2XXZhdkqCH/FH/Lz2JmtGrdqbhvVcVzU+ruN
   JOsJpnnqeuEDnSTqCxSVNht7pd0BGKmF2O1Zr42O4/8ry6Ye4C7b6wFu/
   kajM21WVLGbKo23CZ42zvQySE8ZLTBSamR4EvoaYfh70Rni4GYrG0qKHE
   UYmgJR9zsfWvQTDvuc1H4yvCL+7egeLeU0ezvGVb3sDE8+p92EtxlFWEZ
   J27JKx/7PjrWtE3AfM8nKMgQp5ziHvQFJl1nwuJz3Mz9rg8BDz4YoH2Cy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="377983815"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="377983815"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="900331920"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="900331920"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:17:17 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 66EB4109E5C; Mon,  8 Jan 2024 13:17:15 +0300 (+03)
Date: Mon, 8 Jan 2024 13:17:15 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Message-ID: <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
 <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>

On Mon, Jan 08, 2024 at 03:30:21AM +0000, Huang, Kai wrote:
> On Mon, 2024-01-08 at 03:13 +0000, Huang, Kai wrote:
> > On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > > The helper complements kernel_ident_mapping_init(): it frees the
> > > identity mapping that was previously allocated. It will be used in the
> > > error path to free a partially allocated mapping or if the mapping is no
> > > longer needed.
> > > 
> > > The caller provides a struct x86_mapping_info with the free_pgd_page()
> > > callback hooked up and the pgd_t to free.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/init.h |  3 ++
> > >  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 76 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > > index cc9ccf61b6bd..14d72727d7ee 100644
> > > --- a/arch/x86/include/asm/init.h
> > > +++ b/arch/x86/include/asm/init.h
> > > @@ -6,6 +6,7 @@
> > >  
> > >  struct x86_mapping_info {
> > >  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> > > +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
> > >  	void *context;			 /* context for alloc_pgt_page */
> > >  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
> > >  	unsigned long offset;		 /* ident mapping offset */
> > > @@ -16,4 +17,6 @@ struct x86_mapping_info {
> > >  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
> > >  				unsigned long pstart, unsigned long pend);
> > >  
> > > +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);
> > 
> > Maybe range-based free function can provide more flexibility (e.g., you can
> > directly call the free function to cleanup in kernel_ident_mapping_init()
> > internally when something goes wrong), but I guess this is sufficient for
> > current use case (and perhaps the majority use cases).
> > 
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > 
> 
> Another argument of range-based free function is, theoretically you can build
> the identical mapping table using different x86_mapping_info on different
> ranges, thus it makes less sense to use one 'struct x86_mapping_info *info' to
> free the entire page table, albeit in this implementation only the
> 'free_pgt_page()' callback is used. 

The interface can be changed if there will be need for such behaviour.
This kind of future-proofing rarely helpful.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

