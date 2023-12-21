Return-Path: <linux-kernel+bounces-8317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC0281B590
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4E01C2284A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62996E59A;
	Thu, 21 Dec 2023 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="NokE8d95"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81A6A02A;
	Thu, 21 Dec 2023 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703160785; bh=Qsqg2Nh+p/M5AnL5ZaWqItsHScIrmvOCFyl0+ZYAWN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NokE8d95GceSvL1OTOagLWTS7zq1fSwLslCZGcnGjkiVXSc14/NUjpsv4a7Xaln1D
	 jXGX2OxdS9oZ1D3/MzvrMQDbUkX/Dro+tYh9FktE3eX220X0NA4ot4u/P+yD6gBqWA
	 tWG4LoCgzytRxw4cTe+eYWgVApcoQmhyUAdDEQtKAKv0mVtVOaFZvI+kxE6fCtAeJ/
	 KdqTVzIpzb9Z4IKwsS/6uE/dDM+5lS5mmlMkbDTPcTURIYv4tfJtvZT+++xWQLL17m
	 XBXZAgtm2HTmcgdlzd4AxOZ9iefpyEO/DXRii9EhPEgN04l00OZ8Ne/G7tdSY9v9NP
	 39vkbr9m5g1yw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 5D1B81000FD; Thu, 21 Dec 2023 12:13:05 +0000 (GMT)
Date: Thu, 21 Dec 2023 12:13:05 +0000
From: Sean Young <sean@mess.org>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Message-ID: <ZYQr0TkzdgJpoR5v@gofer.mess.org>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <ZYQEcg0-SEFEeuN6@orome.fritz.box>
 <20231221100950.GC10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221100950.GC10102@google.com>

On Thu, Dec 21, 2023 at 10:09:50AM +0000, Lee Jones wrote:
> On Thu, 21 Dec 2023, Thierry Reding wrote:
> 
> > On Thu, Dec 21, 2023 at 04:58:05PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the backlight tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
> > >   134 |                 ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > >       |                       ^~~~~~~~~~~~~~~
> > >       |                       pwm_apply_args
> > > 
> > > Caused by commit
> > > 
> > >   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")
> > > 
> > > interacting with commit
> > > 
> > >   2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")
> > > 
> > > from the backlight tree.
> > > 
> > > I have appplied the following merge fix patch.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Thu, 21 Dec 2023 16:13:37 +1100
> > > Subject: [PATCH] fix up for "backlight: mp3309c: Add support for MPS MP3309C"
> > > 
> > > from the backlight tree interacting with commit
> > > 
> > >   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")
> > > 
> > > from the pwm tree.
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/video/backlight/mp3309c.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
> > > index 34d71259fac1..b0d9aef6942b 100644
> > > --- a/drivers/video/backlight/mp3309c.c
> > > +++ b/drivers/video/backlight/mp3309c.c
> > > @@ -131,7 +131,7 @@ static int mp3309c_bl_update_status(struct backlight_device *bl)
> > >  					    chip->pdata->levels[brightness],
> > >  					    chip->pdata->levels[chip->pdata->max_brightness]);
> > >  		pwmstate.enabled = true;
> > > -		ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > +		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
> > >  		if (ret)
> > >  			return ret;
> > >  
> > > @@ -393,7 +393,7 @@ static int mp3309c_probe(struct i2c_client *client)
> > >  					    chip->pdata->default_brightness,
> > >  					    chip->pdata->max_brightness);
> > >  		pwmstate.enabled = true;
> > > -		ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > +		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
> > >  		if (ret)
> > >  			return dev_err_probe(chip->dev, ret,
> > >  					     "error setting pwm device\n");
> > 
> > Hi Lee,
> > 
> > We could exchange stable tags to make this work, but given that people
> > (myself included) are getting into holiday mode I'm inclined to just add
> > a pwm_apply_state() compatibility inline for now and then we can address
> > this in the new year or for the next cycle. What do you think?
> 
> Sorry, why is this happening?
> 
> I still see support for pwm_apply_state() in -next.

Not any more:

$ git grep pwm_apply_state linux-next/master 
$ 


Sean

