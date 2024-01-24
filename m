Return-Path: <linux-kernel+bounces-37499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF083B0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FBE1C22A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57412A17A;
	Wed, 24 Jan 2024 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZiH9wTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0B12A165;
	Wed, 24 Jan 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120334; cv=none; b=fA/CPS5DMLg42WJjQLFwbjW4vGs/21jwMC1JHR4h28aYdxs1mfBsWUy6dbsOwNSAaP7EeyQiAVa7yuWc8unlM//smskvhRK0wZwfEYihHRcOrgYipy+ZpzKKHB/YRd3+ENHKh+2PpSHNYc94YuznxSQCSGgpzHc2M2YUJTL8sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120334; c=relaxed/simple;
	bh=DL/EQqcJCQTk9UAclAYOtLINf9xZa1C9Zef6JseuhSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqSR+GsaTzhttc1U+Q7ET0hbBTITXId7dXp4pAE0APPIx/WbVKCN6e34H1TLHX2uTHWh5DYOHTvPI4kTCAKRYMjPmIhEowaOSEYXr8Se+su568cm6vfoOENuabafm6UVvuw/yYkc5jnM1CXzEg/NuNXzhCLyjoh2pQCfEcYjcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZiH9wTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2D5C433C7;
	Wed, 24 Jan 2024 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706120334;
	bh=DL/EQqcJCQTk9UAclAYOtLINf9xZa1C9Zef6JseuhSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZiH9wThtrZRAy5vV1Ct2uyELIURtWXK8fmQT/2Pz+TJephG7gDlaFcKPIoidKbOh
	 gbGFb3T3yNFSsTfnTLTOotgkxbd7uLnw9S9WuMD3YiZDqBRoEPgpUqZM1H2gx4QWWt
	 0nF6bVM7nmeusnnZkvpUM46WZ1v+DMPR5CDVdVxU=
Date: Wed, 24 Jan 2024 10:18:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] leds: make flash and multicolor dependencies
 unconditional
Message-ID: <2024012442-retool-surgical-d828@gregkh>
References: <20240109090715.982332-1-arnd@kernel.org>
 <20240109090715.982332-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109090715.982332-2-arnd@kernel.org>

On Tue, Jan 09, 2024 at 10:06:40AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Along the same lines as making devm_led_classdev_register() declared
> extern unconditional, do the same thing for the two sub-classes
> that have similar stubs.
> 
> The users of these interfaces go to great lengths to allow building
> with both the generic leds API and the extended version, but realistically
> there is not much use in this, so just simplify it to always rely
> on it and remove the confusing fallback logic.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/Kconfig                 |  4 ++--
>  drivers/leds/flash/Kconfig           |  4 ++--
>  drivers/staging/greybus/Kconfig      |  2 +-
>  drivers/staging/greybus/light.c      | 21 --------------------
>  include/linux/led-class-flash.h      | 24 -----------------------
>  include/linux/led-class-multicolor.h | 29 ----------------------------
>  6 files changed, 5 insertions(+), 79 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

