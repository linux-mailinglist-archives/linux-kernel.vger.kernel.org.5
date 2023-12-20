Return-Path: <linux-kernel+bounces-7292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254581A4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC8288B38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BF495E6;
	Wed, 20 Dec 2023 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="kXyIUuPV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501B3FE33;
	Wed, 20 Dec 2023 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=U8rZjAmGtLQfE0RJ8Rx+OYUGCIvs1G9q060d7jcwYcQ=; b=kXyIUuPViEi5Ah6aW+Hz6fnm5V
	qbg//jvoS4+FE70y2JdkCEWJ7UoNow6zbkgFG+9xm+4O57C7I6Cu1y88Uko8r+KXzEYv+QSwhUd3d
	ahUO6MMhWXgCwjXI1qpkZpQpBZ9SUKq09Xg/jvFZVMS41MKHZFAK9T04/s5Ir/WNoZPc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39880 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFzMj-000734-TX; Wed, 20 Dec 2023 11:24:14 -0500
Date: Wed, 20 Dec 2023 11:24:13 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220112413.c6f96dbb438df63a5e5f08a0@hugovil.com>
In-Reply-To: <ZYMOH2VFRJ1npR7L@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-14-hugo@hugovil.com>
	<ZYMOH2VFRJ1npR7L@smile.fi.intel.com>
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
Subject: Re: [PATCH 13/18] serial: sc16is7xx: use in_range() for DT
 properties bound checks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:54:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:57PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Improve code readability and efficiency by using in_range() when checking
> > device tree properties bound.
> 
> ...
> 
> >  	count = device_property_count_u32(dev, "irda-mode-ports");
> > -	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
> > +	if (!in_range(count, 0, SC16IS7XX_MAX_PORTS + 1))
> >  		return;
> 
> Okay, looking at this, it becomes uglier than initial code,
> means my suggestion was not good. Please, drop this patch.

Ok, will drop it for V2.

Hugo Villeneuve

