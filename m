Return-Path: <linux-kernel+bounces-7506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DC81A90B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CD01C22862
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FB4A99B;
	Wed, 20 Dec 2023 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="sBeZGPLI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F622073;
	Wed, 20 Dec 2023 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=pnRhjiZcbdO1KLXw23tApj7CFwqY1eJ1CqhdvhHcuFs=; b=sBeZGPLIOEfeC7qeU3Qb6s6JKo
	dMDmZ/+Np+64Rs9V6UD5EtX0LwVPexKa8BO5rTEcBuoHF1rn7o91w9CCIdCP1kMK0+ahEtrtOYiFt
	74xvtC4MWndES8Lrx00zYC67iAVpkZDz7FhO/S0ElqKSx4/vmK+fnn3zbsV3CrL5oePA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56224 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rG4xH-00036T-2D; Wed, 20 Dec 2023 17:22:19 -0500
Date: Wed, 20 Dec 2023 17:22:18 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220172218.a81bf81bdf502100589dd0b6@hugovil.com>
In-Reply-To: <ZYML9A5txM6nuUbD@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-7-hugo@hugovil.com>
	<ZYML9A5txM6nuUbD@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 06/18] serial: sc16is7xx: use
 spi_get_device_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:44:52 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:50PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Use preferred spi_get_device_match_data() instead of
> > device_get_match_data() and spi_get_device_id() to get the driver match
> > data.
> 
> ...
> 
> > +	devtype = (struct sc16is7xx_devtype *)spi_get_device_match_data(spi);
> 
> Nice one, but drop the casting. (Yes, make sure the assignee is const. It might
> require an additional change.)

Done, devtype was already const.

> 
> > +	if (!devtype) {
> > +		dev_err(&spi->dev, "Failed to match device\n");
> > +		return -ENODEV;
> 
> 		return dev_err_probe(...);
> 
> ?

Yes, done for V2.

Also done the same two changes for the I2C part.

Hugo.

