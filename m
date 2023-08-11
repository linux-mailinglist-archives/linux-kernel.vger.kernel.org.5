Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC33E7794DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjHKQjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjHKQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:39:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7BDE65;
        Fri, 11 Aug 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=TAgSe/fvcEsAuCevj4UGpRGSw4bx6DrrfYgnHUykh04=; b=dyYT0EfC1RxBdwrrg002ZYKUBG
        gM+1qg62PZ1QlIpEgtBoie4k7T4n2f82EWwCI9OndqQhZIArgRWc0KII3zfTvYDU4l1e7hFjdrf2N
        zFJorazHy0YexBrhSHTDH+uW0kAaDXJXX6pmN+srzeq12Uptft6MN8ggGYZvbCUmUE0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUVAC-003pLi-AB; Fri, 11 Aug 2023 18:39:00 +0200
Date:   Fri, 11 Aug 2023 18:39:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Message-ID: <ed096dfe-6a42-4838-972b-7a28afaf2f6e@lunn.ch>
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
 <ac6a4318-3a47-2c77-6b81-b5f04765c04e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6a4318-3a47-2c77-6b81-b5f04765c04e@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/* Only now setup pinctrl to avoid bogus blinking */
> > +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
> 
> This function gets reference on phydev->mdio.dev, but there is no code
> to release it. It looks like a leak which will prevent module unload,
> but I don't have hardware now to prove it.

Since it is a devm_ function, it should get released when the device
is destroyed. Or am i missing something?

   Andrew
