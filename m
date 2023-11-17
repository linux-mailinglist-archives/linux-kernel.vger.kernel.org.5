Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853A7EF2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKQMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:46:26 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5BD4E;
        Fri, 17 Nov 2023 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+YOin7g0g4T8byZD5QObPXU2WYjbG0dAcuL7qKb6CFQ=; b=DPiPJrWkqqPu/2Ozcap4dDcGnH
        X1Y2JjbeKoMJOj6KZlKumVBPARupNyrG0VJdUZnJ5KyyYhMlGnrSEKMhLvsMLIIidfacdkSWgPvSm
        JB9Xp9iqqX9uYVZQgKbrlTeO5lPpXL/iaff+I4NVmjqZIc8dFTM7DZHR6rd88gD2ACoE+Dp4mb+dp
        jbAE8qK6HR8G2pAc/hpEUEmzatlRF5GzL3C8kyRNeMXz5Xj0OMAYN5i4KizcfLWiMdoX/vmCE6poB
        ba8D5bztG6nyrWYUPyQJM/+y/OEj3Po1s2GsJN/jvbP7DHKYagJqB1tYGGHIJzZvmarsVxQqXFHJE
        AYl1ZgdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35790)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r3yEi-0002qX-2g;
        Fri, 17 Nov 2023 12:46:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r3yEk-00008Q-DK; Fri, 17 Nov 2023 12:46:18 +0000
Date:   Fri, 17 Nov 2023 12:46:18 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Marko <robimarko@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: validate PHY mode on
 AQR107
Message-ID: <ZVdgmpvI+F4ClNmG@shell.armlinux.org.uk>
References: <20231117100958.425354-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117100958.425354-1-robimarko@gmail.com>
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

On Fri, Nov 17, 2023 at 11:09:48AM +0100, Robert Marko wrote:
> The Aquantia driver is not setting the PHY mode itself, but it does however
> still check if the PHY mode set in DTS is one of the supported modes.
> 
> However, the set PHY mode does not have to match the actual one, so lets
> add update the PHY mode during .config_init and warn if they differ.

This looks completely wrong to me. These PHYs can be configured to
change their MAC-facing interface mode according to the media negotiated
speed, but you are only checking that _if_ the media is up, then the
interface that has resulted from that negotiation matches what is in
DTS. That could be dependent on the link partner, so what works for a
platform when connected to one link partner may issue your "info"-level
warning when connected to a different link partner.

So no, this to me looks completely wrong.

You need to check the VEND1_GLOBAL_CFG_* registers, and determine from
those what interface mode(s) will be used, and then use that to validate
the mode.

It just so happens that...

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=f7b531ee8855f81d267a8a42c44da51576f48daf
http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=f55389aa5d11da8a32dfd65a1b98049878ce09f0

builds a bitmap that can then be tested to check this. Whether the
above is entirely correct or not, I can't really say, I don't have
enough information on this PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
