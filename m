Return-Path: <linux-kernel+bounces-143546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D18A3AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945A91F24873
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B201B948;
	Sat, 13 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mc6Z3TMJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDB18E10;
	Sat, 13 Apr 2024 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979851; cv=none; b=ZlKhzdVAZMrJmdlbW7eSibEhqBDWE3E4uE77VhgmV8tdodkO6nhiWMrk4STU7Pzw9E+9QhmZ3qcwOT4nkjhJQstqMvwt5uZ+pJeks40WzKgMPmGyJWZBWtojnQC495fWPxijWcoGV5QVju2q7ljzaaDGpUBh/S1T94hfajLcAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979851; c=relaxed/simple;
	bh=tGCnwsdjZOKULuycZTSN66sgNddpxVkqLbRd/ca6hGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAlTdZfG+cKp8Epqj13S0YRZbyyGpg0oAN/ex31CWjQQgqbS1o/UD16+VSotUCc0hDauYP5UIJSGvui49U+w7aO4tu60HIcYK9peJAEvBgEYaO+ndWsqvs1NVGJEtG8SKPonEELbHQ+Q5ilghs+hxv6BfE8OK5raZ6fsJCI3+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mc6Z3TMJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712979851; x=1744515851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tGCnwsdjZOKULuycZTSN66sgNddpxVkqLbRd/ca6hGQ=;
  b=mc6Z3TMJ00Oqxb9ISsXT51mnwWqzGyQ5YIFaaL2QPFrvHBC6FqGOJ1PX
   PHwvQ+3k0/MYa2J53AutGo2sQl7eE+/fNoJM7zbWCrrmMY4m0+RarebIJ
   HWW5FooR1ZRPCazzxJ2OmsslJFAU9cnE/mf7pbi6LG0gMecdffgoWuTGE
   scuiNh5J/vh8HPqhFgBd7aAKQ0CF6zHymA+HRAIQ2InKOlU7JqhPQ8OIN
   Ja+bYUPbBTTNKNX5iMM+BlG4D6qlzsusCkVg3lc12GWFQ/kDBIXnwNc5j
   low7EQHyg/eaB3BapbgYXvXkF8qzwwhgkf+O9JeSEwaLzy0dsH2Srf323
   g==;
X-CSE-ConnectionGUID: xN29MbL9TMWn3i80RlHMoA==
X-CSE-MsgGUID: sU6EAj/4Qba6gzt04xUzAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19593861"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="19593861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 20:44:09 -0700
X-CSE-ConnectionGUID: 8LI87pW7Sg6MjEC4ibNBuQ==
X-CSE-MsgGUID: BonyupnfRz69GPS5TafKtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="26102840"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 12 Apr 2024 20:44:06 -0700
Date: Sat, 13 Apr 2024 11:39:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl: remove unused function is_dfl_feature_present
Message-ID: <Zhn+VHyaD9rZ0X/w@yilunxu-OptiPlex-7050>
References: <20240402222038.1438718-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402222038.1438718-1-peter.colberg@intel.com>

On Tue, Apr 02, 2024 at 06:20:38PM -0400, Peter Colberg wrote:
> The function is_dfl_feature_present was added in commit 5b57d02a2f94
> ("fpga: dfl: add feature device infrastructure") but never used.

Same git commit reference problem, please see:

https://lore.kernel.org/all/Zhn8bjex94DpkGBw@yilunxu-OptiPlex-7050/

Thanks,
Yilun

> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 1d724a28f00a..5063d73b0d82 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -437,11 +437,6 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u16 id)
> -{
> -	return !!dfl_get_feature_ioaddr_by_id(dev, id);
> -}
> -
>  static inline
>  struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
>  {
> -- 
> 2.44.0
> 
> 

