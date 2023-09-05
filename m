Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040E4792B71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjIEQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354383AbjIELLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:11:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91961AB;
        Tue,  5 Sep 2023 04:11:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so3963806e87.1;
        Tue, 05 Sep 2023 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693912291; x=1694517091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WLoQn7be1D72ekzhEmbPr89HcwylHXzc0OOTYnEBNg=;
        b=GHqwV/nAlGEvzxapC3D4nNwu5/sRUKvtR/lwA94tFov33/uZX6UlX71w51IFXfEqGW
         LFeEdVru3kusTP+U8f2HAd+w3IWgTtUb3ZsTkcLLkQHm7/VeEYoOjIGGNrp5Ig5jUtJY
         2Enqn2KkJ0q509EJcDI/Q9cx+86Ghcu3YbM/91drYDDM03cizx7dbOV4pN29Y4aUNsAF
         EwrmY/L1N0ZIbwu3m2JDNF3SH8kqZ9ilMxwh7cKAGxkOg4/6CtPCtUKE54MnjSK1a4h7
         it6T98vOBMylbUa4lBlbjd0dVUBBgiUot/czrMp0k8JzsbqCYc9vmZDvLBnrhLkXJ1xW
         asog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912291; x=1694517091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WLoQn7be1D72ekzhEmbPr89HcwylHXzc0OOTYnEBNg=;
        b=kP0ElZPcSiWAJrsDfrlZnhntz33PJLNPypJkAmai5qtmvx8bWkHcHzlaO6ZETBeL20
         fLLDxemTuTEMz44JPkCfis20mMmOn2VmgsGuh4pji+XqmhEAy67cJm0Bktcd8lP/+YfJ
         OSiQHKOUIHxjWq9mPRD7m0pa75tP3v72167nl7WnyGQUhZ3fZAKsikF5A5PFa0fdvYlj
         1RJC3xgMhf3WuRjR7klVP/Up8SOUyFTtSYuD1pOihgklwYlI7FHUV/KZzP732z1XWc5D
         azb/ysieQcN/ytVt8wssP+NEt44O948v0kWjvIAAZWvyLuB7ewk9P1watiS4GBDJ4+to
         U0ig==
X-Gm-Message-State: AOJu0Yyr0zRrT+ZBtZ0rjwllJ9fAQ5c9bqnmhuwjszMVYN8ueoURydlF
        Uj6cc4XFyJidwfhzXEsffaw=
X-Google-Smtp-Source: AGHT+IFZm+YJ8szZjnCXx4iZ0+YwTJu1WFmNIfkcFqME64Z4ABDlhajbiXLHXOiOLFRXmKQmrQl7dA==
X-Received: by 2002:a05:6512:3990:b0:500:9734:b415 with SMTP id j16-20020a056512399000b005009734b415mr9696436lfu.30.1693912290677;
        Tue, 05 Sep 2023 04:11:30 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id l26-20020a056402125a00b00525c01f91b0sm6961365edw.42.2023.09.05.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:11:30 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:11:27 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20230905111127.hql3pjlrtqc7gybv@skbuf>
References: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <CAJq09z6eghuHY+b2y-kGmjKnLiEEOABXGKhjnB-PxJ=-GtYD4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6eghuHY+b2y-kGmjKnLiEEOABXGKhjnB-PxJ=-GtYD4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:42:19PM -0300, Luiz Angelo Daros de Luca wrote:
> > > [1] ...this. The SMI-controlled and MDIO-controlled Realtek switches are
> > > otherwise the same, right? So why would they have different dt-bindings?
> >
> > Honestly, I'm wondering the answer to this as well. For some reason, when
> > probing the SMI controlled Realtek switches, instead of just letting
> > dsa_switch_setup() populate ds->slave_mii_bus, on realtek_smi_setup_mdio()
> > on realtek-smi.c:
> >
> > - priv->slave_mii_bus is allocated.
> > - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
> > - priv->slave_mii_bus->dev.of_node = mdio_np;
> > - ds->slave_mii_bus = priv->slave_mii_bus;
> 
> I might be able to help here. The Realtek SMI version created a custom
> slave_mii driver because it was the only way to associate it with an
> MDIO DT node. And that DT node was required to specify the interrupts
> for each phy0.
> It would work without that mdio node, letting DSA setup handle the
> slave bus, but it would rely only on polling for port status.

It is possible to set up PHY IRQs even if the MDIO bus is not OF-based.
I think that mv88e6xxx_g2_irq_mdio_setup() does that (sets bus->irq[]).
