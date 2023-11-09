Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5D07E6E73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjKIQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjKIQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:17:43 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90A173E;
        Thu,  9 Nov 2023 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Fupq4hlBImNT9/E31GMXTqKPrNZBcdihgav2GAlB7G8=; b=pgYZcUNj/ZO5UbgTJtXr7RxPoO
        BMmVH8QE5aDmVxhnV1ZHCpAhjNOhRHwZ8DNEXXWgLo8MK1ua74OAIc8zUp5ZB39GJxJ+BmVwoDycc
        K4UMhtqo59MrESwBIxEBXwH3Ukk/d4nwZPyOVodGtMhFSQ4ZV+8FDDiB2q5WzemblC9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r17iU-001DWW-A6; Thu, 09 Nov 2023 17:17:14 +0100
Date:   Thu, 9 Nov 2023 17:17:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Halaney <ahalaney@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Johannes Zink <j.zink@pengutronix.de>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: Add support for HW-accelerated
 VLAN stripping
Message-ID: <b7bd1b0c-5203-4071-95c6-ada047010687@lunn.ch>
References: <20231109053831.2572699-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109053831.2572699-1-yi.fang.gan@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -198,6 +198,17 @@ static int dwmac4_get_tx_ls(struct dma_desc *p)
>  		>> TDES3_LAST_DESCRIPTOR_SHIFT;
>  }
>  
> +static inline int dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
> +}
> +
> +static inline bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p)
> +{
> +	return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
> +		(le32_to_cpu(p->des3) & RDES3_RDES0_VALID));
> +}

No inline functions in C files please. Let the compiler decide.

You are submitting a number of patches for this driver. Do they all
cleanly apply independent of each other? Or are there dependencies?

	Andrew
