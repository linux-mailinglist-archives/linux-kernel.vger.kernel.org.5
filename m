Return-Path: <linux-kernel+bounces-5652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A14818DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F0E1F2616E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD035896;
	Tue, 19 Dec 2023 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="fuyZeC94"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD8374C0;
	Tue, 19 Dec 2023 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703005464; bh=Mk9PhkmouZ13dtQwJISx9AtOkdubRybUQt5D1rkXFrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fuyZeC9428j2fdhhR3IhMBmr2XL5MSFZN0xIIdCCywHWHR9Q+0blG4LqouDPRN+G+
	 unxHV+139w1UI8IfecS6IBOxvn6gBtg+pOrEFkJv4OlG3/GnLeYa6Q3kGH6FLBtaeo
	 cM+uncmQlltL4VnCizkjoigt941AbvDMcBmuQBht4q7lV9BRDrvRDSPlSXDIoEU23a
	 wZxgVYvQ2d4kjdYWsvvt2mzRivCUl0det1h9EfkvA5W7VYU9nX7kwVyajG9kxhz/0W
	 jI+wunyZmTN2walGiorVVLVS5s9THnVRTTqjTmy0GiCapRVcEsoDeiAIxV+zlMOesS
	 +kk2z7yHKPBtQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id E2EAB1000FD; Tue, 19 Dec 2023 17:04:24 +0000 (GMT)
Date: Tue, 19 Dec 2023 17:04:24 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <ZYHNGMabe8xBigyN@gofer.mess.org>
References: <cover.1702890244.git.sean@mess.org>
 <5249bb5d6c067692e4cd09573ced2df58966693b.1702890244.git.sean@mess.org>
 <eicw7ppqj5dubskhmeh7iwdaoixv27qw2zqaljkddt2rwosogt@6aftnwt6p5ek>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eicw7ppqj5dubskhmeh7iwdaoixv27qw2zqaljkddt2rwosogt@6aftnwt6p5ek>

Hello Uwe,

On Mon, Dec 18, 2023 at 10:31:36AM +0100, Uwe Kleine-König wrote:
> On Mon, Dec 18, 2023 at 09:06:46AM +0000, Sean Young wrote:
> > +	pc->rate = clk_get_rate(pc->clk);
> > +	if (!pc->rate) {
> > +		clk_rate_exclusive_put(pc->clk);
> > +		return dev_err_probe(&pdev->dev, -EINVAL,
> > +				     "failed to get clock rate\n");
> > +	}
> > +
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &bcm2835_pwm_ops;
> > +	pc->chip.atomic = true;
> >  	pc->chip.npwm = 2;
> >  
> >  	platform_set_drvdata(pdev, pc);
> >  
> >  	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		clk_rate_exclusive_put(pc->clk);
> >  		return dev_err_probe(&pdev->dev, ret,
> >  				     "failed to add pwmchip\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bcm2835_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
> > +
> > +	clk_rate_exclusive_put(pc->clk);
> 
> The ugly thing here is that now clk_rate_exclusive_put() happens before
> pwmchip_remove().

Mixing devm with non-devm does lead to problems like this.

> Maybe register a devm cleanup which also gets rid of
> the two clk_rate_exclusive_put() in probe's error path?

That's good idea, I've done that in v10.

> 
> >  	return 0;
> >  }
> > @@ -197,6 +216,7 @@ static struct platform_driver bcm2835_pwm_driver = {
> >  		.pm = pm_ptr(&bcm2835_pwm_pm_ops),
> >  	},
> >  	.probe = bcm2835_pwm_probe,
> > +	.remove = bcm2835_pwm_remove,
> 
> Please use .remove_new

No longer needed in v10.


Sean

