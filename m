Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E523C758ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSHXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGSHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B62682
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B72611F6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC3EC433C8;
        Wed, 19 Jul 2023 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689751322;
        bh=3iiA3Y9v1L1k9xx1PzYcaYLgH17AKV0yDCqMSrfyEF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmVKHiZsNnQMe/6FLFncveBM2z3lNTQkHbzhiUP8aLpud297muIMGvdjTef4SGS/k
         I3tf9OzQT50AQy3GiWpiG5MCsiQlF/hD9PxNnkTAeODaxjc0sB/Xf+S7SgREBeOh3q
         wmCT/NQAPpqImQw3Z5djwf9CoMiOeAwwHybpbYOPfTyFmBLWmF1eouxSUlKr1NZdCu
         3UpnNQ+tI4fQKC6T1miwkiXnqdF0BvNHyZ/CnHZGclnPdU4tIf4M+YVg8UcaVBR89P
         dICY5VOfXeP9dOtWgc/NH7zQuqbAnAPerNf+oopqzjxR93iFNTSc9Ft/Ycl7Lzo7rC
         ypyNg8yF612kA==
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 09:21:57 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
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
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 07/11] net: phy: introduce
 phy_mdiobus_read_mmd()
In-Reply-To: <3cfe5af5-31b6-492c-af55-cd0397b07eb1@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-7-9eb37edf7be0@kernel.org>
 <3cfe5af5-31b6-492c-af55-cd0397b07eb1@lunn.ch>
Message-ID: <8147c4e37adfa7b7d9ee95d242223f39@kernel.org>
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

Am 2023-07-19 01:54, schrieb Andrew Lunn:
>> +static int __phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
>> +				  enum phy_access_mode access_mode,
>> +				  int devad, u32 regnum)
>> +{
>> +	switch (access_mode) {
>> +	case PHY_ACCESS_C45:
>> +		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
>> +	case PHY_ACCESS_C22:
>> +		/* ignore return value for legacy reasons */
>> +		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
>> +
>> +		/* Read the content of the MMD's selected register */
>> +		return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
> 
> So this is reading a C45 register space register, otherwise it would
> not be called _mmd and have a devad. So access_mode should really be
> transfer mode. Until now, only transfer mode C45 can be used to access
> C45 register space. The point of this patchset is to add a new
> C45_OVER_C22 transfer mode.

So you suggest to rename access_mode to transfer_mode, right?

> And C22 would should give -EINVAL, since you cannot use plain C22 bus
> transactions to access C45 register space.

We had indirect mmd access before with c22 PHYs before, we could
theoretically fold that into c45-over-c22, but the old indirect
mmd access wasn't checking for error codes and according to Russell
we cannot change that. Honestly, I'd just duplicate the code and
leave the old non-error checking code in __phy_read_mmd() while
__phy_mdiobus_read_mmd() will do error checking and return -EINVAL
with PHY_ACCESS_C22. I had that in one of the first versions but
you suggested to not copy the code :), then this ugly check_rc
thing came. Or __phy_mdiobus_(read,write)_mmd() will have a
check_rc parameter.

-michael
