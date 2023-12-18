Return-Path: <linux-kernel+bounces-3202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94D816915
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC162B20BED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8AC111BD;
	Mon, 18 Dec 2023 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="mMVeDO8/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D31171A;
	Mon, 18 Dec 2023 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890149; bh=nXLNUybO72z9kq/7hDhdxKrWpyLZXnqSO0bXUnPnp04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMVeDO8/ys3Pr00NuGUnefiQQlpH4nhRpLWV1lUyi4n186pegseN3QF7u1MEMhnYQ
	 QVpZrv4Ns+K1NGtGKoyZPfDGZ6rQYXMFzENJrXKuoSvnXJJ18FHhoElrweuO2tiwLh
	 ttc2m0Lrem/Dev610bsLgYubo8CKch3zSEH5+9CRxVGIZRbbzqpeFUD2VgCgBhNXyo
	 9Z5WTXpBQqgvc4T2uPEQ3z0C+SO4q0k1InOods7AyKgDruW1eId6SP8cMwbItTTmSw
	 omzurgBEcDgiAzwASroncI0iN5dWGwsFq4oPG8xWyIv7D1fzT6kf12kIcxDQzn/ca9
	 aR7mDXAKMTAkw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id A890910029E; Mon, 18 Dec 2023 09:02:29 +0000 (GMT)
Date: Mon, 18 Dec 2023 09:02:29 +0000
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
Message-ID: <ZYAKpXOgF1j03KPF@gofer.mess.org>
References: <cover.1702369869.git.sean@mess.org>
 <e9e32c9789da3c90b5a2aa7d5a093120b76421fb.1702369869.git.sean@mess.org>
 <20231212160838.k4z4csy455a7qnje@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212160838.k4z4csy455a7qnje@pengutronix.de>

On Tue, Dec 12, 2023 at 05:08:38PM +0100, Uwe Kleine-König wrote:
> Hello Sean,
> 
> On Tue, Dec 12, 2023 at 08:34:04AM +0000, Sean Young wrote:
> > @@ -169,6 +179,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
> >  {
> >  	struct bcm2835_pwm *pc = dev_get_drvdata(dev);
> >  
> > +	clk_rate_exclusive_put(pc->clk);
> >  	clk_disable_unprepare(pc->clk);
> 
> I thought this was the remove function, but that's suspend. Adding
> clk_rate_exclusive_put() there is wrong.

Nice catch - fixed in v9.


Sean

