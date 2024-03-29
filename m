Return-Path: <linux-kernel+bounces-125133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC789207B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABAE1F2CD82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B81DA37;
	Fri, 29 Mar 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KG7nAZHV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF14FBF3;
	Fri, 29 Mar 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726299; cv=none; b=RaPPLXqa/8aw4fUn6Y/QdKGNarCA22JFQGn1mc13WzYl9OyFex7XD2JYPNt3SM1b2thHdfksCU8EXJHMqYLgTPTFMWEIJ+COBb4bxNZHVViO2ehS4P55ghB6LcNCiNiSwk9yAEDaRvsWjHYlsC83NVnRcI+ZAbLpGuEsyuM+TGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726299; c=relaxed/simple;
	bh=o5wvscSbfKEAAlh6310IOTAWfM+GCnb8Nb2D8Svvj1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUD+21DqHx0yYNXlJheN3Xy8qJjEMrPYVdsH14isxzDEUO00IDAP5SkYUPVEPuKbVi8ufLhLfccWAUwoHJqH2uaXyvLdsI8hkKjexA7n3OSFZe2Gtl69pqhAQp7jW1SFFkt5mzjcRTpg3bocIY/ZpR6JKKJ4IbpW8Dygpl0HZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KG7nAZHV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711726298; x=1743262298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o5wvscSbfKEAAlh6310IOTAWfM+GCnb8Nb2D8Svvj1c=;
  b=KG7nAZHVSFxRPLY8Qs7DvYuzLkil4enE2onSTw4x+yYFXWDXPL8NwnDV
   21NpDjJGLPgJ9jDEgKpEj/ON03EzQFOTOjVWcpTRw+3BaWNyAWx0E+o2d
   YW8JFwyI6TxFLK2AnwIgaFBo8XmRHOJXqEJ1CnlscHY7F/QjzYYPFlQUr
   nis0vzYST340tc8Pe+pkRq1nQWNDR06yxfSMcaZITyQzYVbUyj5VpZU6r
   3A1SbdD1UZWpS4OnwORyYTPZEjaOidqpNeIX1afFR8y6bxt8Ro3X9M6UW
   ceE7Ql6SazCgZbTersDKvhe/1m9W/O4fdenGOhbVAKf+teoQY07L4uRhE
   Q==;
X-CSE-ConnectionGUID: hT58j8j1ThiYpHD1PlogdQ==
X-CSE-MsgGUID: eWMqijdAShe7JQTaWfWoHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10730117"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="10730117"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="16972603"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:31:37 -0700
Date: Fri, 29 Mar 2024 08:31:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-doc@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
Message-ID: <Zgbe2FFwyHMmmsyM@agluck-desk3>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>

On Thu, Mar 28, 2024 at 06:01:33PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 3/22/2024 11:20 AM, Tony Luck wrote:
> > The memory bandwidth software controller uses 2^20 units rather than
> > 10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
> > Linux define for 0x00100000.
> > 
> > Update the documentation to use MiB when describing this feature.
> > It's too late to fix the mount option "mba_MBps" as that is now an
> > established user interface.
> 
> I see that this is merged already but I do not think this is correct.

I was surprised that Ingo merged it without giving folks a chance to
comment.

> Shouldn't the implementation be fixed instead? Looking at the implementation
> the intent appears to be clear that the goal is to have bandwidth be
> MBps .... that is when looking from documentation to the define
> (MBA_MAX_MBPS) to the comments of the function you reference above
> mbm_bw_count(). For example, "...and delta bandwidth in MBps ..."
> and "...maintain values in MBps..."

Difficult to be sure of intent. But in general when people talk about
"megabytes" in the context of memory they mean 2^20. Storage capacity
on computers was originally in 2^20 units until the marketing teams
at disk drive manufacturers realized they could print numbers 4.8% bigger
on their products by using SI unit 10^6 Mega prefix (rising to 7.3% with
Giga and 10% with Tera).

It is clear that the code uses 2^20 as it converts from bytes using
a right shift by 20.

Fixing the code would change the legacy API. Folks with a schemata
file that sets a limit of 5000 MB/s would find their applications
throttled by an addtional 4.8% on upgrading to a kernel with this
"fix".

> To me this change creates significant confusion since it now contradicts
> with the source code and comments I reference above. Not to mention the
> discrepancy with user documentation.
> 
> If you believe that this should be MiB then should the
> source and comments not also be changed to reflect that? Or alternatively,
> why not just fix mbm_bw_count() to support the documentation and what
> it appears to be intended to do. If users have been using the interface
> expecting MBps then this seems more like a needed bugfix than 
> a needed documentation change.

I agree that the comments need to be fixed. I will spin up a patch.

> Finally, if you make documentation changes, please do build the
> documentation afterwards. This change introduces a warning:
> 
> Memory bandwidth Allocation specified in MiBps
> ---------------------------------------------
> .../linux/Documentation/arch/x86/resctrl.rst:583: WARNING: Title underline too short.

My bad. Ingo has already applied a fix to TIP x86/urgent. I assume that
will be merged to Linus soon.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=91491e5fb09624116950f9f2e1767a42e1da786

-Tony

