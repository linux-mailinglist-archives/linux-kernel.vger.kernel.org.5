Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83BE780C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359635AbjHRMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359585AbjHRMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67B3A8D;
        Fri, 18 Aug 2023 05:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB1B673D6;
        Fri, 18 Aug 2023 12:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A0C433C8;
        Fri, 18 Aug 2023 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692362675;
        bh=FNb2SVuYvlLFocySdsYx+8V0njmhNeTW7yGsOfooywE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/drKLHCSyueU5bKmxxpqyI4simi9nIfnkAxFxjDnWAniy4/SW59YhZB9c7hxU8H2
         TF77VqXAL/qerdtEQP+r71icmKSmAdrntcWqtYyLWud7BzEm9Nr4OvcKJwYBT6qREv
         lwu9i3m4can4mSm42grJPlIlf2HDGUGpUDmIw4/72fylZVasltJm4Ka97d6YAW7yU+
         2+0wYTB+ddEtBwL479wUrr6OTx8nZcmBD20Gn/w2Y2C3ghYUfaA/7a38PNOGAN3RSy
         heAC5qwf0I4O2dsWL1ObTTWynLwnq75wWBq5V3Ms8JZX3IY1pauRmTDoK9QX0up7au
         52COAK2wvxoZA==
Message-ID: <5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org>
Date:   Fri, 18 Aug 2023 15:44:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 0/5] Introduce IEP driver and packet timestamping
 support
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230817114527.1585631-1-danishanwar@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230817114527.1585631-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 14:45, MD Danish Anwar wrote:
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
> 
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  61 ++
>  .../bindings/net/ti,icssg-prueth.yaml         |   7 +
>  drivers/net/ethernet/ti/Kconfig               |  12 +
>  drivers/net/ethernet/ti/Makefile              |   1 +
>  drivers/net/ethernet/ti/icssg/icss_iep.c      | 965 ++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |   7 +
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 451 +++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
>  10 files changed, 1586 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
> 

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>
