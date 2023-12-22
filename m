Return-Path: <linux-kernel+bounces-9599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B281C83B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70161C2231E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8A12E7B;
	Fri, 22 Dec 2023 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="n48t/rWx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97111727;
	Fri, 22 Dec 2023 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703241422; bh=cWqAUpWjhIOY5kW4clTqhVJSzMYq+y12OfFP6xGF06s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n48t/rWxle/8Ss7ZXz2Y/rmPUsOtQ/gcbgfbYCDE8IyGIJFMLOCrsRmW9bqqRERH4
	 PoUct/FsAPmVOE8VbKbJvyTIwtFYuSRbW5DUxPAnDLVd505OtwuvF3BhOgsGthX4N8
	 oLPi4ar/DP5eDffZTsR0cGQWdQ3gVEGqzCN3DWmCtvGNPUFXpM65865jQ+7GCUb6H/
	 yCeeb6GVzliT8qJFuaFhhv8hSJLA+6d7aQfSCGsR9sDG0AfVkzKDqBmSWG215aq1sT
	 eZbsgxU+UixcrJlcTCNscAqpV2zO5tspC3QNpSJRdj91rJJd6n3arZyYsGI1ggDv7Z
	 GcBUQRQHYrzZw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 2B1F31000FD; Fri, 22 Dec 2023 10:37:02 +0000 (GMT)
Date: Fri, 22 Dec 2023 10:37:02 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] pwm: bcm2835: Allow PWM driver to be used in atomic
 context
Message-ID: <ZYVmzrRwgVOGinmy@gofer.mess.org>
References: <20231220142426.1275052-1-sean@mess.org>
 <fuku3b5ur6y4k4refd3vmeoenzjo6mwe3b3gtel34rhhhtvnsa@w4uktgbqsc3w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fuku3b5ur6y4k4refd3vmeoenzjo6mwe3b3gtel34rhhhtvnsa@w4uktgbqsc3w>

On Fri, Dec 22, 2023 at 11:30:47AM +0100, Uwe Kleine-König wrote:
> Hello Sean,
> 
> On Wed, Dec 20, 2023 at 02:24:25PM +0000, Sean Young wrote:
> > @@ -151,8 +153,26 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
> >  				     "clock not found\n");
> >  
> > +	ret = clk_rate_exclusive_get(pc->clk);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "fail to get exclusive rate\n");
> > +
> > +	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
> > +				       pc->clk);
> > +	if (ret) {
> > +		clk_rate_exclusive_put(pc->clk);
> 
> That clk_rate_exclusive_put() is wrong. If devm_add_action_or_reset()
> fails that is already cared for.

Yes, you're right. I missed that - should've checked.

> Given that Thierry already applied this patch, getting this fixed in a
> timely manner would be good.

I'll send out a patch shortly, thanks for catching.


Sean

