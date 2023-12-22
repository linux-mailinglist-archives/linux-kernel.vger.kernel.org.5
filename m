Return-Path: <linux-kernel+bounces-9655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264D81C902
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C5C281DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B462171A3;
	Fri, 22 Dec 2023 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC7obWX5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D517743
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703243994; x=1734779994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Tufpk+YO6oOHzRVAgnjreBrHj/vaGdbgRUn173Wy3g=;
  b=CC7obWX5cV6xhOX67vTxqJh/5sdqtZAVdxg/Szywo4CbpleccOWcLPfi
   lrtyIsCZ6zT5VlTHmsBJbTTeT3BFXkoY4OAR45dzxpN1sHrSFRG+GdXFr
   3ZAjx0kQm86RckeDfhynZ5H595iiVHJGhkQVHV6gxJXQOst2zBn2tnz6N
   fYhP/PyS1ws6/vVuXCrGvoYC8IJ/rj1JAGW8x/BRe99jh0u7l55Z6zxPA
   qMGzvnyNDvOuN/Zv+vemubl3i9ixF5OSnU35+M8H34j3FxAlRQkAP/Kmb
   /q55dxGoOjU1YcQi8BzmRp2dedjzi9zbuAHmrFgQC8aSwaWtJReZ8HvDB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482284938"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="482284938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="780524686"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="780524686"
Received: from hassanfa-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.171])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:19:48 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 005ED10945B; Fri, 22 Dec 2023 14:19:45 +0300 (+03)
Date: Fri, 22 Dec 2023 14:19:45 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231222111945.mqzacijpqnzbgxbp@box>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
 <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>

On Tue, Dec 05, 2023 at 11:36:55PM +0000, Huang, Kai wrote:
> 
> > +
> > +static void acpi_mp_stop_other_cpus(int wait)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> > +}
> 
> Is this and ...
> 
> +	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
> 
> ... this below still needed?
> 
> I think the current native_stop_other_cpus() should just work given you have set
> up ...
> 
> +	smp_ops.crash_play_dead = crash_acpi_mp_play_dead;
> 
> ... for TDX guest?

To make it work stop_this_cpu() would need to be modified to use
smp_ops.crash_play_dead() instead of native_halt(). But name of the
callback doesn't match the function, so I renamed it to
smp_ops.stop_this_cpu().

> Sorry for saying this late.  I think we can also use kernel_ident_mapping_init()
> to do the init_transition_pgtable()?  We can set struct x86_mapping_info::offset
> to __PAGE_OFFSET to do that?
> 
> Looks set_up_temporary_mappings() in arch/x86/power/hibernate_64.c uses the same
> trick.
> 
> Anyway I am not sure how many LoC (assuming can do) can be saved so up to you.

Yeah. Benefit is not clear to me. I will leave it as is.


> 
> It's a little bit sad such cleanup code isn't in common code, e.g., with a 
> 
> 	void (*free_pgt_page)(void *);
> 
> to allow the user to specify how to free the page table.
> 
> But this can be future job if needed.

I will consider moving this cleanup in common code. And maybe fix other
users of kernel_ident_mapping_init(). Nobody seems to care to cleanup page
tables on ENOMEM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

