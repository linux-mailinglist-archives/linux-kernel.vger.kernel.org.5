Return-Path: <linux-kernel+bounces-34845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320C83883C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249AEB22EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E885473D;
	Tue, 23 Jan 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BWUI8qL+"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673C2AE91;
	Tue, 23 Jan 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996119; cv=none; b=uVN2ScmMOnDI2ouG9AWnWUFnO+ko3ji9/60ursEa70UEcNQYniXov69RurFuBshGEJdcNd8yvKUU27qcYG3faWkGomzWlYDUZc76QmnHQOnlQ2QKAN1vXN0zoXCcPD2a6q4RA6wqn4zUFEK1O1q69KmbAwKkY0t0rLhiWBHCL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996119; c=relaxed/simple;
	bh=FOaUGUAAPTmWN3a9feloa0W95Ay+xWAJhmLKNf/SkB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maXCkh07tCUjZTZlGfPbIYauSH7HJCkfkE0yv9nBohEdL/ORfOAm5MH87ta21IOmG4lIC7VHJDksHtLR3ePIYwc6LrnhYBL0zoxDnWhbNpAOhIJQl0x8VV8IqEwdRXdukHreVsrSTaos0hzVo3+2FNG1B9nTh8toPfbulPlNy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BWUI8qL+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3929920004;
	Tue, 23 Jan 2024 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705996108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUT2brhMEPIx4srIoyzG1PnPuZrNbL8eu4Saokysw2c=;
	b=BWUI8qL+fMLKZcw+A3+49Cy2mH3c85xLY8ey+cP4qoIBCOtro34o0HHSTOhrK8Uwm1fQZj
	L6r0+IWw68OPwv0QJvxtG9RMIR/FYvYOjScbGw9R+kRAuNCes9xWIVKrVB91lmmSDT+icr
	UBFnd4J7XYlRjAaJfthiT6WsHZ1RC6HC+dE6DGwSyp0asZ8m13IRLzcOiMymexvRFoTTmO
	7Z5qxho2o04PAHF1DWRcF8qPCSJYCIterTn4V+wL+mlyoQMmdVt1t6lldWN/NlDzSPda11
	DAJHn8Wy2vaUZE80aZl6HChUOn5KbEI3oewr/oLrjWxsr7hdAKS/0qheEIEbPg==
Date: Tue, 23 Jan 2024 08:48:26 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	UNGLinuxDriver@microchip.com, Paolo Abeni <pabeni@redhat.com>,
	dsahern@kernel.org, weiwan@google.com,
	"open list:OCELOT ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 14/22] net: fill in MODULE_DESCRIPTION()s for
 ocelot
Message-ID: <20240123074826330a374e@mail.local>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-15-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-15-leitao@debian.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 22/01/2024 10:45:35-0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/ethernet/mscc/ocelot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 56ccbd4c37fe..12999d9be3af 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
>  }
>  EXPORT_SYMBOL(ocelot_deinit_port);
>  
> +MODULE_DESCRIPTION("Ocelot SoCs (VSC7514) helpers");

Shouldn't that mention that this is related to the Ethernet switch?

>  MODULE_LICENSE("Dual MIT/GPL");
> -- 
> 2.39.3
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

