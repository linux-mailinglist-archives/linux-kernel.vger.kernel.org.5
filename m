Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305807F4418
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjKVKlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:41:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DFD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:41:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC6FC433C9;
        Wed, 22 Nov 2023 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700649703;
        bh=s/dlsgjmV9/Gjv6PkVsXWK7wZO4UsNtqC33jkUQSkdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pllgEhGfESNKJ4y1QCO3/xtPQtzDsfLDrTZwVJb7dcjgSp04X70lfQTsdvCyTBqq2
         rYZsJYXe3umDXe2CtsvCRCJ6nQXEZVx99lQ7tSu0Z4+ZZblCV7uVGdQJHLNNodeS17
         cTS6UfNn/VytfQbekcqYu3wC+qsHYkWeWlY5Ydj8xyAT6v7hN7pIzAviS6jy7cyeWb
         aYCuvcW7rfhQxCcK3AR2rbLVLbDyQdftt2Km+Kr9XkC4NFheaSpUDSxtqAhIFNnMkn
         ZMR6kHVKaeGic5UxLn807ZRZheNfV1AJvB6cYoZbazYVtg1zEKxr4xMixJGHWurBwT
         dOFXA/tf/3Ddg==
Date:   Wed, 22 Nov 2023 10:41:34 +0000
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 04/14] net: phy: add initial support for PHY
 package in DT
Message-ID: <20231122104134.GA28959@kernel.org>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120135041.15259-5-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:50:31PM +0100, Christian Marangi wrote:
> Add initial support for PHY package in DT.
> 
> Make it easier to define PHY package and describe the global PHY
> directly in DT by refereincing them by phandles instead of custom
> functions in each PHY driver.
> 
> Each PHY in a package needs to be defined in a dedicated node in the
> mdio node. This dedicated node needs to have the compatible set to
> "ethernet-phy-package" and define "global-phys" and "#global-phy-cells"
> respectively to a list of phandle to the global phy to define for the
> PHY package and 0 for cells as the phandle won't take any args.
> 
> With this defined, the generic PHY probe will join each PHY in this
> dedicated node to the package.
> 
> PHY driver MUST set the required global PHY count in
> .phy_package_global_phy_num to correctly verify that DT define the
> correct number of phandle to the required global PHY.
> 
> mdio_bus.c and of_mdio.c is updated to now support and parse also
> PHY package subnote that have the compatible "phy-package".
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

...

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index c2bb3f0b9dda..5bf90c49e5bd 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -339,6 +339,8 @@ struct mdio_bus_stats {
>   * phy_package_leave().
>   */
>  struct phy_package_shared {
> +	/* With PHY package defined in DT this points to the PHY package node */
> +	struct device_node *np;
>  	/* addrs list pointer */
>  	/* note that this pointer is shared between different phydevs.
>  	 * It is allocated and freed automatically by phy_package_join() and

Hi Christian,

a minor nit from my side: please add np to the kernel doc for
struct phy_package_shared.

> @@ -888,6 +890,8 @@ struct phy_led {
>   * @flags: A bitfield defining certain other features this PHY
>   *   supports (like interrupts)
>   * @driver_data: Static driver data
> + * @phy_package_global_phy_num: Num of the required global phy
> + *   for PHY package global configuration.
>   *
>   * All functions are optional. If config_aneg or read_status
>   * are not implemented, the phy core uses the genphy versions.

...
