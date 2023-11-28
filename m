Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179CE7FC247
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbjK1R0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjK1R0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:26:39 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC96E6;
        Tue, 28 Nov 2023 09:26:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5DAB60005;
        Tue, 28 Nov 2023 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701192404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bng8R5x/Jmq2SVxmDJwMSiwsK4vhqKDM3h6nqdBSV2s=;
        b=AKK5qcPcfM1hiW5bzr3BhkVuOFr724YPqPa74JpMexXiVIIJB8NpxTTx5iws+jqvFTmzKe
        spY8WrOUXoem/qgXMTVJ2910ttXabpuTGG70MuZp5z5dxN99O4e0PcyVI/8CNzzDK7J3J+
        f1Zgd3K6cWN3DTLrkCj/pNHcg7nRF4dfaeQNz016qiFh4vNszeVlCdrSOvDdlNoqgYpm+P
        PD2N/3MCCql4071pAIpf1BRkJqTYm5tzprPYWkJlAj48bvJt3/Ccm5L5qbSZHuUsIAO+QB
        6lOA9DMmFQYoQQaanpr3Z9ceucEwY881QiV9dW3Fe1r0jcmn2fr9WOQ1UX6MmA==
Date:   Tue, 28 Nov 2023 18:26:41 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20231128182641.7e2363c0@device.home>
In-Reply-To: <50d318fd-a82c-4756-a349-682b867c0b8b@lunn.ch>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
        <50d318fd-a82c-4756-a349-682b867c0b8b@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, 28 Nov 2023 17:37:30 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Nov 28, 2023 at 10:45:37AM +0100, Maxime Chevallier wrote:
> > The SGMII adapter isn't present on all dwmac-socfpga implementations.
> > Make sure we don't try to configure it if we don't have this adapter.  
> 
> If it does not exist, why even try to call socfpga_sgmii_config()?
> 
> It seems like this test needs moving up the call stack. socfpga_gen5_set_phy_mode():
> 
> 	if (phymode == PHY_INTERFACE_MODE_SGMII)
> 		if (dwmac->sgmii_adapter_base)
> 			socfpga_sgmii_config(dwmac, true);
> 		else
> 			return -EINVAL;

I don't have access to a platform with the SGMII adapter available, but
my understanding is that we shouldn't error-out when we don't have the
adapter, as some other component (like the lynx PCS) might be there to
handle that mode.

However you have a valid point in that we might want to check if we
have either an SGMII adapter or a PCS, and if we have none of these we
error-out. Thanks for the suggestion, I'll address that :)

Maxime
