Return-Path: <linux-kernel+bounces-53359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1978284A39A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11431F224BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E97F484;
	Mon,  5 Feb 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yolxqp//"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD27D401;
	Mon,  5 Feb 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159802; cv=none; b=KQvCe0Hu/ziGZzEzGDxIIw0J+XDyGPJ7VoNsC86l06V/36WQ+5viAz5k5YoX+lsXuY7AmG/fRIYx7PNjd6txxGb66EQYSD5BDDGZ4ZX7S5qKnjReePNR52DrMnoiM5Rnd2HrxTroTaLv8A+hDwQ60r43X5VARPWpqgul3r2fEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159802; c=relaxed/simple;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFMnQx59puRMbYNgjBGAi2u58ipzL9oVkv81S/tzcLzf6E3IiFp4SgXGNivW05QZ0Wt+Pfz65QkxLZ8BckjHwDvAY5fc5Px2GmHIyw5BN9m2EwfGFmH8BVdRYc/I16SKI3FV6+iT5bEH2wGnFljMdlxWX60uGFfqz71EFOo1DGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yolxqp//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97335C433F1;
	Mon,  5 Feb 2024 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159801;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yolxqp//2GMwwDqc/WImdSIX0v7IjtjfhNhH3QFvMmemCpQhiKd6tAm5N/UArC3Kk
	 /cSE+2pJquDMq1A2jNCgEYQXHJQPGrlAXr8PfYZnmD0f/MeSGx3Zb6c8q+Uc2Qm5eO
	 FRKqQ+UIzvXhA7tL8mcK4FFzeEryIaIydhBFB2F0=
Date: Mon, 5 Feb 2024 04:47:37 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: gpiolib: make gpio_bus_type const
Message-ID: <2024020532-shrivel-phrase-c093@gregkh>
References: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>

On Sun, Feb 04, 2024 at 01:29:42PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the gpio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

