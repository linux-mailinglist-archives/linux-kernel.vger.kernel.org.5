Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262F77A199
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHLSB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEB10F2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E06F61D3D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 18:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D0C433C7;
        Sat, 12 Aug 2023 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691863319;
        bh=GBhWyVgtciTxu71mVGx1KJ0cf/+uvCxSPNmjTOgpN3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsJK/IyCS2K4zDNZ6L2/bAbFrd9ZYTSQWFGu52dtnFB5cRhIIbKF8p4wez06vdTpo
         7bnycU9r2robfULVAJi6iojtEcTTo553Vzp7nyR03Gwix343tZraXZj3/4y3iPdqW0
         IW0B0/Q/RBR1TelIvSHkCngbZpkXbYGFxz5q1qaU0Cb7BYgKm0Il5FqoPt95NygNgq
         en6hqon/0STSUxvCNDG2dazg29Ui8AarZygNM82VQSbJfYhEWHhiODQTY95KRFJ33m
         8WTeQB10GBHoJG/+jA8GK8z3seVH1LtIa25w4T8IjoOztES24f31GtZ9C/aZvqLP4m
         c3y6CeTYNglJA==
Date:   Sat, 12 Aug 2023 20:01:54 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <ZNfJEj0jiTR0ZAbK@vergenet.net>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 06:32:47PM +0300, Radu Pirea (NXP OSS) wrote:
> Add MACsec support.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Hi Radu,

thanks for your patch-set.
Some minor feedback from my side.

...

> diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c

...

> +static int nxp_c45_tx_sc_set_flt(struct macsec_context *ctx,  int secy_id)
> +{
> +	u32 tx_flt_base = TX_FLT_BASE(secy_id);
> +	const u8 *dev_addr = ctx->secy->netdev->dev_addr;
> +	u32 mac_sa;

nit: Please use reverse xmas tree - longest line to shortest
     ordering for local variable declarations in Networking code.

     https://github.com/ecree-solarflare/xmastree is your friend here.

> +
> +	mac_sa = dev_addr[0] << 8 | dev_addr[1];
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_DA_SA(tx_flt_base),
> +			     mac_sa);
> +	mac_sa = dev_addr[5] | dev_addr[4] << 8 |
> +		dev_addr[3] << 16 | dev_addr[2] << 24;
> +
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_SA(tx_flt_base),
> +			     mac_sa);
> +	nxp_c45_macsec_write(ctx->phydev,
> +			     TX_SC_FLT_MAC_CFG(tx_flt_base),
> +			     TX_SC_FLT_BY_SA | TX_SC_FLT_EN |
> +			     secy_id);
> +
> +	return 0;
> +}
> +
> +static bool nxp_c45_port_valid(struct nxp_c45_secy *phy_secy, u16 port)
> +{
> +	if (phy_secy->secy->tx_sc.end_station && __be16_to_cpu(port) != 1)

The type of port is host byte order, but it is assumed to be big endian
by passing it to __be16_to_cpu(). Also, it's probably more efficient
to convert the constant (1).

There are a number of other Sparse warnings introduced by this patch.
Please take a look over them (and ideally fix them).

> +		return false;
> +
> +	return true;
> +}

...

> +static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_tx_sa *new_tx_sa, *old_tx_sa;

nit: reverse xmas tree

...
