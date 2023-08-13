Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E535677AAB9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHMTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHMTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:02:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378A1703;
        Sun, 13 Aug 2023 12:02:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe98583a6fso3218741e87.3;
        Sun, 13 Aug 2023 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953321; x=1692558121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAwbHbILPSNT/2mlrQnn5cannBZhfjKxo5aPZMBdKAE=;
        b=jAZJr/3NoDQONt2xvNzsU6qPcVuX5l/p9UTVsLZpGk093yd/wbf5zOOaVM5QD6XUfs
         aY1KUH/fl983RT6507UIuZ1tEMgJfmtUaYWji0SQh8QO4QAy/Be6brwzJTy+PcgOUGlA
         7dR6B50qri4QLRuqR1z5zhHv1kcFTiW5Wvh3MspSbPQlgP5W7P86TIZTd6dfFlgzTlaI
         TZVrLkYTeQVwCn1ZQvnu+viTAWqGFoo4tp0xrLqVfjOIh3ldjjAzjqN6PlQtvhiwM54p
         TIQHYCWJqzuKjAZzDr+j8eaoSZNRCh84iDkTA04UEqkw32SsgbaVaQCdwbJ7k0PqzOkQ
         O3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953321; x=1692558121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAwbHbILPSNT/2mlrQnn5cannBZhfjKxo5aPZMBdKAE=;
        b=aMv4+JkP6DXdxwrD5ZtuJWFOLh/Np2CyQ8aq4cJVNGG4keN6eZpUebLJy8cok03uem
         AHU6oG8zirMcxLfmb40MP4ZF0bFVY1hwtwO+/9Tr/7IJJkErQIYbIZntUmKuKwxUE5w+
         C7xuyBNbg79upOwfG1xA/0j6Oo6jnZcHxJAwT3WX3JWkdXzgRTKZTA8odOGpx6HtuCh4
         pAkA1cTRMSqRQvyDIql3tePZ7WVnAW7p7Yc9B0NTSGKgbhmYw931kK0oDr3h/1FFZXXP
         /nLR7CBJi8dzadCMK+wJXCTO2Odws1/++5U3pWZQOaWrYQ4bL2uybWxw3qYcdQa6DSG0
         rixQ==
X-Gm-Message-State: AOJu0YzTgDO9xMgSvSPbej33aMbaIQVh1acHnUZLyiEmiq183tv71B6P
        XowQwzAbfrG9ioRFrVCu4eo=
X-Google-Smtp-Source: AGHT+IH0tZP2NKa8iempFVNWwuPn/Zj0V4Lwwpztwz+DiHEX09WEj5U+n3GtijIqy7/Xt4oAo7n+4g==
X-Received: by 2002:a19:2d41:0:b0:4fd:f7e7:24fd with SMTP id t1-20020a192d41000000b004fdf7e724fdmr4028807lft.64.1691953321027;
        Sun, 13 Aug 2023 12:02:01 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b005230f52195esm4724858edt.44.2023.08.13.12.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:02:00 -0700 (PDT)
Date:   Sun, 13 Aug 2023 22:01:57 +0300
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
Message-ID: <20230813190157.4y3zoro53qsz43pe@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 03:59:11PM +0300, Arınç ÜNAL wrote:
> > sja1105 does not support an "mdio" child property. I haven't checked the
> > others. Don't add properties that aren't supported.
> 
> Adding the mdio property to the dsa.yaml schema will allow it on all of the
> schemas that refer to dsa.yaml such as this one. This addition here is only
> to disallow additional properties under the mdio property for this specific
> schema.
> 
> That said, my understanding is that the internal MDIO bus exists on all of
> the switches controlled by DSA.

How come?

> Whether each individual DSA subdriver supports registering it does not
> matter in terms of documenting the internal MDIO bus for all DSA
> switches.
> 
> SJA1110 uses the mdios property instead because it's got two internal mdio
> buses, which is why I invalidate the mdio property for it. If SJA1105 has
> also got two internal mdio buses, let me know.

SJA1105 has zero internal MDIO buses and zero internal PHYs.
