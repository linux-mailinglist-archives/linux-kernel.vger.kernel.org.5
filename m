Return-Path: <linux-kernel+bounces-8401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DB81B6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7991F238FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13C76DBF;
	Thu, 21 Dec 2023 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAvh3J/7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397176DB1;
	Thu, 21 Dec 2023 12:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A518C433C7;
	Thu, 21 Dec 2023 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163073;
	bh=JWkwZTxr1bx7lg4F5uSH+TZQiOtgILUeHxtqIe2ucXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAvh3J/7x2ifsPC4dkV6Lp1isab009nZA9lCssYwh0oJPG490Ynx9iGLMc03l9cDp
	 4vYbbm3k3ad+rnoH0qAMMAxWYs1uDYCBz1bzDGpTy36LjlVPkD7MJ5NPInz6RW3CBK
	 Bvj7tzze8Mh6WXfoyJnaRe6LgwxBdTq+Jt6dkU34HjxUGJjNViT7ndrheKot48cXAu
	 4U8KZbZm1Xh8mX6MM/dlrDMQZ7Tkl1NcWtgE4hZuO8mmkMVl1YPpD921wHJzfBrxYi
	 qTeW5Fi4lUd6oWRDIqQdCqxrzNTNRVZlYu1jgD56mOcAI4ipFcC3kZ413eJpRHeYPH
	 ePsRl7pVNFshA==
Date: Thu, 21 Dec 2023 12:51:08 +0000
From: Lee Jones <lee@kernel.org>
To: Sean Young <sean@mess.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Message-ID: <20231221125108.GF10102@google.com>
References: <20231221165805.0c4771c1@canb.auug.org.au>
 <ZYQEcg0-SEFEeuN6@orome.fritz.box>
 <20231221100950.GC10102@google.com>
 <ZYQr0TkzdgJpoR5v@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYQr0TkzdgJpoR5v@gofer.mess.org>

On Thu, 21 Dec 2023, Sean Young wrote:

> On Thu, Dec 21, 2023 at 10:09:50AM +0000, Lee Jones wrote:
> > On Thu, 21 Dec 2023, Thierry Reding wrote:
> > 
> > > On Thu, Dec 21, 2023 at 04:58:05PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > > 
> > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
> > > >   134 |                 ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > >       |                       ^~~~~~~~~~~~~~~
> > > >       |                       pwm_apply_args
> > > > 
> > > > Caused by commit
> > > > 
> > > >   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")
> > > > 
> > > > interacting with commit
> > > > 
> > > >   2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")
> > > > 
> > > > from the backlight tree.
> > > > 
> > > > I have appplied the following merge fix patch.
> > > > 
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Thu, 21 Dec 2023 16:13:37 +1100
> > > > Subject: [PATCH] fix up for "backlight: mp3309c: Add support for MPS MP3309C"
> > > > 
> > > > from the backlight tree interacting with commit
> > > > 
> > > >   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")
> > > > 
> > > > from the pwm tree.
> > > > 
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >  drivers/video/backlight/mp3309c.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
> > > > index 34d71259fac1..b0d9aef6942b 100644
> > > > --- a/drivers/video/backlight/mp3309c.c
> > > > +++ b/drivers/video/backlight/mp3309c.c
> > > > @@ -131,7 +131,7 @@ static int mp3309c_bl_update_status(struct backlight_device *bl)
> > > >  					    chip->pdata->levels[brightness],
> > > >  					    chip->pdata->levels[chip->pdata->max_brightness]);
> > > >  		pwmstate.enabled = true;
> > > > -		ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > > +		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
> > > >  		if (ret)
> > > >  			return ret;
> > > >  
> > > > @@ -393,7 +393,7 @@ static int mp3309c_probe(struct i2c_client *client)
> > > >  					    chip->pdata->default_brightness,
> > > >  					    chip->pdata->max_brightness);
> > > >  		pwmstate.enabled = true;
> > > > -		ret = pwm_apply_state(chip->pwmd, &pwmstate);
> > > > +		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
> > > >  		if (ret)
> > > >  			return dev_err_probe(chip->dev, ret,
> > > >  					     "error setting pwm device\n");
> > > 
> > > Hi Lee,
> > > 
> > > We could exchange stable tags to make this work, but given that people
> > > (myself included) are getting into holiday mode I'm inclined to just add
> > > a pwm_apply_state() compatibility inline for now and then we can address
> > > this in the new year or for the next cycle. What do you think?
> > 
> > Sorry, why is this happening?
> > 
> > I still see support for pwm_apply_state() in -next.
> 
> Not any more:
> 
> $ git grep pwm_apply_state linux-next/master 
> $ 

Okay, that's changed since this morning.

I think the easiest solution would be to take Stephen's patch.

-- 
Lee Jones [李琼斯]

