Return-Path: <linux-kernel+bounces-51435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE6848B30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F611F22A44
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8986FC7;
	Sun,  4 Feb 2024 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVkmGt+L"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12A6119;
	Sun,  4 Feb 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707023953; cv=none; b=FwWIp9xkCNdm5oqzMPHVAfNL+ullsOoUEYRw7BdrSW+FaoMc9YvCsUkNlElT5uexFiUSfTo+lk2Z/SeKsE/y3+vOboUh3aG2/OCewfg7iDGUb+5XZSEhgjTZ4ZibcjCm+GSAdy6L99NKs8BfQop1YNfNP0swRvAED97gb5mvd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707023953; c=relaxed/simple;
	bh=P6VGiDl0jduaJYu6jiH+VhGE0WfXIZzpvflkq0mKjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiwuX0CWgeqXJuwVM9JA60kpe3mhM3WMIMCWvk3x/sBd5bPHcnh7HLq8bj6tiQF+WKJHLQ9G2s5qdPS61ssdC5fn46GV2TudhDZ8QsOLgCI2+dOzPgkKz6pcQGMcqnIkmF22PgCzyIiPlrMaFslziPYRTjtb+JCZFocea7t4wBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVkmGt+L; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707023952; x=1738559952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6VGiDl0jduaJYu6jiH+VhGE0WfXIZzpvflkq0mKjH4=;
  b=DVkmGt+L+gvx+1jrSn94ZVGw7jn9EePrfnUiO1KIMFg7nyXQ9NdwaSaP
   yLUfc84f8vCNqxbHAGkaX/Cv2dLEu4qHq4W3VFEoxVQlEsISGO6A9N95U
   i/ZFh+rFQH/Gfgm9V5IEhcksH/pN7glLC7Bu1hGgjX0hNhZKWkCF09hhZ
   +ROFFYK5yz1GxETiQFU+lUdIXuP5oq1LmJQaldgEcF6bgzCW37vma+BYT
   llVdOfdUjVajkWzlBFje2jHli1x+c5YurDYqbKryI6tX1S2w+sXE9dJ5c
   o2WLvoToBs0Va3t1GGP5e1yn4aZiaaecpXK8dp0HhS/2SaJk27EcRHr7L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="394787343"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="394787343"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 21:19:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23694652"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 03 Feb 2024 21:19:08 -0800
Date: Sun, 4 Feb 2024 13:15:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>

On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
> 
> 
> On 2024-01-30 05:31, Xu Yilun wrote:
> >> +#define fpga_mgr_register_full(parent, info) \
> >> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>  struct fpga_manager *
> >> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			 struct module *owner);
> >>  
> >> +#define fpga_mgr_register(parent, name, mops, priv) \
> >> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >>  struct fpga_manager *
> >> -fpga_mgr_register(struct device *parent, const char *name,
> >> -		  const struct fpga_manager_ops *mops, void *priv);
> >> +__fpga_mgr_register(struct device *parent, const char *name,
> >> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> >> +
> >>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>  
> >> +#define devm_fpga_mgr_register_full(parent, info) \
> >> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>  struct fpga_manager *
> >> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			      struct module *owner);
> > 
> > Add a line here. I can do it myself if you agree.
> 
> Sure, that is fine by me. I also spotted a typo in the commit log body
> (in taken -> is taken). Do you want me to send a v6, or do you prefer
> to fix that in place?

No need, I can fix it.

> 
> > 
> > There is still a RFC prefix for this patch. Are you ready to get it merged?
> > If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> I'm ready for the patch to be merged. However, I recently sent an RFC
> to propose a safer implementation of try_module_get() that would
> simplify the code and may also benefit other subsystems. What do you
> think?
> 
> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/

I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
proposal is applied before the end of this cycle, we could re-evaluate
this patch.

Thanks,
Yilun

> 
> > Next time if you think patches are ready for serious review and merge, drop
> > the RFC prefix. That avoids an extra query.
> 
> Okay, I'll do it like that next time.
> 
> Thanks,
> Marco
> 

