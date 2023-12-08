Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3223180AC6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjLHSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:46:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868DA11F;
        Fri,  8 Dec 2023 10:46:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a06e59384b6so320501466b.1;
        Fri, 08 Dec 2023 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702061216; x=1702666016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dr8lBkPk/gRBWTFsMFs5wXdj0/vhpvGhmgseUu0tAY=;
        b=dwDid3ELbjUC/pN5M/iq/HhcnyriHAt7hdjXu8j8BlBaFIrE6jzG/DQQhOh4n28rNZ
         mzdXFbTY+UTQogXzgWd/8eSs/8h5ikq/rpdPIv7MawUNjHElFqW6qFRQcuII+qTRDhEx
         u6I9pTjQV4K8cZU/xCZ8ItjSZsCcfcd8lGdpk2QZm5Z9tvXqgnvuqHpMna8FQSVfPJN9
         470cWSLm8VQc/3AF0MSkZwuBjENFXk07hBTUcktcz2pMdptZR0Ieu9Sl8ACznjGD908y
         8V8jrqcyrOfDXMFctPx1BMd/852M94YIr4xFk79SC8ggic1B9Ez4j9DOmy6pXw4x9WXg
         mfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702061216; x=1702666016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dr8lBkPk/gRBWTFsMFs5wXdj0/vhpvGhmgseUu0tAY=;
        b=R4BbcUMFFFmP8ht/HMCsZgKfj9KyevlHN1/TfrDC2ZvqdGrRcu6+D/S/u7O92TD3WT
         5C9ol6q6SctpmlwK/xa3XBDQJIzFTThIsGZbXUdNfvWLnAcFRbJyjKyffuEPiyZgkbmJ
         swqJrILD/XJeeezYZsbhSBcnPDC9JHmJW4w99n+L0zJMSZZkSF29GEryhkijtRl3bCqZ
         WBqj0ajjCU43YS1bDz6Agtt6Gxbt1xBsMI3JMSnisPlxwNCG5GE4vka93VpUBsq7DznW
         PDEEk/hVKzj1r3NP2DSsALEERa9MnUBu9wculH0aeyu2hfG2qTkl12Pnup0je0wRDZIl
         qK2g==
X-Gm-Message-State: AOJu0YxDSk+AIP0c5e/8/2QvOA+Uu1aBTfx/qSVa5UDrVAUbvyyizyCN
        f2Wmu+KETw2K8bNrRw3izEE=
X-Google-Smtp-Source: AGHT+IFqVjj8BiPjTfdPUSjvMIkmUsDvvm2h6RNnCjnqfatSpcv/EcTXmwiu33Eu6zdyUdHxlBmCSA==
X-Received: by 2002:a17:907:94d5:b0:9b8:b683:5837 with SMTP id dn21-20020a17090794d500b009b8b6835837mr301541ejc.46.1702061215767;
        Fri, 08 Dec 2023 10:46:55 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a1e2aa3d094sm1317479ejl.173.2023.12.08.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:46:55 -0800 (PST)
Date:   Fri, 8 Dec 2023 20:46:52 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
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
Message-ID: <20231208184652.k2max4kf7r3fgksg@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 07:23:38AM +0300, Dan Carpenter wrote:
> On Thu, Dec 07, 2023 at 08:40:15PM +0200, Vladimir Oltean wrote:
> > 
> > We could be more pragmatic about this whole sparse false positive warning,
> > and just move the "if" block which calls mt7530_setup_port5() right
> > after the priv->p5_intf_sel assignments, instead of waiting to "break;"
> > from the for_each_child_of_node() loop.
> > 
> > for_each_child_of_node(dn, mac_np) {
> > 	if (!of_device_is_compatible(mac_np,
> > 				     "mediatek,eth-mac"))
> > 		continue;
> > 
> > 	ret = of_property_read_u32(mac_np, "reg", &id);
> > 	if (ret < 0 || id != 1)
> > 		continue;
> > 
> > 	phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
> > 	if (!phy_node)
> > 		continue;
> > 
> > 	if (phy_node->parent == priv->dev->of_node->parent) {
> > 		ret = of_get_phy_mode(mac_np, &interface);
> > 		if (ret && ret != -ENODEV) {
> > 			of_node_put(mac_np);
> > 			of_node_put(phy_node);
> > 			return ret;
> > 		}
> > 		id = of_mdio_parse_addr(ds->dev, phy_node);
> > 		if (id == 0)
> > 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
> > 		if (id == 4)
> > 			priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
> > 
> > 		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 || <---- here
> > 		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> > 			mt7530_setup_port5(ds, interface);
> 
> This doesn't solve the problem that Smatch doesn't know what the
> original value of priv->p5_intf_sel.  And also I don't like this code
> because now we call mt7530_setup_port5() on every iteration after
> we find the first P5_INTF_SEL_PHY_P0.

You seem to have not parsed the "break" from 4 lines below. There is at
most one iteration through for_each_child_of_node().

And why would the "original" value of priv->p5_intf_sel matter? Original
or modified by the "if (id == 0)" and "if (id == 4)" blocks, the code
has already executed the of_get_phy_mode(&interface) call, by the time
we reach the "if" that calls mt7530_setup_port5().

Hmm, maybe the problem, all along, was that we let the -ENODEV return
code from of_get_phy_mode() pass through? "interface" will really be
uninitialized in that case. It's not a false positive.

Instead of:

	ret = of_get_phy_mode(mac_np, &interface);
	if (ret && ret != -ENODEV) {
		...
		return ret;
	}

it should have been like this, to not complain:

	ret = of_get_phy_mode(mac_np, &interface);
	if (ret) {
		...
		return ret;
	}

> > 	}
> > 	of_node_put(mac_np);
> > 	of_node_put(phy_node);
> > 	break;
> > }
