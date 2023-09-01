Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0C78F8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbjIAHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjIAHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:12:35 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51710D2;
        Fri,  1 Sep 2023 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZTZ8SXVcOjA8cytY7ZRFk3Xrk4Dudxy372U5a+JE25c=; b=sMgp6AqBZSshQJyphg9ApcEzJ8
        g/5VIHJpEx5dLwTnt8X2oyNRtWxxgilmwzPQv1LEJmO+eKPfOm6had9N1LqWkBMeSyFL/kjVzoGUi
        lCFnbCDQAejTN6yqNe12Sa/C8YUEMgNed8uM2CPnYAZHY+iGjvA6v0m+DJre1lWfdyl/Utv2T/Jmd
        Gzup2j1bpKTqOe2Z3Y5VD9LH2srSWBm/PYs8LSmdKgynnFhx2dJMq1Qz/LfJHmgkcg8TY3AbIlaNQ
        MFZk8yoZfnSFfBCw4yMNkLwvMa+uWzFortseyaAzdVFjUnMvXg/uFZuKje3Y5pOUmdcI1mBBvkDVj
        0UED61cQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50582)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbyKI-0003fG-1T;
        Fri, 01 Sep 2023 08:12:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbyKH-0007dU-16; Fri, 01 Sep 2023 08:12:17 +0100
Date:   Fri, 1 Sep 2023 08:12:16 +0100
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
Subject: Re: [PATCH net v2 1/1] net: phy: micrel: Correct bit assignments for
 phy_device flags
Message-ID: <ZPGO0GVyH0Gh4yrW@shell.armlinux.org.uk>
References: <20230901045323.3907976-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901045323.3907976-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 06:53:23AM +0200, Oleksij Rempel wrote:
> Previously, the defines for phy_device flags in the Micrel driver were
> ambiguous in their representation. They were intended to be bit masks
> but were mistakenly defined as bit positions. This led to the following
> issues:
> 
> - MICREL_KSZ8_P1_ERRATA, designated for KSZ88xx switches, overlapped
>   with MICREL_PHY_FXEN and MICREL_PHY_50MHZ_CLK.
> - Due to this overlap, the code path for MICREL_PHY_FXEN, tailored for
>   the KSZ8041 PHY, was not executed for KSZ88xx PHYs.
> - Similarly, the code associated with MICREL_PHY_50MHZ_CLK wasn't
>   triggered for KSZ88xx.
> 
> To rectify this, all three flags have now been explicitly converted to
> use the `BIT()` macro, ensuring they are defined as bit masks and
> preventing potential overlaps in the future.
> 
> Fixes: 49011e0c1555 ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
