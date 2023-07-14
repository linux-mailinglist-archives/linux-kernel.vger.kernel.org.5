Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EC7542CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjGNSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjGNSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:49:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0E2D6B;
        Fri, 14 Jul 2023 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jdawOEEHyRUT7F57ZiuPLdAc3zWki3KVkFdsKJ+iCp0=; b=3OB7ozN7Bi7W1GClBi9FNObJ1b
        3R3hCiaACaJAKSBr30C0ShpVIzJcIHDy4xnxGn3GLFYXLJ8pLDHnHTBdE4A1JG8ddQytsoId3KsE0
        fKvTUMvmeQy6gBdcUYkIxY/yZmQ9tT9qiTZfnc+8/JiKOXVw8wyZgyaDAE2xrWlkv/hg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKNrR-001NkM-TZ; Fri, 14 Jul 2023 20:49:49 +0200
Date:   Fri, 14 Jul 2023 20:49:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Message-ID: <55cd8a47-89e5-4f62-8162-c744e1a99ad5@lunn.ch>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-3-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714101406.17686-3-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static u32 yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
> +{
> +	u32 vol;
> +	int i;
> +
> +	vol = yt8531_get_ldo_vol(phydev);
> +	for (i = 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
> +		if (yt8531_ldo_vol[i].vol == vol && yt8531_ldo_vol[i].cur == cur)
> +			return yt8531_ldo_vol[i].ds;
> +	}
> +
> +	phydev_warn(phydev,
> +		    "No matching current value was found %d, Use default value.\n", cur);
> +
> +	return YT8531_RGMII_RX_DS_DEFAULT;

If there is a value in DT and it is invalid, return -EINVAL and fail
the probe. Only use the default if there is no value in DT.

    Andrew
