Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE477F329C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjKUPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:45:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43699;
        Tue, 21 Nov 2023 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t92OZKOw/jrPAQGH9Id5OLcQ57oFZcBBd4j/l0YdMEI=; b=zQcVP1tj2x+6QgwU5DhcqEIUQY
        buB/Vaulv/SCpMKjnIBt8ycB21gewTRNGaJirCKmo8W5ZByxhufVBsmGFcptOxIMiosfPQc9fzMVY
        u/btbit81Q8tJPUj1IFDpT1pt7YvkyELqTVNGQRt0lSGBoA42juDjYsO+mx4J6ExZrevfjoZbD4Li
        DTooEckGVI2tSQaSJATq6Z6LXxs4ELmvwPX3id6aKyZIXTLbg/DsHp5zp1hJ5/NSP8aFvrZY/ip/X
        Q2y/T1+duxQsEClo+Sz/zjTseQ1sMP/RsF3P+clz05QsscjBfFhFymXfje9SaWdu4vZYZbsAScJdL
        7juCgNPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59934)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5Sw6-0007Qc-0N;
        Tue, 21 Nov 2023 15:45:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5Sw3-0004In-UY; Tue, 21 Nov 2023 15:45:11 +0000
Date:   Tue, 21 Nov 2023 15:45:11 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <ZVzQh9ykusyknGgP@shell.armlinux.org.uk>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121151733.2015384-3-tmaimon77@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:17:33PM +0200, Tomer Maimon wrote:
> Add Nuvoton NPCM BMC SoCs support to STMMAC dwmac driver.
> 
> And modify MAINTAINERS to add a new F: entry for this driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

A few comments on this...

> +#define IND_AC_BA_REG		0x1FE
> +#define SR_MII_CTRL		0x3E0000
> +
> +#define PCS_SR_MII_CTRL_REG	0x0
> +#define PCS_SPEED_SELECT6	BIT(6)
> +#define PCS_AN_ENABLE		BIT(12)
> +#define PCS_SPEED_SELECT13	BIT(13)
> +#define PCS_RST			BIT(15)

include/uapi/linux/mii.h:

#define BMCR_SPEED1000          0x0040  /* MSB of Speed (1000)         */
#define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */
#define BMCR_SPEED100           0x2000  /* Select 100Mbps              */
#define BMCR_RESET              0x8000  /* Reset to default state      */

Look familiar? Maybe use the standard definitions for a standardised
register?

> +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> +			 struct plat_stmmacenet_data *plat_dat)
> +{
> +	u16 val;
> +
> +	iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> +	val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> +	val |= PCS_RST;
> +	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> +
> +	while (val & PCS_RST)
> +		val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);

What if the PCS never clears its reset bit? Maybe use
read_poll_timeout() ?

> +
> +	val &= ~(PCS_AN_ENABLE);
> +	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> +}

Also, maybe it's time to require new stmmac platform support to start
making use of the phylink PCS support rather than continuing to code its
own?

I notice, however, that you always disable inband signalling - please
explain why. Also, what protocol does the PCS use when communicating
with the PHY?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
