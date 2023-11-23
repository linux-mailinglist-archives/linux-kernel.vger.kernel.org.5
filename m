Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1E7F66DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjKWTEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:04:28 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC719D;
        Thu, 23 Nov 2023 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/SDYqZIXsdOyj0vjbWI2ClkLE18Ka/bdOsdj54i7Dpw=; b=k73At0T74i/QGx6XSEriGiSqoX
        CilR8xNuoSc2MzKB3RIYMR10jhHrPgI7P72TWzf6UC+JcW1g798XIbibFF9pmGYzY4dEp7FAdsllE
        ruQfBOaBDtPtrqQRf7xn1+mCuZrwuHPbqPo5mxFkSBQ8poR9wzcOtGWJ97qwxsCDI6lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6Ezp-0011Zk-3s; Thu, 23 Nov 2023 20:04:17 +0100
Date:   Thu, 23 Nov 2023 20:04:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC WIP 0/2] net: stmmac: dwmac-rk: add support for PHY
 wake on LAN
Message-ID: <f023fbf0-3669-4617-bb60-77fde3255dc0@lunn.ch>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Setting the USE_PHY_WOL flag configures the PHY as expected (its driver
> writes the MAC address and the interrupt configuration into the PHY
> registers) and an interrupt is generated with every magic packet,
> but only during normal operation i.e. there is no interrupt generation
> in suspend-to-RAM.

Do you have a logic analyser connected? Can you see if the PHY is
toggling its output pin? We then know if its a PHY problem, or a SoC
problem.

> A (probably naive) wakeup-source property in the dt node does not help.
> So now I am trying to find out why the PHY does not react in suspend and
> why its interrupt is ignored in freeze mode, but I might be overlooking
> some other important point to consider.

What is the clock setup? Sometimes the MAC gives a clock to the
PHY. Sometimes the PHY gives a lock to the MAC. If its MAC->PHY, and
this clock is getting turned off, that might cause a problem.

     Andrew
