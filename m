Return-Path: <linux-kernel+bounces-43935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60482841B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D01F2721D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17EE381D1;
	Tue, 30 Jan 2024 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLPlyD1L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64376381A2;
	Tue, 30 Jan 2024 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589275; cv=none; b=VkPvLLBV9IXN7o072Bhi0gPjH2wWjTKTeEM+sfu+tb6vOKgTnM4lhiNj9uEORbFBCRkPyBcOLSmXEOtL9NL6h0S2PrASqO9rCS2Z/LPsvZodSvO9U4e99bt4io2hKGcOpNfWgWdEeGivCfJSZqxf/6JSWxAgfzQJbLKtLfstAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589275; c=relaxed/simple;
	bh=xriwrT8PK5ZnMFWSAiOQ0+sQh4cRZ169864/lire6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YegMJT1XXxuWrjpp8mrYe6EupJ8MblTFLS0TqewLiLdzfP1bMGD3Fux8z59PGZmogLA0JHcOi7O8gC5r1om9g0TU5yXVSHHMMGP39Ut97If9oyzXCIbnaIsS3FD19NnJ6PsYM5pnRLIigpznDVvb172LYooFQRHl5rKByLP1/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLPlyD1L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706589273; x=1738125273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xriwrT8PK5ZnMFWSAiOQ0+sQh4cRZ169864/lire6Kw=;
  b=VLPlyD1LSzMSQed3d83ih9aHEWWGMSz16eiNeUKZvWNIXkc/7uNI/px/
   MWuGqArH2pBrmCdn+R1vxFsk01eSFlYUV7r28mKxau4rdaW62UlCkVwJc
   /2QzW0iXwRe95Ihdr5sZc7eDI9gHTFDOxaPWRyy3p8v9FSzIXAd18c/JJ
   IjeE95Z5SW0FUqtq3mZ7b8/KBVpMCnxXp8AXark5GKcDY6tvqCgH7IKnA
   nhmbyOwe5efOZUM4NZepo2aLr2CjgNMJXcHxD/ie5pox2eT8IBnceWaGD
   7aavG403yYpTOtjR2LgFt6zP3QvqVcJIkDd99mt7djUbTqH/tzVNUKap9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3042805"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3042805"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 20:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="30022513"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2024 20:34:29 -0800
Date: Tue, 30 Jan 2024 12:31:04 +0800
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
Message-ID: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111160242.149265-2-marpagan@redhat.com>

> +#define fpga_mgr_register_full(parent, info) \
> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>  struct fpga_manager *
> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			 struct module *owner);
>  
> +#define fpga_mgr_register(parent, name, mops, priv) \
> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>  struct fpga_manager *
> -fpga_mgr_register(struct device *parent, const char *name,
> -		  const struct fpga_manager_ops *mops, void *priv);
> +__fpga_mgr_register(struct device *parent, const char *name,
> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> +
>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> +#define devm_fpga_mgr_register_full(parent, info) \
> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>  struct fpga_manager *
> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			      struct module *owner);

Add a line here. I can do it myself if you agree.

There is still a RFC prefix for this patch. Are you ready to get it merged?
If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>

Next time if you think patches are ready for serious review and merge, drop
the RFC prefix. That avoids an extra query.

Thanks,
Yilun

> +#define devm_fpga_mgr_register(parent, name, mops, priv) \
> +	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>  struct fpga_manager *
> -devm_fpga_mgr_register(struct device *parent, const char *name,
> -		       const struct fpga_manager_ops *mops, void *priv);
> +__devm_fpga_mgr_register(struct device *parent, const char *name,
> +			 const struct fpga_manager_ops *mops, void *priv,
> +			 struct module *owner);
>  
>  #endif /*_LINUX_FPGA_MGR_H */
> -- 
> 2.43.0
> 
> 

