Return-Path: <linux-kernel+bounces-34936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C683896F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53F11C258B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3F5730B;
	Tue, 23 Jan 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YXBVpSK4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E756450;
	Tue, 23 Jan 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999739; cv=none; b=MApQTQsIbovNGduNu/SDvFt1eOtwQU2lg/4Hx0C3i1FA1mYFlG8+ijrlCQPGUQloT6MLP7TuIBcDiYZIouEBjza5gxO9xb6u5G1SqWbI4xPx/NCJV84mhXXksE936fT+JLRAmpFhqZSExwBlNg8vMTlhmapO16HvGkY0/O399CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999739; c=relaxed/simple;
	bh=t2eee3p+5fYN3Cokye9kBeOsXjD6ww+E/52wz9ArAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h33dJf3gpDoSYs9wyc5fpfoz8DwkLsSQSESuHg9Zt3+cbcM/BENHpEPKftpkhXhJivD9GUwR7+QCdgHBHn/MkpB9RfTVwzFotkzxUpwO44SJ4l5Ky3urK9Jt6PGJGk3xVP7wgWRljQawuG64rw9DzrwrTR2SP+L3j20PV6Y46xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YXBVpSK4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF24620011;
	Tue, 23 Jan 2024 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705999731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Y70JmNATNTUUvhrItUodsxgvGUce4rjjN5KbaPrtU=;
	b=YXBVpSK4YTRxCcvIlW+4GiBrR8mtfdKf9xzd5HHbttHWC969LXsxy5xvAbRTcNZ/TsOXnj
	GDGKDb3QRg9GpPxMu4D3LFX8PHhRCtjdlghGUblGGUclsmgNkGn+rR4Pkpo3QtSeeHqKxJ
	VznDgeqOfyTdO44lfHQQywdWnVOZXoaNvooOjrOzLEVGONG3I52fvWkpkOYBj4o3KWFEyy
	+7qlmvnYD2OS4Qdy7ex5XHO8A7JJrYDS+aAIUOM2o29rsDBD5LuVvvbzdn1acewUrF+mhm
	PsRoUf8NVQVr76HmKu+JV/m9pljp5AYmEtmEbucYooDyhzw5FrCbb5j+uhGosA==
Date: Tue, 23 Jan 2024 09:48:49 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: lan966x: Fix port configuration when using
 SGMII interface
Message-ID: <20240123094849.5ce5acc8@device-28.home>
In-Reply-To: <20240123081514.3625293-1-horatiu.vultur@microchip.com>
References: <20240123081514.3625293-1-horatiu.vultur@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Horatiu,

On Tue, 23 Jan 2024 09:15:14 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> In case the interface between the MAC and the PHY is SGMII, then the bit
> GIGA_MODE on the MAC side needs to be set regardless of the speed at
> which it is running.
> 
> Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> index 92108d354051c..975a6d64a2e18 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> @@ -170,7 +170,8 @@ static void lan966x_port_link_up(struct lan966x_port *port)
>  	/* Also the GIGA_MODE_ENA(1) needs to be set regardless of the
>  	 * port speed for QSGMII ports.

Small nit, I think this comment above the test could also be updated to
reflect that change.

>  	 */
> -	if (phy_interface_num_ports(config->portmode) == 4)
> +	if (phy_interface_num_ports(config->portmode) == 4 ||
> +	    config->portmode == PHY_INTERFACE_MODE_SGMII)
>  		mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
>  
>  	lan_wr(config->duplex | mode,

Besides that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

