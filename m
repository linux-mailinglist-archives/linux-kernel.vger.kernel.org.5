Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E907B1E95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjI1Ngm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1Ngl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:36:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2111F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:36:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29908C433C9;
        Thu, 28 Sep 2023 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908199;
        bh=buWFvyKvzLE7yL9fD5WstGeTidrhh5FjGgosGmcwWnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRZGCX4uM6nkWatFx7vCXHkNlUNWjWo3yiUsyXT5+Lkn/x8HZJejO0I56+C12vAKX
         mJorU9/7Rn6Ix0Ka5F16XmmPqoZp9ssId88f4t8jGBd5LG3pi3bYUgRYoyrjq/dSho
         uY2qKIzOuhL41R7wpANqI/+vSXk08AD6BuvSdqIKwzx773+Z4U6NnerejQug+Kw1lB
         xByiAv/JNY1zsOIEfRX7SVieCdeeCAn5w8+m5gTLdMzUCJT55WBUK+tOSakelTU7FJ
         hgJuQcyIknhUrLOVHIfPUJ1dER7tKcRDGcTRvSbJiQ8GoVB5/Bm2tgTPp5vxcQ1ghX
         AMYeIKxgZBZ3A==
Date:   Thu, 28 Sep 2023 15:36:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration
 interface for copper backplane Ethernet PHYs
Message-ID: <20230928133629.GM24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-4-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:
> In Layerscape and QorIQ SoCs, compliance with the backplane Ethernet
> protocol is bolted on top of the SerDes lanes using an external IP core,
> that is modeled as an Ethernet PHY. This means that dynamic tuning of
> the electrical equalization parameters of the link needs to be
> communicated with the consumer of the generic PHY.
> 
> Create a small layer of glue API between a networking PHY (dealing with
> the AN/LT logic for backplanes) and a generic PHY by extending the
> phy_configure() API with a new struct phy_configure_opts_ethernet.
> 
> There are 2 directions of interest. In the "local TX training", the
> generic PHY consumer gets requests over the wire from the link partner
> regarding changes we should make to our TX equalization. In the "remote
> TX training" direction, the generic PHY is the producer of requests,
> based on its RX status, and the generic PHY consumer polls for these
> requests until we are happy. Each request is also sent (externally to
> the generic PHY layer) to the link partner board, for it to adjust its
> TX equalization.
> 
> struct phy_configure_opts_ethernet is valid when phy_set_mode_ext() has
> been called with PHY_MODE_ETHERNET or PHY_MODE_ETHTOOL, same as with
> other union phy_configure_opts types.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

...

> +/**
> + * struct phy_configure_opts_ethernet - Ethernet PHY configuration set

nit: please include documentation of the structure members - type,
local_tx, and remote_tx - here.

> + *
> + * This structure is used to represent the configuration state of an Ethernet
> + * PHY (of various media types).
> + */
> +struct phy_configure_opts_ethernet {
> +	enum ethernet_phy_configure_type type;
> +	union {
> +		struct c72_phy_configure_local_tx local_tx;
> +		struct c72_phy_configure_remote_tx remote_tx;
> +	};
> +};

...
