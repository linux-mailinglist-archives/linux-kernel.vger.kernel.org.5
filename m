Return-Path: <linux-kernel+bounces-44703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7584263A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE5428965F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FE6D1AA;
	Tue, 30 Jan 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LDp/nUkr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9636BB4A;
	Tue, 30 Jan 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621653; cv=none; b=PGTCKUQgnPtacDu4zAYjaAkmqWdqHVLJBRgCr+AGH2aoikD2QsmSkI1K6+KOkxfPp6VJHaJuKS2kOf6t4MBcqM+P9TQwe2FUT6QJ9/eWKW493vTiO31xwRIFsH4iCr6+r0NGOSQUcks87pcCL1dnFYKXO4COnsIo3gxerMvMLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621653; c=relaxed/simple;
	bh=Gn1q7ktiWdbyhy7s2NQWRHwEjdB1UjSxc8vIDzzfCTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od7tybP7RZ5+aTIIVEjYL8oxkWp+j2WZOE9VoQNjX2AZxVob51skodR6QpKQO6FdTv/tHAwAycnCHpYfHTB33uIUnfb3tfaW9bbKk5TMboHmp/KfHaE2IKfm/Kkrc/7wPMgxNflV0x0AFQgME3XBUPREuxUI88xRi7Z6zgBsldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LDp/nUkr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8E4zlUNFez7CfCq5HUwawJjAHyI/J1BFW/vD4LLyEY4=; b=LDp/nUkrRorBTsaU6y3pB7B1c+
	Prwvnky7EgbzOj3XVCjksKb9bmfeXE2bMpQdotuW5RZnHYBml/AmqhW1PgJoVWf5ajPLva3RvoK1Q
	Yo8X5aqAEZ8brDT0l+x19kFUy2X8n1Zt4hq8/kzK6EwVRcLj1/uvsKU3XUHD65cKZ8Bk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUoFU-006Uhd-9M; Tue, 30 Jan 2024 14:34:00 +0100
Date: Tue, 30 Jan 2024 14:34:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <dc81a307-3541-47e2-9c72-d661e76889bf@lunn.ch>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130085935.33722-2-bastien.curutchet@bootlin.com>

> +  ti,led-config:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +    description: |
> +      If present, configures the LED Mode (values defined in
> +      dt-bindings/net/ti-dp83640.h).
> +      LED configuration can also be strapped. If the strap pin is not set
> +      correctly or not set at all then this can be used to configure it.
> +       - 1     = Mode 1
> +        LED_LINK = ON for Good Link, OFF for No Link
> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
> +        LED_ACT = ON for Activity, OFF for No Activity
> +       - 2     = Mode 2
> +        LED_LINK = ON for Good Link, BLINK for Activity
> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
> +        LED_ACT = ON for Collision, OFF for No Collision
> +       - 3     = Mode 3
> +        LED_LINK = ON for Good Link, BLINK for Activity
> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
> +        LED_ACT = ON for Full Duplex, OFF for Half Duplex
> +       - unset = Configured by straps

Please look at have the Marvell PHY driver supports LEDs via
/sys/class/leds. Now we have a generic way to supports LEDs, DT
properties like this will not be accepted.

> +
> +  ti,phy-control-frames:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      If present, enables or disables the PHY control frames.
> +      PHY Control Frames support can also be strapped. If the strap pin is not
> +      set correctly or not set at all then this can be used to configure it.
> +       - 0     = PHY Control Frames disabled
> +       - 1     = PHY Control Frames enabled
> +       - unset = Configured by straps

What is a control frame?

> +
> +  ti,energy-detect-en:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If present, Energy Detect Mode is enabled. If not present, Energy Detect
> +      Mode is disabled. This feature can not be strapped.

Please use the phy tunable ETHTOOL_PHY_EDPD. There are a few examples
you can copy.

    Andrew

