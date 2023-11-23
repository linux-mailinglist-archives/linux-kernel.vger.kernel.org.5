Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E797B7F605E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbjKWNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbjKWNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:35:02 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8DC1;
        Thu, 23 Nov 2023 05:35:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD7DD1C0007;
        Thu, 23 Nov 2023 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mI4znOI0zE5PCCzZTTeLMyK+ZXMtNz24QJhN8KXDmLA=;
        b=EtcX4T8VhqjpHCjMpiAz1lTycXWcOjenC90NFWYOwNIhxgMZCuHf2pxZbLcclEXAXOE63P
        2hu19ZFS7LgZITw3sRvmmVQkCWWbuy/9qOUihaTgl1p28zlnSIiHRoHYd/IZ+kTOQEB/1s
        jWV9pfUI8PxVdlKHpKUXh7WyYu160a0hFynJxTEcxbETVLmPIB7x2foY8DaUjh6UB44ST8
        hZjDRtQ/QaTMSacxb5rjNOlDvwncJKdnY4Qzs89ZlZ9yeYFikgaKK2vTxgDN3xGLD527tT
        Tevhxp97kPmtXnkFhTKio9ZFgG2aARv8x8AJzeIXQRToNSXG+FM9ZY0OAQOCbQ==
Date:   Thu, 23 Nov 2023 14:35:02 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 04/10] net: sfp: Add helper to return
 the SFP bus name
Message-ID: <20231123143502.3a9a9047@device.home>
In-Reply-To: <ZVyEe0zH8Zo1NLFO@shell.armlinux.org.uk>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
        <20231117162323.626979-5-maxime.chevallier@bootlin.com>
        <00d26b50-56f1-4eac-a37f-36cf321bd46a@lunn.ch>
        <ZVyEe0zH8Zo1NLFO@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Russell,

On Tue, 21 Nov 2023 10:20:43 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Nov 21, 2023 at 02:00:58AM +0100, Andrew Lunn wrote:
> > > +const char *sfp_get_name(struct sfp_bus *bus)
> > > +{
> > > +	if (bus->sfp_dev)
> > > +		return dev_name(bus->sfp_dev);
> > > +
> > > +	return NULL;
> > > +}  
> > 
> > Locking? Do you assume rtnl? Does this function need to take rtnl?  
> 
> Yes, rtnl needs to be held to safely access bus->sfp_dev, and that
> either needs to happen in this function, or be documented as being
> requried (and ASSERT_RTNL() added here.)
> 
> The reason is that sfp_dev is the SFP socket device which can be
> unbound via sfp_unregister_socket(), which will set bus->sfp_dev to
> NULL. This could race with the above.
> 

That's right, I'll add an assert and document it, thanks for spotting
this.

Maxime
