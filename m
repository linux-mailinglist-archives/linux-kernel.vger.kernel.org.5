Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCC7D3CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjJWQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJWQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:40:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B993;
        Mon, 23 Oct 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2Qgu3sV7JqSs1+xqVkj3Q4GC+iKi/Wf5NSoQxrtF3ew=; b=V/xOy/CXT9JTBGtsL7Y3xvmZwV
        rnjrtnpa5D22ISWgGO9NXgw8FxE1TOh+Ky7E5bQuEIBPVohIRtEarYFHeqnEvmA8GPV33pt+97QuE
        qNoxRycGKX+H0q2vf7UImSz8VoL2M2kkyftM18WG2htwIMUd1lNv1JzSTbHPyZMJga6Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1quxyl-0032zT-EI; Mon, 23 Oct 2023 18:40:35 +0200
Date:   Mon, 23 Oct 2023 18:40:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 2/5] net: dsa: qca: Make the QCA8K hardware
 library available globally
Message-ID: <3f279720-5386-4ea2-b54c-ffc44277b1cc@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-3-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023155013.512999-3-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -62,21 +61,37 @@ const struct qca8k_mib_desc ar8327_mib[] = {
>  	MIB_DESC(1, 0xa8, "RXUnicast"),
>  	MIB_DESC(1, 0xac, "TXUnicast"),
>  };
> +EXPORT_SYMBOL(ar8327_mib);

Christian should decide, since he wrote most of this code, but i would
prefer EXPORT_SYMBOL_GPL().

> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/include/linux/dsa/qca8k.h
> @@ -13,6 +13,7 @@
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/dsa/tag_qca.h>
> +#include <net/dsa.h>
>  
>  #define QCA8K_ETHERNET_MDIO_PRIORITY			7
>  #define QCA8K_ETHERNET_PHY_PRIORITY			6
> @@ -265,6 +266,7 @@
>  #define   QCA8K_PORT_LOOKUP_STATE_LEARNING		QCA8K_PORT_LOOKUP_STATE(0x3)
>  #define   QCA8K_PORT_LOOKUP_STATE_FORWARD		QCA8K_PORT_LOOKUP_STATE(0x4)
>  #define   QCA8K_PORT_LOOKUP_LEARN			BIT(20)
> +#define   QCA8K_PORT_LOOKUP_LOOPBACK_EN			BIT(21)

Maybe do the move first, and then add new features in another patch?

      Andrew
