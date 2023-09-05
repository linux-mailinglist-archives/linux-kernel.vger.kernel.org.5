Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D142792839
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbjIEQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354299AbjIEKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:37:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B29E8;
        Tue,  5 Sep 2023 03:37:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so2992799a12.0;
        Tue, 05 Sep 2023 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693910273; x=1694515073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApbezLaRT9D4Gr9PvWZAHTC2S+HnA1h1J9QKZkIqIyU=;
        b=d9+P83O8iGhliqtWZp6jd8DNvOMTMWWXAJ5JpIRYlGFD8Fc1v7KYscPZfm9TLHAAhg
         Wp8/ecjd/NMYNz1dVhxHyIDEIks/+c3j330B0KhUppHjPbgsr1qXD+CjSj/flsJ0zh7w
         nsQt0ZTXMr/JjUJH0wROx1rENCmFNWdboKP3a1iLmnWp/VnbQfdipmFNdTiSxRd2T1tn
         R08yKjpBOb0+aPr5xsEljFRKe4QNH2vQsHci5+ChCBCIreaqzzinhUaS14UIbO2uk1kx
         H1YNOs2Pddo115crBVf3bdtqYozdbVgzUwA6hQmldQhHFHJWC06FzRB8zezMdMwy7JBA
         u4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910273; x=1694515073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApbezLaRT9D4Gr9PvWZAHTC2S+HnA1h1J9QKZkIqIyU=;
        b=H98RqwzId26dFN4eFrwnBgnkt0zQO+4xOVWo9S9Kxc+sGta7CBYkMpHa+g6pwnYkha
         N1sDlimh//WL6c22C4au2aFV/qGZVv0lqfCDBPzQr+pxn6r0bZMjfkaosdMzXYTGNw9o
         Bnh1nJr7+3WY9YluOS1vunlNGXoPdn7pNCBKE/wvJFjJqmOMW9CD5GUwyzI7PmIDcMgn
         CjhPeHUOhOYdhaTqNX+8caaD+7l6T937SpdMOhfkdvxWFkHEpT62IdrvkH0ghMV9+CFQ
         eYYlTxWXPILaJVNsALGaSZwKWfDWBH0GYPcXiNhqFPLSFShYhgnEY90bZepYAfRq1nVS
         xlQQ==
X-Gm-Message-State: AOJu0Yy9jcqfgTxqmpJ6qSK67WObGvLAMb0FT+iZNEt9caD5S88B6W4J
        gMxtgqwzcWDe+7dqjOVRHHU=
X-Google-Smtp-Source: AGHT+IF0deXQ4ftfhJLVJAn7+JuV5lMIxdkGqAE23fn/n2jtRIQ+3h2pbJsonILyVi9x+bRkgsN2sQ==
X-Received: by 2002:a05:6402:124c:b0:52c:164:efe4 with SMTP id l12-20020a056402124c00b0052c0164efe4mr9102439edw.34.1693910272867;
        Tue, 05 Sep 2023 03:37:52 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id w16-20020a056402269000b0052e1959db1csm2930863edd.20.2023.09.05.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:37:52 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:37:50 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905103750.u3hbn6xmgthgdpnw@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904120209.741207-4-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 02:02:08PM +0200, Lukasz Majewski wrote:
> This patch adds functions for providing in KSZ9477 switch HSR
> (High-availability Seamless Redundancy) hardware offloading.
> 
> According to AN3474 application note following features are provided:
> - TX packet duplication from host to switch (NETIF_F_HW_HSR_DUP)
> - RX packet duplication discarding
> - Prevention of packet loop
> 
> For last two ones - there is a probability that some packets will not
> be filtered in HW (in some special cases). Hence, the HSR core code
> shall be used to discard those not caught frames.
> 
> Moreover, some switch registers adjustments are required - like setting
> MAC address of HSR network interface.
> 
> Additionally, the KSZ9477 switch has been configured to forward frames
> between HSR ports (1,2) members.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Use struct ksz_device to store hsr ports information (not struct dsa)
> 
> Changes for v3:
> - Enable in-switch forwarding of frames between HSR ports (i.e. enable
>   bridging of those two ports)
> 
> - The NETIF_F_HW_HSR_FWD flag has been marked as supported by the HSR
>   network device
> 
> - Remove ETH MAC address validity check as it is done earlier in the net
>   driver
> 
> - Add comment regarding adding support for NETIF_F_HW_HSR_FWD flag
> ---
>  drivers/net/dsa/microchip/ksz9477.c | 103 ++++++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477.h |   4 ++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 83b7f2d5c1ea..c4ed89c1de48 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1141,6 +1141,109 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
>  	return ksz_pwrite16(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
>  }
>  
> +/* The KSZ9477 provides following HW features to accelerate
> + * HSR frames handling:
> + *
> + * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
> + * 2. RX PACKET DUPLICATION DISCARDING
> + * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS FILTERING
> + *
> + * Only one from point 1. has the NETIF_F* flag available.
> + *
> + * Ones from point 2 and 3 are "best effort" - i.e. those will
> + * work correctly most of the time, but it may happen that some
> + * frames will not be caught. Hence, the SW needs to handle those
> + * special cases. However, the speed up gain is considerable when
> + * above features are used.
> + *
> + * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR frames
> + * can be forwarded in the switch fabric between HSR ports.

How do these 2 concepts (autonomous forwarding + software-based
elimination of some frames) work together? If software is not the sole
receiver of traffic which needs to be filtered further, and duplicates
also get forwarded to the network, does this not break the HSR ring?

What are the causes due to which self-address filtering and duplicate
elimination only work "most of the time"?

> + */
> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_FWD)
> +
> +int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
> +		     struct dsa_port *partner)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct net_device *slave;
> +	u8 i, data;
> +	int ret;
> +
> +	/* Program which ports shall support HSR */
> +	dev->hsr_ports = BIT(port) | BIT(partner->index);
> +	ksz_write32(dev, REG_HSR_PORT_MAP__4, dev->hsr_ports);
> +
> +	/* Forward frames between HSR ports (i.e. bridge together HSR ports) */
> +	ksz_prmw32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4, dev->hsr_ports,
> +		   dev->hsr_ports);
> +	ksz_prmw32(dev, partner->index, REG_PORT_VLAN_MEMBERSHIP__4,
> +		   dev->hsr_ports, dev->hsr_ports);

Call ksz9477_cfg_port_member() instead?

> +
> +	/* Enable discarding of received HSR frames */
> +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> +	data |= HSR_DUPLICATE_DISCARD;
> +	data &= ~HSR_NODE_UNICAST;
> +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> +
> +	/* Self MAC address filtering for HSR frames to avoid
> +	 * traverse of the HSR ring more than once.
> +	 *
> +	 * The HSR port (i.e. hsr0) MAC address is used.
> +	 */
> +	for (i = 0; i < ETH_ALEN; i++) {
> +		ret = ksz_write8(dev, REG_SW_MAC_ADDR_0 + i, hsr->dev_addr[i]);
> +		if (ret)
> +			return ret;

FWIW: https://lore.kernel.org/netdev/155ff37f-43d5-5fe0-6de4-c4639909553d@gmail.com/
Some coordination will be required regarding the MAC address that the
switch driver needs to program to these registers. It seems that it is
not single purpose.

> +	}
> +
> +	/* Enable global self-address filtering if not yet done during switch
> +	 * start
> +	 */
> +	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data);
> +	if (!(data & SW_SRC_ADDR_FILTER)) {
> +		data |= SW_SRC_ADDR_FILTER;
> +		ksz_write8(dev, REG_SW_LUE_CTRL_1, data);
> +	}

If there is no way that SW_SRC_ADDR_FILTER can be unset after
ksz9477_reset_switch() is called, then this is dead code which should be
removed.

> +
> +	/* Enable per port self-address filtering */
> +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
> +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> +		     PORT_SRC_ADDR_FILTER, true);
> +
> +	/* Setup HW supported features for lan HSR ports */
> +	slave = dsa_to_port(ds, port)->slave;
> +	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
> +
> +	slave = dsa_to_port(ds, partner->index)->slave;
> +	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;

Can the code that is duplicated for the partner port be moved to the
caller?

> +
> +	pr_debug("%s: HSR join port: %d partner: %d port_map: 0x%x\n", __func__,
> +		 port, partner->index, dev->hsr_ports);
> +
> +	return 0;
> +}
> +
> +int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr,
> +		      struct dsa_port *partner)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	/* Clear ports HSR support */
> +	ksz_write32(dev, REG_HSR_PORT_MAP__4, 0);
> +
> +	/* Disable forwarding frames between HSR ports */
> +	ksz_prmw32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4, dev->hsr_ports, 0);
> +	ksz_prmw32(dev, partner->index, REG_PORT_VLAN_MEMBERSHIP__4,
> +		   dev->hsr_ports, 0);
> +
> +	/* Disable per port self-address filtering */
> +	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
> +	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
> +		     PORT_SRC_ADDR_FILTER, false);
> +
> +	return 0;
> +}
> +
>  int ksz9477_switch_init(struct ksz_device *dev)
>  {
>  	u8 data8;
> diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
> index b6f7e3c46e3f..634262efb73c 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -58,5 +58,9 @@ int ksz9477_dsa_init(struct ksz_device *dev);
>  int ksz9477_switch_init(struct ksz_device *dev);
>  void ksz9477_switch_exit(struct ksz_device *dev);
>  void ksz9477_port_queue_split(struct ksz_device *dev, int port);
> +int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
> +		     struct dsa_port *partner);
> +int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr,
> +		      struct dsa_port *partner);
>  
>  #endif
> -- 
> 2.20.1
> 

