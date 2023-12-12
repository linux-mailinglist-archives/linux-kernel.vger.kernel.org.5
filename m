Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA47480ECE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376525AbjLLNKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376524AbjLLNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:10:29 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4FDF4;
        Tue, 12 Dec 2023 05:10:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 031601C0007;
        Tue, 12 Dec 2023 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702386629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atELFnnIPthqWoz2bHuN1bLUw36gajFDes0IJ/cmoaA=;
        b=aW8gD0JRdbGr0NXlm1/llPif8XCoQDwRZP9mhQl30Bb1nhbVJ9YfMP6npegebx2FhmVNuG
        cFg4LCrmzoeje3lshNHVDKmZf1t7Biz89foTOLpNkFOu5URuDBnXqAOnlyHnExKYETXjNc
        6gyGq10FG130gPiUsJixdIYmMFH2V4BB/Nl3LhmsabozpPhSY0zlivgkaONO4sFxJMwpXV
        qYDLYX6x6mQDv/xjZhsz2UwwzkGmbRLu9lNcEXBQKFsZHrg7kZvoEqhbyielS3ubVC5E8z
        Fe+NxJa+T/WhdwwNnh1z2EWAC9Nj9Z2FVwER92sEp5heBmkwYlmjR9SSGd7MnQ==
Date:   Tue, 12 Dec 2023 14:10:26 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Simon Horman <horms@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231212141026.37e7af58@device.home>
In-Reply-To: <67557c83-4318-4557-ac96-858053b5f89b@lunn.ch>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
        <20231201163704.1306431-2-maxime.chevallier@bootlin.com>
        <20231209170241.GA5817@kernel.org>
        <20231211120623.03b1ced4@device.home>
        <67557c83-4318-4557-ac96-858053b5f89b@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 15:09:09 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > > @@ -10832,6 +10833,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > > >  #ifdef CONFIG_NET_SCHED
> > > >  	hash_init(dev->qdisc_hash);
> > > >  #endif
> > > > +	phy_link_topo_init(&dev->link_topo);
> > > > +    
> > > 
> > > I don't think this can work unless PHYLIB is compiled as a built-in.  
> > 
> > Inded, I need to better clarify and document the dependency with
> > PHYLIB.  
> 
> It is getting harder and harder to make the phylib core a module :-(
> 
> How much work does phy_link_topo_init() do? Could it be an inline
> function? Are there other dependencies?

Sorry about that, I'll make sure it works with phylib entirely disabled
for next version. I try to keep the integration with net_device minimal
and avoid any dependency bloat, we don't need much besides xarray stuff
(hence the fact there are 2 headers, the phy_link_topology_core.h
containing the bare minimum), but I did miss that.

> Also look at ethtool_phy_ops and e.g. how plca_get_cfg_prepare_data()
> uses it.

Thanks, indeed that's a good example. I'll also address that in the
netlink part as well.

Thanks,

Maxime
