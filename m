Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7177BC33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHNO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHNO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:57:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDEB183;
        Mon, 14 Aug 2023 07:57:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so588668166b.2;
        Mon, 14 Aug 2023 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025042; x=1692629842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i86f9/Rs574ma35nEC5H2b5rAALRZ5mUOOKcLiJGdDY=;
        b=s1P4uJPHazogidjjEMW8c6pKvEL27pkGy7BCZS1Y+3A+AD7Jmlk0P3VFL95GYJptWd
         TzMUAOCBKgvqNJZfuxH5XZvrZrNoupzka0zhJVIK/6Ap6laPkWapKs0Re2gZ+T940kNB
         IR0rjGWE6Btkx4VEhZby66fQCO/OW99IT2jExsBnO0BLrtjEKVyPfAGlWpoIUJa31rlA
         PRK5sqIiG+OEcx3zFMz0WcXz8KDOIQqhdEeXVhcZjOcV2eyTI66WHM0svUw5ItDbTPiM
         0REtYwjFaLPFk46kd6oqI0tnhi4/MDK2k8ikYT+tl1HgCdag/5skKY3DPbcavIjr3SBL
         S4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025042; x=1692629842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i86f9/Rs574ma35nEC5H2b5rAALRZ5mUOOKcLiJGdDY=;
        b=iAC1hPGWTjlorBIwxj5wFHXDJk3ogse2ssoZ4qs+GnpfQEhf3rKKc7yZoTPfOHnHxn
         h8wyNrJjHU9QP77qrT5uN4v9CpMKiSi8WJzOSdPtw31TEr45s4tiNchFDdqtmVZhVWxR
         kLnsf7imDWq7YNKo6NsPEpoKvPRCGPcnPXzZKAnhgJi0uHfSBCMufbCrD/FTw4gGgPj1
         8Y7xiJeXsLMDNVxGbHGNcQe1iawAPJ8uL3AXBCEdA4auxe3yWHg7xZKQeFAC9cNSCvG1
         tzNTLhQNNTi7Q2AujsmxYC21tRPJBhRZ2fisEM7YH3bOg/yJRMk4+Zt4u9wOZOukblSk
         J7ww==
X-Gm-Message-State: AOJu0YwnQtB8wlfomEv3BCfRSfa8ri+V9vOMA5Roq9Z8us/SfPAVl2Qw
        0RUq8nJWxQdg0OrZEmeg+TM=
X-Google-Smtp-Source: AGHT+IHkDM9PnOsqb5Z+CFy9tRGS3ujo9y9pEj54EY4plE5vgvopuOZgUdWUUpCNzrem/BAGreLqaQ==
X-Received: by 2002:a17:906:2189:b0:99b:e6c3:f6b0 with SMTP id 9-20020a170906218900b0099be6c3f6b0mr6825473eju.62.1692025041796;
        Mon, 14 Aug 2023 07:57:21 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090668d500b0099cf44adf2csm5701636ejr.46.2023.08.14.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:57:21 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:57:18 +0300
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
Message-ID: <20230814145718.g5gpekxus4n3ycah@skbuf>
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
> Adding the mdio property to the dsa.yaml schema will allow it on all of the
> schemas that refer to dsa.yaml such as this one. This addition here is only
> to disallow additional properties under the mdio property for this specific
> schema.

So, how about not adding it to dsa.yaml, but to individual switch schemas,
along with their specific handling of phylink bindings on user ports?
