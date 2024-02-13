Return-Path: <linux-kernel+bounces-63475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE5853014
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EF11C22448
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259539FE2;
	Tue, 13 Feb 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I33xxnbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43326383BC;
	Tue, 13 Feb 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825823; cv=none; b=N/9I4PeIWTDsysqQU0zeYliA8P+5G5HMv+IDJiaShmnR2ALunXSeivNlvAjBxeJa3bu+Ep9D1Yl4Ls0iaxOBccaPMa5TKSq4rKI/fysULERVozGfR3D2qzFLM/4Mw01LZegBUYh8/ei47AuyQYNN/lKlMju8VG98OpkZdQSx8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825823; c=relaxed/simple;
	bh=CviYwbRqpFGS88D0mkTG3roQKE+pXGZbNiNrRVAM/SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJKvSU1noxpJP9o7MY1w0aFT66SFP8GjBwJj813hezpfVexFNtr0+hi6rpAsvzKrAm90ypOuRUtx1NRwAh0WSNesjhk0rivIENFzXBuF0lSE8JMIWc7eVp9sgHSMzBO06j3z3WRA07t2uXZCZ0yT5vjen23XKreJgXWjMDg0dTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I33xxnbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CCCC43390;
	Tue, 13 Feb 2024 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707825822;
	bh=CviYwbRqpFGS88D0mkTG3roQKE+pXGZbNiNrRVAM/SU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=I33xxnbf451rGaMq5BPH8ksyNTK4xGmrl+GWF4q+rsAqgntLcSrAxiFmAyoSKZEDu
	 MPj8Me1DjI3mqaRV0cG7tcH7m+pTk4rr0APRZN/2h4wt6JWAD/h4IlJFwlNH0fE9NE
	 zwyJbj8MP2EJvZjGJIG8dAn81ZkJmWUXdjUbDAueRUwV/Mc5sDxoyeB4gfrVqa/SDO
	 idwAgdNiIo3Pu+b5ZyaefHtRvZxq617AnDp26cwrLBjOSVlywyUfoEAywccrWY106c
	 lyGTFHb3C9v6uI69SVwuW+VuyLQJzuMSviojw2rk7YR1C7lGAmw78xhI0Fd85MF5zj
	 QoWJvgyu92FsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 577C4CE0FF5; Tue, 13 Feb 2024 04:03:42 -0800 (PST)
Date: Tue, 13 Feb 2024 04:03:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 3/3] gpio: use rcu_dereference_protected() to make
 lockdep happy
Message-ID: <6139b738-3013-45fa-a192-92b9abaa4b78@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213093108.13922-1-brgl@bgdev.pl>
 <20240213093108.13922-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093108.13922-4-brgl@bgdev.pl>

On Tue, Feb 13, 2024 at 10:31:08AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Lockdep with CONFIG_PROVE_RCU enabled reports false positives about
> suspicious rcu_dereference() usage. Let's silence it by using
> rcu_dereference_protected().
> 
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 12 ++++++++----
>  drivers/gpio/gpiolib.h |  4 +++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c1391a9a0af6..d7503376b918 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -109,7 +109,8 @@ const char *gpiod_get_label(struct gpio_desc *desc)
>  		return "interrupt";
>  
>  	return test_bit(FLAG_REQUESTED, &flags) ?
> -			rcu_dereference(desc->label) : NULL;
> +			rcu_dereference_protected(desc->label,
> +					lockdep_is_held(&desc->srcu)) : NULL;

Why not this instead?

> +			srcu_dereference(desc->label, &desc->srcu) : NULL;

And similarly for the rest of the changes.

							Thanx, Paul

>  }
>  
>  static int desc_set_label(struct gpio_desc *desc, const char *label)
> @@ -2978,7 +2979,8 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
>  
>  	guard(srcu)(&gdev->srcu);
>  
> -	gc = rcu_dereference(gdev->chip);
> +	gc = rcu_dereference_protected(gdev->chip,
> +				       lockdep_is_held(&gdev->srcu));
>  	if (!gc)
>  		return -ENODEV;
>  
> @@ -3012,7 +3014,8 @@ static bool gpio_device_chip_cmp(struct gpio_device *gdev, struct gpio_chip *gc)
>  {
>  	guard(srcu)(&gdev->srcu);
>  
> -	return gc == rcu_dereference(gdev->chip);
> +	return gc == rcu_dereference_protected(gdev->chip,
> +					       lockdep_is_held(&gdev->srcu));
>  }
>  
>  int gpiod_get_array_value_complex(bool raw, bool can_sleep,
> @@ -3593,7 +3596,8 @@ int gpiod_to_irq(const struct gpio_desc *desc)
>  	gdev = desc->gdev;
>  	/* FIXME Cannot use gpio_chip_guard due to const desc. */
>  	guard(srcu)(&gdev->srcu);
> -	gc = rcu_dereference(gdev->chip);
> +	gc = rcu_dereference_protected(gdev->chip,
> +				       lockdep_is_held(&gdev->srcu));
>  	if (!gc)
>  		return -ENODEV;
>  
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 07443d26cbca..a857848b8955 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h> /* for enum gpiod_flags */
>  #include <linux/gpio/driver.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/srcu.h>
> @@ -202,7 +203,8 @@ DEFINE_CLASS(gpio_chip_guard,
>  
>  		_guard.gdev = desc->gdev;
>  		_guard.idx = srcu_read_lock(&_guard.gdev->srcu);
> -		_guard.gc = rcu_dereference(_guard.gdev->chip);
> +		_guard.gc = rcu_dereference_protected(_guard.gdev->chip,
> +					lockdep_is_held(&_guard.gdev->srcu));
>  
>  		_guard;
>  	     }),
> -- 
> 2.40.1
> 

