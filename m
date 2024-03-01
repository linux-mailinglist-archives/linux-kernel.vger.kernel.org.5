Return-Path: <linux-kernel+bounces-88440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADD86E1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059D4284659
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912F6D1A8;
	Fri,  1 Mar 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LjLFSDgf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3527E1;
	Fri,  1 Mar 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298897; cv=none; b=MojtFafIOrKH65GCN11nH9yI039j4mqZdBfYngag94Nb6YZ5uvGTq/a5G40a/V5AYAPQ2N6ltdDJ9+EKUzDsL/tHIoGRvI4RE3PwfVs4aNQMih8hziMn0OBFOSqZCIPgTGF5mPgM4ka5ehWc313oTjx1TlksM0uYBp5W3RB1SIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298897; c=relaxed/simple;
	bh=D8wqWZgP5j4U3Gy8XWOlMUhgVBct6naC34RFtMGwxkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjsu/bNqZZV5IbYsoG4Y3h/DcNQcruQ84wC3kVSKm/zRA0voeucLcji4R1V9nq8iOC5+Nu2wgmLRJxjJAOy7kjCDdUmvSg+KF/INB0M+LWZGQ5jMoc/zJbgasYkWKCYKHQUk+MhZYfHdW0HG5MVbvoC+t/eFEWmWDkkGzobRx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LjLFSDgf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D14719CE;
	Fri,  1 Mar 2024 14:14:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709298879;
	bh=D8wqWZgP5j4U3Gy8XWOlMUhgVBct6naC34RFtMGwxkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjLFSDgf9xJtOpGjsnakjFQLqZpvuXyW1biVwDDFPVlDtOF6sQxTd4gBSue31rZ18
	 NhYdKsXdaxZnHBEm4DpDGzL2Xm4o/yxHoHAi4fyJ4sAImn7FOT9n4CQPizhLIe3UXp
	 YDmQ0E51BE3OoAqm85a5hTpP6L1Ngz1vY1FDC0sQ=
Date: Fri, 1 Mar 2024 15:14:55 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: rzg2l-csi2: Use common error handling code in
 rzg2l_csi2_parse_dt()
Message-ID: <20240301131455.GF30104@pendragon.ideasonboard.com>
References: <c26c73d8-9b20-431e-a299-c9508ac3f6ed@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c26c73d8-9b20-431e-a299-c9508ac3f6ed@web.de>

On Fri, Mar 01, 2024 at 02:10:41PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 14:02:22 +0100
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
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> index e68fcdaea207..ef6922dad35f 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> @@ -671,12 +671,13 @@ static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2)
>  	ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
>  	if (ret) {
>  		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
> -		fwnode_handle_put(ep);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_fwnode_ep;
>  	}
> 
>  	ret = rzg2l_csi2_parse_v4l2(csi2, &v4l2_ep);
>  	if (ret) {
> +put_fwnode_ep:
>  		fwnode_handle_put(ep);
>  		return ret;
>  	}
> --
> 2.44.0
> 
> 

-- 
Regards,

Laurent Pinchart

