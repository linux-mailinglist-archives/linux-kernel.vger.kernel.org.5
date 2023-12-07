Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71F2809049
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjLGSkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLGSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:40:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9F1711;
        Thu,  7 Dec 2023 10:40:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so1202060a12.0;
        Thu, 07 Dec 2023 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974419; x=1702579219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kigIueQOAcLn75XXfZ0Gwh0kRvsokZ/Ypm7K8+pRm4g=;
        b=AkPg8zUA5Qy9urB8yTdFgXwc+OmQiIsdguI/55xs625Q5N+agQFhoqrWgVAS/hUJs7
         yrMfX1WowF3LqDbvl5qOO3BAa0npq8QKgbsfnt+CZxj0lCkx7LraEpXm+E4J4vr0UB+S
         ro0qT91uXacb5NY3TrAdWac1hRXq3YEc2Y0y/vBh3eVfkSHayezd2IX7RSHwcQrBulvG
         bk/HZhjIgniRaxUDivzJDsdvzORX+ifjDOEg4uQoKZFgmAXtw6VPK7hdoKsK7MHO4/QP
         lcJEFWPETl34VjLUHRzae1N2cn8ps/+aXHqwMFzYikY1hUMs1uJJ5LbQU7v0PKWfr0/+
         lZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974419; x=1702579219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kigIueQOAcLn75XXfZ0Gwh0kRvsokZ/Ypm7K8+pRm4g=;
        b=WqLFvDAPStLfOBIOPTE8S7dQqkFzgMb/LqvCPJgLN49ld/S0pjihI5fEbyiJvrsO/G
         6xdqmE3QhiEtmS3B6PoD41L6gPEL9rIGJChLodMN0/rqWIl8GDdRHkIJ1bGhxIOvjAVk
         aMkUzkn2fToU4Kvf58ecLePWpZ/5GSI4TLNnzSr4PoR1+i8u5Ck2nIKhPXnEe+ov05YE
         NBD05ogEJIcY5t0n/+hDj+nlRzjaErN3yPOeDtEyX/Bg3P67qdInCsxPZbQBn2ZbkL7G
         xxekW0bCdjd+wlRQNGOHf3eKm15FuN+rdjSt9vV+yKkMpAQtexHDRZxCvf8qQE5q1/KN
         aU4g==
X-Gm-Message-State: AOJu0Yx9FVleNCHWZl/r9+1Yvz1iBGhv5k6YOzJLV8EZGkZlXPGC/FKb
        fEsqYRJuNNy/e9h5D2UH7pM=
X-Google-Smtp-Source: AGHT+IEyVEmWPr683mIgsYZk1wfGxtefcti3FrQu/q9XZjuViGfGsnMvgIfr5NwzTX0f4Wg9AjJQQg==
X-Received: by 2002:a05:6402:1d91:b0:54c:4837:903e with SMTP id dk17-20020a0564021d9100b0054c4837903emr1942092edb.54.1701974418673;
        Thu, 07 Dec 2023 10:40:18 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id l12-20020a50cbcc000000b0054b53aacd86sm113790edi.65.2023.12.07.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:40:18 -0800 (PST)
Date:   Thu, 7 Dec 2023 20:40:15 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
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
Message-ID: <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:51:07AM +0300, Dan Carpenter wrote:
> On Sat, Dec 02, 2023 at 11:45:42AM +0300, Arınç ÜNAL wrote:
> > 
> > I'm not sure why it doesn't catch that for mt7530_setup_port5() to run
> > here, priv->p5_intf_sel must be either P5_INTF_SEL_PHY_P0 or
> > P5_INTF_SEL_PHY_P4. And for that to happen, the interface variable will be
> > initialised.
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
> > 	}
> > 	of_node_put(mac_np);
> > 	of_node_put(phy_node);
> > 	break;
> > }
> > 
> > if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
> >     priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> > 	mt7530_setup_port5(ds, interface);
> 
> Smatch doesn't know:
> 1) What the value of priv->p5_intf_sel is going into this function
> 2) We enter the for_each_child_of_node() loop
> 3) That if (phy_node->parent == priv->dev->of_node->parent) { is
>    definitely true for one element on the list.
> 
> Looking at how Smatch parses this code, I could probably improve problem
> #1 a bit.  Right now Smatch sees "struct mt7530_priv *priv = ds->priv;"
> and "priv->p5_intf_sel" is unknown, but I could probably improve it to
> where it says that it's in the 1-3 range.  But that doesn't help here
> and it doesn't address problems 2 and 3.
> 
> It's a hard problem.
> 
> regards,
> dan carpenter
> 

We could be more pragmatic about this whole sparse false positive warning,
and just move the "if" block which calls mt7530_setup_port5() right
after the priv->p5_intf_sel assignments, instead of waiting to "break;"
from the for_each_child_of_node() loop.

for_each_child_of_node(dn, mac_np) {
	if (!of_device_is_compatible(mac_np,
				     "mediatek,eth-mac"))
		continue;

	ret = of_property_read_u32(mac_np, "reg", &id);
	if (ret < 0 || id != 1)
		continue;

	phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
	if (!phy_node)
		continue;

	if (phy_node->parent == priv->dev->of_node->parent) {
		ret = of_get_phy_mode(mac_np, &interface);
		if (ret && ret != -ENODEV) {
			of_node_put(mac_np);
			of_node_put(phy_node);
			return ret;
		}
		id = of_mdio_parse_addr(ds->dev, phy_node);
		if (id == 0)
			priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
		if (id == 4)
			priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;

		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 || <---- here
		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
			mt7530_setup_port5(ds, interface);
	}
	of_node_put(mac_np);
	of_node_put(phy_node);
	break;
}

I hope it's now much clearer to sparse that "interface" is used within
the same basic block in which it also got assigned, and that determination
does not depend upon the values taken by a second variable.

Maybe it's also a bit clearer for us humans.

What would also help us humans even more is to extract the entire "dn"
handling from mt7530_setup() into a separate mt7530_setup_phy_muxing()
function, and put a good comment there about what's going on with this
PHY muxing thing.

The advantage of splitting this up is that we don't pollute mt7530_setup()
with finding the "dn" if dsa_is_unused_port(ds, 5) returns false.

Also, reducing the indentation level of for_each_child_of_node() by one
can't be bad. Maybe even by more. There's this pattern:

for_each_child_of_node(dn, mac_np) {
	// do stuff with mac_np
	break;
}

aka we only care about the first child of dn. We could find the mac_np
as the only operation inside for_each_child_of_node(), break directly,
and "do stuff with mac_np" could be done outside, further reducing the
indentation by 1 level.
