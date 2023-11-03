Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96C7E02A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbjKCMO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjKCMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:14:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D842D44;
        Fri,  3 Nov 2023 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=uGWXOxmGU6DijpJJLAD9Go42xjGlOch3s+DAI+XWLI0=; b=VQasqY3JRsMGSCiXl/ygTaJTha
        d5TgpVFRabepseEvnzDZ+yjcH/AVdGfAWz+X4svsx2o7AsV09fm+JfCLbQ6kmndwJpQC+kh1YuigU
        VJnRJF/GzPjWOgT3ic/S+Kv7gpk2yLz9Aam8jtk5sv4to969wcoIh5F7IbN72hbSAZBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyt3j-000oOe-Vj; Fri, 03 Nov 2023 13:13:55 +0100
Date:   Fri, 3 Nov 2023 13:13:55 +0100
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
Message-ID: <6d45f4da-c45e-4d35-869f-85dd4ec37b31@lunn.ch>
References: <20231030225446.17422-1-marcovr@selfnet.de>
 <5414570.Sb9uPGUboI@5cd116mnfx>
 <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
 <4890615.31r3eYUQgx@5cd116mnfx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4890615.31r3eYUQgx@5cd116mnfx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 02:47:38AM +0100, Marco von Rosenberg wrote:
> On Wednesday, November 1, 2023 11:06:56 PM CET Andrew Lunn wrote:
> > On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
> > > On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> > > > Are we talking about a device which as been suspended? The PHY has
> > > > been left running because there is no suspend callback? Something then
> > > > triggers a resume. The bootloader then suspends the active PHY? Linux
> > > > then boots, detects its a resume, so does not touch the hardware
> > > > because there is no resume callback? The suspended PHY is then
> > > > useless.
> > > 
> > > Hi Andrew,
> > > 
> > > thanks for your feedback. I guess a bit of context is missing here. The
> > > issue has nothing to do with an ordinary suspension of the OS. The main
> > > point is that on initial power-up, the bootloader suspends the PHY before
> > > booting Linux. With a resume callback defined, Linux would call it on
> > > boot and make the PHY usable.
> > 
> > Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).
> > 
> > This seems an odd way to solve the problem. It was not Linux which
> > suspend the PHY, so using resume is asymmetric.
> > 
> > I think soft_reset() or config_init() should be taking the PHY out of
> > suspend.
> 
> I agree with all of your points. This is just one way which happens to solve
> this specific problem. Of course it might be asymmetric to see the patch as
> a solution to my problem. However is there anything fundamentally wrong with
> adding suspend/resume callbacks?

No, there is nothing wrong with that at all, if you want to support
suspend/resume. I do however see that as a different use case to what
you describe as your problem. It fixing your problem is more of a side
effect.

We can go with this fix, but please change your justification in the
commit message. Also, its unlikely, but resume could be made
conditional in phy_attach_direct(), and you would then be back to a
broken PHY on boot. Fixing this in config_init() is the correct way
for your use case.

       Andrew
