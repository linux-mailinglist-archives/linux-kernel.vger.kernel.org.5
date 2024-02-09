Return-Path: <linux-kernel+bounces-59834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4484FC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AB82858BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8BA80C17;
	Fri,  9 Feb 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+VcpdL1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8B6BB22;
	Fri,  9 Feb 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504689; cv=none; b=iXLLzyGkNgRBYolvp4kNON9uCqum007L5Vbyh00p/0uFyvD4qFGLosPEdl1NDxqnQVA+lgXR4l6AZxwY0zl86R6gcPPYEUxvUOdv9Cis0eUI9+gFsQhgwkMyAJaSGrYU33FJWVRy6kHGYMfYpT4T+r7a85mM4aNixhGj+l6L6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504689; c=relaxed/simple;
	bh=zSd+Tr0N5ssM9VaLZc8HIHGHOmryVhAXfEsuY8XuY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0QlWVaRcpbdAN3y5YX6a9Ud33vuhcptaWs5q5QU2mBC38+Kf3IjEq84nf7aUNy1bFMmKjtfgpgCH4XpWE1mJPuYgOjXuLj41lJcvksqKBUi/LXLpsKfSmKKTuJWOH2nZfM/PXojR5Xovfd7NiJ2k0KvLuID3x9Ceb4HPf48lxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+VcpdL1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707504688; x=1739040688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zSd+Tr0N5ssM9VaLZc8HIHGHOmryVhAXfEsuY8XuY+k=;
  b=a+VcpdL1J/FuEuKOFdxg1Gp1+sV7KXNvqZQRhzVIaHLBoy7NivYqbLCS
   ejkaLBi3njfyrwSwJMKVmdFU1yoPoH4X0IpFDq8mKwDW8/SXikfkcdwBi
   DjH/sOdL2asHxNpdzjD0yoK+AJizhWhQR1PQ82C3K3+L1NP2gypO4lJu5
   sXZJTmsooeL1ZEgjh0tICszn28LTyNp3IfpKY0kwHkjrrK+BgM+dQaWE+
   GXYZ8qV6pte33EoRNefRiZdo+XW6iu5wk3QTmc0f8Sxy3HeEh8uOMy0Aa
   PylcLJoiGNePpBe7APoK4Cyp9rC105qIKudMldqn9QLX3FdKgxCCyqndv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12568988"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12568988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2043753"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:51:27 -0800
Date: Fri, 9 Feb 2024 10:51:25 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v15-RFC 2/8] x86/resctrl: Move all monitoring functions
 to RDT_RESOURCE_L3_MON
Message-ID: <ZcZ0LVHwkOKVApzi@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-3-tony.luck@intel.com>
 <fa80f524-eff6-4513-a03a-3fb111289d86@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa80f524-eff6-4513-a03a-3fb111289d86@amd.com>

On Fri, Feb 09, 2024 at 09:28:25AM -0600, Moger, Babu wrote:
> Tony,
> 
> On 1/30/24 16:20, Tony Luck wrote:
> > Switch over all places that setup and use monitoring funtions to
> 
> functions?

Yes. Will fix.

> > use the new resource structure.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++--
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++--------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
> >  3 files changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index c50f55d7790e..0828575c3e13 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -591,11 +591,13 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  		return;
> >  	}
> >  
> > -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> > +	if (r == &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl) {
> >  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> >  			cancel_delayed_work(&d->mbm_over);
> >  			mbm_setup_overflow_handler(d, 0);
> >  		}
> > +	}
> > +	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> 
> RDT_RESOURCE_L3_MON?

Good catch.

-Tony

