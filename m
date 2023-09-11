Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7879C160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjILA5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjILA5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:57:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B62719C365;
        Mon, 11 Sep 2023 17:53:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a64619d8fbso639726966b.0;
        Mon, 11 Sep 2023 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694479944; x=1695084744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XWTcwow2et7upqcwf54DyK1wVNFfm6M3zpWLMMZDCl4=;
        b=o2Oh1/rCeX8rHZN2WMmHEjVvCGzUaQ3zbPowULhStxfYG86nXYTXFteHCt4b/7iK4E
         L3PLr5uecXIsd9czgMEevISeSbbCC0NVI2VreFmnm1QTgosD67J8GQjD8fq8YfmYSD7M
         PC9DQxnXvp8Z0yhhorq2Eel+Ept6ObM1h6nrbCABx3H7bNkMqmKA6ouXHRK7taPouSBh
         45klUpwTcfQ76xuOdKLbMnLS+ISTcCrGx7F5AUTFcuiEyjiYOcoBCgDKJKC+Mgu+vxWp
         m+bT2LRZ22o3nWpggkpnPKYz8dUfVnwPYRgkMccFhc9nuQgUcb1mBoCGaiAa1OafJjih
         5AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694479944; x=1695084744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWTcwow2et7upqcwf54DyK1wVNFfm6M3zpWLMMZDCl4=;
        b=o66WqNv1R0eX6fUQvkk8P+Nz397cBzAjV98qsMgzxQGoBoFL+sSFsDTqE1ihVe7k4k
         GkAS4TrTOx/uSbaOHBO0+FC3TRixsjSKPNmOTURBFJAEK3htUJWI1e5+4pb3kZZ/qpM/
         7Z6s79pgtMtgZu3DZe8nN6xzPln9Es5nzGdrR0DEHzpqAkPyioC+jlnmowhQc5qszRqv
         E3RDhxXgWFoJCzH3YagxULsCSCkaKesLmdYCL/CrvIMLZ12blT2STMrNKw04J+yUUHiG
         /iCvVNY6vstSGX1eOq2gOwC7/iJ7JQVF2O+aU813ISID0yIUeQejV71WS94lpiclMH4s
         us9A==
X-Gm-Message-State: AOJu0YxRJF7M0m+mBNxwsbTW3O0JIFqtJhnT0C4fKmCAvtJcpwakgeIX
        oBUxbCOQrENpeAnofWWuxbtw1Y4WLwN7Xw==
X-Google-Smtp-Source: AGHT+IG4neBUt+ie4pzDoZiQeWUSKTNp1+XgRuVaZj4s2RJQC3CdsSSnlnDEU6xXFuAqvt2am5jxOw==
X-Received: by 2002:a17:906:30da:b0:99d:fc31:242f with SMTP id b26-20020a17090630da00b0099dfc31242fmr9012606ejb.66.1694472689910;
        Mon, 11 Sep 2023 15:51:29 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id dx22-20020a170906a85600b0099d959f9536sm6023945ejb.12.2023.09.11.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:51:29 -0700 (PDT)
Date:   Tue, 12 Sep 2023 01:51:26 +0300
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
Message-ID: <20230911225126.rk23g3u3bzo3agby@skbuf>
References: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 11:53:50AM +0300, Arınç ÜNAL wrote:
> What to do:
> - For mscc,vsc7514-switch, enforce phylink bindings for ports.
> - For mscc,vsc7512-switch, enforce phylink bindings for user ports.

you can also look at dsa_switches_apply_workarounds[], and if the switch
isn't there, then you can replace "user ports" with "ports" here and
everywhere.

> - renesas,rzn1-a5psw.yaml
>   - renesas,r9a06g032-a5psw, renesas,rzn1-a5psw
> 
> What to do:
> - Document "mdio".

Not clear here and for all the schemas quoted below.. is "mdio" not documented already?

> - realtek.yaml
>   - realtek,rtl8365mb
>   - realtek,rtl8366rb
> 
> drivers/net/dsa/realtek/realtek-mdio.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> What to do:
> - Document "mdio".
>   - Require "mdio". (Can't do because it's not required for MDIO controlled
>     switches that share the compatible string with SMI controlled switches.
>     This is why I would like Luiz to unify the bus registeration process.)
> - Document compatible string "realtek,smi-mdio" on "mdio" child node.
>   - Require compatible. (Can't do because the same as above.)
> - Enforce phylink bindings for user ports. (Can't do because the same as
>   above.)
>   - Enforce phylink bindings for user ports if "mdio" is defined.
> 
> ---
> 
> - qca8k.yaml
>   - qca,qca8327
>   - qca,qca8328
>   - qca,qca8334
>   - qca,qca8337
> 
> drivers/net/dsa/qca/qca8k-8xxx.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
>   child node is defined.
>   - mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
> 
> What to do:
> - Document "mdio".
> - Enforce phylink bindings for user ports if "mdio" is defined.
> 
> ---
> 
> - nxp,sja1105.yaml
>   - nxp,sja1105e
>   - nxp,sja1105t
>   - nxp,sja1105p
>   - nxp,sja1105q
>   - nxp,sja1105r
>   - nxp,sja1105s
>   - nxp,sja1110a
>   - nxp,sja1110b
>   - nxp,sja1110c
>   - nxp,sja1110d
> 
> What to do:
> - Document "mdios".
>   - Document child node pattern property under "mdios".
>     - Document "nxp,sja1110-base-tx-mdio" and "nxp,sja1110-base-t1-mdio"
>       compatible strings.
> ---
> 
> - microchip,lan937x.yaml
>   - microchip,lan9370
>   - microchip,lan9371
>   - microchip,lan9372
>   - microchip,lan9373
>   - microchip,lan9374
> - microchip,ksz.yaml
>   - microchip,ksz8765
>   - microchip,ksz8794
>   - microchip,ksz8795
>   - microchip,ksz8863
>   - microchip,ksz8873
>   - microchip,ksz9477
>   - microchip,ksz9897
>   - microchip,ksz9896
>   - microchip,ksz9567
>   - microchip,ksz8565
>   - microchip,ksz9893
>   - microchip,ksz9563
>   - microchip,ksz8563
> 
> What to do:
> - Document "mdio".
