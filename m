Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA937585D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGRTxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGRTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9219D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F7C60C7F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E0CC433C8;
        Tue, 18 Jul 2023 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689710010;
        bh=iS8olXu4j8uUvayUIlwSeJUyNl508dh0P8150fs7BRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=agag+Gscd6wX7IDzIqBzi1Td8r+5wRVep1vJYbhVCCNwdq7eUERxITKXmAznPuLjC
         Q9CsueWTJkjgLZNgENnGENdB65aKIQR3t+pX6x6bzsS0r5v/TqhfN80UoETNjYJvBl
         L9NLlaPvmfFIT9w1sCIKqNtK3VrqWYsA9zgt9xUIbFmmvMX1s/+Sy2YWnL1w6h4RhI
         JaN49/blYRgppryxR/SFyfl5LUdAo/JJNhzjhf3/0Q236Pw4hIPHe6t8lIEpcm/ZGI
         /3arPWc8kABMo0tFmDJ87cWSYExO75nEy0GlfEkFPObnJi3nwszvuQa7s66aKl9o+p
         fu4AD4wLNGwlg==
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 21:53:25 +0200
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
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
In-Reply-To: <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
 <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
Message-ID: <66d9daa106d7840e972dba35914e6983@kernel.org>
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

Am 2023-07-18 19:40, schrieb Andrew Lunn:
>>  static inline bool phy_has_c45_registers(struct phy_device *phydev)
>>  {
>> -	return phydev->is_c45;
>> +	return phydev->access_mode != PHY_ACCESS_C22;
>>  }
> 
> So this is making me wounder if we have a clean separation between
> register spaces and access methods.

The idea is to at least have it behind a helper which can be changed
if we get that information from somewhere else.

But right now, a PHY is considered to have c45 registers if it is
probed via c45 (accesses).

Instead of checking the access mode, I could also introduce a
bitmask(?)/flags has_c22/has_c45_registers. But how would you tell
if a PHY as c22 registers? Probe both c22 and c45? What if the bus
can't do c45?

> Should there be a phy_has_c22_registers() ?
> 
> A PHY can have both C22 registers and C45 registers. It is up to the
> driver to decide which it wants to access when.

But isn't it also the driver which has the ultimate information whether
a PHY has c22 register space and/or c45 one?

Maybe we need to clarify what "has c22/c45 registers space" actually
means. Responds to MII c22/c45 access?

-michael

> Should phydev->access_mode really be phydev->access_mode_c45_registers
> to indicate how to access the C45 registers if phy_has_c45_registers()
> is true?
> 
> Has there been a review of all uses of phydev->is_c45 to determine if
> the user wants to know if C45 registers exist,
> a.k.a. phy_has_c45_registers(), or if C45 bus transactions can be
> performed, and then later in this series, additionally if C45 over C22
> can be performed. These are different things.
> 
> I need to keep reading the patches...
> 
>   Andrew
