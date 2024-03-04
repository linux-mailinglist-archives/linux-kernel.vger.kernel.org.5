Return-Path: <linux-kernel+bounces-90456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903D86FF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6641C220FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6243839F;
	Mon,  4 Mar 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR2tb1cA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9F374DE;
	Mon,  4 Mar 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549335; cv=none; b=adWvqNIA7QTUIb8Z93mfKYxQhFk98+N1WgPzTiKxQP60QCUICLEbS10ebjweAHYSKyYFddlhE8pQ6WMfo9bCoJp59w51l4Kww+tRQw9rPBZUQHPsyxICPI9gdpMpPxbRPAm0Fm2DcRSR6SkRirhs/EFX7pVpvhrjVkOTn/pQfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549335; c=relaxed/simple;
	bh=OE0XZMxoN+lzBJ6Pub/O4OVZnEDZz5AZoPrtdE7dITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9vNbz9tw4CdUqsyvbr21AiHqRRu2Idphux0VWNmDP/KI8G8FIv1mwaHKjhj1KehAqWzSCG1T+6qiTKonROcSjVgAVQE3nHKRufKEUreVUf30JuwNOlOQRIFU2oxUpweJN/UT+QMzrml7cn6oKYgUGMMpg2VpXB+tkRBS8arzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR2tb1cA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709549332; x=1741085332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OE0XZMxoN+lzBJ6Pub/O4OVZnEDZz5AZoPrtdE7dITo=;
  b=CR2tb1cA+TraR8LCqREED7ChrsBO29hi/r9+SDXalwINVKgbx37bx9cQ
   YUsvokWxwy8r/eqVVVF1PfQP4IO03aF58p/yPUCpUa5kEZV4bv0B5ZHfH
   LdklePH5kLEHh8LVkb7vSonjGcSp+LxJYH53yNZGxmW1i6ZTrNuP6QGGM
   v5eY5bKEP38A9Sgvifg8e+qTSlK8w0xWHY/PwZmMT2RghWqHBD5vh5zJZ
   LIP9kbFyJR9nBFJ8bL6RHH4oUcJDy8kNHBwYxPRt44av1cqn32oxz6Fk9
   n2I9EtwXqtm3uNx6oX4tOveSt2iqvzJJH/ghugOgrKxNNPqSKI9FxC778
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4197661"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4197661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="46470235"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:48:51 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9C6C911F8B1;
	Mon,  4 Mar 2024 12:48:47 +0200 (EET)
Date: Mon, 4 Mar 2024 10:48:47 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Message-ID: <ZeWnD9YrXLWJYmhT@kekkonen.localdomain>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
 <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
 <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>

Hi Dan,

On Fri, Mar 01, 2024 at 04:42:01PM +0300, Dan Carpenter wrote:
> Sakari Ailus pointed out in another thread that we could use __free()
> instead.  Something like this:
> 

Looks good to me.

We could merge this with your SoB (pending Niklas's review). :-) The driver
has been since moved under drivers/media/platform/renesas/rcar-vin/ .

> diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
> index 582d5e35db0e..c569df6057b7 100644
> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -1372,8 +1372,8 @@ static int rcsi2_parse_v4l2(struct rcar_csi2 *priv,
>  static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  {
>  	struct v4l2_async_connection *asc;
> -	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *ep;
> +	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
> +	struct fwnode_handle *ep __free(fwnode_handle);
>  	struct v4l2_fwnode_endpoint v4l2_ep = {
>  		.bus_type = V4L2_MBUS_UNKNOWN,
>  	};
> @@ -1388,18 +1388,14 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  	ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
>  	if (ret) {
>  		dev_err(priv->dev, "Could not parse v4l2 endpoint\n");
> -		fwnode_handle_put(ep);
>  		return -EINVAL;
>  	}
>  
>  	ret = rcsi2_parse_v4l2(priv, &v4l2_ep);
> -	if (ret) {
> -		fwnode_handle_put(ep);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	fwnode = fwnode_graph_get_remote_endpoint(ep);
> -	fwnode_handle_put(ep);
>  
>  	dev_dbg(priv->dev, "Found '%pOF'\n", to_of_node(fwnode));
>  
> @@ -1408,7 +1404,6 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  
>  	asc = v4l2_async_nf_add_fwnode(&priv->notifier, fwnode,
>  				       struct v4l2_async_connection);
> -	fwnode_handle_put(fwnode);
>  	if (IS_ERR(asc))
>  		return PTR_ERR(asc);
>  
> 

-- 
Regards,

Sakari Ailus

