Return-Path: <linux-kernel+bounces-94104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F386A873A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E651F228D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF44134738;
	Wed,  6 Mar 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNJ3NK4u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA737F7FA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737373; cv=none; b=KZr33gnooRbXqM6zhGzXOZ79rnB310wsVzlV5Le1n5F/RNhGN3UA5tGF1+rYs7qSbDRFCPxhwuH7Bbqy+CMH0msMuOjdc03c1edRvH0Bxc9MIABV0ps3vPXeR7ej6EkDlxwCqUMp14EcnnA/FgEgCijGft7rbzag2OdB9wrpCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737373; c=relaxed/simple;
	bh=0YlQcNDY2yZmAytkOmvFnpG2SeB7XydxVJMOyJgBm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak4JKfva3/HXBr46p6kF4+UDd5F0MUDSIuWGmK1ZTihcgZ6Svei8qq4ZyRAnuINFQBFyi8YRJLRvxyAuqTsG2KsTf5x1BSMQv9eLAt6FNFn8yqLxjycLFyfBUToY8XGI7rIgeBCwjD0Tro7QhudQjUTk/tZ+X7hAlbCdFG1K4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNJ3NK4u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709737372; x=1741273372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0YlQcNDY2yZmAytkOmvFnpG2SeB7XydxVJMOyJgBm2U=;
  b=VNJ3NK4u7SbSGb1dKEL3Zp7ZerXNG7Yng7KygEaeMEuBXU7/YVjn40qS
   W698ufl58Q9ZsPp2yO7u7VCVdknJ6RPDwy/hiC+K3NpOmq8opM57U6tan
   LFgphFasIZ5wbID0jqLAUyytyc4A0uUadb9C7g3s9yp3tIIbMsLav20Dj
   WaO6noABHWShnEWtFN6+9AQ7gzzzEjemp7DFeZNLmwbUZpKPpKYklWjkq
   AXmFLWvyXBd1+JS8CQOPR/GKFHCbP66rKNzdeuMZ/PCrWeUfXR330hZf8
   Uz7pWdiF+0IBuwPjl49/YGRgQLokD9hTZxsCe1OdHcKs2jpTYFKrYqjbc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4467260"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4467260"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937045015"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 07:02:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B7F1D184; Wed,  6 Mar 2024 17:02:45 +0200 (EET)
Date: Wed, 6 Mar 2024 17:02:45 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/17, CORRECTED] x86/tdx: Add kexec support
Message-ID: <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>

On Tue, Feb 27, 2024 at 11:24:35PM +0200, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
> 
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> 2nd kernel with single CPU.
> 
> Please review. I would be glad for any feedback.

Thomas, Ingo, Borislav, Dave,

Any feedback?

Is there anything else I can do to get the patchset moving?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

