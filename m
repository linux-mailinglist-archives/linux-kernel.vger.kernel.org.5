Return-Path: <linux-kernel+bounces-30167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8F831AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C47B21B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0A2562D;
	Thu, 18 Jan 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E4vw31DH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB71D55A;
	Thu, 18 Jan 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585943; cv=none; b=qrGdDHHBudHR8dolr30Pra63eM+TRx3iOEwm8fesuN4m1D3AvtxPqIy4uT26raCZxfLvEh3qImX/tc0Wzz+XFMc8ees6CcvtEEuffKdcjvEABYMO2et7+L1dPHkIPXM0s0wHqIptKbIM9n61uZZSJ3EzHNkztXEE8Rthe015Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585943; c=relaxed/simple;
	bh=Jfm8rH6Vu4OXBlLEiOeoDMc8nZWMiaF12XmjmX2naBY=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=pVMTozEwOoTBJsofYS76Lhmd122pT9cCDBTF7vpVkTuWAGoK1+HweEgpovF0PvMMNj+L67WHOmRiGYj30D3rTXOKIUTwFbIkSH8EtNcvjDZ11uHs4dVSZkv9bZDI8e5wH89i5f9dZSNYDo21uspg7hVRD3QRZf1jX8/4qfxWLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E4vw31DH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jTLMNO6QLs7Mk2LMJXLb6RpI1xo7VaBuKpCA3y9deRU=; b=E4vw31DHixYXzd+QaIPGeT4V93
	AUUOzbIVLZ+EdxGfOXp28QD6LNV8z/Tb5pw6Wgl8P8Z2MsJFj55bJBINECdMWXVkYz1V9MgFiB1JE
	aH+1UfjS+wSqAn6jlNcPQjFPnZNm+KqW8qU+h4BOxXm61Xx+tCdiFefL+Gwa/MN1PuCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQSoO-005TuC-1O; Thu, 18 Jan 2024 14:52:04 +0100
Date: Thu, 18 Jan 2024 14:52:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, Divya.Koppera@microchip.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <6fa37dfd-3c92-4842-9785-1b17bbbedc9d@lunn.ch>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118085916.1204354-3-horatiu.vultur@microchip.com>

On Thu, Jan 18, 2024 at 09:59:16AM +0100, Horatiu Vultur wrote:
> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future like
> year 2150, it was failing to set this.

Stable rules say:

It must either fix a real bug that bothers people...

Do we have users of this device in 2150?

Maybe submit this for net-next?

      Andrew

