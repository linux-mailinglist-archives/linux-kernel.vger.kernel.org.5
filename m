Return-Path: <linux-kernel+bounces-40442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DA83E03F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C73728661C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9D20310;
	Fri, 26 Jan 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwRnoQ1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C0AD53;
	Fri, 26 Jan 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290419; cv=none; b=KqVnvMvNsq2elZQD+sg0SdO+kDyZCPDbWBHMdQZLg2D1Qy6P6njXFd9uLOnz9rtrgBfdJCV9fMe7G2xUcQ3UKrnOFGMRc+757+b1ybwtNPfd5QIUJlAmql49H2NO/EYptQb0pUJf2QmNog4GTrmsFDFHTCjrSpfejg8BAt7PKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290419; c=relaxed/simple;
	bh=EaGdLLuK7KoXxc2xwMv+tfwgW/TA2h5qfkCRdoyTOyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+dc/dwQhEBakUNDDJQXFDLS5GZeiZwk5x513puLwSDyYWlRDsIGgjnw6voGn9p0v3xxHHcs6wz3/OmvzJt+fcwmC3dseYbwhEzbO51pf/WS/kvv0xtRmAsWOjGPGE1940Lu4V50420GdtVx16xJTgQr2eos2IM5+qPbwhhTWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwRnoQ1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D745EC43394;
	Fri, 26 Jan 2024 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706290419;
	bh=EaGdLLuK7KoXxc2xwMv+tfwgW/TA2h5qfkCRdoyTOyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwRnoQ1Ye8YMACDACjk5RagyKlSNs72JQsoidf+W273G8WOIEyfUud+q8YybXHJcE
	 IJvV6jIc5HYAbgJC7ny4yBZfu5q+zDJ58YkWkU2MVax8K76m3NNQfWUibmF8i/ZW2D
	 ONU3E7Ddway0hduJreV+qfbrvi8QLzT3ZXDMX/Fc2i7eEn2cMPCF93HrbX+TOW6pYi
	 gJSWCGBXWGF5lOMKBtCDrUKxap6u64LOIYNAUUTSNJwmwjk0aKkFL/ZeW2davTSOx8
	 4DQCbgPVsts8vDApApLLqlItUKrPAhRqP0FnpT47JbW94nmqjNaAzYu49jKCgCn77O
	 3fQpD0alsmyXw==
Date: Fri, 26 Jan 2024 09:38:26 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v4 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <4xqmpxq4uqqxmgsf5lzxo3qjxmoeu6cpb4iqvtxefyiqlt3pzk@g76y2r4uxkiw>
References: <20240103221124.3063683-1-tanmay.shah@amd.com>
 <20240103221124.3063683-3-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103221124.3063683-3-tanmay.shah@amd.com>

On Wed, Jan 03, 2024 at 02:11:25PM -0800, Tanmay Shah wrote:
> This patch enhances rproc_put() to support remoteproc clusters
> with multiple child nodes as in rproc_get_by_phandle().
> 
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

As described in the first patch, this documents that Tarak first
certified the origin of this patch, then you certify the origin as you
handle the patch.

But according to From: you're the author, so how could Tarak have
certified the origin before you authored the patch?

Either correct the author, or add Co-developed-by, if that's what
happened.

> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 0b3b34085e2f..f276956f2c5c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2554,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
>   */
>  void rproc_put(struct rproc *rproc)
>  {
> -	module_put(rproc->dev.parent->driver->owner);
> +	if (rproc->dev.parent->driver)
> +		module_put(rproc->dev.parent->driver->owner);
> +	else
> +		module_put(rproc->dev.parent->parent->driver->owner);
> +

This does however highlight a bug that was introduced by patch 1, please
avoid this by squashing the two patches together (and use
Co-developed-by as needed).

Regards,
Bjorn

>  	put_device(&rproc->dev);
>  }
>  EXPORT_SYMBOL(rproc_put);
> -- 
> 2.25.1
> 

