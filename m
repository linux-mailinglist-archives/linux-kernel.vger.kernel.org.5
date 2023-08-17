Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892E877F171
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348588AbjHQHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348612AbjHQHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996E2D63;
        Thu, 17 Aug 2023 00:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8074563436;
        Thu, 17 Aug 2023 07:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD9DC433C8;
        Thu, 17 Aug 2023 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692258352;
        bh=onKG4UaSIXvx73FVELXuTURmfyjPZd62E2Ggu8RV0UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBSyYwRq4ukM+F0TADNzRB2xmIXTJcxJ0yaWvaf8nHHyv0HwA4WqV406TOksPFasq
         Pd0ZU1Q17HqL4fKlQb7bTcigZNc0/ETKGYy+XZdSQDvOCvBcbUDKijk/6GTZ3W2YnZ
         pnDR+tgWaUw1GfmhJIm6GR4PI35UPBWktbp3sRWx0h+dfBjebD/9cWISc9+VLe3Mda
         f//r5igfPaFWTfLj5pI9MJzGe6Byb1M0hl00nO5q9TYD6Vn+8YDpm+QdbbBm6ZBh87
         hJovxgM7gqMvD6YRICJvi0UOTmqoXffJF1Csfs/rTDfm+rN3yQ+Amou0x2gcEboU5w
         nc7PbHoWQHSUA==
Date:   Thu, 17 Aug 2023 09:45:47 +0200
From:   Simon Horman <horms@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <ZN3QKyHoUNoN9dx5@vergenet.net>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-5-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:52:19PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Ethernet MACs that can be connected externally
> to several physical devices. From an external interface perspective
> the BMC provides two SERDES interface connections capable of either
> SGMII or 1000Base-X operation. The BMC also provides a RMII interface
> for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

...

> diff --git a/drivers/net/ethernet/hpe/gxp-umac.c b/drivers/net/ethernet/hpe/gxp-umac.c

...

> +static int umac_init_mac_address(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct platform_device *pdev = umac->pdev;
> +	char addr[ETH_ALEN];
> +	int err;
> +
> +	err = of_get_mac_address(pdev->dev.of_node, addr);
> +	if (err)
> +		netdev_err(ndev, "Failed to get address from device-tree: %d\n",
> +			   err);
> +		return -EINVAL;

Hi Nick,

it looks like there should be some {} involved in the condition above,
else the function will return -EINVAL unconditionally.

Flagged by W=1 builds with clang-16 and gcc-13.

> +
> +	if (is_valid_ether_addr(addr)) {
> +		dev_addr_set(ndev, addr);
> +		netdev_dbg(ndev,
> +			   "Read MAC address %pM from DTB\n", ndev->dev_addr);
> +	} else {
> +		netdev_err(ndev, "Mac Address is Invalid");
> +		return -EINVAL;
> +	}
> +
> +	dev_addr_set(ndev, addr);
> +	umac_set_mac_address(ndev, addr);
> +
> +	return 0;
> +}

...
