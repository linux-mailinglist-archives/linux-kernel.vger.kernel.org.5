Return-Path: <linux-kernel+bounces-56342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539984C8F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B01284C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96270171B6;
	Wed,  7 Feb 2024 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AV8BBeIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3717BB4;
	Wed,  7 Feb 2024 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302948; cv=none; b=YhC+SdHAJ3RJL3zEGEhLSxHPoAbd9I7WYoN5CXY8LDiWJ66o3MOQWD1OQdU1aJU/KleX9TmTUzNpEKdKBJoJOusHyyoTCjHnXb8NHOBFK6CR8K9FBVe0YaS+Axpl4d16si4yIql5RJIdYNA3gcwQyk5w+c57Y55s9YXzbLn/VZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302948; c=relaxed/simple;
	bh=HjVI1rzsu+zvlKE1HIxOXNwow7cL5cXi4YaNQhhBG84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIL670lE6RjQCNlU8W+X4AfLP5ZVwv1zuu2D0VLjR6QHVmvbZU+Tk4S0Y3AqclxMjdrt3S7u0V6ak/EQeKQ2C3jndT6v0H4p1BbafF+xCcIvsn97E/uAJUhb9pTfx5+i5odrr3CCyFBqskBBvuCs7IC/PnvdymZ7BeRptmDuzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AV8BBeIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5913C433F1;
	Wed,  7 Feb 2024 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707302948;
	bh=HjVI1rzsu+zvlKE1HIxOXNwow7cL5cXi4YaNQhhBG84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AV8BBeIJl2tQ1nV+4PPUTSvU8ah2M0D1ak19c8pIvvlyjwR59PkOhskYe7IysKTmr
	 MRpcTccxtnwh3R62ct1PrbRCwJfNfsRNL9ksiEA7QdBSx1As+QXKqnvP5rehfVTo0L
	 vj9pzph8ahvLRVJ0GkjC01q4+5uKlmwbrJHXZ9eg=
Date: Wed, 7 Feb 2024 10:49:05 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: set device type for GPIO chips
Message-ID: <2024020732-duchess-husband-8b1b@gregkh>
References: <20240201162758.50733-1-brgl@bgdev.pl>
 <CACRpkdbAw5NfSr8GSNiQhOzSi-tERyn=-ZroLfF-FRbsW2JviQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbAw5NfSr8GSNiQhOzSi-tERyn=-ZroLfF-FRbsW2JviQ@mail.gmail.com>

On Wed, Feb 07, 2024 at 11:45:39AM +0100, Linus Walleij wrote:
> On Thu, Feb 1, 2024 at 5:28 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > It's useful to have the device type information for those sub-devices
> > that are actually GPIO chips registered with GPIOLIB. While at it: use
> > the device type struct to setup the release callback which is the
> > preferred way to use the device API.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (...=
> > +static struct device_type gpio_dev_type = {

Can you make this structure const please?

> > +       .name = "gpio_chip",
> > +       .release = gpiodev_release,
> > +};
> > +       gdev->dev.type = &gpio_dev_type;
> >         gdev->dev.bus = &gpio_bus_type;
> >         gdev->dev.parent = gc->parent;
> 
> Looks good to me (TM) but we should run this by Greg so he get the chance
> to chime in, I doubt he will see it on LKML.

Yes thanks, I wouldn't have caught it...

greg k-h

