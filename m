Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63417EF2F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbjKQMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjKQMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:48:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5ED4E;
        Fri, 17 Nov 2023 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zAUDCRPdG1Nj8bvw6mmcNifjjS9KnmeQaCPWVoHNMwc=; b=joSToGwyXM7onK02SVbfsxqj0g
        XdELT+kDLqY9YZZbB0OXmgDqVJl5XVVULxrnZ5fYbcrXawS8YLFRV7intMCMrQ7yxOn8IHln1LMrB
        V8mp8lBbs5+Mfm7255wS9DWvmCwDJXcFVvbBUheSlc+igS82OoEFG0vr6E0UoXBbbUloqaYXlJcUH
        jPb7d1jMi/dt0kSvyXAfMrtxLTzMDBianwI3mHTiQcRHk4sf4jG+cEAwfcgQEPnnuEDwMGmHDUHlk
        FdL6CD2HDSwi+Gm23i8xbHY2mdWrQ0H0SzRuEmGH/j2zp2lP4R+jUJa51dlG6VbdA9++fobKNAzvu
        9OW4q7WQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48128)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r3yGH-0002qo-0G;
        Fri, 17 Nov 2023 12:47:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r3yGI-00008Z-UD; Fri, 17 Nov 2023 12:47:55 +0000
Date:   Fri, 17 Nov 2023 12:47:54 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Marko <robimarko@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: enable USXGMII autoneg
 on AQR107
Message-ID: <ZVdg+vFb46aFRtC0@shell.armlinux.org.uk>
References: <20231117100958.425354-1-robimarko@gmail.com>
 <20231117100958.425354-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117100958.425354-2-robimarko@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:09:49AM +0100, Robert Marko wrote:
> In case USXGMII is being used as the PHY interface mode then USXGMII
> autoneg must be enabled as well.
> 
> HW defaults to USXGMII autoneg being disabled which then results in
> autoneg timeout, so enable it in case USXGMII is used.

I was led to believe that the bitfield in bits 8:7 of the
VEND1_GLOBAL_CFG_* registers, when set to value '1' is something
to do with selecting USXGMII mode as opposed to 10GBASE-R. Could
you look in to that and whether that is the more correct way of
configuring the PHY for USXGMII mode?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
