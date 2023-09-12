Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82079D9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjILTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjILTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:34:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B8199;
        Tue, 12 Sep 2023 12:34:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so762134266b.2;
        Tue, 12 Sep 2023 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694547294; x=1695152094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z8gdWrWuVeFlnSIKZ2NOJm7Y8BUbwd2ZNwalxRE+BW0=;
        b=pIVTZev24UgmHyJqvdKLjXnZlirXrMgzcYKdE+ba8GHyxDJyocbHVfjhB1/Aehsqmc
         t19iAbnupAbkjfV8hb8emBExePQN0eV7jsxAYLag3x6HZyn+/m1gTeQed0jhJhIwECC/
         h9P1vz+T29vR/8RxlxysH1ev5xPDX9zEsDP4CwOklL5l45TZF+sLFU6T2DAzV45TjNJK
         Cf8xz4AKh1tqYk5PXAqu7TUYS20M4cjc1SiqTJhK0SBgOKSjx0KbvxaWylxbSb9q5Y0d
         fs75BKeN8FYNjUFwNdQ53R8bCJvYUMLzP91wEG9xKhMdr0HoWmAh4e2/2d2NRPSRUIYq
         g9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694547294; x=1695152094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8gdWrWuVeFlnSIKZ2NOJm7Y8BUbwd2ZNwalxRE+BW0=;
        b=VKWlHjsz/UxJUZ/FM7GzHZNq/zjoOkGev8QJn1jagdNVQlQJrxy/+9B6awRU6WsBJl
         5aKPtrBVWhxdp29LpzzIxynDRCzO/AjtuLdpYVbHD27XdIr7s/ATWh2s1PoP5cSLmKMO
         GQ/60QqinWF4hBQEt8tb/he7OVAuXtBafk8MxcYMya+Eq7PjCXh7WikPP57H9Fmj9Rqf
         vjo/4omvGc8FUz1xmVJUapxCrlaS5lC7IISMw/eYS++PxwzOjFEe4xlDeOBz+OO9IV3j
         WaQyu24lhZDZOvdAn7iad3/9kbSDgycew0eiRBJrokueCaHJrGpCcWKDK5avU1uhXh0g
         xNtw==
X-Gm-Message-State: AOJu0Yx9H5Ce/v/9mIxkm2GbjD+M7thhghaKLrylnxcOn79eznSoZRoH
        GtuyGUduw7KDRKlOlRWyTVQ=
X-Google-Smtp-Source: AGHT+IF2x+0PJReOu0h7LIhK4z/2N8GnhuzGa4jCv35kEX4WT+YNV6CCZ1h1zkd9sRMux2n4P4GJMQ==
X-Received: by 2002:a17:906:3149:b0:9a5:cade:8044 with SMTP id e9-20020a170906314900b009a5cade8044mr186839eje.21.1694547293556;
        Tue, 12 Sep 2023 12:34:53 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090671d200b0099cf840527csm7290131ejk.153.2023.09.12.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:34:53 -0700 (PDT)
Date:   Tue, 12 Sep 2023 22:34:50 +0300
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
Message-ID: <20230912193450.h5s6miubag46z623@skbuf>
References: <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:23:51PM +0300, Arınç ÜNAL wrote:
> On 12.09.2023 01:51, Vladimir Oltean wrote:
> > On Sat, Sep 09, 2023 at 11:53:50AM +0300, Arınç ÜNAL wrote:
> > > What to do:
> > > - For mscc,vsc7514-switch, enforce phylink bindings for ports.
> > > - For mscc,vsc7512-switch, enforce phylink bindings for user ports.
> > 
> > you can also look at dsa_switches_apply_workarounds[], and if the switch
> > isn't there, then you can replace "user ports" with "ports" here and
> > everywhere.
> 
> The phylink bindings for user ports I ended up making by looking up the
> existing devicetrees are different than the phylink bindings for the shared
> (CPU and DSA) ports currently enforced on all switches.
> 
> My phylink bindings for user ports:
> 
>             allOf:
>               - anyOf:
>                   - required: [ fixed-link ]
>                   - required: [ phy-handle ]
>                   - required: [ managed ]
> 
>               - if:
>                   required: [ fixed-link ]
>                 then:
>                   not:
>                     required: [ managed ]

Right, it should have been anyOf and not oneOf.. my mistake. It is a bug
which should be fixed. It's the same phylink that gets used in both cases,
user ports and shared ports :)

> 
> The phylink bindings for shared ports enforced on all switches on
> dsa-port.yaml:
> 
>   allOf:
>     - required:
>         - phy-mode
>     - oneOf:
>         - required:
>             - fixed-link
>         - required:
>             - phy-handle
>         - required:
>             - managed
> 
> Here's what I understand:
> 
> - For switches in dsa_switches_apply_workarounds[]
>   - Enforce the latter for shared ports.
>   - Enforce the former for user ports.
> 
> - For switches not in dsa_switches_apply_workarounds[]
>   - Enforce the former for all ports.

No, no. We enforce the dt-schema regardless of switch presence in
dsa_switches_apply_workarounds[], to encourage users to fix device trees
(those who run schema validation). The kernel workaround consists in
doing something (skipping phylink) for the device trees where the schema
warns on shared ports. But there should be a single sub-schema for
validating phylink bindings, whatever port kind it is.
