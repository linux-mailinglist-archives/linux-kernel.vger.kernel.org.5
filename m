Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231567EC3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbjKONot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:44:48 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC499B;
        Wed, 15 Nov 2023 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gtHdcKH61L06S8styF2hP6URbouJS+Q9N5ufE6csYpc=; b=UREF5loC4B3svBkFjSgazmXSJT
        /F42CuDfxkaZK/c992Gr/Bba/NDRaILkogzJ/ZMDChRgKXPorQAa/cPg3+hYc4t05PwXF5B8P/jwJ
        OLEP0zmjF+jSQ6qtmnNFmmijON2TdoUKqR0AUZ7sCFQ3rPFTWwu+YXWtyNOlkagSbX+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3GBy-000F9b-1Y; Wed, 15 Nov 2023 14:44:30 +0100
Date:   Wed, 15 Nov 2023 14:44:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 1/9] net: mdio: ipq4019: increase eth_ldo_rdy for ipq5332
 platform
Message-ID: <c7ae6561-fbcc-40d9-a02c-61fc76e089d0@lunn.ch>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
> +		if (priv->eth_ldo_rdy[ret]) {
> +			val = readl(priv->eth_ldo_rdy[ret]);
> +			val |= BIT(0);
> +			writel(val, priv->eth_ldo_rdy[ret]);
> +			fsleep(IPQ_PHY_SET_DELAY_US);
> +		}

Please add a new variable, rather than use ret this way.

> +	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, ret + 1);
> +		if (res)
> +			priv->eth_ldo_rdy[ret] = devm_ioremap(&pdev->dev,

same here.

    Andrew

---
pw-bot: cr
