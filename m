Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFE762008
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGYRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGYRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:23:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E5B1BDA;
        Tue, 25 Jul 2023 10:23:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fd190065a7so49103615e9.2;
        Tue, 25 Jul 2023 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690305826; x=1690910626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCjYLQGpUi9LZHFadFMiEEo7QqPcY2DeKsVFl+2aKNU=;
        b=rZc8FbgcxGUFmb5gc7OQU/Sro9b3WDYmvOw10TDvtAUsu45MuNvr++Eq95bscNrb+k
         IUgBx4ERTdGauOFSedmrIcK3/t+rDumodi7q1zQT+2bIrKxxECphKHejt2JWdbKcl66V
         rHfVbPlwquRdRlR/aGKeqoyJuLsIOYZWbJg2LdkArn4E6JOhGoC8lq+YmYPKuYd4FMc7
         yaauj+HK/2YDF+z3WWiKEdVgiYY2s9ZQieXJWMPrxP+3qaqqEecvJDOjb+UbIVP/3WiH
         4esQtyY0gLaq7Fo/+jUMe7fyFcNfbVI0jG5LoXY4yuCuFKvhltBndVGX07VQy/BVgkQD
         4XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690305826; x=1690910626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCjYLQGpUi9LZHFadFMiEEo7QqPcY2DeKsVFl+2aKNU=;
        b=ELBmt/MvYE321gdoFk+VboXTTqUfFxm66qCS180F+0/Vx2YktuvU1mxP8MyGGFAmyD
         hRVZ0oI/yFgYS/ma4FgyUGWXHHGbeiKTH3JfC0vYKAGzUhwgr4iTZg/sF7t5YxGWC6hn
         yP33UM42p7ibK4NO1cFQVx93Fc8J5NC5aoFqlPENZTXsJExM+YGPyTPu101wLkp2Xt3D
         o+eX5HMXCUZBZqmBoYZkgIJ8lNtvLYeKMRCbZx4MEf52OUUPJ2rKqqQJW6B6n661h8S2
         uWFjySYDACoUUVPy30oRwt84adPeQbaLBHZCF935+uYjWjLEVAru0Flh7WqrpBMq6cQ1
         UJcA==
X-Gm-Message-State: ABy/qLbDK5zNATJfxdu5AFBdvimwWFcKJNj59sLJicQre6vqKJKuYmIJ
        nUXqcWStkw3pHtUQQSE2D60=
X-Google-Smtp-Source: APBJJlGnSy9IQ24p2o5A8KVMr5JGQSx2IGkAk/3kl493CMkTV5w3ePXFoTlGVb108Sah7vITokuXyw==
X-Received: by 2002:a1c:f707:0:b0:3fc:175:ade7 with SMTP id v7-20020a1cf707000000b003fc0175ade7mr11115010wmh.38.1690305825941;
        Tue, 25 Jul 2023 10:23:45 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id e23-20020a05600c219700b003fc02218d6csm16239587wme.25.2023.07.25.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:23:45 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:23:43 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230725172343.qcqmcoygyhcgunmh@skbuf>
References: <20230721102618.13408-1-ante.knezic@helmholz.de>
 <20230721102618.13408-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721102618.13408-1-ante.knezic@helmholz.de>
 <20230721102618.13408-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:26:18PM +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
> V3 : Rework to fit the new phylink_pcs infrastructure
> V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch> 
>  * make int lanes[] const 
>  * reorder prod_nums
>  * update commit message to indicate we are dealing with
>    undocumented Marvell registers and magic values
> ---
>  drivers/net/dsa/mv88e6xxx/pcs-639x.c | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> index 98dd49dac421..50b14804c360 100644
> --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
>  	struct mdio_device mdio;
>  	struct phylink_pcs sgmii_pcs;
>  	struct phylink_pcs xg_pcs;
> +	struct mv88e6xxx_chip *chip;
>  	bool supports_5g;
>  	phy_interface_t interface;
>  	unsigned int irq;
> @@ -205,13 +206,52 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
>  }
>  
> +static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
> +{
> +	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
> +		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
> +		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
> +		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
> +	struct mdio_device mdio;
> +	int err, i;
> +
> +	/* 88e6190x and 88e6390x errata 3.14:
> +	 * After chip reset, SERDES reconfiguration or SERDES core
> +	 * Software Reset, the SERDES lanes may not be properly aligned
> +	 * resulting in CRC errors
> +	 */
> +
> +	mdio.bus = mpcs->mdio.bus;
> +
> +	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
> +		mdio.addr = lanes[i];
> +
> +		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> +					0xf054, 0x400C);
> +		if (err)
> +			return err;
> +
> +		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> +					0xf054, 0x4000);
> +		if (err)
> +			return err;

I'm not sure which way is preferred by PHY maintainers, but it seems to
be a useless complication to simulate that you have a struct mdio_device
for the other lanes when you don't. It appears more appropriate to just
use mdiobus_c45_write(mpcs->mdio.bus, lanes[i]).

There's also the locking question (with the big caveat that we don't
know what the register writes do!). There's locking at the bus level,
but the MDIO device isn't locked. So phylink on those other PCSes can
still do stuff, even in-between the first and the second write to
undocumented register 0xf054.

I can speculate that writing 0x400c -> 0x4000 is something like: set
RX_RESET | TX_RESET followed by clear RX_RESET | TX_RESET. Is it ok if
stuff happens in between these writes - will it stick, or does this
logically interact with anything else in any other way? I guess we won't
know. I might be a bit closer to being okay with it if you could confirm
that some other (unrelated) register write to the PCS does make it
through (and can be read back) in between the 2 erratum writes.

> +	}
> +
> +	return 0;
> +}
> +
>  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
>  					   phy_interface_t interface)
>  {
>  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
> +	struct mv88e6xxx_chip *chip = mpcs->chip;
>  
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
>  
> +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> +		mv88e6390_erratum_3_14(mpcs);

You could at least print an error if a write failure occurred, so that
it doesn't go completely unnoticed.

> +
>  	return 0;
>  }
>  
> @@ -523,6 +563,7 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
>  	mpcs->sgmii_pcs.neg_mode = true;
>  	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
>  	mpcs->xg_pcs.neg_mode = true;
> +	mpcs->chip = chip;
>  
>  	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
>  	if (err)
> @@ -873,6 +914,7 @@ static int mv88e6393x_pcs_init(struct mv88e6xxx_chip *chip, int port)
>  	mpcs->xg_pcs.ops = &mv88e6393x_xg_pcs_ops;
>  	mpcs->xg_pcs.neg_mode = true;
>  	mpcs->supports_5g = true;
> +	mpcs->chip = chip;
>  
>  	err = mv88e6393x_erratum_4_6(mpcs);
>  	if (err)
> -- 
> 2.11.0
> 

