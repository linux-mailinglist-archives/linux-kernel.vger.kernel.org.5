Return-Path: <linux-kernel+bounces-70184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E1859473
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4B61C213D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDF184D;
	Sun, 18 Feb 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJu/yDhW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DEEA4;
	Sun, 18 Feb 2024 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229300; cv=none; b=dgmL62aUWWrNInMaWEg9R5dEPw0ISwTC40+9nsuk7/8OfJ34y1lNMwe5toe8p6ozNn3IaKuLWEAt+OjpgKz0pA5yN1B38wtCDKngpjg2p3NGCqunn+0TzDUu/xwV8kYhWdEzfqTJgRG5uTyfAStKcCj4o44dGviDAq+QXm5gGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229300; c=relaxed/simple;
	bh=jZWkLrrWcKwKxwtRGIYPKqmoUV4X285Ptu7AjJ0XUqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjhtWeTnUd4uWGpjtyxlzg4MbCmqw2ei2GU7Nnb2k/sUr0mnyfsINop0EbUhmvnp6pYRxLEeN26O5RnpWVeOy2uUkrKLfmOB2GY9uJ2FkAyM5ycfzbP1tb2YHzo23tNXIu237dKo1TGraeMbrXeTUV4e7mZCRbV/q09Oa02zaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJu/yDhW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708229298; x=1739765298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZWkLrrWcKwKxwtRGIYPKqmoUV4X285Ptu7AjJ0XUqY=;
  b=MJu/yDhWj43//JvlH/ofOdDYmJCIi5av1G3a/NyysS7rwRAchdSxT+L+
   8flCYLcEOqX018h311VjRfl5EAVDix7dsISv5bKU0JaccOGBA0BzdV41J
   t2JVEm47v0ziCrxe3isAN2LwrbVVF2XZTftlRGU+9KHQkKznRfoar/Tlk
   l9taFCQXzD5KxyQlxiN/9DDipKdSnucT4zjYrn6SZm3tGFFMSS8/bREXZ
   dz0E6XTzJE4v2fB1UrFs92oEJKI13PxzMXLSM61NGOLoihNl+uzBsT+uo
   odE3VRAK31cBUZy96JODH3Hk/844MNUeeWPvLCwErL72ChNlnJNrcisJt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2192132"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2192132"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 20:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8860739"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 17 Feb 2024 20:08:16 -0800
Date: Sun, 18 Feb 2024 12:04:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: remove redundant checks for bridge ops
Message-ID: <ZdGByar/ZmzA81cc@yilunxu-OptiPlex-7050>
References: <20240201155713.82898-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155713.82898-1-marpagan@redhat.com>

On Thu, Feb 01, 2024 at 04:57:12PM +0100, Marco Pagani wrote:
> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
> driver") introduced a check in fpga_bridge_register() that prevents
> registering a bridge without ops, making checking on every call
> redundant.
> 
> v2:
> - removed ops check also in state_show()

Don't put the history in changelog. 

I could fix it.
Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
v2:
- XXXX

This way the history could be discarded when apply.

> ---
>  drivers/fpga/fpga-bridge.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index a024be2b84e2..79c473b3c7c3 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
>  {
>  	dev_dbg(&bridge->dev, "enable\n");
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_set)
> +	if (bridge->br_ops->enable_set)
>  		return bridge->br_ops->enable_set(bridge, 1);
>  
>  	return 0;
> @@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>  {
>  	dev_dbg(&bridge->dev, "disable\n");
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_set)
> +	if (bridge->br_ops->enable_set)
>  		return bridge->br_ops->enable_set(bridge, 0);
>  
>  	return 0;
> @@ -296,7 +296,7 @@ static ssize_t state_show(struct device *dev,
>  	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>  	int state = 1;
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_show) {
> +	if (bridge->br_ops->enable_show) {
>  		state = bridge->br_ops->enable_show(bridge);
>  		if (state < 0)
>  			return state;
> @@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  	 * If the low level driver provides a method for putting bridge into
>  	 * a desired state upon unregister, do it.
>  	 */
> -	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
> +	if (bridge->br_ops->fpga_bridge_remove)
>  		bridge->br_ops->fpga_bridge_remove(bridge);
>  
>  	device_unregister(&bridge->dev);
> 
> base-commit: c849ecb2ae8413f86c84627cb0af06dffce4e215
> -- 
> 2.43.0
> 
> 

