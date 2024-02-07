Return-Path: <linux-kernel+bounces-56582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A799684CBFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611082902C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3377F12;
	Wed,  7 Feb 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Umvlx6nk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045B224DA;
	Wed,  7 Feb 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313818; cv=none; b=mcP5gNfL7e6Pn96p+K7cczX+hoSyFScoXiuq0kZ9YVZ9QA5tu67HZhuSAcrdP7TBpPzo5qvb6E2Bl+3rJ72uOoeu/KiPW2X+ffXMpbbuKjuQtRrDImSaEbDq23bGmlq4GDRovphp5/06oulC0QPuHewhoU4NZIGcEFSW4C6OHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313818; c=relaxed/simple;
	bh=jcoUxEY87KkfMgsCGsXG2YEeGW5KmgaZ5ihRjWU9Tx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqQTYw34TS4sG4rQH6la0WGV5oeALYSHDnXf+78XurO4ZAqRUcMtAj9jWDq7lhHnvpbNXU3t62I1CpmXvlS/dRFVSjKdcU75cAguPb8CjqqyInoGRcriTwwsxTr6IHShPlHsGHYGWs1PEHOdWZxhl3Arw5ZS+g4pPKUcG02NvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Umvlx6nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B41C433C7;
	Wed,  7 Feb 2024 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707313817;
	bh=jcoUxEY87KkfMgsCGsXG2YEeGW5KmgaZ5ihRjWU9Tx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Umvlx6nk1yqc2O2ZAI04nkBHxe3kxDuFDag6+KP8+88j60rvJi7BFcbe1wEjFdkgi
	 at46MjU5eE7rHi5Dwfy3LdLpF7frLgWhhuGlA54Pk1/fY6DFspMxejAZ28FBELOBjo
	 kA5n43Kj+7jm7vmU/VJY4M8HRwfSg1u/XpSujnFA=
Date: Wed, 7 Feb 2024 13:50:15 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Ricardo B . Marliere" <ricardo@marliere.net>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: set device type for GPIO chips
Message-ID: <2024020702-upcoming-alone-1ce9@gregkh>
References: <20240205100811.41534-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205100811.41534-1-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 11:08:11AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> It's useful to have the device type information for those sub-devices
> that are actually GPIO chips registered with GPIOLIB. While at it: use
> the device type struct to setup the release callback which is the
> preferred way to use the device API.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

