Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3097CC50A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJQNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJQNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:45:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333AED;
        Tue, 17 Oct 2023 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QnLj8jQpNlVL5S9pBvsZqfOhgiPc8/H/ihQuqo7NgHo=; b=u8FF/R+M3iNqDUDnkBUj5sipCO
        AotgGq8KsYpEUFwjJBDe5xLoritiMkMPogoXlLagZpaenA/2KRZegMkpMpq6vrXnzxg4hjnd1YR0F
        P9QA4pcOE38AzOznezccxDRAa+XOIBflUmUsKWZOAyfnsgt7SzuNX3dXBdEqhuNjLLFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qskNW-002U4d-Qg; Tue, 17 Oct 2023 15:44:58 +0200
Date:   Tue, 17 Oct 2023 15:44:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Message-ID: <4ccd7dc9-b611-48aa-865f-68d3a1327ce8@lunn.ch>
References: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
 <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe make these conditional on the parent bus implementing the c45
> read/write ops?

And optionally, for net-next, make the c22 read/write ops conditional
on the parent bus having C22 as well. Its a bit of a corner case, but
there are a couple of MDIO bus masters which are C45 only.

Not having C45 is however very common, so we should make this
conditional as part of the fix.

      Andrew
