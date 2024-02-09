Return-Path: <linux-kernel+bounces-59826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67684FC30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9846F288F93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227080BF5;
	Fri,  9 Feb 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjTEhcx7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5457337;
	Fri,  9 Feb 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504303; cv=none; b=eW0UURqmFErzxSlACtyqFN++cMs05MI5CrTKILS8SIgL3kx/onogLtkylIOoDFDcI810ozQp9G3gpp/F2YTi/MZUtJpDlvsh9tadz/PhlYPkZlkczmEB1/2dTpqOOMmi6ZPuMRRl3wbBsCfEDZMot1djmbVpVfO8m9B1vWeAW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504303; c=relaxed/simple;
	bh=r99sVZ3dN5h4LRp+rYDgytD8f2JrBqu/IHxuwknZauQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itYWu5A7QZ9OtM9lPnXP7AVWCWo314S770f5GZFzBx9K/n/w2Szs3yl4WfOcMKHC9U47X9kCISuQwLgj0rsw7APwIn/DCmMpuEr1Nnyvw+rBaovM+SfgWRheJ37JUWuV8tWclZjKeyXcZ9OSYGhegQ2K7h40E9f95UvfM1Hemjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjTEhcx7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707504301; x=1739040301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r99sVZ3dN5h4LRp+rYDgytD8f2JrBqu/IHxuwknZauQ=;
  b=ZjTEhcx77Zw/XJfD2MSOH93V0ZpzSXSkD3RD65nW4bgOcoZeoQVsxWpR
   URxmbc+rdCkLyPX4XwQLvTgXTZweVU3R4t2uWO4LYMEJ7UqnHZJAsBSCJ
   cZLDkB/hX0pp2Drd94ZAzCX7NQwufF+/1PcpxfTGfCDTgdi72t+QSYD/a
   iitoA3VLHOxj+gekdmfRUpCJJGUyWl0y2e2GmDlfvEolPcS4REN1CErBY
   1KRQ4kmK4Zjqggrk2m7TVTLbjnXF6f+SpeGd8smWA41apx8k3UDp5MHNx
   uGlZDAz+MrW0ZkL/pVkOXI7Rxgd5YLtmjykBbKXMdS25vIBosCPRSJ8YG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12568172"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12568172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:45:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2042411"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:45:00 -0800
Date: Fri, 9 Feb 2024 10:44:58 -0800
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
Subject: Re: [PATCH v15-RFC 1/8] x86/resctrl: Split the RDT_RESOURCE_L3
 resource
Message-ID: <ZcZyqs5hnQqZ5ZV0@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-2-tony.luck@intel.com>
 <c9629380-c97c-4797-b6b3-5044d5beeb97@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9629380-c97c-4797-b6b3-5044d5beeb97@amd.com>

On Fri, Feb 09, 2024 at 09:28:16AM -0600, Moger, Babu wrote:
> >  enum resctrl_res_level {
> > +	RDT_RESOURCE_L3_MON,
> >  	RDT_RESOURCE_L3,
> 
> How about?
> RDT_RESOURCE_L3,
> RDT_RESOURCE_L3_MON,

Does the order matter? I put the L3_MON one first because historically
cache occupancy was the first resctrl tool. But if you have a better
argument for the order, then I can change it.

> >  	RDT_RESOURCE_L2,
> >  	RDT_RESOURCE_MBA,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index aa9810a64258..c50f55d7790e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -60,6 +60,16 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
> >  #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> >  
> >  struct rdt_hw_resource rdt_resources_all[] = {
> > +	[RDT_RESOURCE_L3_MON] =
> > +	{
> > +		.r_resctrl = {
> > +			.rid			= RDT_RESOURCE_L3_MON,
> > +			.name			= "L3",
> 
> L3_MON ?

That was my first choice too. But I found:

$ ls /sys/fs/resctrl/info
L3  L3_MON_MON  last_cmd_status  MB

This would be easy to fix ... just change this code to not append
an extra "_MON" to the directory name:

        for_each_mon_capable_rdt_resource(r) {
                fflags = r->fflags | RFTYPE_MON_INFO;
                sprintf(name, "%s_MON", r->name);
                ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
                if (ret)
                        goto out_destroy;
        }

But I also saw this:
$ ls /sys/fs/resctrl/mon_data/
mon_L3_MON_00  mon_L3_MON_01

which didn't seem to have an easy fix. So I took the easy route and left
the ".name" field as "L3_MON".

-Tony

