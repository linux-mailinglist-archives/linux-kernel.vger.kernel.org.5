Return-Path: <linux-kernel+bounces-87200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254586D101
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E8628DB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5571EC5;
	Thu, 29 Feb 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEf56g/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7761EB42;
	Thu, 29 Feb 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228599; cv=none; b=nIXet25/oG+vmiaPlyBqa8ha43EBT/ZFmjlJeAp+3S6JCPh3lPtwY+jLXZDhIrGLxjBpFhUd8LQzGX6wnSxt5LUnMMiQPmBdZg0ax/y0o7fSN55/LfokU1eYfTVC8jPJgaMiYLWBUjuka1LogQ2hznfZoGwgeOGxuPiL02O8fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228599; c=relaxed/simple;
	bh=Q6nxWcrxn7KzNs1FvujT6UGXcJ8SR7fy+oVrqz+kTRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TJmXBv00SrO88u4hIalWg9osVnsp+4pq1r61PXJuWa5aRHIOYB/i4yTZZ29j4X7bg1AzB/6nW6FIY7EmDZ57STboG9F2p/B+GPpifr/FT0rtKm5f2qUbSeVKe1cZtQ6EjHihMZUm4GGoiv2ficSyjD1uECnQ7wfCQ2kZMMc6Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEf56g/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF7AC433C7;
	Thu, 29 Feb 2024 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228599;
	bh=Q6nxWcrxn7KzNs1FvujT6UGXcJ8SR7fy+oVrqz+kTRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uEf56g/y0NEunY+Z9giAExLkZZkYuxInd0/k3kb04EAvxU2MNPmBnZ82ZaZAigAWx
	 TFeZECdMLyLAq7db17nRSyogMyKY3CPcasimkaSFCkdzNtQ/guq5qaII+HvNsiSXkS
	 5y8vSysB/yYcbDa3Sl26RjOu8UN5qTGm8Xswxbjp6+QrohwNegghXaFo3GE+NHbe++
	 8crKR4a4dChtkRQrsTPnBl7cGLisRGz+tLFrZiHua2IJOH/AxRWj1PyJL69Bq+8F05
	 a/zqyW70Qwxs+zlO6uipD3rmxwlDiXEa6KEVxDVJzPyyX4fw5K8Ov22FHVFtTjTyMW
	 YVxtTird2F/9Q==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240228093834.2230004-1-arnd@kernel.org>
References: <20240228093834.2230004-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] leds: fix ifdef check for
 gpio_led_register_device()
Message-Id: <170922859684.1626996.4061581947298770912.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:43:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 28 Feb 2024 10:38:26 +0100, Arnd Bergmann wrote:
> gpio_led_register_device() is built whenever CONFIG_LEDS_GPIO_REGISTER is
> enabled, and this may be used even when CONFIG_NEW_LEDS is turned off.
> 
> However, the stub declaration in the header is provided for all configs
> without CONFIG_NEW_LEDS, resulting in a build failure:
> 
> drivers/leds/leds-gpio-register.c:24:1: error: redefinition of 'gpio_led_register_device'
>    24 | gpio_led_register_device(int id, const struct gpio_led_platform_data *pdata)
>       | ^
> include/linux/leds.h:646:39: note: previous definition is here
> 
> [...]

Applied, thanks!

[1/1] leds: fix ifdef check for gpio_led_register_device()
      commit: 71c65d0ff79e3b21cb3eba67d87159533daaadbc

--
Lee Jones [李琼斯]


