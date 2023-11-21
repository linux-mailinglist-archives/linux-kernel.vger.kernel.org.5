Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612587F368E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjKUSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjKUSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:54:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4573193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:54:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E211C433C8;
        Tue, 21 Nov 2023 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700592845;
        bh=co9lMUzvw3BfxT6r7XtEhDDe5hhA8tulVxZdHRcAkE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISW9tAm/yGrJQpNo6XTzZkUNwdPwdPqYh/2v/hvXHUByZDPwQ2x45l+FnJg8xw3kz
         VZbZm7KoTgiEDbrLU9AekSnhiiCC3LTKiakbme3HPHemzht88vslNhl6XeS7sbAWip
         jAYCp0KSMXy/MqW2S8DpkDiutWV6gqpja3FuMgNkpwMHYrPeVwCmhWWAYY+Lua7Ceq
         q+ykpM9z9Le4JQ2Gt1lUOgWFwH1Lq1HHJYBxyVFSNL2cqfLCMF2TywHu0OyTPKfH1F
         Z7n5XSZ/nTZSlAVtjV7hEDbQwlSBf2IAV/b1UKGPaHHn3BifFxyjmzH+ASLEZZxks6
         iIuYq8OzNfbDg==
Date:   Tue, 21 Nov 2023 18:53:58 +0000
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20231121185358.GA16629@kernel.org>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-8-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 03:31:57PM +0300, Arınç ÜNAL wrote:
> There's no need to run all the code on mt7530_setup_port5() if port 5 is
> disabled. The only case for calling mt7530_setup_port5() from
> mt7530_setup() is when PHY muxing is enabled. That is because port 5 is not
> defined as a port on the devicetree, therefore, it cannot be controlled by
> phylink.
> 
> Because of this, run mt7530_setup_port5() if priv->p5_intf_sel is
> P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4. Remove the P5_DISABLED case from
> mt7530_setup_port5().
> 
> Stop initialising the interface variable as the remaining cases will always
> call mt7530_setup_port5() with it initialised.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  drivers/net/dsa/mt7530.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index fc87ec817672..1aab4c3f28b0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -942,9 +942,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>  		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
>  		val &= ~MHWTRAP_P5_DIS;
>  		break;
> -	case P5_DISABLED:
> -		interface = PHY_INTERFACE_MODE_NA;
> -		break;
>  	default:
>  		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
>  			priv->p5_intf_sel);
> @@ -2313,8 +2310,6 @@ mt7530_setup(struct dsa_switch *ds)
>  		 * Set priv->p5_intf_sel to the appropriate value if PHY muxing
>  		 * is detected.
>  		 */
> -		interface = PHY_INTERFACE_MODE_NA;
> -
>  		for_each_child_of_node(dn, mac_np) {
>  			if (!of_device_is_compatible(mac_np,
>  						     "mediatek,eth-mac"))
> @@ -2346,7 +2341,9 @@ mt7530_setup(struct dsa_switch *ds)
>  			break;
>  		}
>  
> -		mt7530_setup_port5(ds, interface);
> +		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
> +		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> +			mt7530_setup_port5(ds, interface);

Hi Arınç,

It appears that interface is now uninitialised here.

Flagged by Smatch.

>  	}
>  
>  #ifdef CONFIG_GPIOLIB
> -- 
> 2.40.1
> 
