Return-Path: <linux-kernel+bounces-18438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BDB825D83
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302A61C23A31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636D15A5;
	Sat,  6 Jan 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRLQ4bSz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AB15A0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704502749; x=1736038749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bSsYNHPqPBPvIfJLFuPRmb0GQmnn1/patfbIJCmnLTQ=;
  b=BRLQ4bSz0qsthctPXjsE714BffJdhaitUaTo1HBmQqSev3BEL8TcgIGr
   SPCvUwG81S8NtPQdvE0KD2y+ol8M2s92hypDG04jrmusTH0GGyqS9Q/iY
   p22eRRg0R+Gz2EsEFly1ZnwSFYS2SQEcS7TGix4JjzXFnCkOtnR8MZVzf
   ZXrxjptYzNzAaQSQkiDr9x9T3HXvsnDwczDmReYAxjBF3HeF7Htln1Xw4
   9cwfaYhhZNhxDcbN7qaCktyqvxBv+1Z1M5rIffLOpRGmCNcIKDTY2Xn1A
   ooM1x3lh75z1utonYTR9k/wrkpWvzURECnskenf6/wgbsiERv2rxZzO/G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461918823"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="461918823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 16:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871366157"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="871366157"
Received: from mflierl-xps15.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.36.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 16:59:03 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 49F5C10A57B; Sat,  6 Jan 2024 03:59:01 +0300 (+03)
Date: Sat, 6 Jan 2024 03:59:01 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Huang, Kai" <kai.huang@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240106005901.jpdxd544ddih6nw7@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>

On Fri, Jan 05, 2024 at 07:38:48PM +0000, Edgecombe, Rick P wrote:
> The break apart looks good.
> 
> On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > +       while (addr < end) {
> > +               unsigned long size;
> > +               unsigned int level;
> > +               pte_t *pte;
> > +
> > +               pte = lookup_address(addr, &level);
> > +               size = page_level_size(level);
> > +
> > +               if (pte && pte_decrypted(*pte)) {
> > +                       int pages = size / PAGE_SIZE;
> > +
> > +                       /*
> > +                        * Touching memory with shared bit set
> > triggers implicit
> > +                        * conversion to shared.
> > +                        *
> > +                        * Make sure nobody touches the shared range
> > from
> > +                        * now on.
> > +                        */
> > +                       set_pte(pte, __pte(0));
> 
> Does this need a full shootdown at this point, at least in the crash
> case? A local flush for the non-crash case might be nice too.

See __flush_tlb_all() after the loop.

> Also, probably a barrier() between set_pte() and
> tdx_enc_status_changed().

But why? There's no concurrency at this point. Interrupts are disabled and
only one CPU is active. Nobody can touch the memory relevant for the PTE.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

