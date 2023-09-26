Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C27AF7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjI0BWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjI0BUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:20:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B1726BF;
        Tue, 26 Sep 2023 15:45:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so9794456f8f.1;
        Tue, 26 Sep 2023 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695768299; x=1696373099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFQJ8D+sSFOYvK98iDZQWiRqQc78CyhpZfXgoVc4/N8=;
        b=joVpUxe20IggQRCD0Xo4k0cEdF4sn4efbdtKWyTg60/gX5MbjcumR5DBFSz11OsLQr
         nrhG4rb6LVKZd2luN3FNYa/cE7qjOPDCk1BQgqToSObPPTJl1gA9RzebmndBz235QrQx
         AAMnUFTfFtta7fauVP/Txw1/T49gHTeesRImfSPMGggXu3qqWpugU1GyPVSv6x22q1Av
         R7MCbkyIrBm0JIw7osuru35A1/ibC+3ogJxI0Q4b3ogiYJdrpi1LAPZOi9Gj/tT3ePqe
         4SZLppnlbrzkgV4F8jj1LZyZQeowSXCrFZITP6GkoySeC9qFVEpxcH1Pi0oND7SXZez4
         3IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768299; x=1696373099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFQJ8D+sSFOYvK98iDZQWiRqQc78CyhpZfXgoVc4/N8=;
        b=Dg8RSqws5Qm8MEpi1UenLGWu0OLvPZ6SOJValFg9mnwBwjtj+8YFNCCqjelaM9zEeZ
         qPPyoT4zNm7OSflnXns2HzsCALPaX7VP1WWFXJTqxJcs6gl86JpcDuG2zoVRPokOhLNN
         a/6hsY6ogpknWOd3e0pU8OydpzxeDQXMte5ynb7Et/1wpm8ETXhSEAc/bFQ7Z8/Em5iT
         tK1AZf6aWARjGnw/o18vY3AenYpsXIWa7OZEUOcr1vF5iqLynFEk7KtUVJUXEb714O1w
         ZFKddyOLFm+oi+kqxnDdzDJGNPcwvijESfRbGeAiNTYYxgkA1WqYZsBp7HxyS3lRQNL9
         NG+g==
X-Gm-Message-State: AOJu0YwLsARqZ3Vktv6pVxd+CJctQmjmVBXnjHhVOhTJnIWeu2oU8ESc
        Vk9ocS8LDGNpoEhsK/FozP8=
X-Google-Smtp-Source: AGHT+IHBiO5RzUxun2eesmCq4TU4wyXDvDMgwXx6usXKaVMDNKDG8lWAAEa+cz7bASW4wgcxABFDyg==
X-Received: by 2002:a5d:6a8a:0:b0:31f:a136:96c6 with SMTP id s10-20020a5d6a8a000000b0031fa13696c6mr55213wru.42.1695768299218;
        Tue, 26 Sep 2023 15:44:59 -0700 (PDT)
Received: from skbuf ([188.25.161.12])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b009adca8ada31sm8458045ejr.12.2023.09.26.15.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 15:44:58 -0700 (PDT)
Date:   Wed, 27 Sep 2023 01:44:56 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>,
        George McCollister <george.mccollister@gmail.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v6 net-next 1/5] net: dsa: propagate extack to
 ds->ops->port_hsr_join()
Message-ID: <20230926224456.h6eupvuyyl2qahpo@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
 <20230922133108.2090612-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922133108.2090612-2-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:31:04PM +0200, Lukasz Majewski wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Drivers can provide meaningful error messages which state a reason why
> they can't perform an offload, and dsa_slave_changeupper() already has
> the infrastructure to propagate these over netlink rather than printing
> to the kernel log. So pass the extack argument and modify the xrs700x
> driver's port_hsr_join() prototype.
> 
> Also take the opportunity and use the extack for the 2 -EOPNOTSUPP cases
> from xrs700x_hsr_join().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes for v5:
> - New patch
> Changes for v6:
> - None
> ---
>  drivers/net/dsa/xrs700x/xrs700x.c | 18 ++++++++++++------
>  include/net/dsa.h                 |  3 ++-
>  net/dsa/port.c                    |  5 +++--
>  net/dsa/port.h                    |  3 ++-
>  net/dsa/slave.c                   |  2 +-
>  5 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
> index 753fef757f11..5b02e9e426fd 100644
> --- a/drivers/net/dsa/xrs700x/xrs700x.c
> +++ b/drivers/net/dsa/xrs700x/xrs700x.c
> @@ -548,7 +548,8 @@ static void xrs700x_bridge_leave(struct dsa_switch *ds, int port,
>  }
>  
>  static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
> -			    struct net_device *hsr)
> +			    struct net_device *hsr,
> +			    struct netlink_ext_ack *extack)
>  {
>  	unsigned int val = XRS_HSR_CFG_HSR_PRP;
>  	struct dsa_port *partner = NULL, *dp;
> @@ -562,16 +563,21 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
>  	if (ret)
>  		return ret;
>  
> -	/* Only ports 1 and 2 can be HSR/PRP redundant ports. */
> -	if (port != 1 && port != 2)
> +	if (port != 1 && port != 2) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only ports 1 and 2 can offload HSR/PRP");
>  		return -EOPNOTSUPP;
> +	}
>  
> -	if (ver == HSR_V1)
> +	if (ver == HSR_V1) {
>  		val |= XRS_HSR_CFG_HSR;
> -	else if (ver == PRP_V1)
> +	} else if (ver == PRP_V1) {
>  		val |= XRS_HSR_CFG_PRP;
> -	else
> +	} else {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only HSR v1 and PRP v1 can be offloaded");
>  		return -EOPNOTSUPP;
> +	}
>  
>  	dsa_hsr_foreach_port(dp, ds, hsr) {
>  		if (dp->index != port) {
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 0b9c6aa27047..426724808e76 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1198,7 +1198,8 @@ struct dsa_switch_ops {
>  	 * HSR integration
>  	 */
>  	int	(*port_hsr_join)(struct dsa_switch *ds, int port,
> -				 struct net_device *hsr);
> +				 struct net_device *hsr,
> +				 struct netlink_ext_ack *extack);
>  	int	(*port_hsr_leave)(struct dsa_switch *ds, int port,
>  				  struct net_device *hsr);
>  
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 37ab238e8304..5f01bd4f9dec 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -2024,7 +2024,8 @@ void dsa_shared_port_link_unregister_of(struct dsa_port *dp)
>  		dsa_shared_port_setup_phy_of(dp, false);
>  }
>  
> -int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
> +int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
> +		      struct netlink_ext_ack *extack)
>  {
>  	struct dsa_switch *ds = dp->ds;
>  	int err;
> @@ -2034,7 +2035,7 @@ int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr)
>  
>  	dp->hsr_dev = hsr;
>  
> -	err = ds->ops->port_hsr_join(ds, dp->index, hsr);
> +	err = ds->ops->port_hsr_join(ds, dp->index, hsr, extack);
>  	if (err)
>  		dp->hsr_dev = NULL;
>  
> diff --git a/net/dsa/port.h b/net/dsa/port.h
> index dc812512fd0e..334879964e2c 100644
> --- a/net/dsa/port.h
> +++ b/net/dsa/port.h
> @@ -103,7 +103,8 @@ int dsa_port_phylink_create(struct dsa_port *dp);
>  void dsa_port_phylink_destroy(struct dsa_port *dp);
>  int dsa_shared_port_link_register_of(struct dsa_port *dp);
>  void dsa_shared_port_link_unregister_of(struct dsa_port *dp);
> -int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr);
> +int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr,
> +		      struct netlink_ext_ack *extack);
>  void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr);
>  int dsa_port_tag_8021q_vlan_add(struct dsa_port *dp, u16 vid, bool broadcast);
>  void dsa_port_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid, bool broadcast);
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 48db91b33390..2b3d89b77121 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -2862,7 +2862,7 @@ static int dsa_slave_changeupper(struct net_device *dev,
>  		}
>  	} else if (is_hsr_master(info->upper_dev)) {
>  		if (info->linking) {
> -			err = dsa_port_hsr_join(dp, info->upper_dev);
> +			err = dsa_port_hsr_join(dp, info->upper_dev, extack);
>  			if (err == -EOPNOTSUPP) {
>  				NL_SET_ERR_MSG_WEAK_MOD(extack,
>  							"Offloading not supported");
> -- 
> 2.20.1
> 

It would have been good to Cc George here, for the driver-side patch.
But anyway, it looks ok.
