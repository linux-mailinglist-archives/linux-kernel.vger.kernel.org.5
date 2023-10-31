Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF327DCD47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjJaMs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbjJaMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:48:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2F98;
        Tue, 31 Oct 2023 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=uu3dorM1BwNO7ya/P4sr4zNZu6tWr377yz93OprYyw4=; b=mUwNs9bthnmDK8zfD2uE+xv02/
        N5tjiEKrgRwmzte3T9A5K7ee6Gm1W4BcRFmGW3gU6PvB28hhl41eQk1NxEIvsYqd+OYQRoYZKR//X
        KxTfVG/GLBaovLfusRrgH1QYusfbNNNd6oqqNvoptisVMo2Re6ZUrMdjX766o5MaeJEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxoAE-000c2y-Dx; Tue, 31 Oct 2023 13:48:10 +0100
Date:   Tue, 31 Oct 2023 13:48:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <c67b0e57-b87b-45cd-b3fd-be11b0670b0d@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
 <5c240b3b-60c2-45bb-8861-e3a8de28d00f@lunn.ch>
 <7873124e-d7b2-4983-9be3-f85865d46de2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7873124e-d7b2-4983-9be3-f85865d46de2@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +             tc6->mdiobus = mdiobus_alloc();
> >> +             if (!tc6->mdiobus) {
> >> +                     netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> >> +                     return -ENODEV;
> >> +             }
> >> +
> >> +             tc6->mdiobus->phy_mask = ~(u32)BIT(1);
> > 
> > Does the standard define this ? BIT(1), not BIT(0)?
> Ok, I think here is a typo. Will correct it.

There is still the open question, does the standard define this? If
not, a vendor might decide to use some other address, not 0. So it
might be better to not set a mask and scan the whole bus.
phy_find_first() should then work, no matter what address it is using.

	Andrew
