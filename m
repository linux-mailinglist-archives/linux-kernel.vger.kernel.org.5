Return-Path: <linux-kernel+bounces-152549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680838AC060
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815831C20809
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB623B2AD;
	Sun, 21 Apr 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tlwBeR8T"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7379FD;
	Sun, 21 Apr 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713722105; cv=none; b=VtgYgVVguiw+lh3R9mn1QkvhUKcjFGc5J9u5nmArtKm+7VZg69IhdA8YoZe0pTT84lu1DJKI5ojFNbbud8ZMk+kyA2LyUszutUZABV20/B3wku1UhyYiaMO5TceRDAB2XCJZz3MefZP4syaC9X+uFjgvWCwTThwkUduhVHj6yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713722105; c=relaxed/simple;
	bh=Qaj9o+2NK19fCBbgW9Z+DVmAh2E8bkZ2Z7Is1K9MqHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBkgtGWgAXRFRRNv6Mo5OvEUno7N4igsAlqLfeNgmmTsGFVact9GKScuino2STx+ltqVaQxB0AOWzdEFtjR45JRNk/wCxhefvi6keRuFRIoXWz62wzVBxXwwGFH1hE8mW6G87Kfj+ozWAsg5P3htdSDjCo9S6gzdYcx54kuMFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tlwBeR8T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mlipOm1BapM8HlNYoaxhyEbmDWmT73O1xUbpkHHF2aM=; b=tl
	wBeR8TgSnIoJPSXFuCCm3yVByJfFFgfTw4x7h+30jW2dUC8iJR5f9XiRLyBPlm7FXyOi4bMVrpf56
	kpBzydxzzutY3guROW6cvYq8iIn1j4BISS6i7fI7gHJYjd7m9jjbmZu13jrkZeUr3CqDfWQWRz0Fl
	IuS0ej8m+8qt3tI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rybOe-00DYZJ-NB; Sun, 21 Apr 2024 19:54:36 +0200
Date: Sun, 21 Apr 2024 19:54:36 +0200
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
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Message-ID: <ac8fba1b-93ef-4120-a03b-f91772ecb5df@lunn.ch>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
 <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
 <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>
 <2c622947-3b54-4172-b009-0551f43c3504@lunn.ch>
 <1fe2dce3-972e-420e-b4e1-f07e15b6b35f@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fe2dce3-972e-420e-b4e1-f07e15b6b35f@solid-run.com>

> I merely don't like the idea that this makes no sense for the other
> possible pin functions.
> Once somebody uses this pin for different use-case, they will need
> to solve it again.

There are not too many different uses of this pin. The data sheet
indicates you can connect it to the MAC to indicate link. You might
also be able to use it with an external PTP stamper, using the start
of frame indication.

I don't know of any bindings for such use case, but something will be
needed to describe how the pin is connected to the other device. And
at that point, the active low property could be used.

> >> This kind of configuration is much more like pinctrl than led.
> >  
> > So what is the pinctrl way of describing this? You should not be
> > inventing something new if there is an existing mechanism to describe
> > it. We want consistency, not 42 different ways of doing one thing.
> I am mostly familiar with the
> #define PIN_FUNCTION magic-numbers
> pins = <PIN_FUNCTION more-magic-numbers>;
> 
> But on Marvell platforms there is:
> marvell,pins =  "mpp1";
> marvell,function = "gpio";
> 
> I also found more generic???:
> Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
> Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
> which have output-high/output-low, function, pin.

So that is probably your alternative if you want to not use the LED
binding.

> 
> Interestingly LED_0 supports some non-led functions, too:
> - collision detection
> - carrier sense
> - tx/rx start
> - tx error
> so polarity is also relevant to non-led usage of LED_0 pin.

Collision detection is an LED usage, you just don't see it very often
since half duplex is pretty unusual this century. Carrier sense is
also similar age, from when Ethernet was CSMA/CD.

Since they are not really used any more we don't have them in the LED
framework, but i think we could implement them if somebody actually
wanted them. My intention was to keep the LED framework KISS, since
vendors tend to implement all sorts of odd LED blink reasons. But if
nobody wants them, nobody has a good end user use case for them, why
support them?

       Andrew

