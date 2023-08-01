Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447F576B7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjHAOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjHAOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47143122
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA14E615C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382ABC433C8;
        Tue,  1 Aug 2023 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901229;
        bh=ykWFBTph97MsIBRZhRpXY23VWTA1pLICPIttkiODQac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwAJ3SW5GWfqcGCBYqcfzfRBMEqZVwj+Oo7X268oJqjKdJJf1SO6Oj69Q+Q/RZtUu
         Svs0WXYNorzknnU9vRJjv13cnY807KX0wVrcfVLJrgKpDqZQ5/9Qqa9oHzGPcawHGK
         HEdgJy/6+o/DLQjxMRXKDPazc72hLFfc1fvzCg29RqghnqZx0YiJVDK/q3AB665ghy
         JrNm+PSDj8UzENjDvC6icO/exzfKZCJBLhRsJrqHftukgLFuocDRxSDlEhR8Y/X+xK
         C0gABCp3lCBMFLJRr3Fn0b7IowISwmHxZtMFEUZv7kfyDlX5vcpqi5D2acdNGtv2Qm
         2BOmL5g+6Ltgg==
MIME-Version: 1.0
Date:   Tue, 01 Aug 2023 16:47:04 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_Beh?= =?UTF-8?Q?=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
In-Reply-To: <867ae3cc05439599d63e4712bca79e27@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
Message-ID: <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Am 2023-07-19 09:11, schrieb Michael Walle:
>>> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
>>> index a64186dc53f8..686a57d56885 100644
>>> --- a/drivers/net/phy/phy-core.c
>>> +++ b/drivers/net/phy/phy-core.c
>>> @@ -556,7 +556,7 @@ int __phy_read_mmd(struct phy_device *phydev, int 
>>> devad, u32 regnum)
>>> 
>>>  	if (phydev->drv && phydev->drv->read_mmd) {
>>>  		val = phydev->drv->read_mmd(phydev, devad, regnum);
>>> -	} else if (phydev->is_c45) {
>>> +	} else if (phy_has_c45_registers(phydev)) {
>> 
>> This i would say should be
>> 
>> phy_has_c45_transfers(phydev). This is about, can we do C45 transfers
>> on the bus, and if not, fall back to C45 over C22.
> 
> Shouldn't this then be a bus property? I.e. 
> mdiobus_has_c45_transfers().
> I've have a similar helper introduced in 9/11:
> 
> static inline bool mdiobus_supports_c45(struct mii_bus *bus)
> {
>     return bus->read_c45 && !bus->prevent_c45_access;
> }
> 
>>>  static int phylink_sfp_connect_phy(void *upstream, struct phy_device 
>>> *phy)
>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>> index 11c1e91563d4..fdb3774e99fc 100644
>>> --- a/include/linux/phy.h
>>> +++ b/include/linux/phy.h
>>> @@ -766,6 +766,11 @@ static inline struct phy_device 
>>> *to_phy_device(const struct device *dev)
>>>  	return container_of(to_mdio_device(dev), struct phy_device, mdio);
>>>  }
>>> 
>>> +static inline bool phy_has_c45_registers(struct phy_device *phydev)
>>> +{
>>> +	return phydev->is_c45;
>>> +}
>> 
>> And this is where it gets interesting. I think as a first step, you
>> should implement the four functions:
>> 
>> phy_has_c22_registers()
>> phy_has_c45_registers()
>> phy_has_c22_transfers()
>> phy_has_c45_transfers()
>> 
>> based on this. So there is initially no functional change.
>> 
>> 
>> You can then change the implementation of _transfers() based on what
>> the MDIO bus can do, plus the quirk for if a FUBAR microchip PHY has
>> been found.
> 
> See above. Shouldn't it be mdiobus_...() then?
> 
>> Then change the implementation of _registers() based on the results of
>> probing for the ID registers.
> 
> So this is where I cannot follow. Right now there is
> (1) probing via bus scan
> (2) probing via DT (or maybe also ACPI)
> 
> With (1) you we have scan_c22(), so if successful, 
> phy_has_c22_registers()
> will return true, right? But it's not that clear for
> phy_has_c45_registers(), because sometimes we prevent that scan. So
> the PHY might have c45 but we don't know.
> 
> For (2) we don't even do a c22 scan if we know if its a C45 PHY (or the
> other way around). I'm not sure we can reliably tell (at the end of 
> this
> series) if a phy has c22 register, c45 registers or both.

Any news here?

-michael
