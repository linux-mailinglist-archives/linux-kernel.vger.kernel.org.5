Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15C27B25A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI1TFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:05:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166EB195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:05:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BEAC433C7;
        Thu, 28 Sep 2023 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695927945;
        bh=hL+1NK7FhszHgz8oD0fZO4rkoqzQEsWg3x3hhHFUDiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5RF0CV+X6PZ2UnKfF1cHF0YRVn39sT/fWwmRXYooWHxcmtRfB3Pzkh3H2SXVWzDK
         hOxEwwX8zPxXSRo+nXVuHXZF9uCGZwEZ6m3OTiBlR69wgxpSgERc0v+wlxEAEr59KS
         BdQHOnTrmj1EGypvPQozajvkpiL4Q9I14qQvIwl3tcuL2tvZD1jvxxuOgLi5Jrcsuo
         xDw5ORw6S9vV08RvCLEGmVSepCLo+YMUoaqOssAzZfxjd7/Xh9YAsYf9AsKo3Zv/vv
         WAGeKLgkgQzr6RuMmGMoxP9uHdb1dZzLt7RnDAxU8f+O5yW+zUd8r5Zs5MCyNqw9O1
         slQ1GCspCCBPw==
Date:   Thu, 28 Sep 2023 21:05:36 +0200
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
Message-ID: <20230928190536.GO24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-4-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:

...

> +/**
> + * coef_update_opposite - return the opposite of one C72 coefficient update
> + *			  request
> + *
> + * @update:	original coefficient update
> + *
> + * Helper to transform the update request of one equalization tap into a
> + * request of the same tap in the opposite direction. May be used by C72
> + * phy remote TX link training algorithms.
> + */
> +static inline enum coef_update coef_update_opposite(enum coef_update update)

Hi Vladimir,

another nit from me.

Please put the inline keyword first.
Likewise elsewhere in this patch.

Tooling, including gcc-13 with W=1, complains about this.

> +{
> +	switch (update) {
> +	case COEF_UPD_INC:
> +		return COEF_UPD_DEC;
> +	case COEF_UPD_DEC:
> +		return COEF_UPD_INC;
> +	default:
> +		return COEF_UPD_HOLD;
> +	}
> +}

...
