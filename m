Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B47E0F23
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjKDLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:35:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FDD49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:35:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD4FC433C8;
        Sat,  4 Nov 2023 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699097727;
        bh=eQe1wFKxq3ZqObZy6vRwp3gsb3y+Y6bu7pHdSAo8SKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F81P/3b6o/poheCB9O8X8dq9m/r4k6OKV33/JSc/hoIHLNId4FeYJIoIR/O/bghTJ
         wdaguamX+dW5SZynhF9CZ3yH9joJNEXznIAi1ep7EnYx2i++yLG9f1XeDOIecntp3E
         lqhtLpiJE1US6hx5ejpi1bgxWEdFFvPL/b4T98kpkn1cw2MSlT+a4GEDv0aM8mJ09Z
         Bn2IT7V4BEYdTjI9mG6aPn5MzrHdVbHgIxW5w4mcG9O8FVnR/PvhUeMCDSdgFj21To
         z1X9qs/8So1bYiyJ0r4NMKWz7sPNotpu70PvlwrBv49HsTHWQiVc1agxswAUpLO5MC
         LpjCqZahpUGLg==
Date:   Sat, 4 Nov 2023 11:35:06 +0000
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <20231104113506.GA891380@kernel.org>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
 <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:43:25PM +0300, Radu Pirea (NXP OSS) wrote:
> Add MACsec support.
> The MACsec block has four TX SCs and four RX SCs. The driver supports up
> to four SecY. Each SecY with one TX SC and one RX SC.
> The RX SCs can have two keys, key A and key B, written in hardware and
> enabled at the same time.
> The TX SCs can have two keys written in hardware, but only one can be
> active at a given time.
> On TX, the SC is selected using the MAC source address. Due of this
> selection mechanism, each offloaded netdev must have a unique MAC
> address.
> On RX, the SC is selected by SCI(found in SecTAG or calculated using MAC
> SA), or using RX SC 0 as implicit.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

...

> +void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
> +				     irqreturn_t *ret)
> +{
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *pos, *tmp;
> +	struct nxp_c45_sa *sa;
> +	u8 encoding_sa;
> +	int secy_id;
> +	u32 reg = 0;
> +
> +	if (!priv->macsec)
> +		return;
> +
> +	do {
> +		nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
> +		if (!reg)
> +			return;
> +
> +		secy_id = MACSEC_REG_SIZE - ffs(reg);
> +		list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list,
> +					 list)
> +			if (pos->secy_id == secy_id)
> +				break;
> +
> +		encoding_sa = pos->secy->tx_sc.encoding_sa;

Hi Radu,

I'm unsure if this can happen, but my understanding is that if
priv->macsec->secy_list is empty then pos will be uninitialised here.

Flagged by Coccinelle.

> +		phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
> +			   pos->secy_id, encoding_sa);
> +
> +		sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
> +		if (!IS_ERR(sa))
> +			macsec_pn_wrapped(pos->secy, sa->sa);
> +		else
> +			WARN_ON(1);
> +
> +		nxp_c45_macsec_write(phydev, MACSEC_EVR,
> +				     TX_SC_BIT(pos->secy_id));
> +		*ret = IRQ_HANDLED;
> +	} while (reg);
> +}

...
