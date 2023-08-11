Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91110778C76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHKKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHKKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE71C3;
        Fri, 11 Aug 2023 03:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630AD6689A;
        Fri, 11 Aug 2023 10:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B1C433C7;
        Fri, 11 Aug 2023 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751264;
        bh=3HRZWARQB58DVgTE9n/uduYuv8xQ00R94c+DuYJr0pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uy0dVfEo2BhVIj3Y9tGMsDqntnAorj85qTgQE8rv3OdhqkvkCAWnuvzs6Plvaxl25
         KMa2V88aqxpG9lzZXpvaFTiFR0cIsizRZaEyjzruKRgTryjJFRo2qs3udCQWrUXKb4
         1T5H7W5dfVu+Idp9TZqcNb5xdup4HGG5ghNkC9tpAplwScoq2ToEFftEG8JjlKX43F
         AX+cWnNNwcZHo49uj2IW0X56dZ1STNKLY881+j7/J2dAq2qXBrcNg0YoYjShAAKxj8
         q6+Im67Sp2fUaPj1CefCJNI5k7v5iQR3Z3aQQmpL9ItBvPsLsW2Qg0KkMiBQSGUJ7t
         prjcWv8fnXWog==
Date:   Fri, 11 Aug 2023 12:54:19 +0200
From:   Simon Horman <horms@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        Gabor Juhos <j4g8y7@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce PSGMII PHY interface
 mode
Message-ID: <ZNYTWya4OM8pmcZf@vergenet.net>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
 <20230810102309.223183-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810102309.223183-2-robert.marko@sartura.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:22:55PM +0200, Robert Marko wrote:
> From: Gabor Juhos <j4g8y7@gmail.com>
> 
> The PSGMII interface is similar to QSGMII. The main difference
> is that the PSGMII interface combines five SGMII lines into a
> single link while in QSGMII only four lines are combined.
> 
> Similarly to the QSGMII, this interface mode might also needs
> special handling within the MAC driver.
> 
> It is commonly used by Qualcomm with their QCA807x PHY series and
> modern WiSoC-s.
> 
> Add definitions for the PHY layer to allow to express this type
> of connection between the MAC and PHY.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

...

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index ba08b0e60279..23756a10d40b 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -147,6 +147,7 @@ typedef enum {
>  	PHY_INTERFACE_MODE_XGMII,
>  	PHY_INTERFACE_MODE_XLGMII,
>  	PHY_INTERFACE_MODE_MOCA,
> +	PHY_INTERFACE_MODE_PSGMII,

Hi Gabor an Robert,

Please add PHY_INTERFACE_MODE_PSGMII to the kernel doc for phy_interface_t
which appears a little earlier in phy.h

>  	PHY_INTERFACE_MODE_QSGMII,
>  	PHY_INTERFACE_MODE_TRGMII,
>  	PHY_INTERFACE_MODE_100BASEX,

...
