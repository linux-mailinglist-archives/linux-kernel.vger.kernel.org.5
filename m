Return-Path: <linux-kernel+bounces-78476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8E8613E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E61F237D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E838061F;
	Fri, 23 Feb 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9H59djv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FE78B57;
	Fri, 23 Feb 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698143; cv=none; b=Yor93XOqhfVeqBwrwc0vvBphxdYSfIhb5XIn2EDAOZWqt9sJ7aXysquYmc7HZbxIUqYDAT6bmG7RAG6+fPogMdYGMGj1iHDDuvki5CJ1a27Th7AqFaO4oVopvl0kOW4Sea4Um8cwtllBzKpW798eT+9zHuAGo/HrH/Q0ePtnK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698143; c=relaxed/simple;
	bh=VxpccfonnRW7IPLZiMVnUbAMDQVPguZSl5ozwgM5NkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8FsrjdygIe6tw3+Rw6P0CpT3d0clE+EmM0covaskF9R7zwVF4rE0Y1RvhY9a+TDrgi48tqE3xFypuLJKyyv7crBWwedDyuszvqsfUk/QY2AJ0rh1uqoZk+Md/4Otme2m5QM8J+8y+mf3L4wr5vOqpPZ7Pz/mRAjSHkyvFud5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9H59djv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBEC433C7;
	Fri, 23 Feb 2024 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708698142;
	bh=VxpccfonnRW7IPLZiMVnUbAMDQVPguZSl5ozwgM5NkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9H59djv+xdj9IMpiTO2kiHy8ruKsmdNsaXe8aBecR1fc21Lj7r+uRmdCOGOTdQFh
	 Hke0UzbdOV9HhvDHB4GqsOLfF8+TFp49qgq0IL8BBm+/9YYGpd3nPhcbIGlwDykLZN
	 556lwzBGz4mHKiK3yfwJ//5P5mww+ge+oZDp6m3F9P1T+DAYNm90BKFeNfD0HSxGY/
	 isxufZAjD0IWY9nNhSPkpGpFy2ybPxM80O/naJ2PCBOi4EuiPTb/viqS9A7XePqEpQ
	 mRKhJtzkgMagjfg35+gZLXzBYloC78y/wcapN644tpq82lRV06m9I1uE0IzjXh0msJ
	 38uTU3DnbEHPA==
Date: Fri, 23 Feb 2024 14:22:18 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Juergen Borleis <jbe@pengutronix.de>, linux-leds@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] leds: trigger/tty: Use led_set_brightness() to support
 all use cases
Message-ID: <20240223142218.GA1666215@google.com>
References: <20210503092542.14497-1-jbe@pengutronix.de>
 <20230109084320.nj7erwh3eu4jlw7y@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109084320.nj7erwh3eu4jlw7y@pengutronix.de>

On Mon, 09 Jan 2023, Uwe Kleine-König wrote:

> Hello Jürgen,
> 
> On Mon, May 03, 2021 at 11:25:42AM +0200, Juergen Borleis wrote:
> > Using led_set_brightness_sync() only works for LEDs which are connected
> > via some kind of external bus like I²C or SPI. But it doesn't work for
> > the simple use case of directly connected LEDs via GPIOs.
> > Because this function only honors the led_classdev::brightness_set_blocking
> > callback. But the LED-GPIO driver registers the
> > led_classdev::brightness_set member if the GPIO can be modified directly
> > and thus, TTY triggers fail silently with -ENOTSUPP.
> > 
> > With the previously used led_set_brightness() it works for both use cases.
> > This function first checks for the simple case where the GPIO can be changed
> > without additional overhead, and if it fails, does the modification via a
> > workqueue.
> > 
> > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> > ---
> >  drivers/leds/trigger/ledtrig-tty.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> > index f62db7e..af61281 100644
> > --- a/drivers/leds/trigger/ledtrig-tty.c
> > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > @@ -122,12 +122,12 @@ static void ledtrig_tty_work(struct work_struct *work)
> >  
> >  	if (icount.rx != trigger_data->rx ||
> >  	    icount.tx != trigger_data->tx) {
> > -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > +		led_set_brightness(trigger_data->led_cdev, LED_ON);
> >  
> >  		trigger_data->rx = icount.rx;
> >  		trigger_data->tx = icount.tx;
> >  	} else {
> > -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> > +		led_set_brightness(trigger_data->led_cdev, LED_OFF);
> >  	}
> 
> This problem still exists, right?
> 
> I think the right thing here is to call led_set_brightness_nosleep()
> however.
> 
> Having said that, I think there are too many variants of
> led_set_brightness which makes it difficult to pick the right one.
> 
> (I'm aware of
>  - led_set_brightness_nosleep
>  - led_set_brightness_nopm
>  - led_set_brightness_sync
>  - led_set_brightness
> 
> and there are a few more static variants in led-core.c
> (__led_set_brightness, __led_set_brightness_blocking,
> set_brightness_delayed).)

This patch (and this response) was never sent to me.

Not a great deal I can do if I'm not aware of it.

-- 
Lee Jones [李琼斯]

