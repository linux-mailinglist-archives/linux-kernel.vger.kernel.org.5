Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326657F0027
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjKROfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKROfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 09:35:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A720196;
        Sat, 18 Nov 2023 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WepOBgGYhP2iPHXfLSJdrtcP/KdijGX4DDw5TtExb38=; b=ICT7ys2yuuz5dBBplm5lRh/5RH
        8DQ/wBrdoRzImt37gHrrXGZbxFIq4nQUYdnoFZ7ub45vgsKXdsFQ3WpPYIwtzRGEaFUSWs9Jl8Cft
        zV68Vv2CJet2uScBr/EMtq2w1ZSkE0yvexguq2PIPGaq2XB0x9Tap/3aCxuXzAYeukSpt01ru2o4w
        7MdD2AzqMSjlu0CLptTCpQ3QDLr6gxqWc9v8RdDACx1Rd5uF0R/esxAjX0DldxAaJylPxhg6B5Zrm
        sIoACMMyxvIad3j1tCTqoAiOBFKVS9XUS8iLiGQBCNMlSfF/nFqmtOvD+TiCYUoVZk0LZZVL0CFUB
        y0pbCdCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53404)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r4MPR-0003mC-32;
        Sat, 18 Nov 2023 14:34:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r4MPP-0001Cx-B2; Sat, 18 Nov 2023 14:34:55 +0000
Date:   Sat, 18 Nov 2023 14:34:55 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Message-ID: <ZVjLj6/iCL/muzmH@shell.armlinux.org.uk>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-2-arinc.unal@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 03:31:51PM +0300, Arınç ÜNAL wrote:
> +	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
> +	 * forwarded to the numerically smallest CPU port which the DSA conduit
> +	 * interface its affine to is up.
> +	 */
> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
> +		return;
> +
> +	if (operational)
> +		priv->active_cpu_ports |= BIT(cpu_dp->index);
> +	else
> +		priv->active_cpu_ports &= ~BIT(cpu_dp->index);
> +
> +	if (priv->active_cpu_ports)
> +		mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, CPU_EN |
> +			   CPU_PORT(__ffs(priv->active_cpu_ports)));

I would be tempted to write this as:

	mask = BIT(cpu_dp->index);

	if (operational)
		priv->active_cpu_ports |= mask;
	else
		priv->active_cpu_ports &= ~mask;

Now, what happens when active_cpu_ports is zero? Doesn't that mean there
is no active CPU port? In which case, wouldn't disabling the CPU port
direction be appropriate, such as:

	if (priv->active_cpu_ports)
		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));
	else
		val = 0;

	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);	

?

>  struct mt7530_priv {
>  	struct device		*dev;
> @@ -786,6 +787,7 @@ struct mt7530_priv {
>  	struct irq_domain *irq_domain;
>  	u32 irq_enable;
>  	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
> +	unsigned long active_cpu_ports;

So this will be 32 or 64 bit in size. Presumably you know how many CPU
ports there can be, which looking at this code must be less than 8 as
CPU_PORT_MASK is only 3 bits in size. So, maybe use a u8, and check
that cpu_dp->index <= 7 ?

I would also suggest moving irq_enable after create_sgmii, to avoid
holes in the struct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
