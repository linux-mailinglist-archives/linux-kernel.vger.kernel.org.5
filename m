Return-Path: <linux-kernel+bounces-41351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61D83EF6D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19453B229A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE92D620;
	Sat, 27 Jan 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJzblu0j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0B2D610
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379368; cv=none; b=a5PfNfvMkTvnzQy46XSooS/TarNJ7qOWHIA0eHyXbX+fB0XFQi63nUPrzMD60oFHWIAHdGgd7IBVJNDfmwIiChaOCXAw7AIksKFalSE8+/wCr/QFPthNTF5YWSCh6O+KToUTn5poEydA6Xve9dpvQb7jpRBi0rrAidhYGCOt1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379368; c=relaxed/simple;
	bh=ZaHfr8zzpIiXgdpCUTc6QBJVotPOw1kev8Awy0ZxIXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9cF4E7j3sK4wAKFlrWiCvWp5g2yLs+ApyJOpZ1DAFHEyX2PTfs3FrMhO1CsDmzKsZms32C36TmJMKPgwB2pZ8dMO7Zj1NTLNR+IBTp4y1kGb+T0genPVSTospWzUSkQvWIT2rHgzXsTDX5foQ8vGLCh72WEVAOd52thzLl4kD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJzblu0j; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706379366; x=1737915366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZaHfr8zzpIiXgdpCUTc6QBJVotPOw1kev8Awy0ZxIXE=;
  b=gJzblu0jpKRnX+zKMk9EXijQgQXGXHVfWmcwSGw83eSiTbGCemJ1M0zX
   vPKb3GIXmfJDDglceRDSQpp7Woi8Zk53IxOAYS8UgTet20YKJgBt1JW0W
   ofSRzfTZ/rR39UgMBgSHh2/b4Pa0q320amqZrcveEiRggOZk4MiHhmACp
   eR21czmZ7FKH7yCJlQ6gqHzKlbnDhXOf9ktb+XGnbEBJJ2tWuaYEmOmf+
   fq5795eIhCjuUPm7anW52gg/p3WefUHh0zwUxDnaEEXTBckARZaCxq0Uh
   VnfZTgJGuJe2p/fFeYmn4NF5Kx8umT81b4CpBumJgDuiKLosM9TxC0AxQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10084691"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10084691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 10:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787423836"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787423836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2024 10:16:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9CC521F1; Sat, 27 Jan 2024 20:15:59 +0200 (EET)
Date: Sat, 27 Jan 2024 20:15:59 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com" <seanjc@google.com>, 
	"bhe@redhat.com" <bhe@redhat.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <r6u3m7ux2v7w3bg24dqmrolos4jna74nfeheudgxmxcn3iuets@qkuaj2son5mr>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
 <075348cdf2b4d3361db5c7d420f09a1c8935328e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075348cdf2b4d3361db5c7d420f09a1c8935328e.camel@intel.com>

On Fri, Jan 26, 2024 at 02:21:30PM +0000, Huang, Kai wrote:
> > +static int __init acpi_mp_setup_reset(u64 reset_vector)
> > +{
> > +	pgd_t *pgd;
> > +	struct x86_mapping_info info = {
> > +		.alloc_pgt_page = alloc_pgt_page,
> > +		.free_pgt_page	= free_pgt_page,
> > +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> > +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> > +	};
> 
> Nit: Reverse Christmas-tree style
> 
> [...]

Okay, will fix if new version is required.

> >  
> > -#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> > +#define ACPI_MP_WAKE_COMMAND_WAKEUP	1
> 
> Nit: Is this change intended?

Yes. Changed to indentation with tabs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

