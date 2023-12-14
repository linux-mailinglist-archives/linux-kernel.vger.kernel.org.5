Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9978136F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443468AbjLNQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjLNQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:53:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314511A;
        Thu, 14 Dec 2023 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fIFfoB7fiP8F9z4MEfp2p7LeH1J7dMGPo+SgIwKTuLg=; b=roL2mfkdCdllhG5ba7BvkgzOJL
        SLmYEZllRxYjOi5gMKJ2mMPy8ZXP6JQ43ymwuSaUUL4gAM1RBEz3dpcaW+8qwQUTxnKGezR0NSqYU
        pVSoCWM2SEIr1QE2eS7MawzRCUHMJ02ORvvrq/rC4vFT0Z5iFqOZBnDTqJnLZQHYf5oTXVEeh9vZB
        4NnoHFeEDs7jzURkZA8m7zMwtJok6ourk+Rv7IL/rgludRqWhXD11XJNtjYmXoY+myDFeK75AOpS9
        15sDC3tHt3ysJNEN+RwqqrrJsAQN9SkmsRHYdUSmYqv/FvamYF2ROAKNBJT38cbtuEWxhz5YQSvua
        O7WsnXPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55304)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDoxo-0001iC-0z;
        Thu, 14 Dec 2023 16:53:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDoxo-0002hO-KC; Thu, 14 Dec 2023 16:53:32 +0000
Date:   Thu, 14 Dec 2023 16:53:32 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 01/14] net: phy: introduce core support for phy-mode =
 "10g-qxgmii"
Message-ID: <ZXszDKwzB7hJZ8yE@shell.armlinux.org.uk>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
 <20231214094813.24690-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214094813.24690-2-quic_luoj@quicinc.com>
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

On Thu, Dec 14, 2023 at 05:48:00PM +0800, Luo Jie wrote:
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
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
