Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2195780B65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjHRLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376725AbjHRLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7F30E6;
        Fri, 18 Aug 2023 04:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91644653E4;
        Fri, 18 Aug 2023 11:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6A2C433C8;
        Fri, 18 Aug 2023 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692359248;
        bh=kQCjU+mVZk93ddvGtri/QJoYzc994kW+5bwhHWH/UPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvNdoBiQdrf5a6u4Jdi4AIl4bJeTD2d8X6lFjWTy7/FE3sCygu0Vu29wxMkN2vei4
         U1jc08PYjrtGRxFMaxsfYO9YSbOs7iqf8BDg/OITjI2SL42agGvojyMoZpZ9H7voQD
         P5WPZfBcCs3xawyuow6O7YsWfF+p+eMbncvrZRasZQcYDfA98WphSOoYhkGNOtcZO0
         1jD4iwNTTwCt+uEiPyO9sggCeFVjRcd2tPna/4Bd8ebii7DZ7KDHKCJ3q0pxyI+V6S
         DHykulMbj5jmz53ln/5TUMLc0fpgYo62Am2lD1GXBWHs3fV6HXaYiLNPdrTW88NMbI
         dIYihvCDleLtA==
Date:   Fri, 18 Aug 2023 13:47:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <ZN9aSTUOT+SKESQS@vergenet.net>
References: <20230817114527.1585631-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817114527.1585631-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:15:22PM +0530, MD Danish Anwar wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.
> 
> This series also adds 10M full duplex support for ICSSG ethernet driver.
> 
> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
> is used for 10M full duplex support.
> 
> This is v5 of the series [v1]. It addresses comments made on [v4].
> This series is based on linux-next(#next-20230817).
> 
> Changes from v4 to v5:
> *) Added comments on why we are using readl / writel instead of regmap_read()
>    / write() in icss_iep_gettime() / settime() APIs as asked by Roger.
> 
> Change from v3 to v4:
> *) Changed compatible in iep dt bindings. Now each SoC has their own compatible
>    in the binding with "ti,am654-icss-iep" as a fallback as asked by Conor.
> *) Addressed Andew's comments and removed helper APIs icss_iep_readl() / 
>    writel(). Now the settime/gettime APIs directly use readl() / writel().
> *) Moved selecting TI_ICSS_IEP in Kconfig from patch 3 to patch 4.
> *) Removed forward declaration of icss_iep_of_match in patch 3.
> *) Replaced use of of_device_get_match_data() to device_get_match_data() in
>    patch 3.
> *) Removed of_match_ptr() from patch 3 as it is not needed.
> 
> Changes from v2 to v3:
> *) Addressed Roger's comment and moved IEP1 related changes in patch 5.
> *) Addressed Roger's comment and moved icss_iep.c / .h changes from patch 4
>    to patch 3.
> *) Added support for multiple timestamping in patch 4 as asked by Roger.
> *) Addressed Andrew's comment and added comment in case SPEED_10 in
>    icssg_config_ipg() API.
> *) Kept compatible as "ti,am654-icss-iep" for all TI K3 SoCs
> 
> Changes from v1 to v2:
> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>    Fixed it in this version.
> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>    comment in patch 1. 
> *) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
>    bindings for ICSSG.
> 
> [v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.com/
> [v2] https://lore.kernel.org/all/20230807110048.2611456-1-danishanwar@ti.com/
> [v3] https://lore.kernel.org/all/20230809114906.21866-1-danishanwar@ti.com/
> [v4] https://lore.kernel.org/all/20230814100847.3531480-1-danishanwar@ti.com/
> 
> Thanks and Regards,
> Md Danish Anwar
> 
> Grygorii Strashko (1):
>   net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
> 
> MD Danish Anwar (2):
>   dt-bindings: net: Add ICSS IEP
>   dt-bindings: net: Add IEP property in ICSSG DT binding
> 
> Roger Quadros (2):
>   net: ti: icss-iep: Add IEP driver
>   net: ti: icssg-prueth: add packet timestamping and ptp support

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

