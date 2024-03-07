Return-Path: <linux-kernel+bounces-95941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4187552A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A2D1F23B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658A130E5B;
	Thu,  7 Mar 2024 17:29:55 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 332E2130E3C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832594; cv=none; b=bSdGH5oM6NHH/WuVHN1/j8wuo4R3eaqoFtwgKLHI1lTPEYEeIDAYcGcCdwFvXK7EdrKJDLlmujlTE6r6f0pfhSrxFbsTuFQ+8qlnYCyoosd+HTrOkSV7T+tDSh0qr0DUitDIYJ/hW/IJlsxjQzKS6GDKae+Oe1tCXUbm6NICTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832594; c=relaxed/simple;
	bh=knRagf2SaEsYlyHQSJfvNiE/tRYyl0/2a8GwXg+213Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqLd8zWTIipKyGv+wJDPmrM6Qzovu+ZYeXVUiqet2J0CD7hB1xweS6XC0f+BxicAqeNhDRMiEl2IfAD2e6Aj0Y5JDE4nJzm9MgCEGWURlsyVcIjwqRw14C/ihErPrbPC7yTFF6aoWgOrnO4afpriPyJjKQUJlbq/Rc60RHWR1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 226215 invoked by uid 1000); 7 Mar 2024 12:29:51 -0500
Date: Thu, 7 Mar 2024 12:29:51 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Colin Ian King <colin.i.king@gmail.com>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
  kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: gadget: net2272: remove redundant variable
 irqflags
Message-ID: <2b318367-2428-44ba-b4d9-0a452fcb7858@rowland.harvard.edu>
References: <20240307105135.1981060-1-colin.i.king@gmail.com>
 <mywsgq453muhggv5y7pfrsg7zrodtuebcpo5rbc4kus5h2ameo@fhnpemjuntaz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mywsgq453muhggv5y7pfrsg7zrodtuebcpo5rbc4kus5h2ameo@fhnpemjuntaz>

On Thu, Mar 07, 2024 at 05:51:59PM +0100, Uwe Kleine-König wrote:
> On Thu, Mar 07, 2024 at 10:51:35AM +0000, Colin Ian King wrote:
> > The variable irqflags is being initialized and being bit-or'd with
> > values but it is never read afterwards. The variable is redundant
> > and can be removed.
> > 
> > Cleans up clang scan build warning:
> > drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
> > set but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> this "problem" exists since the driver was introduced in commit
> ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device
> controller"). Might be worth a Fixes: line.
> 
> I wonder if the better fix would be:
> 
> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
> index 12e76bb62c20..19bbc38f3d35 100644
> --- a/drivers/usb/gadget/udc/net2272.c
> +++ b/drivers/usb/gadget/udc/net2272.c
> @@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
>  		goto err_req;
>  	}
>  
> -	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
> +	ret = net2272_probe_fin(dev, irqflags);
>  	if (ret)
>  		goto err_io;

I agree, that makes much more sense.

Alan Stern

