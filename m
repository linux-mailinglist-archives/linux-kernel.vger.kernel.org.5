Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B987887D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbjHYMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244904AbjHYMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:53:23 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8FD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:53:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-Y7NVsyhmP-6lIszpvB8fGQ-1; Fri, 25 Aug 2023 08:53:01 -0400
X-MC-Unique: Y7NVsyhmP-6lIszpvB8fGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0A971C0693A;
        Fri, 25 Aug 2023 12:53:00 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E46840C6F4C;
        Fri, 25 Aug 2023 12:52:58 +0000 (UTC)
Date:   Fri, 25 Aug 2023 14:52:57 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <ZOikKUjRvces_vVj@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Some of the questions I'm asking are probably dumb since I don't know
anything about phy drivers. Sorry if that's the case.]

General code organization nit: I think it would be easier to review
the code if helpers functions were grouped by the type of object they
work on. All the RXSA-related functions together, all the TXSA
functions together, same for RXSC and then TXSC/SecY. Right now I see
some RXSA functions in a group of TXSA functions, another in the
middle of a group of RXSC functions. It makes navigating through the
code a bit less convenient.

Another nit: for consistency, it would be nice to stick to either
"tx_sa" or "txsa" (same for rxsa and rxsc) in function names.

2023-08-24, 12:16:13 +0300, Radu Pirea (NXP OSS) wrote:
> +static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
> +{
> +	WARN_ON_ONCE(reg % 4);
> +
> +	reg = reg / 2;
> +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +		      VEND1_MACSEC_BASE + reg, val);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +		      VEND1_MACSEC_BASE + reg + 1, val >> 16);

Can these calls fail? ie, do you need to handle errors like in
nxp_c45_macsec_read (and then in callers of nxp_c45_macsec_write)?

I see that no caller of nxp_c45_macsec_read actually checks the return
value, so maybe those errors don't matter.


[...]
> +void nxp_c45_macsec_config_init(struct phy_device *phydev)
> +{
> +	if (!phydev->macsec_ops)
> +		return;
> +
> +	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
> +			 MACSEC_EN | ADAPTER_EN);

The calls to phy_set_bits_mmd() in nxp_c45_config_intr() have error
handling. Does this need error handling as well?

[...]
> +static bool nxp_c45_port_valid(struct nxp_c45_secy *phy_secy, u16 port)
> +{
> +	if (phy_secy->secy->tx_sc.end_station &&
> +	    __be16_to_cpu((__force __be16)port) != 1)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
> +				struct macsec_rx_sc *rx_sc)
> +{
> +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);

u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
u16 port = (u16)sci;

And then drop the __be16_to_cpu conversion from nxp_c45_port_valid

> +
> +	if (phy_secy->point_to_point && phy_secy->secy_id != 0)
> +		return false;
> +
> +	return nxp_c45_port_valid(phy_secy, port);
> +}
> +
> +static bool nxp_c45_secy_cfg_valid(struct nxp_c45_secy *phy_secy, bool can_ptp)
> +{
> +	u16 port =  (__force u64)phy_secy->secy->sci >> (ETH_ALEN * 8);

u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
u16 port = (u16)sci;

> +	if (phy_secy->secy->tx_sc.scb)
> +		return false;

[...]
> +static int nxp_c45_update_tx_sc_secy_cfg(struct phy_device *phydev,
> +					 struct nxp_c45_secy *phy_secy)
> +{
[...]
> +	phydev_dbg(phydev, "scb %s\n",
> +		   phy_secy->secy->tx_sc.scb ? "on" : "off");
> +	if (phy_secy->secy->tx_sc.scb)
> +		cfg |= MACSEC_TXSC_CFG_SCI;
> +	else
> +		cfg &= ~MACSEC_TXSC_CFG_SCI;

Should that be called MACSEC_TXSC_CFG_SCB? I had to check that it
wasn't using the wrong constant, using "SCI" for "SCB" (when SCI is
already a well-defined thing in macsec) confused me.

> +
> +	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
> +
> +	return 0;
> +}
> +
[...]
> +static int nxp_c45_set_rxsa_key(struct macsec_context *ctx, bool key_a)
> +{
> +	u32 *salt = (u32 *)ctx->sa.rx_sa->key.salt.bytes;
> +	const struct nxp_c45_macsec_sa_regs *sa_regs;
> +	u32 ssci = (__force u32)ctx->sa.rx_sa->ssci;
> +	u32 key_size = ctx->secy->key_len / 4;
> +	u32 salt_size = MACSEC_SALT_LEN / 4;
> +	u32 *key = (u32 *)ctx->sa.key;
> +	u32 reg;
> +	int i;
> +
> +	sa_regs = nxp_c45_get_macsec_sa_regs(key_a);
> +
> +	for (i = 0; i < key_size; i++) {
> +		reg = sa_regs->rxsa_ka + i * 4;
> +		nxp_c45_macsec_write(ctx->phydev, reg,
> +				     (__force u32)cpu_to_be32(key[i]));
> +	}
> +
> +	if (ctx->secy->xpn) {
> +		for (i = 0; i < salt_size; i++) {
> +			reg = sa_regs->rxsa_salt + (2 - i) * 4;
> +			nxp_c45_macsec_write(ctx->phydev, reg,
> +					     (__force u32)cpu_to_be32(salt[i]));
> +		}
> +		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_ssci,
> +				     (__force u32)cpu_to_be32(ssci));
> +	}

This looks basically identical to nxp_c45_txsa_set_key except for the
registers it writes to. It could be turned into 2 or 3 small helpers
(one for the key, then salt and ssci).

> +
> +	nxp_c45_set_rxsa_key_cfg(ctx, key_a, false);
> +
> +	return 0;
> +}

[...]
> +static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	u64 sci = (__force u64)ctx->secy->sci;
> +	struct nxp_c45_secy *phy_secy;
> +	bool can_ptp;
> +	int idx;
> +	u32 reg;
> +
> +	phydev_dbg(ctx->phydev, "add secy SCI %llu\n", ctx->secy->sci);

nit: %016llx feels more natural for SCIs since they can be broken down
into address+port.

And since it's stored in network byte order, you'll want to convert it
via be64_to_cpu before you print it out.

I'd suggest doing that directly into the sci variable:

    u64 sci = be64_to_cpu((__force __be64)ctx->secy->sci);

and then adapt the uses of sci further down.

Feel free to move the sci_to_cpu function from
drivers/net/netdevsim/macsec.c to include/net/macsec.h and reuse it.


[...]
> +static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
> +{
[...]
> +	if (phy_secy->enabled_an != ctx->secy->tx_sc.encoding_sa) {
> +		old_tx_sa = phy_secy->tx_sa[phy_secy->enabled_an];
> +		phy_secy->enabled_an = ctx->secy->tx_sc.encoding_sa;
> +		new_tx_sa = phy_secy->tx_sa[phy_secy->enabled_an];
> +		if (!new_tx_sa) {
> +			nxp_c45_tx_sa_disable(phydev, phy_secy);
> +			goto disable_old_tx_sa;
> +		}
> +
> +		if (!new_tx_sa->tx_sa->active) {
> +			nxp_c45_tx_sa_disable(phydev, phy_secy);
> +			goto disable_old_tx_sa;
> +		}

You can combine those two conditions into

		if (!new_tx_sa || !new_tx_sa->tx_sa->active) {
			nxp_c45_tx_sa_disable(phydev, phy_secy);
			goto disable_old_tx_sa;
		}

> +
> +		new_tx_sa->is_key_a = phy_secy->tx_sa_key_a;
> +		phy_secy->tx_sa_key_a = phy_secy->tx_sa_key_a;

Is this missing a ! on the right side?

Maybe worth creating a "next_sa_key_id" helper (or something like
that) that returns the current value and updates tx_sa_key_a, since
you use this pattern a few times.


[...]
> +static int nxp_c45_mdo_add_rxsc(struct macsec_context *ctx)
> +{
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +	struct nxp_c45_rx_sc *rx_sc;
> +
> +	phydev_dbg(phydev, "add RX SC %s\n",
> +		   ctx->rx_sc->active ? "enabled" : "disabled");

If the HW/driver supports multiple TXSC/RXSC on the same device, it
would probably be helpful to add their SCIs to this debug message (and
the update/delete ones, also for the mdo_*_rxsa and mdo_*_txsa
functions).

[...]
> +static int nxp_c45_mdo_add_rxsa(struct macsec_context *ctx)
> +{
[...]
> +	if (!rx_sc->rx_sa_b) {
> +		phydev_dbg(phydev, "add RX SA B %u %s\n",
> +			   an, rx_sa->active ? "enabled" : "disabled");
> +		nxp_c45_set_rxsa_key(ctx, false);
> +		rx_sc->rx_sa_b = rx_sa;
> +		return 0;
> +	}
> +
> +	return -ENOMEM;

maybe -ENOSPC would fit better?

> +}
> +

[...]
> +static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
> +{
[...]
> +	if (phy_secy->tx_sa[sa])
> +		return -EBUSY;
> +
> +	tx_sa = kzalloc(sizeof(*tx_sa), GFP_KERNEL);

missing NULL check

[...]
> +static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
> +{
[...]
> +
> +	phy_secy->tx_sa[sa] = NULL;
> +	kfree(tx_sa);

tx_sa contains the key, so this needs to be kfree_sensitive, or add a
memzero_explicit(tx_sa->key) before freeing. Or if possible, don't
copy the key at all into tx_sa.

similar changes in the mscc driver:
1b16b3fdf675 ("net: phy: mscc: macsec: clear encryption keys when freeing a flow")
0dc33c65835d ("net: phy: mscc: macsec: do not copy encryption keys")


[...]
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 7ab080ff02df..5bf7caa4e63d 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
[...]
> @@ -1218,12 +1201,25 @@ static int nxp_c45_start_op(struct phy_device *phydev)
>  
>  static int nxp_c45_config_intr(struct phy_device *phydev)
>  {
> -	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +	int ret;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> +				       VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
> +		if (ret)
> +			return ret;
> +
>  		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
>  					VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);

Maybe a dumb question: should we be clearing the MACSEC_IRQS bits when
this 2nd call to phy_set_bits_mmd fails? (and same below, reset when
the 2nd clear fails)


> -	else
> -		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
> -					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
> +	}
> +
> +	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
> +				 VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
> +	if (ret)
> +		return ret;
> +
> +	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
> +				  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
>  }

[...]
> @@ -1666,6 +1666,20 @@ static int nxp_c45_probe(struct phy_device *phydev)
>  	}
>  
>  no_ptp_support:
> +	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
> +	if (!macsec_ability) {
> +		phydev_info(phydev, "the phy does not support MACsec\n");
> +		goto no_macsec_support;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MACSEC)) {
> +		ret = nxp_c45_macsec_probe(phydev);

I don't know how this probing is handled so maybe another dumb
question: if that fails, are we going to leak resources allocated
earlier?  (devm_kzalloc for example)

> +		phydev_dbg(phydev, "MACsec support enabled.");
> +	} else {
> +		phydev_dbg(phydev, "MACsec support not enabled even if the phy supports it");
> +	}
> +
> +no_macsec_support:
>  
>  	return ret;
>  }

-- 
Sabrina

