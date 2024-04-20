Return-Path: <linux-kernel+bounces-152321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52E8ABC59
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5891C21039
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A533A1A2;
	Sat, 20 Apr 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sp3H5nX+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E867F;
	Sat, 20 Apr 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713629079; cv=none; b=ESdtoSG9ID2c5DBYMbzReJCxjvmSMKzF50FIv3CJEQ6G1Kz6//1YU9PjoxEIX5F7jCutjrimBHw/zusk2V42VwyJi+QX5zQ8y+ynBpMQ5lwdxIcSfVfsgrRErl7//QTBcL3SbXG9IEfVj3ooKsArKgAfOUHh/2PQSlBlJdZK7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713629079; c=relaxed/simple;
	bh=7L8msFWXsjgIOFymfuyiLmAka5va6AwcRXmVCbhMnws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq5r9l0yYMZirIczCx64OVmIi0Uj4o7x7+G4khiVnmTut41wmNSNaIhjffWlaid1HTd71QkPLyyC903QIg2gCuuO35qB9tCGw0bwHA19VMDMeZvqt6L7aCBWTdSar2R+XvR9N3CyqutIwuhpY7kmQnn+BQ2kC9UUHxn9jlieNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sp3H5nX+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wjJBKDNaKI0ROz+bFURwPDTbi+LX3n6MLMpFALh+vcA=; b=sp
	3H5nX+2Ccm3oiq+FmvNNVtASCII9OZoogBVIXfg4nFBgRaP2ynqNCaYRza2TsT4xavAP48eoHKxiI
	RQqYUxzk8GpMEP8xH/sFTE/T4DLwyF/RWANYd3dEXdVkIQqY9Dp73lPEjtiLG6MV0nONqlY0NaFpA
	BS6Jx8fKGgAoCjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryDCC-00DW82-EA; Sat, 20 Apr 2024 18:04:08 +0200
Date: Sat, 20 Apr 2024 18:04:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: adin: add support for setting
 led-, link-status-pin polarity
Message-ID: <6d843f6f-01f9-4ac9-a661-af452f5ab623@lunn.ch>
References: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
 <20240419-adin-pin-polarity-v1-2-eaae8708db8d@solid-run.com>
 <65411c68-c76a-499d-88c7-e80ca59a3027@lunn.ch>
 <fb13743f-a1f6-44b7-9659-882976f0bc7d@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb13743f-a1f6-44b7-9659-882976f0bc7d@solid-run.com>

> Hi Andrew,
> 
> That looks very much related!
> 
> I was already planning to investigate adding led support ... .
> 
> 1. for the  LINK_ST pin I believe we still need a non-led-framework
> device property for setting polarity, as it is a fixed function signal
> that we can't even turn on or off from software.

We should separate the device tree binding from the implementation of
the binding. The binding describes the hardware. The hardware is
active low. And the binding can describe that. So i don't see a need
for anything vendor specific.

I think the real question is, can the current generic LED code be made
to handle this LED, or should you have code in the PHY driver to
handle this binding in a specific way for this LED?

Given the restrictions on this LED, i don't think it makes sense to
expose it in /sys/class/leds. But is it possible to leverage the
framework to parse the binding and call the polarity function?

> 2. LED_0 control not currently supported by adin driver.
> The phy supports what data-sheet calls extended configuration
> (disabled by default) for controlling led state (on, off, patterns).
> 
> Since it is not default, I see the polarity setting separate from leds.
> However I do believe the led_polarity_set callback is an acceptable
> solution.

Again, you should use the LED binding, even if you don't use the LED
framework. I just wounder how much code you will duplicate if you do
decide to implement the binding in the driver. And when you fully
implement the control of the LED using the framework, are you going to
throw the code away again?

       Andrew

