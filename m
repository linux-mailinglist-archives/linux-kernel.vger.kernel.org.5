Return-Path: <linux-kernel+bounces-65825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97985527C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0EA1C26712
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75F134CD9;
	Wed, 14 Feb 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPIIXwfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7712CD95;
	Wed, 14 Feb 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936277; cv=none; b=ODgoW3IlLrvvuNz0bJKRAnuS1WSZvphz1y8Z9npsj6DFhunxb3lFeI+doyoWbBwVT5vkV2PLWdsuSsGwj0cL37OuYrh1QpvBgF0+BTuktHx+1KlXfgBPHumFIfY6W6trvDdIfOjVrnvv8eXsZ+Bh1M36SNsRRUEWHvSSAwXJIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936277; c=relaxed/simple;
	bh=p2c4INhu1ft4+yh96H2P3PPmFRifbuDMKDxl0VrMN3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXznwaxcG6hCMrtnwlit69kqZ3kLlubOpLoeeZgNAAaltNbhjqdNkFHYKHpMFn314I1Ntrsc3VKHPNrpi1yhUVJjFcOW46hP40Oo32mimvq33827rOH7mR4sIsZgL9oP1m4ID1egXXrkrqIcgXstQzJ265/Dm8H6zVY6Gdti+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPIIXwfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0653C433F1;
	Wed, 14 Feb 2024 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707936276;
	bh=p2c4INhu1ft4+yh96H2P3PPmFRifbuDMKDxl0VrMN3c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MPIIXwfzl7Mw8AF/IMoUuaTEREDARtYl7SwxRSd/xyGamq2+HCgc67WrhvMJweA/y
	 zoy87vYKaqhbzQYCMF1Cj+Xy5KSrCm1+pDca4++3DVxaV453kqZvqAVttgFTM2VI+t
	 o7SDNmFwr91g3D/D3Svz/XNb3EnhiPFuAE+ScdU9YREtUaVpTED7ZMEuj7ac1QMW5c
	 Lt1hsKj7ONspqHxzZaf4tl217j1HHag7F7nJFFf3KffPOSHH2AJMVqiAloqj0w4GrL
	 fszRv1b3t4pMxlXaiXrKJQsQ0dm2Y3VhlnKG0rp0LePTRMJsUhuLiroN/BG47ZEJwp
	 Fwkellni3MbTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5B235CE0AB0; Wed, 14 Feb 2024 10:44:36 -0800 (PST)
Date: Wed, 14 Feb 2024 10:44:36 -0800
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
Message-ID: <4a08c610-c249-4b56-b09c-09e1fd07f723@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240214084419.6194-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>

On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are four fixes to some bugs in recent SRCU changes. The first one fixes
> an actual race condition. The other three just make lockdep happy.

For 1/4-3/4:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

For 4/4, you are playing with fire, but I will assume that you know what
you are doing.  ;-)

							Thanx, Paul

> v1 -> v2:
> - use srcu_dereference() instead of rcu_dereference_protected() as
>   advised by Paul
> - add a patch using rcu_dereference_check(..., 1) in deprecated
>   interfaces that return the address of the RCU-protected chip structure
>   to external users (who shouldn't use it anyway but well...)
> - pick up review tags for patches 1/4 and 2/4
> 
> Bartosz Golaszewski (4):
>   gpio: take the SRCU read lock in gpiod_hog()
>   gpio: cdev: use correct pointer accessors with SRCU
>   gpio: use srcu_dereference() with SRCU-protected pointers
>   gpio: don't let lockdep complain about inherently dangerous RCU usage
> 
>  drivers/gpio/gpiolib-cdev.c  | 25 ++++++++++++-------------
>  drivers/gpio/gpiolib-sysfs.c |  5 +++--
>  drivers/gpio/gpiolib.c       | 32 ++++++++++++++++++--------------
>  drivers/gpio/gpiolib.h       |  3 ++-
>  4 files changed, 35 insertions(+), 30 deletions(-)
> 
> -- 
> 2.40.1
> 

