Return-Path: <linux-kernel+bounces-22908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2282A533
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2026E1C226A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE618363;
	Thu, 11 Jan 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pk18AGWz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8718F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1F6B240003;
	Thu, 11 Jan 2024 00:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704932125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L956n0qI7eMoQ9LeBFrRDOVKdOpf1Z3wRlhs+uI//gs=;
	b=pk18AGWzv7CtCKJ4ALrIYofo0V0sitodrffpsHo79GpHrr4gs0ALx/cjRscWDBMd4zIpAU
	+ewsqokLP8V+yQ1ByPEnaXggblDGR40x6/r7W4KJT4vyPqZr+K/ctsQTBohGqX4OSZXISb
	LkEG2eT9qzWhE4ZygoHzWyXPSuy3vQZJ3il8grd+PWe0+FeFCj36ntHzkXWK3aBiiqWleA
	IPfuR8iq92qe1Mhbby9/o7UlgjctwvXlVYSDtKCNs1TH1JR/mX5R8qKDbVBHf/geyq3neu
	UDkRVOZv44eyO4okI4SI606q6RoUCGl29mF5A3QqoSVTulbs5kFmYrL2zbyhSw==
Date: Thu, 11 Jan 2024 01:15:23 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH 1/1] i3c: master: svc: return error when read length
 bigger than 255
Message-ID: <20240111001523f69f6a29@mail.local>
References: <20240110222503.2381599-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110222503.2381599-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 10/01/2024 17:25:03-0500, Frank Li wrote:
> RDTERM in MCTRL is 8 bits. Add a length check to prevent silent data errors
> when the read length exceeds 255 bytes during each i3c_priv_xfer operation.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index bd10bb698da0f..181b56953fb28 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1375,6 +1375,11 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
>  		cmd->len = xfers[i].len;
>  		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
>  		cmd->continued = (i + 1) < nxfers;
> +
> +		if (cmd->rnw && cmd->len > 255) {
> +			dev_err(master->dev, "only support read less than 255 each xfer\n");

What would be the end user action upon seeing this message? Is it actually
useful?

> +			return -EINVAL;
> +		}
>  	}
>  
>  	mutex_lock(&master->lock);
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

