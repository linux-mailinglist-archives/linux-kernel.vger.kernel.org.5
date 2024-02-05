Return-Path: <linux-kernel+bounces-53353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8484A38E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3316D1F21A02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528FD7CF14;
	Mon,  5 Feb 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BctugL3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DF77F05;
	Mon,  5 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159801; cv=none; b=p44yIvKF4ecMPF7fNBIawQ9fK7EOXzcmo5ERu+qvm0vMLsMgIyOUm+sPJenSmEaHXwu4eimXWvom7U8rACofupcM0EjR2S+VDb2Hgu8JO5WOH/cp45MZdhQ/q2C9QFhFMif8dMjX5e4aNQok86pqjFAtkGjfEMMNBxypI5FLy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159801; c=relaxed/simple;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joq16WFUZIvjxrAbQ7jne8P9EefFBRMAG3/QZ0MoLzWgcT59ZkGqVrdFtUChNcc9h58AJ7fmmE32nhsfqt7aoUzQIJZlwP11Pw25m9+rl09Qv9FX+BAC0Z4T+huSDanTNsiCcqrt5UhzltNKLkT77QQmABFrrO6M//Guz6WIiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BctugL3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C7C43601;
	Mon,  5 Feb 2024 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159800;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BctugL3GaKWwsWy+ZYhamc9PedQAqCTk7XkiWvIBsCoZe6wfR+9ZBJNNjhI+kTuET
	 2fmKsIErOiH/CvnjhN5uGbG56GYkpD/nXMTOepIta9H/ZTNmkznLmD9cFbJHZCcKEI
	 CptlGITew5HrEduc/s6/mxjV/Gtnsk8qmG6/rGcQ=
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

