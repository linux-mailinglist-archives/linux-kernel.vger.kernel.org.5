Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC447FC25C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbjK1Qhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK1Qhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:37:33 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16183D51;
        Tue, 28 Nov 2023 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rFUp8aL5AaK6GjDSBIX/cd7crb+WCO19wYlvW6clkBE=; b=ohfKZwKNKJ4S2OyweVT6DzxqDw
        J8E8HPPRFTOGE+wwx7vHBjhIlLoEmeGXtfXhSGW5YiDO8+mjVG5ix3NBrEGxbJ4v9otJy3095sWPU
        JFPFcfvjO9VqMaJeh3fyJPw4EVBtxnfoa/fovwnz1+uwH5aZruCTruSH5NdAbfl1oG2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r815W-001TUQ-TO; Tue, 28 Nov 2023 17:37:30 +0100
Date:   Tue, 28 Nov 2023 17:37:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        alexis.lothore@bootlin.com
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII
 adapter when not available
Message-ID: <50d318fd-a82c-4756-a349-682b867c0b8b@lunn.ch>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:45:37AM +0100, Maxime Chevallier wrote:
> The SGMII adapter isn't present on all dwmac-socfpga implementations.
> Make sure we don't try to configure it if we don't have this adapter.

If it does not exist, why even try to call socfpga_sgmii_config()?

It seems like this test needs moving up the call stack. socfpga_gen5_set_phy_mode():

	if (phymode == PHY_INTERFACE_MODE_SGMII)
		if (dwmac->sgmii_adapter_base)
			socfpga_sgmii_config(dwmac, true);
		else
			return -EINVAL;
			
Same in socfpga_gen10_set_phy_mode()?

     Andrew
