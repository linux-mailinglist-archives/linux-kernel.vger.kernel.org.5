Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D78809AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573141AbjLHEXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:23:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD9171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:23:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b27726369so18391595e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702009424; x=1702614224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPl6U0GokDKYjf8mFtBabOMqth1qqIW6W4U8DQpUoFQ=;
        b=MbI5cu+vG+FkNB6axRSRHqcLezZQ8RXfRcUsyzkVlOnlrkTFke8AZL6p4RHnrQ+kaj
         7lfDbYl62k0qRqFJ6uJw25+vDB0uNQDQSS0BZMfw0wYsc2H51tC2YpqPmU+jcI6jeYqg
         Wgp/qryjFiM6r7thcyyKt+5DpEXCmEZswmVlTfnxD6m+HLGVFkBMsYCr20+3pHwWNjLG
         33sz7QubTOf6RUmOuENNp8aYF6z0KJA2LKTKVHJy2mMmUwcWF0Cye6lraw47UNYnQOCs
         En6OTXoo5F/VkRXcXUD7TllTmVIjM2fd2BFCdZ43Tmt9SlQgqDF6KfcrTUwBkKlw5h8+
         grWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702009424; x=1702614224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPl6U0GokDKYjf8mFtBabOMqth1qqIW6W4U8DQpUoFQ=;
        b=lyMAYRmBZfgPmT4mAO08n2f39mh+aEouq1+ATTbGypQ914DinnGROHxwXJfdv29Wm8
         jKwLPRNmdz6EEmpbTN8UL3NEOUnLnIb4k9fGRYQXwA+IkkOpKpEJjggC7s+8NKIUBZ/T
         Q00KwUGMiw3Nje+iptASFkTziGkwhHR/ZY3/Udlys2ho8iLBsN+kth8HkDyR5ox1fgEz
         VyauQKauWOcGqlmPxSo1HKARDgW8HYD37CH+KB+OTzIaDs20ia22ypnzx+x62n80kPWu
         liwYX0dUpY3V7MC65yCy7YA6u8ltHcal+jEBiix9WFnB2x2kweubaIKKxZVs4MVYgYNG
         FF/g==
X-Gm-Message-State: AOJu0YwI9DdFnM8GV5L/VQb1ixfPSX3QdZi6Fbi9jSUExB4W6LAUitLi
        kca5iIhKIIDyoAT99yv9mdUmqw==
X-Google-Smtp-Source: AGHT+IGb8HNYcf4CwqR2mNQtwvE2sIxWS6ha8l/UWovNTRhq1viL+9jJuZvP6Uejra7pVJ3NHVKIxA==
X-Received: by 2002:a05:600c:4651:b0:40c:2518:687c with SMTP id n17-20020a05600c465100b0040c2518687cmr1507452wmo.61.1702009423621;
        Thu, 07 Dec 2023 20:23:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004063c9f68f2sm1470710wmb.26.2023.12.07.20.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:23:43 -0800 (PST)
Date:   Fri, 8 Dec 2023 07:23:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Simon Horman <horms@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:40:15PM +0200, Vladimir Oltean wrote:
> 
> We could be more pragmatic about this whole sparse false positive warning,
> and just move the "if" block which calls mt7530_setup_port5() right
> after the priv->p5_intf_sel assignments, instead of waiting to "break;"
> from the for_each_child_of_node() loop.
> 
> for_each_child_of_node(dn, mac_np) {
> 	if (!of_device_is_compatible(mac_np,
> 				     "mediatek,eth-mac"))
> 		continue;
> 
> 	ret = of_property_read_u32(mac_np, "reg", &id);
> 	if (ret < 0 || id != 1)
> 		continue;
> 
> 	phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
> 	if (!phy_node)
> 		continue;
> 
> 	if (phy_node->parent == priv->dev->of_node->parent) {
> 		ret = of_get_phy_mode(mac_np, &interface);
> 		if (ret && ret != -ENODEV) {
> 			of_node_put(mac_np);
> 			of_node_put(phy_node);
> 			return ret;
> 		}
> 		id = of_mdio_parse_addr(ds->dev, phy_node);
> 		if (id == 0)
> 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
> 		if (id == 4)
> 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
> 
> 		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 || <---- here
> 		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> 			mt7530_setup_port5(ds, interface);

This doesn't solve the problem that Smatch doesn't know what the
original value of priv->p5_intf_sel.  And also I don't like this code
because now we call mt7530_setup_port5() on every iteration after
we find the first P5_INTF_SEL_PHY_P0.

> 	}
> 	of_node_put(mac_np);
> 	of_node_put(phy_node);
> 	break;
> }

Let's not worry too much about false positives.  We can just ignore
them.  There is always a trade off between false positives and false
negatives.  With GCC we try to get a clean run with no warnings, but
with Smatch I'm targetting the false positive ratio at "this is worth
reviewing one time."

regards,
dan carpenter

