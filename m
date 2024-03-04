Return-Path: <linux-kernel+bounces-90125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E01F86FAAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12898284BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818E13AF0;
	Mon,  4 Mar 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuiqweWU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC6168D0;
	Mon,  4 Mar 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537017; cv=none; b=Ynyq7Ea11AxGO08hY+IaXv7kA7mZ6+mgYCqwzxrNOWgnu8z65nQ7jbGOsHLbW0UmjZvFXvbxjrplEQmoI79wh1CHmZgw49bX6GDjTkNX7NPHopgTv82xxZ5kakV6PYRg3jKkFEJoRjw/XrIq4FD+t3pzuTL+bMfP9R8rGuQWGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537017; c=relaxed/simple;
	bh=B27z1Z88iPUB5Ma3pXW59JeufqOPxYT1JfOeH07WPPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb3ZRppXaXx8jnjo58Ys8Eq87DfyujKakfXHGJVHqWfsSYJIoK1SOWRwAFOkmh1FUE8iBCeBEmh7oI4KeJ6cRnUr4SZLtUo1VVuxk0swEC3ipF6yVlnZkIH8/bvDUD8VNBJE1pLEytQDp66WPf0gDpI/KQD8JFGYNILKriXFrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuiqweWU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709537015; x=1741073015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B27z1Z88iPUB5Ma3pXW59JeufqOPxYT1JfOeH07WPPU=;
  b=fuiqweWUhA8dVE9YH+u4RmGfzdg3zGBiNcKb7XRweekoqZf+/dje4b4F
   Tm/zjZco049Qf/5xiyUttQGj7z6gVeTSKyRHLfLRuo6Xl8lnWxDQqAWl6
   YMnqguaQE2N+rB+LSFUZI2/ruPT+I0N37EolB8K3QRyYPJqxEQLVwRv6r
   GckKZmWOFa1Q0o61g8pj+CZ+pcrH0AaE+BbxGKPDwq4hWt0+ibg9cQl44
   inoubd/bWiqhiw/tL+CZfvpIPMFuEVMKVufDlLbeTGnbMk4QvO2i2/Ndn
   gYr9UHeE50PINb0SSGhkMd0HwbnmlnBZGKRf6tJbzKlPkIN9RuaTvEhF/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3867756"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3867756"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9463163"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:23:22 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 94EA711F8B1;
	Mon,  4 Mar 2024 09:23:19 +0200 (EET)
Date: Mon, 4 Mar 2024 07:23:19 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: v4l2-fwnode: Improve exception handling in
 v4l2_fwnode_connector_add_link()
Message-ID: <ZeV25-dTLVE_vyqx@kekkonen.localdomain>
References: <9d0511cd-1fb2-4612-9b21-196a43ad0397@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0511cd-1fb2-4612-9b21-196a43ad0397@web.de>

Hi Markus,

On Fri, Mar 01, 2024 at 03:07:50PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 15:02:09 +0100
> 
> The kfree() function was called in one case by
> the v4l2_fwnode_connector_add_link() function during error handling
> even if the passed variable contained a null pointer.
> Thus use another label.

This isn't a problem, the code is fine as-is.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 89c7192148df..dc6daf3a9a51 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -744,7 +744,7 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link) {
>  		err = -ENOMEM;
> -		goto err;
> +		goto put_fwnode_ep;
>  	}
> 
>  	err = v4l2_fwnode_parse_link(connector_ep, &link->fwnode_link);
> @@ -760,6 +760,7 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
> 
>  err:
>  	kfree(link);
> +put_fwnode_ep:
>  	fwnode_handle_put(connector_ep);
> 
>  	return err;
> --
> 2.44.0
> 

-- 
Sakari Ailus

