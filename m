Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC057924A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjIEP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354373AbjIELFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:05:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A3132;
        Tue,  5 Sep 2023 04:05:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so360146366b.3;
        Tue, 05 Sep 2023 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693911914; x=1694516714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kV2u1LJ/AQQMdTka+tApDVxIh+Eo+L4Z4u7wlv+3woU=;
        b=XFBBphpAskDiNvzPrd+HOMtz4E9T0kAeEMxpwzEaJO6Q6+G6CZuLsofywWA7oxSlYq
         TlCm6UNEke/ZC2/NdlbZge/RamgtQAvawKMhYXQyZaUau/w9ntY/I7VL2nnviYLFZbMB
         g+xN9Z9baQQQlQo/2FtzPAX6g+8vkF83mMNb76lILz4a1I+jhyGg6gWzpOOljneaX8BI
         u0PYG2P+NPo1bKYN7otd/wH6vOpuGr96/NtYvy/gUanInH0c2neXcFS89htvKH8W3fMk
         NDnXiMXIMcsfqn3oyPwZvDq5Z27PiaJSl19VTC6eyhA0sDZfALWslUxwrlKGHOOhYc6i
         2flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693911914; x=1694516714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV2u1LJ/AQQMdTka+tApDVxIh+Eo+L4Z4u7wlv+3woU=;
        b=PHGw8gEjLDDuksH7ncXJNttWY6Miyw/XmNz2YgbIPgCPjDY/Yt9AUhOGZzhKfeIN6g
         24cDc18DD4xnMsyGsADDr4CfByRkvggWujToZ3Mn5eNwi5mrCaEH6/8c4XUef0pa/IY7
         cH7P4PAOKZSYuo0ja2FTgCh992iZipKg92l/ctSRLmw2Ebzt9971rQZG8+0iWUvuuokg
         ld+ZwlcsWhSogZt41wwMYA5hzvSql2ZkbqIuZ7f6SoEywLW51ghwYacO72+DtXkd3ERN
         h4s4n6jskQP+OWXVdYWEsisPgFDecgCGG+nG2oWvkAOv5tFMeahinBka/oONkDFVMX9r
         iVxA==
X-Gm-Message-State: AOJu0YwsRmqR9tbxTB6lZfK9RiJrHzC86BjpaPKupakrkFRnQGEcA4Iv
        TPXD8TjomZH33P7/8dip/Vs=
X-Google-Smtp-Source: AGHT+IGrI66p2CBlDOcMK2yKRkeShj590QUDA31D8xucis1MBr3Sx1jck3yAeoVNwtjgdsXFZ3lyyQ==
X-Received: by 2002:a17:906:1bb2:b0:9a6:69bf:fa5a with SMTP id r18-20020a1709061bb200b009a669bffa5amr2412702ejg.63.1693911914444;
        Tue, 05 Sep 2023 04:05:14 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709063e5400b0099ccee57ac2sm7408438eji.194.2023.09.05.04.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:05:14 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:05:11 +0300
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
Message-ID: <20230905110511.hyap7grnomzwqj6d@skbuf>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:42:19PM -0300, Luiz Angelo Daros de Luca wrote:
> I submitted a small series of patches to unify that behavior between
> those two drivers:
> 
> https://lore.kernel.org/netdev/CAJq09z44SNGFkCi_BCpQ+3DuXhKfGVsMubRYE7AezJsGGOboVA@mail.gmail.com/
> (This is my answer to the series opening message to include the first
> paragraph ate by the editor)
> 
> There was some discussion but not NAC, ACK or RFC. It would have
> dropped some lines of code. I can revive it if there is interest.

There was no Ack or Nack from me because I didn't manage to understand
what bothers you if the unified dt-binding has a "compatible" string for
the "mdio" node, which the driver simply ignores.
https://lore.kernel.org/netdev/20220706152923.mhc7vw7xkr7xkot4@skbuf/
