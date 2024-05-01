Return-Path: <linux-kernel+bounces-165416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057B8B8C74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA68A1F232A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0612F584;
	Wed,  1 May 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ub7vtwJF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8E1527AD;
	Wed,  1 May 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576085; cv=none; b=KLWa+kWZhjzbBNTxosDV1yeeYTgVQaC5SzHUiPj6Il4jeRYUAvdIpOzpGYdHArooVenZfKuM3Zs9Hvg0Q9dIhjIMrFP1JmdjfZEawhWouA3G+ZRPRlW3Ve2N+shEU8RcB4dWqcwUA7NR4RW4oQ4Oy+qQbtAE1VKrRcpJD8eBDP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576085; c=relaxed/simple;
	bh=WkNpj7MrWb1DUuLQkCSwYjQqW4spsuCzL5df6e8cjYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQsUTn2Dyupc7ScBqaIpadE1rPVlRdNB++EmexKQ+7+n4gCetnoP/Fgf6IjHMBnSWr767GhlV9ogLGxpuQyUBzaE6m0VkuXmUd9h+Agerhsn/PJzhLXvdvsXNEeRlKtRj8/h0rvmoGdPcDZn+siji8dd9lNCyGeUn1BxMn7bQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ub7vtwJF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r7gAXy+cNEHO7G6rohfcs/xnGaGYf4/LzouNOqGTrog=; b=Ub7vtwJFu31k+jCSuleQcGO1Qb
	sfN8ktFXayykcXReCJZQowkbnYKx3TSDpjEm1o8mt0XUt0DXYlyqZiU7v9r7rVUKusSvnVZ5sM22d
	5h/kFCCevEEeyuUEiAtX7MZgTd3RdYRuzF+zrYLm7hFVDfTbPQ0T6hRRl4JBw0/yZRxw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2BYe-00EQuu-Kp; Wed, 01 May 2024 17:07:44 +0200
Date: Wed, 1 May 2024 17:07:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <229b5a82-1086-40be-8ee5-16b7f3a03b30@lunn.ch>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>

On Tue, Apr 30, 2024 at 04:02:19PM -0500, Andrew Halaney wrote:
> Hi,
> 
> I've been taking a look at the following error message:
> 
>     qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
> 
> end1 is using a phy on the mdio bus of end0, not on its own bus. Something
> like this devicetree snippet highlights the relationship:
> 
>     // end0
>     &ethernet0 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy0>;
> 
>             mdio {
>                     compatible = "snps,dwmac-mdio";
>                     sgmii_phy0: phy@8 {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0x8>;
>                             device_type = "ethernet-phy";
>                     };
> 
>                     sgmii_phy1: phy@a {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0xa>;
>                             device_type = "ethernet-phy";
>                     };
>             };
>     };
> 
>     // end1
>     &ethernet1 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy1>;
>     };

I agree with Russell here. You need to determine where the ENODEV
comes from.

It seems unlikely, but one possibility is:

static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
                                       int phyreg)
{
        struct net_device *ndev = bus->priv;
        struct stmmac_priv *priv;
        u32 addr;

        priv = netdev_priv(ndev);

        /* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
        if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
            phyaddr > MII_XGMAC_MAX_C22ADDR)
                return -ENODEV;

Maybe if the interface is down, priv->synopsys_id has not been set
yet? Your devices are at address 8 and 10, so if priv->synopsys_id
where 0, this would give you the ENODEV.

Once you know the root cause, we might be able to make suggests how to
fix it.

      Andrew

