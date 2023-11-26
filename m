Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124217F948B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjKZRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:20:21 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57166FA;
        Sun, 26 Nov 2023 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4MBWFFSClU/aEAnkgxSP6reaZoimcEhMr3ed7yybq+M=; b=hsZEBQ+u8iH9Hs0HeYuSUu6EkU
        XZckZ4Bn2MGdjRy/wATcotRT2fVdBnGryCcx8+1hzLR7Z2A3O+aq3Ni+xDGB7eormGj7LX1+7N5X3
        xnPm07ZamDJDbK60mlLAhyfsbNPIQqmm9gew4cZcnfAEEgIOyUT2+Omj0bZVd9ked034=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7Ino-001GFC-C1; Sun, 26 Nov 2023 18:20:16 +0100
Date:   Sun, 26 Nov 2023 18:20:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/6] net: phy: introduce core support for phy-mode =
 "10g-qxgmii"
Message-ID: <f97fd2f0-3e39-4de0-8b1c-f333a0f56a7f@lunn.ch>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
 <20231126060732.31764-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126060732.31764-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 02:07:27PM +0800, Luo Jie wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> 10G-QXGMII is a MAC-to-PHY interface defined by the USXGMII multiport
> specification. It uses the same signaling as USXGMII, but it multiplexes
> 4 ports over the link, resulting in a maximum speed of 2.5G per port.
> 
> Some in-tree SoCs like the NXP LS1028A use "usxgmii" when they mean
> either the single-port USXGMII or the quad-port 10G-QXGMII variant, and
> they could get away just fine with that thus far. But there is a need to
> distinguish between the 2 as far as SerDes drivers are concerned.

Can this is split into two patches?

>  	switch (interface) {
>  	case PHY_INTERFACE_MODE_USXGMII:
> -		caps |= MAC_10000FD | MAC_5000FD | MAC_2500FD;
> +		caps |= MAC_10000FD | MAC_5000FD;
> +		fallthrough;

This change seems to refer to the second paragraph, where as the rest
of the code is about the first. Or does splitting this cause a bisect
problem?

	Andrew
