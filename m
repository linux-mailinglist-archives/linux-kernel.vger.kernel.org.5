Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8AD7F3308
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjKUQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjKUQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:01:28 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704E139;
        Tue, 21 Nov 2023 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aZVSbYQtEsrPqaqCsxCo31rNgSiygRJ3cLDc3knYFXU=; b=bl/aQJrfTUHDANhv3Dm5Ml7ZlX
        okOdikl4AvtMqEPCYzdztmNsTVsVk54SMW+rRWhtfEdvZIL45Bq24Hiq59b/Sdqw/RhiBP96bZzgr
        A4kORTZ2Boqv7A76JCAy1UhWdqd0PYSbFYBy8O1c0KYzzbRX6IJRtyCjZZPIY4IshspA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5TBF-000m1v-SN; Tue, 21 Nov 2023 17:00:53 +0100
Date:   Tue, 21 Nov 2023 17:00:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121151733.2015384-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> +
> +	val &= ~(PCS_AN_ENABLE);
> +	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> +}

Is this a licensed PCS implementation? Or home grown? If its been
licensed from somebody, it maybe should live in driver/net/pcs, so
others can reuse it when they license the same core.

       Andrew
