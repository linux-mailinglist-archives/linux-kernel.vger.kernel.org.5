Return-Path: <linux-kernel+bounces-59886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0B84FCED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842041C24EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025F84A32;
	Fri,  9 Feb 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHULZBc0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F88289B;
	Fri,  9 Feb 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507316; cv=none; b=GRuB2DbAI0zS18t/Xh0aV/bTnOsMBKfvSwWHZenGoptGueZtsxISQ5X2GjQ6bClGLLtpS2cE8Q/LB1Sn3Y0nb+HLMzdoTV5fhpWlIgsUt492qWLtQOKvMwNOXlw5lifHfDOokmuk8jnsVIfpeByfxkTbag7G0SDvFLS+S4/eWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507316; c=relaxed/simple;
	bh=xhzwrO+6ZlV1l0qgiqyNhA2TgTafW1vbnrmWtuXQhXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRwRcJbUTrL8EaISq+GJsSwRdKgZQMEDoDGg0e5tQSC2YR2IfNHtA/BOtu4ja1GG8DuIr0Rsei8VLn8JlHC9d52aGfaacB7n9cuJq0NoA7cOt38V28LBvLyv+RJHVy/CTci4dOdSuI5a7dwf78ZqxEWDG/PCsZWxW5zNShK+Smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHULZBc0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707507314; x=1739043314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhzwrO+6ZlV1l0qgiqyNhA2TgTafW1vbnrmWtuXQhXU=;
  b=GHULZBc0IwH1WVl31TVc8ImVr78SOmbcNfkdNIMp1FBRPMQFD6GxlWHV
   FqpSOMKE2uPQJbxbBYtX+jmXOWkKhZk69p8VKUhMahoB/y3PV4zfuV15S
   OhC9l4MgIikYLWbluOkYH/rG9gfSx6PsNtfTM5ax85RNnvb+QQ/r9/ilA
   AeXd6aD/OfBNvsZyBqKTOgIT8CvMsUNtonQpGTDokf0JHBDSnZArnBYDz
   OwOm/i795apr4Jxvq15xq/Z6gu6Kphp1CaAAy6a7YmHQe7NN9eGhwmjSs
   RiGYxbY0U7s/OHNOEaRUP2wTO3xQD23Fr4OPlFXIHA+y0eitNPtd2CR1G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1641131"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1641131"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="33099836"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:35:13 -0800
Date: Fri, 9 Feb 2024 11:35:12 -0800
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
Subject: Re: [PATCH v15-RFC 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Message-ID: <ZcZ-cDqGLTtHpB1T@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-7-tony.luck@intel.com>
 <89dc9022-c9a4-42dc-8710-be2d6d9a4e7c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dc9022-c9a4-42dc-8710-be2d6d9a4e7c@amd.com>

On Fri, Feb 09, 2024 at 09:29:16AM -0600, Moger, Babu wrote:
> >  
> > +extern unsigned int snc_nodes_per_l3_cache;
> 
> I feel this can be part of rdt_resource instead of global.

Mixed emotions about that. It would be another field that appears
in every instance of rdt_resource, but only used by the RDT_RESOURCE_L3_MON
copy.

> 
> > +
> >  enum resctrl_res_level {
> >  	RDT_RESOURCE_L3_MON,
> >  	RDT_RESOURCE_L3,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index b741cbf61843..dc886d2c9a33 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -48,6 +48,12 @@ int max_name_width, max_data_width;
> >   */
> >  bool rdt_alloc_capable;
> >  
> > +/*
> > + * Number of SNC nodes that share each L3 cache.  Default is 1 for
> > + * systems that do not support SNC, or have SNC disabled.
> > + */
> > +unsigned int snc_nodes_per_l3_cache = 1;
> > +
> >  static void
> >  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
> >  		struct rdt_resource *r);
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 080cad0d7288..357919bbadbe 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
> >  
> >  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  {
> > +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> 
> RDT_RESOURCE_L3_MON?

Second good catch.

> 
> > +	int cpu = smp_processor_id();
> > +	int rmid_offset = 0;
> >  	u64 msr_val;
> >  
> > +	/*
> > +	 * When SNC mode is on, need to compute the offset to read the
> > +	 * physical RMID counter for the node to which this CPU belongs.
> > +	 */
> > +	if (snc_nodes_per_l3_cache > 1)
> > +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> 
> Not sure if you have tested or not. r->num_rmid is initialized for the
> resource RDT_RESOURCE_L3_MON. For other resource it is always 0.

I hadn't got time on the SNC machine to try this out. Thanks
for catching this one, I'd have been scratching my head for a
while to track the symptoms of this problem back to this mistake.

Thanks

-Tony

