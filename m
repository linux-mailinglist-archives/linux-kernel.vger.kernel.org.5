Return-Path: <linux-kernel+bounces-127352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD694894A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624121F21A35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C217732;
	Tue,  2 Apr 2024 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L388u013"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5131179BC;
	Tue,  2 Apr 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029930; cv=none; b=WT9tbLFxZFXikMVkJ+E+UoqE2JNlbrbImEH3xUY9hWOCO8KXch4dK6ePP3MYUDbIIYLPr37ebX6f4hLvqHHZqQdKyn2FmeaK4PJPNhkUJqdkduyYigem8XrmhHSVFxON4m0UZXQzE6DGOmFrQlBcVRT9+ed+hWnzh5SfM2LsAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029930; c=relaxed/simple;
	bh=7gHW/qvQSs1Nc3EuoXfs26hkvGBC1r6itQPxwRNZFek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI1efpX6kL7v9YTtgAWJFII07Wxcemv6o/82XyyeFE78KAR4BEqj10pYzjDv4V4/vaMzxp3Db3kY00yxwtRzPVj0fllYSm7qY0U5ekx4Km4DtsJAQrSmkUvANO+OItivfM8v9FIO2LYAmW5nGfvFN7dy8k2Rtb8ohmzZTAjqAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L388u013; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712029929; x=1743565929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7gHW/qvQSs1Nc3EuoXfs26hkvGBC1r6itQPxwRNZFek=;
  b=L388u013YZb7SfLPzYdct0x67zWhnIahEaXBG4Stz7tPjBd1sCudBVO+
   7edR+a9PZ8BNbY5n4vptQKc/xr17ERsOPUuzxWfhh81C2ab2cCEqREdk6
   q0676fcHh467iUEbnZ/Ey47KzZzt5W8JmU+K19OI3f9XWXWdyOYnVQOrQ
   4ef9HoNlbI8QWTZEmVz7zVgHzVw0kCKoR7gcD3OH1+lF9ZLiJdo0qtcCB
   QVcIUIp/27dFkRvsyfvGZ2E1/42Ht1wzADnu0F2X9Z9WS0xxgoCHEPcba
   GdWeSUJE2OboJISb6Xnb1gNoYGLJsdMffS0RNTFyxwW6FNeCfgT1dAy1r
   g==;
X-CSE-ConnectionGUID: PA8vrnaxTqyvtyWzZqDffw==
X-CSE-MsgGUID: jEzjLMaMRwaVv12PvyTTiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18539075"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18539075"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 20:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22607322"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 01 Apr 2024 20:52:04 -0700
Date: Tue, 2 Apr 2024 11:47:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Alan Tull <atull@kernel.org>, Shiva Rao <shiva.rao@intel.com>,
	Kang Luwei <luwei.kang@intel.com>,
	Enno Luebbers <enno.luebbers@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fpga: dfl: fme: fix kernel-doc comments for some
 functions
Message-ID: <Zgt/wftzm4xthfio@yilunxu-OptiPlex-7050>
References: <20240329001542.8099-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329001542.8099-1-peter.colberg@intel.com>

On Thu, Mar 28, 2024 at 08:15:42PM -0400, Peter Colberg wrote:
> From: Xu Yilun <yilun.xu@intel.com>

I didn't remember I wrote this exact patch, but anyway the patch itself
is confusing.

> 
> lkp reported 2 build warnings:
> 
>    drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
> 
> >> drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
> >> dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
> >> instead
> 
> Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
>  drivers/fpga/dfl-fme-pr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index cdcf6dea4cc9..96cb24787ab1 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -166,6 +166,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>   * dfl_fme_create_mgr - create fpga mgr platform device as child device
>   * @feature: sub feature info

The member 'feature' is described here. It still causes build warning?

>   * @pdata: fme platform_device's pdata
> + * @feature: the dfl fme PR sub feature

Why adding a duplicated item would fix the warning?

>   *
>   * Return: mgr platform device if successful, and error code otherwise.
>   */
> @@ -273,7 +274,7 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
>  }
>  
>  /**
> - * dfl_fme_destroy_bridges - destroy all fpga bridge platform device

The prototype is for dfl_fme_destroy_bridges(), why the warning?

> + * dfl_fme_destroy_bridges - destroy all fpga bridge platform devices

Correct the plural form in description would fix the warning?

>   * @pdata: fme platform device's pdata
>   */
>  static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
> -- 
> 2.44.0
> 
> 

