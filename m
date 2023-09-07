Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10CF7973E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbjIGPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbjIGP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:11 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE274CA;
        Thu,  7 Sep 2023 08:28:42 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C0ECBCF83F;
        Thu,  7 Sep 2023 12:20:29 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAF1360002;
        Thu,  7 Sep 2023 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694089208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMIxgcqQLFA1Dd5kyFbxEHu6hstdO8nu7zHeGXeALaA=;
        b=URJWNqtWN3BykyhzJV3wJxdqspNgMYK52/gu6V+TpGvxvWYO3MawObSrJQIhXzgzdczVQT
        sEYuPVuTWb5+TUwezhlklVb5E0fPQo5bkkJXqqMcd481me24ItoyjLZdXfUEPFqvYVNpY9
        dVZyJO5zAx7nuvbB6ROez6xyFn4gcrqzxEBZnGAtyn068wSqADWntf0ZWkwPj/jrfk/VXM
        vxAjwV195uR72PLrFAof8FOBCpHIW5LovnkPOXAFIak5RKzWM4wYsz8grcIVJT962cPnSp
        GVQKDVDRKOAu/wRPXHTocnGH20BGDUtoLhKs9zAsH+0c/quJx1D39kgMU13X9Q==
Date:   Thu, 7 Sep 2023 14:20:05 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230907142005.058383b8@pc-7.home>
In-Reply-To: <ZPmgSFVp8+hou3QT@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-7-maxime.chevallier@bootlin.com>
        <ZPmgSFVp8+hou3QT@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Thu, 7 Sep 2023 11:04:56 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 07, 2023 at 11:24:04AM +0200, Maxime Chevallier wrote:
> > +	data->phyindex = req_info->phyindex;
> > +	data->drvname = phydev->drv->name;
> > +	if (phydev->is_on_sfp_module)  
> 
> Please use the accessor provided:
> 
> 	if (phy_on_sfp(phydev))

Ack, I'll switch to that then.

Thanks,

Maxime


