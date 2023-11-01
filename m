Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB37DE7ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbjKAWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKAWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:07:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0F119;
        Wed,  1 Nov 2023 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KgzCwQKtlZ3s9s50rcNwyHCoDZfACulHcl3W84haDr4=; b=OYSWK1YF4X45HUwjA5CyXAzwr2
        /I4EiffvQhPEokY4fA6QF5iTIGSbLgS1U7eaPZ3xM5YUXoCWdnp7l+T9d39GuiTedyO9gyx0P9zrh
        H9xyPPmNIIHUpVljhJ4VYDhb3R/0m9rJp8J/aJRXg5auR8X7biR0ppHoyZF2vVMLhtSo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyJMW-000i2r-4k; Wed, 01 Nov 2023 23:06:56 +0100
Date:   Wed, 1 Nov 2023 23:06:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marco von Rosenberg <marcovr@selfnet.de>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Message-ID: <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
References: <20231030225446.17422-1-marcovr@selfnet.de>
 <9cb4f059-edea-4c81-9ee4-e6020cccb8a5@lunn.ch>
 <5414570.Sb9uPGUboI@5cd116mnfx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5414570.Sb9uPGUboI@5cd116mnfx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
> On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> > Are we talking about a device which as been suspended? The PHY has
> > been left running because there is no suspend callback? Something then
> > triggers a resume. The bootloader then suspends the active PHY? Linux
> > then boots, detects its a resume, so does not touch the hardware
> > because there is no resume callback? The suspended PHY is then
> > useless.
> 
> Hi Andrew,
> 
> thanks for your feedback. I guess a bit of context is missing here. The issue 
> has nothing to do with an ordinary suspension of the OS. The main point is 
> that on initial power-up, the bootloader suspends the PHY before booting 
> Linux. With a resume callback defined, Linux would call it on boot and make the 
> PHY usable.

Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).

This seems an odd way to solve the problem. It was not Linux which
suspend the PHY, so using resume is asymmetric.

I think soft_reset() or config_init() should be taking the PHY out of
suspend.

	Andrew
