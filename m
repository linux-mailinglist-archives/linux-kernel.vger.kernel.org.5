Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345F776E71A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjHCLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjHCLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6726AB;
        Thu,  3 Aug 2023 04:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4486E61D59;
        Thu,  3 Aug 2023 11:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA2C433C8;
        Thu,  3 Aug 2023 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062770;
        bh=+K+JAySmTUowlnbVqwziUzl1bReyozbO+guU69SBB34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlYDs6lFk2yG8HjpZ+tB0KD7LsTCBbRdO5X913YeGZAw29/Ll4XDRdKd67yEHeySo
         2iri4L99AmVgfL9ksUqXWmReepqQcmD3efTrPAVK/iEXrniQkNPfxrt8jmPRyXo+jd
         ApetWp+/RnZD7U7n//UNQVeg9V2L+z1+rviLwKM2ZtsVf+sxrOvnHm++AhN5T+rcN3
         uSOBcnV+Z2LNeowhLurCC/yahz0xh+UAYL09oK54M3pL18q5g9REQOoWowm/hBd0gX
         TedKkdEzQhjtS6pTsxvdrkPlFxSKakZe3XywqEuXi89KCN409oFgliIa/AFqzHozpw
         NwpP8487pzJMg==
Date:   Thu, 3 Aug 2023 13:39:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <ZMuR7XKm9Jelh0Sq@kernel.org>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:18:21PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Universal Ethernet MACs that can be
> connected externally to several physical devices. From an external
> interface perspective the BMC provides two SERDES interface connections
> capable of either SGMII or 1000Base-X operation. The BMC also provides
> a RMII interface for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration. The MDIO(mdio1) interface from
> the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
> on the two SERDES interface connections.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

...

> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 5a274b99f299..b4921b84be51 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -80,6 +80,7 @@ source "drivers/net/ethernet/fujitsu/Kconfig"
>  source "drivers/net/ethernet/fungible/Kconfig"
>  source "drivers/net/ethernet/google/Kconfig"
>  source "drivers/net/ethernet/hisilicon/Kconfig"
> +source "drivers/net/ethernet/hpe/Kconfig"
>  source "drivers/net/ethernet/huawei/Kconfig"
>  source "drivers/net/ethernet/i825xx/Kconfig"
>  source "drivers/net/ethernet/ibm/Kconfig"

Hi Nick,

I think this hunk belongs in [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver.
As it is that patch where drivers/net/ethernet/hpe/Kconfig is added.
And as things stands, the above caused a build failure.
