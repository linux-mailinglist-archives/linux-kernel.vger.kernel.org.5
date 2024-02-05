Return-Path: <linux-kernel+bounces-53360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18E84A399
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D2A281D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76B7F471;
	Mon,  5 Feb 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OendJWcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9A7D400;
	Mon,  5 Feb 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159802; cv=none; b=qf+Zgdc8mxeaPuXru6G8tVS4CoPaGdrqeyvz3F/bRJYIBLiJhJztgxfBMqB6f/quOwuKyuTxxCO6vHkLbXJcLAW9pA5QI6TuM1XBGOu6+Tib0kn9PHnzuMn+DpXaYrRQN4MJD9Z6stlXyRB3XaNIX9TWIEhVQhu3hYD1Xun2fcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159802; c=relaxed/simple;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFMnQx59puRMbYNgjBGAi2u58ipzL9oVkv81S/tzcLzf6E3IiFp4SgXGNivW05QZ0Wt+Pfz65QkxLZ8BckjHwDvAY5fc5Px2GmHIyw5BN9m2EwfGFmH8BVdRYc/I16SKI3FV6+iT5bEH2wGnFljMdlxWX60uGFfqz71EFOo1DGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OendJWcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5843C43390;
	Mon,  5 Feb 2024 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159802;
	bh=XOREM53K6Y8lg+gfOY8PATZMT6V5AF0JLY8nmGpzfj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OendJWcHqZfrt7j+TkVn2qPC+PRJHIJQ7KxMeEhPPcSpPUIOrVHBcfHmO0pzyEvKv
	 3i+BbEcO8TjEbBj28i0/abKZf6pduv00HhfiFY8vBpyPaD0FMaDXUY29J6RMr204o1
	 4AlK2rWervpxQ5NoHzB5LWY7SWWdZC5C+7tJ8xYY=
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

