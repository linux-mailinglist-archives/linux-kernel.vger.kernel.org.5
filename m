Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC077BBCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHNOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjHNOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:36:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4AE4;
        Mon, 14 Aug 2023 07:36:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bccc9ec02so618637766b.2;
        Mon, 14 Aug 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023765; x=1692628565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cb+czWvjyYwGX3W5jJNktQj/kqBnzJwyrscW7IZnlQY=;
        b=XbfMx5jsNXr50NyK210tfW4QKpsGsD74//ZIbinQlLd3unrsFsTE3Fy38/ZuUg6GAl
         lnjA9xjzgaC6DyN8pHIIVMTdfwiKznFIEXVlWSfX5w/ScG80veQfBa73rVo0+chMb+dG
         S2Mj+HBlFmaT5jiv9IfHPtBhIY/C6xLD7HtFr9n1gZZKq9Fk5S2x1vlp4IJmOcbnlMOf
         5bTxtUqrxZDckP2xpGCfG6Qw0c2QsksVkowrOYMj12JA5Wp0N9qDwg3X8CUnqrPq6CTy
         HIdNXjVZR+9cn4SiIikVE78sUWO4LWWn53vIuXgt4hpj6oTBf1qXcr4Dpc5C8ZUvX6mG
         q+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023765; x=1692628565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+czWvjyYwGX3W5jJNktQj/kqBnzJwyrscW7IZnlQY=;
        b=Ga0PLx2FxUGXwEYPcTrwgcwNJNWVbE1a7tSlzg8cjXeinoyK1gg2Vmag5D7muwf7km
         TCOeomhg2iVLJYxKGVMsCP1dyvi2lGi3mNN66zm0+2QzesRooXyYQM11oFpU+1tkqG/l
         Clx2JhddzjBz/H/mDV1PH4XUx1ckV0p/roo7XM20oNWK41bQRiFtzJuRe2P29ocM12mu
         Ww6OWdqQA3Hj0GV/3T964qkMvI9z3VdlwPyYXpKSmSefRQYY9XuGIKqmmnjgaiHke1aC
         vAM8Gyzm7qcBjvEcOJ0nxQdnnWOyAzdNODXzkCqFd3O1Njwt7VP53QG+Apfc9nvBLzcJ
         wz4w==
X-Gm-Message-State: AOJu0YyY2rYc5meIbcSr8bnSHYWRxBCLlBjtw1Wi7nuMW9MQsRo7Nl2+
        At5Q9WZVN1wBoZV4e1tcgek=
X-Google-Smtp-Source: AGHT+IEzC/K1rqJm6FyRoXxbVfFap/m4A3OEwMLw3F3kbnFkKMoPl1Ot5DzpCuUMPZZM11AzTmRiNg==
X-Received: by 2002:a17:906:3299:b0:99b:66eb:2162 with SMTP id 25-20020a170906329900b0099b66eb2162mr7632434ejw.5.1692023764565;
        Mon, 14 Aug 2023 07:36:04 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id qc1-20020a170906d8a100b0099d9bc9bfd9sm2399461ejb.48.2023.08.14.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:36:04 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:36:01 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230814143601.mnpxtcm2zybnbvoh@skbuf>
References: <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arınç,

On Mon, Aug 14, 2023 at 01:06:29PM +0300, Arınç ÜNAL wrote:
> On 13.08.2023 22:01, Vladimir Oltean wrote:
> > SJA1105 has zero internal MDIO buses and zero internal PHYs.
> 
> Ah okay. I didn't consider the switch architecture where the data interface
> of the PHY is connected to the switch, and the PHY management interface is
> connected to the mdio bus that the switch is connected to.
> 
> The schemas of the switches which already utilise the mdio property:
> - /schemas/net/dsa/microchip,lan937x.yaml
> - /schemas/net/dsa/qca8k.yaml
> - /schemas/net/dsa/realtek.yaml
> - /schemas/net/dsa/renesas,rzn1-a5psw.yaml
> 
> The schemas of the switches which don't have an internal MDIO bus, meaning
> the mdio property must be invalid:
> - /schemas/net/mscc,vsc7514-switch.yaml
> - /schemas/net/dsa/nxp,sja1105.yaml
> 
> The schemas of the switches which I don't know if the switch has got an
> internal MDIO bus:
> - /schemas/net/dsa/arrow,xrs700x.yaml
>   - I believe, because there's phy-handle defined on every port without the
>     mdio node on the example, the PHYs are not connected to the internal
>     MDIO bus. Therefore, we can invalidate the mdio property for this
>     schema.
> - /schemas/net/dsa/brcm,b53.yaml
>   - Seems ok to keep it valid.
> - /schemas/net/dsa/brcm,sf2.yaml
>   - Seems ok to keep it valid.
> - /schemas/net/dsa/hirschmann,hellcreek.yaml
>   - Same as /schemas/net/dsa/arrow,xrs700x.yaml.
> - /schemas/net/dsa/microchip,ksz.yaml
>   - Seems ok to keep it valid.
> - /schemas/net/dsa/mscc,ocelot.yaml
>   - Same as /schemas/net/dsa/arrow,xrs700x.yaml.
> 
> Not json-schema documentation, don't care about:
> - ar9331.txt
> - lan9303.txt
> - lantiq-gswip.txt
> - marvell.txt
> - vitesse,vsc73xx.txt
> 
> Arınç

We have to keep in sight why we're here, and stick to that.

You had issues with a device tree that didn't work, but it passed
validation, and you're trying to enforce extra rules through the
json-schema so that next time, it fails. Verbally, that rule would be:
"if the switch has a ds->slave_mii_bus which does not have an OF
presence, then phylink compatible bindings may be omitted, and that has
a special and valid meaning (the port is connected to an internal PHY on
that ds->slave_mii_bus). If ds->slave_mii_bus has an OF presence, or if
ds->slave_mii_bus is NULL, then phylink-compatible bindings (phy-handle
or fixed-link or managed) are required on all user ports".

So it becomes a question of tracking ds->slave_mii_bus for all drivers.
In essence, it's fundamentally about the ds->slave_mii_bus, not about
the "mdio" child node. See more below.

There are 2 code paths that lead to its creation:

1. DSA registers the bus in dsa_slave_mii_bus_init(), based on the
   presence of ds->ops->phy_read() and ds->ops->phy_write(). Traditionally,
   a slave_mii_bus created this way was always non-OF-based, but Luiz,
   in commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus"), thought
   it would be a good idea for them to be optionally OF-based (and thus,
   useless at their primary purpose of being able to have internal PHYs
   without a phy-handle). But, it was thought that the framework
   registering an MDIO bus automatically would be a plus. So, ds->slave_mii_bus
   created in this way may or may not have an OF presence, with no way
   to know except to look at device trees (and to presume that they do).

   The drivers that populate ds->ops->phy_read() and ds->ops->phy_write() are:
    |
    +--- dsa_loop_driver: not OF-based
    |
    +--- ksz_switch_ops: OF-based or non-OF-based
    |
    +--- mv88e6060_switch_ops: OF-based or non-OF-based
    |
    +--- lan9303_switch_ops: OF-based or non-OF-based
    |
    +--- rtl8365mb_switch_ops_mdio: OF-based or non-OF-based
    |
    +--- b53_switch_ops: OF-based or non-OF-based
    |
    +--- vsc73xx_ds_ops: OF-based or non-OF-based

2. The switch driver registers the bus, and populates ds->slave_mii_bus with
   a pointer to it.
    |
    +--- Bus is not OF-based (it was registered with mdiobus_register()).
    |    This is the normal case:
    |      * mv88e6xxx_default_mdio_bus() in some cases
    |      * qca8k_mdio_register() in the "qca8k-legacy slave mii" case
    |      * bcm_sf2_mdio_register()
    |      * mt7530_setup_mdio()
    |
    +--- Bus is OF-based (it was registered with of_mdiobus_register()).
         I've no idea why you'd do this, because you have neither the
         benefit of using a non-OF-based phy_connect(), nor the benefit
         of having DSA register the bus for you:
           * mv88e6xxx_default_mdio_bus() when of_get_child_by_name(np, "mdio")
             is non-NULL
           * qca8k_mdio_register() when of_get_child_by_name(priv->dev->of_node, "mdio")
             is non-NULL
           * ksz_mdio_register() - it always wants an "mdio" child node
           * gswip_mdio() - it always wants a child node compatible with
             "lantiq,xrx200-mdio"
           * realtek_smi_setup_mdio() - it always wants a child node
             compatible with "realtek,smi-mdio"

For switches in the first category, the presence of the "mdio" child
node is what makes the ds->slave_mii_bus be OF-based or not, since it is
all the same binding, imposed by Luiz in dsa_switch_setup().

For switches in the second category, it all depends on the way in which
the driver finds the node for of_mdiobus_register().


Having identified all switches which make some sort of use of
ds->slave_mii_bus, the rule would sound like this:

1. If the schema is that of (need to replace this with compatible
   strings, I'm too lazy for that):

   - ksz_switch_ops
   - mv88e6060_switch_ops
   - lan9303_switch_ops
   - rtl8365mb_switch_ops_mdio
   - b53_switch_ops
   - vsc73xx_ds_ops
   - mv88e6xxx
   - qca8k

   and we have an "mdio" child, then phylink bindings are mandatory on user ports.

2. If the schema is that of gswip_mdio and we have a child node of "lantiq,xrx200-mdio",
   then phylink bindings are mandatory on user ports (I haven't checked,
   but it might be that the "lantiq,xrx200-mdio" child is mandatory, and
   in that case, this goes to category 4 below).

3. If the schema is that of realtek_smi_setup_mdio and we have a child node of
   "realtek,smi-mdio", then phylink bindings are mandatory on user ports
   (same comment about the child MDIO note maybe being mandatory).

4. If the switch didn't appear in the above set of rules, then phylink
   bindings are unconditionally mandatory on user ports.

We don't care at all what the drivers that don't use ds->slave_mii_bus
do with the "mdio" child node. It doesn't change the fact that their
user ports can't have missing phylink bindings.
