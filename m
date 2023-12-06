Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282F8073E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379393AbjLFPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379298AbjLFPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:42:54 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E9D4F;
        Wed,  6 Dec 2023 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=W8om7MlfeXGuyaEqx9q949RWwCO+0suYJB77IGmK5z4=; b=kXj86yBrrEihSOaunTY1GwV2IK
        dv/yVOaN8d3IWEMghAy0wuyWYpSe2AGZki4s6XuxKDmGt0gaTx/KFjuE/mMHfqJgWGx4ypUA1Xl4i
        3y5XeUDLVbOmOEj34R94jSYks+nCa/GZkAn3BO5RySjC1+1P8ReFCeN68cbQWKBbYA1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAu32-002DnU-5Z; Wed, 06 Dec 2023 16:42:52 +0100
Date:   Wed, 6 Dec 2023 16:42:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Daniel Danzberger <dd@embedd.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: properly support
 platform_data probing
Message-ID: <9d2bc0a2-1ef9-4e42-82ac-e5c1b2af90c9@lunn.ch>
References: <20231205164231.1863020-1-dd@embedd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205164231.1863020-1-dd@embedd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:42:30PM +0100, Daniel Danzberger wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The ksz driver has bits and pieces of platform_data probing support, but
> it doesn't work.
> 
> The conventional thing to do is to have an encapsulating structure for
> struct dsa_chip_data that gets put into dev->platform_data. This driver
> expects a struct ksz_platform_data, but that doesn't contain a struct
> dsa_chip_data as first element, which will obviously not work with
> dsa_switch_probe() -> dsa_switch_parse().
> 
> Pointing dev->platform_data to a struct dsa_chip_data directly is in
> principle possible, but that doesn't work either. The driver has
> ksz_switch_detect() to read the device ID from hardware, followed by
> ksz_check_device_id() to compare it against a predetermined expected
> value. This protects against early errors in the SPI/I2C communication.
> With platform_data, the mechanism in ksz_check_device_id() doesn't work
> and even leads to NULL pointer dereferences, since of_device_get_match_data()
> doesn't work in that probe path.
> 
> So obviously, the platform_data support is actually missing, and the
> existing handling of struct ksz_platform_data is bogus. Complete the
> support by adding a struct dsa_chip_data as first element, and fixing up
> ksz_check_device_id() to pick up the platform_data instead of the
> unavailable of_device_get_match_data().
> 
> The early dev->chip_id assignment from ksz_switch_register() is also
> bogus, because ksz_switch_detect() sets it to an initial value. So
> remove it.
> 
> Also, ksz_platform_data :: enabled_ports isn't used anywhere, delete it.
> 
> Link: https://lore.kernel.org/netdev/20231204154315.3906267-1-dd@embedd.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Daniel Danzberger <dd@embedd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
