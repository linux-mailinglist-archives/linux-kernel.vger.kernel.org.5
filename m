Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2B758F11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGSHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA591BE3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A87612FB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D6C433C7;
        Wed, 19 Jul 2023 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689751945;
        bh=LjK7+/aqSFBrBrXXXxem4dM/R5AvRUDJ78gWaQxHllM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XmmUp9TMbDTxSU6x46xBk4xBOr5FT8wz58CmMeWy38dwSzy0GtfB2AW58e10jMf/t
         UuA01wVDGsmS2Gkiz4oaBwbFs5Px1F0NcwhKlfd1iN2ct7kLEB7CHsufDv8zz6QOdF
         Rl/524wx3rMmKF+jEsFVmX9wySwDdAoFFvy4gw0XfmQz2qpI+rv87dPoqxNXEXrtGH
         bDyQYUIz58sBkecswsGJFQrgf9BKyN1tYJoerWiSB21Wl9HKT/aY8PK1UhUvVnQass
         UkMluW756ZhYqIFnaevcDk/OKyg2YXjhZ+z0gczWfdKHwNDeiWTCxWxhEn0xhOM/7L
         heVp1l2FOO1mA==
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 09:32:19 +0200
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
Subject: Re: [PATCH net-next v3 10/11] net: mdio: add C45-over-C22 fallback to
 fwnode_mdiobus_register_phy()
In-Reply-To: <4b31b4d0-e327-4ee5-a887-a5c35d51b2af@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-10-9eb37edf7be0@kernel.org>
 <4b31b4d0-e327-4ee5-a887-a5c35d51b2af@lunn.ch>
Message-ID: <3fd646ef7c4f92187a2d44af6d1c9a03@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-19 02:03, schrieb Andrew Lunn:
>> Please note, that both with the old and the new code compatible =
>> "ethernet-phy-idNNNN.NNNN" only works for the C22 case. I'm wondering 
>> if
>> compatible = "ethernet-phy-idNNNN.NNNN", "ethernet-phy-ieee802.3-c45
>> even makes sense because there might be multiple C45 ids. At least it 
>> is
>> an allowed pattern according to the device tree bindings. But with the
>> current code, the ethernet-phy-idNNNN.NNNN is ignored in the c45 case.
> 
> I think these two should be orthogonal.
> 
> ethernet-phy-idNNNN.NNNN should be used to load the driver. The driver
> has a list of IDs it can drive, and we want the module loading
> machinery to load a module which can driver this ID.

See [1]. It is used to overwrite the PHY ID. Which I think works
in the c22 case.

> "ethernet-phy-ieee802.3-c45" should be about how to read the ID
> registers, if ethernet-phy-idNNNN.NNNN is not present.

And if it's present? See [2].

-michael

[1] 
https://elixir.bootlin.com/linux/v6.4.3/source/Documentation/devicetree/bindings/net/ethernet-phy.yaml#L38
[2] 
https://elixir.bootlin.com/linux/v6.4.3/source/Documentation/devicetree/bindings/net/ethernet-phy.yaml#L50
