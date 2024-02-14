Return-Path: <linux-kernel+bounces-65945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED8855421
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9796E1F22AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F412882A;
	Wed, 14 Feb 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8SWL0AM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51455E45;
	Wed, 14 Feb 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943450; cv=none; b=PZm5V0NCpwuC62/rwuak1Tik5Do7o4zNY8K/GVypZQwXfUyjUcj6IqQTMylvZNLISsOlSVNMERubWkQatGkm+aLq2NgUDjybjbC8N3wOnqxySz2Cc37BBEVydn0/PZUJRlBLwdX94r850RlvHMJqbV3N+Ccs6K6a4UKUniWSOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943450; c=relaxed/simple;
	bh=+z4R9GOfdgSWa79X71iBygTDc7cRtojjnHQFNVDBR/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwVuJUojSpwUCKRIIT6NVnqSHsHp5VRSxP6Bjg9qnxma5c7amGpXkFMvAvjd7rbavJKTZn9KPz319mPzXuRKNqMQ7HYmlN5YssWH1LcnWh9SDvbKFnoZIf2+46Qqk7clRobob2FLHH3eZrFzQVKq8e/XBCRSWUwzruYF04mywEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8SWL0AM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E46C433F1;
	Wed, 14 Feb 2024 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707943450;
	bh=+z4R9GOfdgSWa79X71iBygTDc7cRtojjnHQFNVDBR/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=P8SWL0AMOgR0ZgwjSRfc8Nph5lcySi3a9sk80iyN7XMdEzpFEsBjNR+oKNOgse79k
	 ZdpkTyXpsBmnNCBc5EkQtd0fgQ7Rndbv3/e0V/9zrv1+HkhcGauFMzv+XD5rJPCmA2
	 LMcDr0e2DJo5yijZPg7g4j4YfkUL4Kqd9YLsnL4vIg6Nxxv0SRIE4FHYpgG5Z7KChW
	 LP8yI/gmnfsfTR2zniFcxaL6BmO3WKJzE0+AJ9iszMpD2sv3zHm48Ap6Q43PD/9P9E
	 cvART3OM+TdZYtB8kEZqhOpjetVem5BrEkiWCpGQOvfYeVLeCIpn2YUedMJwH/weWi
	 TgZ0Z56Huf6hQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86886CE0D11; Wed, 14 Feb 2024 12:44:09 -0800 (PST)
Date: Wed, 14 Feb 2024 12:44:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
Message-ID: <ef420f58-cf5a-4bd3-adc4-b9ef651498ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240214084419.6194-1-brgl@bgdev.pl>
 <4a08c610-c249-4b56-b09c-09e1fd07f723@paulmck-laptop>
 <CAMRc=McXr_3OD6Uf+PKD-wLQfJKJSWes3fh_ZD9fnrPyF9GoSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McXr_3OD6Uf+PKD-wLQfJKJSWes3fh_ZD9fnrPyF9GoSQ@mail.gmail.com>

On Wed, Feb 14, 2024 at 08:08:33PM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 14, 2024 at 7:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Here are four fixes to some bugs in recent SRCU changes. The first one fixes
> > > an actual race condition. The other three just make lockdep happy.
> >
> > For 1/4-3/4:
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > For 4/4, you are playing with fire, but I will assume that you know what
> > you are doing.  ;-)
> 
> Up until this rework, this gdev->chip pointer could go from under any
> user at any point. Now we have this gpio_device wrapper that provides
> an entry point to using the chip safely while protected by the SRCU
> read lock. Anyone who is still accessing gpio_chip directly (and not
> being the GPIO provider themselves) is asking for trouble. There's
> however no point in spamming lockdep splats in this case. I may end up
> adding a warning to these routines.
> 
> Unfortunately, it's hard to fix 15 years of technical debt. :(

Indeed, life is sometimes hard!

							Thanx, Paul

> Thanks for the Acks.
> Bartosz
> 
> [snip]

