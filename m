Return-Path: <linux-kernel+bounces-17675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDDF82510B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A912869A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA68249F7;
	Fri,  5 Jan 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9r6lOqm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AA241E9;
	Fri,  5 Jan 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30349C0005;
	Fri,  5 Jan 2024 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704447805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg+cGgMq8pxVi7pfoAS8f36ObtzxcpalFQWLzmVnS9c=;
	b=W9r6lOqmL8erIAhcahN6PXh1q2lHaYA164FpQk/1hY9YV933Ctc2WNXqWITWFbIZt/GVyQ
	ue5FXiRR4FU7JR4Mgsb8Ual6RDPqS5fmj22lHGc5fAlVnVNwdd7pNkOv+KdtKSZdQdn95T
	p4p5nT2zbyzD390UG5NOBq7HpwvOY7HnmoCfZBu6uzqhW77h04fCUXpbUuM7ofAkLUfExK
	VV2bq3El96fPzEQcbF7Pkgs542lnZz3cGKMxPPGTtUhg8vi3sKm0iP15Sbx/fZQtD0coqW
	pSRX+ZiJ4v8o0uPYay8i8YCQ102wHPDR+aYlJ18vY+n4rohVWZZm03denybZpA==
Date: Fri, 5 Jan 2024 10:43:23 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yuiko.oshino@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Message-ID: <20240105104323.76ddfdca@device-28.home>
In-Reply-To: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
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

Hi Claudiu,

On Fri,  5 Jan 2024 10:52:42 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ/G3S SMARC Module has 2 KSZ9131 PHYs. In this setup, the KSZ9131 PHY
> is used with the ravb Ethernet driver. It has been discovered that when
> bringing the Ethernet interface down/up continuously, e.g., with the
> following sh script:
> 
> $ while :; do ifconfig eth0 down; ifconfig eth0 up; done
> 
> the link speed and duplex are wrong after interrupting the bring down/up
> operation even though the Ethernet interface is up. To recover from this
> state the following configuration sequence is necessary (executed
> manually):
> 
> $ ifconfig eth0 down
> $ ifconfig eth0 up
> 
> The behavior has been identified also on the Microchip SAMA7G5-EK board
> which runs the macb driver and uses the same PHY.
> 
> The order of PHY-related operations in ravb_open() is as follows:
> ravb_open() ->
>   ravb_phy_start() ->
>     ravb_phy_init() ->
>       of_phy_connect() ->
>         phy_connect_direct() ->
> 	  phy_attach_direct() ->
> 	    phy_init_hw() ->
> 	      phydev->drv->soft_reset()
> 	      phydev->drv->config_init()
> 	      phydev->drv->config_intr()
> 	    phy_resume()
> 	      kszphy_resume()
> 
> The order of PHY-related operations in ravb_close is as follows:
> ravb_close() ->
>   phy_stop() ->
>     phy_suspend() ->
>       kszphy_suspend() ->
>         genphy_suspend()
> 	  // set BMCR_PDOWN bit in MII_BMCR
> 
> In genphy_suspend() setting the BMCR_PDWN bit in MII_BMCR switches the PHY
> to Software Power-Down (SPD) mode (according to the KSZ9131 datasheet).
> Thus, when opening the interface after it has been  previously closed (via
> ravb_close()), the phydev->drv->config_init() and
> phydev->drv->config_intr() reach the KSZ9131 PHY driver via the
> ksz9131_config_init() and kszphy_config_intr() functions.
> 
> KSZ9131 specifies that the MII management interface remains operational
> during SPD (Software Power-Down), but (according to manual):
> - Only access to the standard registers (0 through 31) is supported.
> - Access to MMD address spaces other than MMD address space 1 is possible
>   if the spd_clock_gate_override bit is set.
> - Access to MMD address space 1 is not possible.
> 
> The spd_clock_gate_override bit is not used in the KSZ9131 driver.
> 
> ksz9131_config_init() configures RGMII delay, pad skews and LEDs by
> accessesing MMD registers other than those in address space 1.
> 
> The datasheet for the KSZ9131 does not specify what happens if registers
> from an unsupported address space are accessed while the PHY is in SPD.
> 
> To fix the issue the .soft_reset method has been instantiated for KSZ9131,
> too. This resets the PHY to the default state before doing any
> configurations to it, thus switching it out of SPD.
> 
> Fixes: bff5b4b37372 ("net: phy: micrel: add Microchip KSZ9131 initial driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/phy/micrel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 08e3915001c3..f31f03dd87dd 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -4842,6 +4842,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.flags		= PHY_POLL_CABLE_TEST,
>  	.driver_data	= &ksz9131_type,
>  	.probe		= kszphy_probe,
> +	.soft_reset	= genphy_soft_reset,
>  	.config_init	= ksz9131_config_init,
>  	.config_intr	= kszphy_config_intr,
>  	.config_aneg	= ksz9131_config_aneg,

This looks good to me. Thanks for the detailed analysis,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

