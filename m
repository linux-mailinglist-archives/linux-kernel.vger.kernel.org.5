Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644178EBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346066AbjHaLUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjHaLUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:20:50 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BE4E4C;
        Thu, 31 Aug 2023 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7XFdGYMDNVSq8CV1JzaT+3F2PZ/VizVU8Z8a8zgCGPo=; b=zDW8azAAIuKKg48t8Mi7GqHGvY
        Clz5Gwzm2v1bLMpZSI66ouPq9ds69t80FrLoDwja566j4PE5jzZO19NnieBxUOxHXPjyeJx2aYrNQ
        kyVhojBLd/Urr+Svbj96r+OsNAPQ8oxZ0u/V96wz7mcmlGh9kqPMfXLI8SP97fyo1J5Fd2bGwm074
        NFaFU0vI7dk9QC5xb+VGdcLIt7g4xj91+THiJds4wdv0qyRrMDorGnvIxaLNsCMX5jMBzDEcPvOIE
        0GCY2kgWNaxNikXGGMQ4zw8IFhuz3m6HNvfQY8lS+JbvgtoaoPlvJcvj1t/i/L7hJvkBRHlW8OBRc
        JrW1eviQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55220)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbfij-0002kB-22;
        Thu, 31 Aug 2023 12:20:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbfij-0006kS-CR; Thu, 31 Aug 2023 12:20:17 +0100
Date:   Thu, 31 Aug 2023 12:20:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1] net: phy: micrel: Correct bit assignment for
 MICREL_KSZ8_P1_ERRATA flag
Message-ID: <ZPB3cYMnFq1qGRv0@shell.armlinux.org.uk>
References: <20230831110427.3551432-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110427.3551432-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:04:27PM +0200, Oleksij Rempel wrote:
> The previous assignment of the phy_device quirk for the
> MICREL_KSZ8_P1_ERRATA flag was incorrect, working only due to
> coincidental conditions. Specifically:
> 
> - The flag MICREL_KSZ8_P1_ERRATA, intended for KSZ88xx switches, was
>   mistakenly overlapping with the MICREL_PHY_FXEN and
>   MICREL_PHY_50MHZ_CLK flags.
> - MICREL_PHY_FXEN is used by the KSZ8041 PHY, and its related code path
>   wasn't executed for KSZ88xx PHYs and other way around.
> - Additionally, the code path associated with the MICREL_PHY_50MHZ_CLK
>   flag wasn't executed for KSZ88xx either.
> 
> Fixes: 49011e0c1555d ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/linux/micrel_phy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> index 8bef1ab62bba3..0cedbeb9167c3 100644
> --- a/include/linux/micrel_phy.h
> +++ b/include/linux/micrel_phy.h
> @@ -43,7 +43,7 @@
>  /* struct phy_device dev_flags definitions */
>  #define MICREL_PHY_50MHZ_CLK	0x00000001
>  #define MICREL_PHY_FXEN		0x00000002
> -#define MICREL_KSZ8_P1_ERRATA	0x00000003
> +#define MICREL_KSZ8_P1_ERRATA	BIT(3)

Please can you also convert the other two flags to use BIT() as well to
make the entire thing explicitly bit-orientated? Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
