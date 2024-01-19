Return-Path: <linux-kernel+bounces-31528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C4832F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923621C235DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4E56744;
	Fri, 19 Jan 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG7l7u+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C852F62;
	Fri, 19 Jan 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694514; cv=none; b=J4nwl2qKNvq0JJSri2PfzEyoaujc2OHUP1AYyB9uV0lJdYCYco+qym3obgiHJunsSiapCP+bzTgI4iL/ElKeVrmDeDUW0I++zJmtf1XSCK5k9JqLx0YE0/g4MTpWH+o2c3LpLkjQa8yy9SmcwBCUAiI+f1EoHMPpxG494tfoTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694514; c=relaxed/simple;
	bh=bZIjiq8CM3ELLDTwYTsAgCyXwGVxdbQzN3y6mzM9EjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMq5xiKjDlFI5D3p/yPM/NmfuJkpcx+0/ljzsqlzoE33/Bcee9JJTfxwY+Sskc8DRUFLE/cKCVg4m9X06kAsNiBdUxzshAm5zgBV+MGSu5rNbz/VDEdPh9tyIB4F+jjb3Jl2rYtBEtXptiiCyXHL9/JE31eKSHXo57gwf+xPOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG7l7u+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14332C433F1;
	Fri, 19 Jan 2024 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705694513;
	bh=bZIjiq8CM3ELLDTwYTsAgCyXwGVxdbQzN3y6mzM9EjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG7l7u+vJdCE64PPER+4pcoT38wO9NLt4a9yjrKFjWb1LLHyY5f/l93veqNunx2xV
	 m0kBO80H7jQziXnf2g/6gkivAsK11pcGHh7xv306QVprHc4QIeR1nFjNRCkAyVriIZ
	 0kNve1Bs5Yf8XGL7vCzqAQwJcZpRWz1tA5DKDgtBhGOUzHlGi/c/080iILTRlac3ai
	 veh8AdqnbdjTQpQHIXNvR5SAO+pl0uU5QwEVLUilltvEJg16YBXQ+SifxD4EmPZaga
	 9zXgd++yDn8XD24i1DMiRiAWSuGz59OwkymwDc8CGvfy52jF8gVuaWmG7qcxzwVLvR
	 tIDkNsJGuWh5A==
Date: Fri, 19 Jan 2024 20:01:48 +0000
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	Divya.Koppera@microchip.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 1/2] net: micrel: Fix PTP frame parsing for lan8814
Message-ID: <20240119200148.GB105385@kernel.org>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118085916.1204354-2-horatiu.vultur@microchip.com>

On Thu, Jan 18, 2024 at 09:59:15AM +0100, Horatiu Vultur wrote:
> The HW has the capability to check each frame if it is a PTP frame,
> which domain it is, which ptp frame type it is, different ip address in
> the frame. And if one of these checks fail then the frame is not
> timestamp. Most of these checks were disabled except checking the field
> minorVersionPTP inside the PTP header. Meaning that once a partner sends
> a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
> frame was not timestamp because the HW expected by default a value of 0
> in minorVersionPTP. This is exactly the same issue as on lan8841.
> Fix this issue by removing this check so the userspace can decide on this.
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Divya Koppera <divya.koppera@microchip.com>
> ---
>  drivers/net/phy/micrel.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index bf4053431dcb3..43520ac0f4e00 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -120,6 +120,11 @@
>   */
>  #define LAN8814_1PPM_FORMAT			17179
>  
> +#define PTP_RX_VERSION				0x0248
> +#define PTP_TX_VERSION				0x0288
> +#define PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
> +#define PTP_MIN_VERSION(x)			((x) & GENMASK(7, 0))

FWIIW, these macros feel like open-coded versions of FIELD_PREP to me.

> +
>  #define PTP_RX_MOD				0x024F
>  #define PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_ BIT(3)
>  #define PTP_RX_TIMESTAMP_EN			0x024D
> @@ -3150,6 +3155,12 @@ static void lan8814_ptp_init(struct phy_device *phydev)
>  	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
>  	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
>  
> +	/* Disable checking for minorVersionPTP field */
> +	lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION,
> +			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
> +	lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION,
> +			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
> +
>  	skb_queue_head_init(&ptp_priv->tx_queue);
>  	skb_queue_head_init(&ptp_priv->rx_queue);
>  	INIT_LIST_HEAD(&ptp_priv->rx_ts_list);
> -- 
> 2.34.1
> 

