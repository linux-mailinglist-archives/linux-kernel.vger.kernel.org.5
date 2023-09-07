Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10613797780
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjIGQ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjIGQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95357AA4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA035C4AF78;
        Thu,  7 Sep 2023 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694098863;
        bh=jMRaB1zToyVwAnrRSqUPWODNdMLHdXs6mibSqgmFpbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s05r2K0QrK0edOGzCiGfwbFtY1VtHeYVcRkwk4JV665nIVdPCOIOshegPBP1dFcTp
         fRQ6mXkeX88q4dkSbESsgjnUwHWPRJDFQ9t0tsd/2NuYV6kkGy/m0bnk8F/OCv4Q/3
         /V26QVRLpyLP/Eu/LnnhQ304L+U9IfimH0dTbxmaqVS0TywOBewNPPe9Y27wP0W1e7
         +DnfRWrBEhmqXr5Rx4+fXLtF2/f5Yc1UMJhav/1sCQ6NgXXG0egTQEXsD6aoE7iDH8
         sbAScY+yeWpmG4ov6b/1dimV0dKNqy/ZHUCeW3ErJtY0DBtvq5IF1R6xHD5sNeKXdi
         4g+RXzYnMwTzA==
Date:   Thu, 7 Sep 2023 17:00:58 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 4/6] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <20230907150058.GD434333@kernel.org>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:01:32PM +0300, Radu Pirea (NXP OSS) wrote:
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

> +static struct nxp_c45_sa *nxp_c45_find_sa(struct list_head *sa_list,
> +					  enum nxp_c45_sa_type sa_type, u8 an)
> +{
> +	struct nxp_c45_sa *pos, *tmp;
> +
> +	list_for_each_entry_safe(pos, tmp, sa_list, list)
> +		if (pos->an == an && pos->type == sa_type)
> +			return pos;
> +
> +	return ERR_PTR(-EINVAL);
> +}

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
> +	if (!phydev->macsec_ops)
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
> +		phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
> +			   pos->secy_id, encoding_sa);
> +
> +		sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
> +		if (!IS_ERR(sa))
> +			macsec_pn_wrapped(pos->secy, sa->sa);
> +		else
> +			WARN_ON(!sa);

Hi Radu,

Smatch doesn't seem to think that sa can be NULL: it is either a valid
pointer or an error pointer.

> +
> +		nxp_c45_macsec_write(phydev, MACSEC_EVR,
> +				     TX_SC_BIT(pos->secy_id));
> +		*ret = IRQ_HANDLED;
> +	} while (reg);
> +}

...
