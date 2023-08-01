Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB46776B87C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHAPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjHAPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4652510F5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ABF0615F5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224C1C433C9;
        Tue,  1 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690903227;
        bh=S/yh4HFwSMKveBH7hjxGoJ0RILF31mQprfeX/QR7adw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IMNAd8WNqR7fhcTMzEQSUIa5VmK1a8jm9JXX+D0lRJGb7jbrisVJPkWNSoDgE7wOx
         Ke+R5iMvLsGiLC+LRZny1cThYLu2k8ndFT2LA+RqzReI7kZk5+ocbsBdfxMLitMZ2f
         dlHXQt2+wFrm09Gle72M+pbcreDfAngpUXQ9QLZ/XFzQsZDEzBgL3B95v0Yf2l6mdT
         KmSPBNfPDNpsgyk2HBJ4ysAiz0KH9sDaeOesAAzjom5yU2l6iA8mxBcwCQ9Ob6q43y
         A0nrdpBGYg1RHo4/NTMbojQc/Z/gUPtTdXSoN/im/otr7bHBsxmlXODbfZuOWk1S/e
         L8BjiNlhiRAIg==
MIME-Version: 1.0
Date:   Tue, 01 Aug 2023 17:20:22 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_B?= =?UTF-8?Q?eh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
In-Reply-To: <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
Message-ID: <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> > > > diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
>> > > > index a64186dc53f8..686a57d56885 100644
>> > > > --- a/drivers/net/phy/phy-core.c
>> > > > +++ b/drivers/net/phy/phy-core.c
>> > > > @@ -556,7 +556,7 @@ int __phy_read_mmd(struct phy_device
>> > > > *phydev, int devad, u32 regnum)
>> > > >
>> > > >  	if (phydev->drv && phydev->drv->read_mmd) {
>> > > >  		val = phydev->drv->read_mmd(phydev, devad, regnum);
>> > > > -	} else if (phydev->is_c45) {
>> > > > +	} else if (phy_has_c45_registers(phydev)) {
>> > >
>> > > This i would say should be
>> > >
>> > > phy_has_c45_transfers(phydev). This is about, can we do C45 transfers
>> > > on the bus, and if not, fall back to C45 over C22.
>> >
>> > Shouldn't this then be a bus property? I.e. mdiobus_has_c45_transfers().
>> > I've have a similar helper introduced in 9/11:
>> >
>> > static inline bool mdiobus_supports_c45(struct mii_bus *bus)
>> > {
>> >     return bus->read_c45 && !bus->prevent_c45_access;
>> > }
> 
> In the case of the above (the code in __phy_read_mmd()), I wouldn't
> at least initially change the test there.
> 
> phydev->is_c45 will only be true if we probed the PHY using clause
> 45 accesses. Thus, it will be set if "the bus supports clause 45
> accesses" _and_ "the PHY responds to those accesses".
> 
> Changing that to only "the bus supports clause 45 accesses" means
> that a PHY supporting only clause 22 access with indirect clause
> 45 access then fails if it's used with a bus that supports both
> clause 22 and clause 45 accesses.

Yeah of course. It was more about the naming, but I just realized
that with mdiobus_supports_c45() you can't access the original
"is_c45" property of the PHY. So maybe this patch needs to be split
into two to get rid of .is_c45:

First a mechanical one:
phy_has_c45_registers() {
    return phydev->is_c45;
}

phy_has_c22_registers() {
   return !phydev->is_c45;
}

For all the places Andrew said it's correct. Leave all the
other uses of .is_c45 as is for now and rework them in a
later patch to use mdiobus_supports_{c22,c45}().

-michael
