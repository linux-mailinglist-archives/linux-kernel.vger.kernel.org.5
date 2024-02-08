Return-Path: <linux-kernel+bounces-58344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA784E4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F259F28EBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4C7EF09;
	Thu,  8 Feb 2024 16:22:49 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E27E59F;
	Thu,  8 Feb 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409369; cv=none; b=NaUMK85qnUK62ESXVTjo7+wOMakWPpjS4sKznXmOQ8NN36JAPFmLHrIpiGEcv1l447Kv7AkwO2I7Uc4o+lYHOMNUtUdas1Q19mGDi/AEDtBu2jeJcDFxaKXPfiS9z9s5v6Jcwu2OU3DNzOkOp0Ca10F9Nc3NKd2VvHaVfQwBb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409369; c=relaxed/simple;
	bh=MBrKiKWR78aRQohSnwR71yciqdbXWCE/pYxZWoLdR1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KccLj+Le0SxzuOuy/WWuLfLWmK6w01yZozEQgZ4GWwDGQ23Z7xPKlEIA7UUdNpHWtzw2pQiylCfC+Qooj95PQ4edehvrNevVR9WFMitWswzZ8Si0hu1aiwqvmjZoOhY0s517dWuSWCx16GSdKNUTV7Dl5kCmweyCg/bpg5kDE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rY7AH-0004wG-0D;
	Thu, 08 Feb 2024 16:22:17 +0000
Date: Thu, 8 Feb 2024 16:22:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH netnext 8/8] net: dsa: mt7530: simplify link operations
 and force link down on all ports
Message-ID: <ZcT_r68mStRAC3Uk@makrotopia.org>
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
 <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>

On Thu, Feb 08, 2024 at 08:51:36AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, the link operations for switch MACs are scattered across
> port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
> phylink_mac_link_down.
> 
> port_enable and port_disable clears the link settings. Move that to
> mt7530_setup() and mt7531_setup_common() which set up the switches. This
> way, the link settings are cleared on all ports at setup, and then only
> once with phylink_mac_link_down() when a link goes down.
> 
> Enable force mode at setup to apply the force part of the link settings.
> This ensures that only active ports will have their link up.
> 
> Now that the bit for setting the port on force mode is done on
> mt7530_setup() and mt7531_setup_common(), get rid of PMCR_FORCE_MODE_ID()
> which helped determine which bit to use for the switch model.
> 
> The "MT7621 Giga Switch Programming Guide v0.3", "MT7531 Reference Manual
> for Development Board v1.0", and "MT7988A Wi-Fi 7 Generation Router
> Platform: Datasheet (Open Version) v0.1" documents show that these bits are
> enabled at reset:
> 
> PMCR_IFG_XMIT(1) (not part of PMCR_LINK_SETTINGS_MASK)
> PMCR_MAC_MODE (not part of PMCR_LINK_SETTINGS_MASK)
> PMCR_TX_EN
> PMCR_RX_EN
> PMCR_BACKOFF_EN (not part of PMCR_LINK_SETTINGS_MASK)
> PMCR_BACKPR_EN (not part of PMCR_LINK_SETTINGS_MASK)
> PMCR_TX_FC_EN
> PMCR_RX_FC_EN
> 
> These bits also don't exist on the MT7530_PMCR_P(6) register of the switch
> on the MT7988 SoC:
> 
> PMCR_IFG_XMIT()
> PMCR_MAC_MODE
> PMCR_BACKOFF_EN
> PMCR_BACKPR_EN
> 
> Remove the setting of the bits not part of PMCR_LINK_SETTINGS_MASK on
> phylink_mac_config as they're already set.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 26 +++++++++++++-------------
>  drivers/net/dsa/mt7530.h |  2 --
>  2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 5c8ad41ce8cd..f67db577d1c0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1018,7 +1018,6 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
>  	priv->ports[port].enable = true;
>  	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
>  		   priv->ports[port].pm);
> -	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
>  
>  	mutex_unlock(&priv->reg_mutex);
>  
> @@ -1038,7 +1037,6 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
>  	priv->ports[port].enable = false;
>  	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
>  		   PCR_MATRIX_CLR);
> -	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
>  
>  	mutex_unlock(&priv->reg_mutex);
>  }
> @@ -2257,6 +2255,12 @@ mt7530_setup(struct dsa_switch *ds)
>  	mt7530_mib_reset(ds);
>  
>  	for (i = 0; i < MT7530_NUM_PORTS; i++) {
> +		/* Clear link settings and enable force mode to force link down
> +		 * on all ports until they're enabled later.
> +		 */
> +		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
> +		mt7530_set(priv, MT7530_PMCR_P(i), PMCR_FORCE_MODE);

Any reason to not combine the two lines above into a single call:

mt7530_rmw(priv, MT7530_PMCR_P(i),
	   PMCR_LINK_SETTINGS_MASK | PMCR_FORCE_MODE,
	   PMCR_FORCE_MODE);

> +
>  		/* Disable forwarding by default on all ports */
>  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
>  			   PCR_MATRIX_CLR);
> @@ -2359,6 +2363,12 @@ mt7531_setup_common(struct dsa_switch *ds)
>  		     UNU_FFP_MASK);
>  
>  	for (i = 0; i < MT7530_NUM_PORTS; i++) {
> +		/* Clear link settings and enable force mode to force link down
> +		 * on all ports until they're enabled later.
> +		 */
> +		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
> +		mt7530_set(priv, MT7530_PMCR_P(i), MT7531_FORCE_MODE);
> +

Same here obviously.

>  		/* Disable forwarding by default on all ports */
>  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
>  			   PCR_MATRIX_CLR);
> @@ -2657,23 +2667,13 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>  			  const struct phylink_link_state *state)
>  {
>  	struct mt7530_priv *priv = ds->priv;
> -	u32 mcr_cur, mcr_new;
>  
>  	if ((port == 5 || port == 6) && priv->info->mac_port_config)
>  		priv->info->mac_port_config(ds, port, mode, state->interface);
>  
> -	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
> -	mcr_new = mcr_cur;
> -	mcr_new &= ~PMCR_LINK_SETTINGS_MASK;
> -	mcr_new |= PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | PMCR_BACKOFF_EN |
> -		   PMCR_BACKPR_EN | PMCR_FORCE_MODE_ID(priv->id);
> -
>  	/* Are we connected to external phy */
>  	if (port == 5 && dsa_is_user_port(ds, 5))
> -		mcr_new |= PMCR_EXT_PHY;
> -
> -	if (mcr_new != mcr_cur)
> -		mt7530_write(priv, MT7530_PMCR_P(port), mcr_new);
> +		mt7530_set(priv, MT7530_PMCR_P(port), PMCR_EXT_PHY);
>  }
>  
>  static void mt753x_phylink_mac_link_down(struct dsa_switch *ds, int port,
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 8a8144868eaa..a71166e0a7fc 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -304,8 +304,6 @@ enum mt7530_vlan_port_acc_frm {
>  					 MT7531_FORCE_DPX | \
>  					 MT7531_FORCE_RX_FC | \
>  					 MT7531_FORCE_TX_FC)
> -#define  PMCR_FORCE_MODE_ID(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
> -					 MT7531_FORCE_MODE : PMCR_FORCE_MODE)
>  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
>  					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
>  					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
> 
> -- 
> 2.40.1
> 

