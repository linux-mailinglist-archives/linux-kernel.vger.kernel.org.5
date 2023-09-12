Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EEA79D3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjILOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjILOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:48:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007AB115;
        Tue, 12 Sep 2023 07:48:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad749473baso203154566b.1;
        Tue, 12 Sep 2023 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694530085; x=1695134885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mh3N+atY6fKlEdWof649s8ajhIo+Yy5qpEAzk5J3lE=;
        b=AFJgk5nH4gzHb22ZSyZeM5iZyqngU3wRN8WgdaCAJPGH0tpXbZFeozlr3xYCxjo2se
         t+hV3qdMCWx8cYTojx2tvB8PSC/Mc5m2RT31QCBqtTBvjVWd4lDKSc6y8Jlvo3rJMS4H
         kyTHD/6niDbOjLndjV5Uqi1gXUhTd/+jbuhwdvZhYOWICEyNxnaD+A++UwCOSIsi8zwT
         V3jsOX2jFEhuH+xVMLTt4KJimcusDebe0+cLzoQEyNkgbGehLr/JPnXfXgaX+Jfk7J5w
         k+HT6Ko6NJMvG8TGHfHwpKxlbCFsZU5PgD/p3oPTgsTJkmTuxnuFMW7QgRPh51p0n9Jj
         hQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694530085; x=1695134885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mh3N+atY6fKlEdWof649s8ajhIo+Yy5qpEAzk5J3lE=;
        b=vQz+vCdRtPUKRT6GanFtp9EbaPtVmsSOM6X9MzO607DCzqN8mhJjAiz11K9goAF4aH
         nAFS8D3dgPdEkRm8nmmlmydZDkv5WH+JSHn4cIbPdxrvonF5R8rm8P80IUu42r1Ek9of
         GD6ISF4UbfxJasjP3eNIEm+hodDGNTrFOShKsDAukPJkn410qeMs1ekqpoJGOJXYMGZv
         OWlhysH0F/giD4cClZ7djdq4HqRAVZC3fxXgz1sDiN4HKAcp+UeZYPwG7mWOENlrE6Gp
         T1aXZIbyZIFXjPZXDbd5Js6apzGJsXWnN2Zp2fhOt29Md4pBuq0jSSBklHzJGhr81aqe
         npbA==
X-Gm-Message-State: AOJu0YxZY8JMsHwyDc47g1Mx4Is/xo6r8yni38Rggem9uPxCCvXA1w0m
        E2eEXFdpYCNP0dIcBXUnLnQ=
X-Google-Smtp-Source: AGHT+IH9wOTaGkTJFDyjmU8WryOltmH2Q7LMedYMwsNNq2HMT5i2dYmwYWLHYrSxtaajZH2vkJj7Ug==
X-Received: by 2002:a17:906:295:b0:9a5:da6c:6539 with SMTP id 21-20020a170906029500b009a5da6c6539mr10782887ejf.75.1694530085232;
        Tue, 12 Sep 2023 07:48:05 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906360700b0098ce63e36e9sm7064813ejb.16.2023.09.12.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:48:04 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:48:02 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20230912144802.czdpb6hpn2yiewvf@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-5-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912122201.3752918-5-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On Tue, Sep 12, 2023 at 02:21:58PM +0200, Pawel Dembicki wrote:
> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
> 
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 8f2285a03e82..541fbc195df1 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -1033,9 +1031,59 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
>  	return 9600 - ETH_HLEN - ETH_FCS_LEN;
>  }
>  
> +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> +{

For bisectability, the series must build patch by patch.
Here, you are missing:

	struct vsc73xx *vsc = ds->priv;

../drivers/net/dsa/vitesse-vsc73xx-core.c:1038:3: error: use of undeclared identifier 'vsc'
                vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK &
                ^
../drivers/net/dsa/vitesse-vsc73xx-core.c:1041:3: error: use of undeclared identifier 'vsc'
                vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK &
                ^
2 errors generated.

> +	/* Configure forward map to CPU <-> port only */
> +	if (port == CPU_PORT)
> +		vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK &
> +					     ~BIT(CPU_PORT);

		vsc->forward_map[CPU_PORT] = dsa_user_ports(ds);

> +	else
> +		vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK &
> +					 BIT(CPU_PORT);

		vsc->forward_map[port] = BIT(CPU_PORT);

> +
> +	return 0;
> +}
> +
> +/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
> + * forwarded only from and to PI/SI interface. For more info see chapter
> + * 2.7.1 (CPU Forwarding) in datasheet.
> + * This function is required for tag8021q operations.
> + */
> +
> +static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
> +				       u8 state)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	if (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED)
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_RECVMASK, BIT(port), 0);
> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_RECVMASK, BIT(port), BIT(port));
> +
> +	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_LEARNMASK, BIT(port), BIT(port));
> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_LEARNMASK, BIT(port), 0);
> +
> +	if (state == BR_STATE_FORWARDING)
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK,
> +				    vsc->forward_map[port]);

To forward a packet between port A and port B, both of them must be in
BR_STATE_FORWARDING, not just A.

> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
> +}
> +
>  static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_tag_protocol = vsc73xx_get_tag_protocol,
>  	.setup = vsc73xx_setup,
> +	.port_setup = vsc73xx_port_setup,
>  	.phy_read = vsc73xx_phy_read,
>  	.phy_write = vsc73xx_phy_write,
>  	.phylink_get_caps = vsc73xx_phylink_get_caps,
> @@ -1049,6 +1097,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
> +	.port_stp_state_set = vsc73xx_port_stp_state_set,
>  };
>  
>  static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index f79d81ef24fb..224e284a5573 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -18,6 +18,7 @@
>  
>  /**
>   * struct vsc73xx - VSC73xx state container
> + * @forward_map: Forward table cache

If you start describing the member fields, shouldn't all be described?
I think there will be kdoc warnings otherwise.

>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -28,6 +29,7 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u8				forward_map[VSC73XX_MAX_NUM_PORTS];
>  };
>  
>  struct vsc73xx_ops {
> -- 
> 2.34.1
> 
