Return-Path: <linux-kernel+bounces-126559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA211893976
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38423B2131C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A41095C;
	Mon,  1 Apr 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOkBk/4p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3387DDB6;
	Mon,  1 Apr 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964338; cv=none; b=LpqzrC1DX79P2eUAhyKq85/hmiUW4Hm9OzTvmjqjX6qIcAtyl13og8ssS04QCPBkm0sztF7jT7t+22whRyedySghZ7m4b5NZJUdb92DKFOBc9HFntSpm+xufXr01gVOS5P6ZLOTDlcD7Y3EReDMwBq+vbnrJSJ10FY6mbCTOsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964338; c=relaxed/simple;
	bh=kiZVMGBa1eAUPnAXQqslxytPb57aNml6Kj1vn0W2qBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W48ATV1en7xb0wr3KZi6Augs7jMHJTOUT7Cjxr7pptZRCYXw0aO1dEruHBt7+IA7BQj4aRJH4VfYYqgGa31vr69dUV8NpszBjQX1fmZzfc+/5s3LW30nNprU1Cghpboj6bEdF7BOxZLw6m/TVNhJtckZTPUxs69XPhbvEc1iVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOkBk/4p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711964337; x=1743500337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kiZVMGBa1eAUPnAXQqslxytPb57aNml6Kj1vn0W2qBI=;
  b=bOkBk/4pJQnME2L3qzPh3C4freXAxkNMnpA9/BrNigN0fqjhQMZrXlcq
   EQ38eaKzS+DfPE2UwU6Y1VslNYZb5Gp9tfhSA8jSN89HS0ozt/7Ij5j4i
   /LHvZbor2qK6iKz5KtA0f0mhiIY2UcuaT4zfmzX/LEMEOOJ6/fXWbjzYl
   LF4GzFGI1rXuGc5gh1+tNZ/2VCc76lA5hyBB9fL5itmKUZrMxOKdyWu2B
   4SUSCqPPJGWcZM0zWEv+1NBl9jvZ/oCnxK1bXEBjUt5yGN3fyMh0qaiql
   c9tU337B0Sz5EYmg/uAlX06/cTnlccmpZuswSEAJHZQZUJbyUArXcMUaj
   Q==;
X-CSE-ConnectionGUID: 6AdeUXfXTI6IBo8xfElSbA==
X-CSE-MsgGUID: ZjLlUBF7QaChgdkx3QVRQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="10043267"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="10043267"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 02:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="48858934"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2024 02:38:54 -0700
Date: Mon, 1 Apr 2024 17:34:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: region: add owner module and take its refcount
Message-ID: <Zgp/jNst2yuXEbpU@yilunxu-OptiPlex-7050>
References: <20240327160022.202934-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160022.202934-1-marpagan@redhat.com>

On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
> The current implementation of the fpga region assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the region
> during programming if the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_region
> struct and use it to take the module's refcount. Modify the functions for
> registering a region to take an additional owner module parameter and
> rename them to avoid conflicts. Use the old function names for helper
> macros that automatically set the module that registers the region as the
> owner. This ensures compatibility with existing low-level control modules
> and reduces the chances of registering a region without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga region.
> 
> Other changes: unlock the mutex before calling put_device() in
> fpga_region_put() to avoid potential use after release issues.

Please try not to mix different changes in one patch, especially for
a "bug fix" as you said.

And I do have concern about the fix, see below.

[...]

> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  	}
>  
>  	get_device(dev);
> -	if (!try_module_get(dev->parent->driver->owner)) {
> +	if (!try_module_get(region->br_owner)) {
>  		put_device(dev);
>  		mutex_unlock(&region->mutex);
>  		return ERR_PTR(-ENODEV);
> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>  
>  	dev_dbg(dev, "put\n");
>  
> -	module_put(dev->parent->driver->owner);
> -	put_device(dev);
> +	module_put(region->br_owner);
>  	mutex_unlock(&region->mutex);

If there is concern the region would be freed after put_device(), then
why still keep the sequence in fpga_region_get()?

And is it possible region is freed before get_device() in
fpga_region_get()?

Or we should clearly document how/when to use these functions?

Thanks,
Yilun

> +	put_device(dev);
>  }

