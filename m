Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868E79BC50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355650AbjIKWBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbjIKNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:05:57 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A393DF;
        Mon, 11 Sep 2023 06:05:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38CEF60004;
        Mon, 11 Sep 2023 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694437547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwIYsqLUnY+qjK/+Si2acqNJrj9pOQtmxP0WNxCQT64=;
        b=Ju0jNKa1DfjDdVEOGca+OtlrWcjg+2BqJgRZfn753HkWcFLYPaMRZ9UrsphyjWn7y9ilq/
        0cYvAlkrdvSgMcTL/nzM3sf2bTQYX7eDhiG1C5SzJwgbG7aSiQcaWh7DbrCqFJRpnlBioF
        7p4LtAslZ7f+HFKBmo/1PxXQ9hzszvl1JrS2xCAwYYl5dEahVISzosQ2OUKCX0zxaFbWEO
        8RoSx6QHHC/INgrZ30TgPi3NfpqktifbI3l+l26VZcbF4lzNtLVLvbpnIPo0lRv5rkgw+V
        w4sFFmiebQIBk04mvmWtVqtav85esJQn1nwNxDH8MefDomRLV1fHk0i2YEeCLQ==
Date:   Mon, 11 Sep 2023 15:05:44 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230911150544.5304e763@fedora>
In-Reply-To: <20230908083608.4f01bf2c@kernel.org>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-2-maxime.chevallier@bootlin.com>
        <ZPmicItKuANpu93w@shell.armlinux.org.uk>
        <20230907141904.1be84216@pc-7.home>
        <20230908083608.4f01bf2c@kernel.org>
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

Hello Jakub,

On Fri, 8 Sep 2023 08:36:08 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 7 Sep 2023 14:19:04 +0200 Maxime Chevallier wrote:
> > > I think you can simplify this code quite a bit by using idr.
> > > idr_alloc_cyclic() looks like it will do the allocation you want,
> > > plus the IDR subsystem will store the pointer to the object (in
> > > this case the phy device) and allow you to look that up. That
> > > probably gets rid of quite a bit of code.
> > > 
> > > You will need to handle the locking around IDR however.    
> > 
> > Oh thanks for pointing this out. I had considered idr but I didn't spot
> > the _cyclic() helper, and I had ruled that out thinking it would re-use
> > ids directly after freeing them. I'll be more than happy to use that.  
> 
> Perhaps use xarray directly, I don't think we need the @base offset or
> quick access to @next which AFAICT is the only reason one would prefer
> IDR?

Oh indeed xa_alloc_cyclic looks to fit perfectly, thanks !

Maxime
