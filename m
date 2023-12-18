Return-Path: <linux-kernel+bounces-3224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1381696D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8941C226D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5C12E4A;
	Mon, 18 Dec 2023 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="oXRNqQij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7713ADF;
	Mon, 18 Dec 2023 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890125; bh=N7bSQjKB+Nqt9vDqsKQUJqGrXnPirrkscDlo7t38zU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXRNqQijmzM6RWM7tISRwu3m+pkVdxddfWPWQ5yR7J9QI30/ji0+/5yvg4P/n0ghn
	 C7YsykIWpsqV1nVG8PlsS/bctTxM8Wz1+oAGIUMp41AqNiK5TkMIFAQCjsouXh0eAN
	 9miwcfDvBOjBE7xYJXzaUsVqy3ces9AlmdngSYOXI8w0KdLelpJobODguf0ebpJWUB
	 XwfqLymplXqKKK7CFVGjGK4kG03R9zWcv4294w4ApEBUFaUV1t3MJZzbh/U+hDRCTD
	 GQliPlrcR8/5iUPcjSUrhA8k4E9j0TI8UnAS+py8FDOqDs+CkGIRBnkA9YbYdrDW7Q
	 fKnQSO5uv2ANg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 3DBA11000FD; Mon, 18 Dec 2023 09:02:05 +0000 (GMT)
Date: Mon, 18 Dec 2023 09:02:05 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <ZYAKjTdr64GlCnxU@gofer.mess.org>
References: <cover.1702369869.git.sean@mess.org>
 <e9e32c9789da3c90b5a2aa7d5a093120b76421fb.1702369869.git.sean@mess.org>
 <20231212160838.k4z4csy455a7qnje@pengutronix.de>
 <20231212181444.mw5kxff5ijz676qh@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212181444.mw5kxff5ijz676qh@pengutronix.de>

On Tue, Dec 12, 2023 at 07:14:44PM +0100, Uwe Kleine-König wrote:
> Hello Sean,
> 
> On Tue, Dec 12, 2023 at 05:08:38PM +0100, Uwe Kleine-König wrote:
> > On Tue, Dec 12, 2023 at 08:34:04AM +0000, Sean Young wrote:
> > > @@ -169,6 +179,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
> > >  {
> > >  	struct bcm2835_pwm *pc = dev_get_drvdata(dev);
> > >  
> > > +	clk_rate_exclusive_put(pc->clk);
> > >  	clk_disable_unprepare(pc->clk);
> > 
> > I thought this was the remove function, but that's suspend. Adding
> > clk_rate_exclusive_put() there is wrong.
> 
> https://lore.kernel.org/linux-clk/744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de/
> might be useful to fix this.

That does look useful, I suppose I can only use it once it's merged in
pwm-next though. Leaving out for v9.

Thanks,
Sean

