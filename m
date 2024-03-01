Return-Path: <linux-kernel+bounces-88442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E086E1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA091C21B15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59DF6EB6D;
	Fri,  1 Mar 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jNa9ppBu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1269DFC;
	Fri,  1 Mar 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298914; cv=none; b=F9doGqEvvbCxWcvuPK1VP/SCRSAUUw87k0qBRZcMXJREWsXd+T2l7wQzFSyT29x3K05sEZVdhO0ueEJCafBBDF760d9AdnlJ6/H+leykUiId8+GbT1IgZrzu/vky6PAef+z7vMn7OwZgBRkQ+r0pZwPCQDyEQn/HXKEOG6aU9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298914; c=relaxed/simple;
	bh=S9uT2Pz4LtJnMifeUT8J8MOdifzyAx6Erp5bTQR06XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnIm9QHJrVM+AXzuXXQBS3L/opLSP9xSW7E3Mct6cLvAnIbXPLU0vXGh5jkfeuB6XG8ZmsRuzczGVQrTbzNmYgvHvoUt59/934v0C5EJb+58nvOTpowk8P6x6+TE3auu9gluHLiCGv8UZaqLJTxK8PQ6QD9DmPYwKk2RI7rcfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jNa9ppBu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E27D99CE;
	Fri,  1 Mar 2024 14:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709298897;
	bh=S9uT2Pz4LtJnMifeUT8J8MOdifzyAx6Erp5bTQR06XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNa9ppBulCpYblCBQUBcTqcffURdQsXH/j6q2ehohQkvfJyKHPC555WuSJKwTLwc8
	 QrzAqJILuQwkxBCtDbQs2ftT5Z6bkUoc1w7KGd4NJWvy/4ce2nhFjBLgWOibhokiM8
	 xn7AbkVk5RwYAT3flrOt2JXtwzsrWqtTLy/M2utQ=
Date: Fri, 1 Mar 2024 15:15:13 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Message-ID: <20240301131513.GG30104@pendragon.ideasonboard.com>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>

On Fri, Mar 01, 2024 at 01:10:15PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 13:02:18 +0100
> 
> Add a label so that a bit of exception handling can be better reused
> in an if branch of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Just in case someone may be tempted to apply this:

NAK

Markus, don't bother replying to this e-mail, I will delete your reply
without reading it.

> ---
>  drivers/media/platform/renesas/rcar-csi2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
> index 582d5e35db0e..621c92c31965 100644
> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -1388,12 +1388,13 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  	ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
>  	if (ret) {
>  		dev_err(priv->dev, "Could not parse v4l2 endpoint\n");
> -		fwnode_handle_put(ep);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_fwnode_ep;
>  	}
> 
>  	ret = rcsi2_parse_v4l2(priv, &v4l2_ep);
>  	if (ret) {
> +put_fwnode_ep:
>  		fwnode_handle_put(ep);
>  		return ret;
>  	}

-- 
Regards,

Laurent Pinchart

