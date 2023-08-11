Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F17779084
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjHKNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHKNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:14:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85826A0;
        Fri, 11 Aug 2023 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KN0V0b1cvZhsr3ZgIxKHJ6DjqlcYAL+J/k6uHOW7PXA=; b=wt33i2aFCwO/UD9kZdJmfxF/bR
        N3rrqMROnewUrRHVo6Hoi6K0T3ppHWrKOdQIhGwOhKqqJ+1lv6D3meiHphfmCgrTDVHqKczMDxMRh
        SWlJA2DMlyhgfpwBfNQ4a2dfIK0C8IyijJs2NbTk7o8ENQjvydZ+KoSEcgsrR7Tsz1/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qURxS-003o6u-6j; Fri, 11 Aug 2023 15:13:38 +0200
Date:   Fri, 11 Aug 2023 15:13:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Message-ID: <9727375d-8d89-489b-bd3f-4f18930ff42c@lunn.ch>
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> +#define MTK_PHY_LED_STATE_FORCE_ON	BIT(0)
> +#define MTK_PHY_LED_STATE_FORCE_BLINK	BIT(1)
> +#define MTK_PHY_LED_STATE_NETDEV	BIT(2)
> +struct mtk_socphy_priv {
> +	unsigned long		led_state;
> +};

Hi Daniel

A blank line between the #defines and the struct would be nice.

> +
> +struct mtk_socphy_shared {
> +	u32			boottrap;
> +	struct mtk_socphy_priv	priv[4];
> +};
> +
>  static int mtk_socphy_read_page(struct phy_device *phydev)
>  {
>  	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
> @@ -1071,6 +1112,370 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
>  	return mt798x_phy_calibration(phydev);
>  }
>  
> +static int mt798x_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
> +				    bool on)
> +{
> +	struct mtk_socphy_priv *priv = phydev->priv;
> +	u32 mask = MTK_PHY_LED_STATE_FORCE_ON << (index ? 16 : 0);
> +	bool changed;

Reverse christmass tree please.

Otherwise, this looks good.

	   Andrew
