Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717C7FAEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjK1AUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjK1AUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:20:13 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178151B1;
        Mon, 27 Nov 2023 16:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3rCiSJ0JteV9fXbkXFk1duODECuXLFBCy7Ih056e2Wc=; b=hW0dZeRHACO/frHZ9YnX3eoLtx
        ZG4ktbt2J7QdboYO3eTqrtkBibe95L41acOPNsXyHMn18Tcb4nOT/FUxsSZ4TCrDrEGGdm3h96IKk
        dUWHSEb2dcLSLRLxSlaIuQDe25Ra/l8MSE+VbSNVoGi8Q3oHYvX4dFWWcxVE1XmvLONU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7lpj-001OoV-D5; Tue, 28 Nov 2023 01:20:11 +0100
Date:   Tue, 28 Nov 2023 01:20:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
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
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 0/8] net: phy: Support DT PHY package
Message-ID: <a29b1106-87a6-4ea2-bb1d-9858f9ab425b@lunn.ch>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126015346.25208-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 02:53:38AM +0100, Christian Marangi wrote:
> This depends on another series for PHY package API change. [1]
> 
> Idea of this big series is to introduce the concept of PHY package in DT
> and generalize the support of it by PHY driver.
> 
> The concept of PHY package is nothing new and is already a thing in the
> kernel with the API phy_package_join/leave/read/write.
> 
> The main idea of those API is to permit the PHY to have a shared global
> data and to run probe/config only once for the PHY package. There are
> various example of this already in the kernel with the mscc, bcm54140
> mediatek ge and micrle driver and they all follow the same pattern.
> 
> What is currently lacking is describing this in DT and better reference
> the PHY in charge of global configuration of the PHY package. For the
> already present PHY, the implementation is simple enough with only one
> PHY having the required regs to apply global configuration.
> 
> This can be ok for simple PHY package but some Qcom PHY package on
> ""modern"" SoC have more complex implementation. One example is the PHY
> for qca807x where some global regs are present in the so-called "combo"
> port and everything about psgmii calibration is placed in a 5th port in
> the PHY package.
> 
> Given these additional thing, the original phy_package API are extended
> with support for multiple global PHY for configuration. Each PHY driver
> will have an enum of the ID for the global PHY to reference and is
> required to pass to the read/write function.

Please update the text. As far as i see, a lot of this is not relevant
for this patch set. phy_package_join() etc has no relation to DT,
since the driver knows how many devices are in its package, it knows
its base address, etc.

The DT is only about properties which are shared by all PHYs within
the package, e.g reset, regulators, maybe the MODE_CFG register for
this particular PHY package.

> 
> On top of this, it's added correct DT support for describing PHY
> package.
> 
> One example is this:
> 
>         ethernet-phy-package@0 {
>             compatible = "ethernet-phy-package";

This needs a compatible for this particular PHY package.

>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             reg = <0>;
>             qcom,package-mode = "qsgmii";

This property it not useful. Why PCA does it apply to, when there are
two? It makes much more sense to describe the overall configuration
mode, from which you can derive what interface mode each port should
be using, and thus validate the phy-mode in DT.

   Andrew
