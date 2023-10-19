Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F507CFAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjJSNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbjJSNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:21:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C498;
        Thu, 19 Oct 2023 06:21:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so13380204a12.3;
        Thu, 19 Oct 2023 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721687; x=1698326487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgxKa8AO9ndn9A10MY0AzoFh3nJur0uCTmMfy39Eot8=;
        b=JW2EdFx3QJ/7jxW2xpcnJYEN8HSXL8Vk0zF8lEfzK/9PRouUWJlGlxxsZmpJnGeKOG
         aurGBoh6Hzgij4mF6vE2LWAOYSlCkY8DILHKy7sOkAHbLp0OiBOhyhkMg7u5xhWKkTJ2
         vaTVMlU+CYEqwV4pvBY4GkooueLy3YBtVFVa1HQEaIQq8oivV8r1XO19dgM823JSdPTj
         jN8BWKD850e0enJAlOL+uGa1zwjI4vLUDvBGpZ5iiQOoiDS+IlejRBmJ/czHTPc/Zxbo
         S3kYOCd+k7/Q6956nQACvFcZ5Ts1BXAnnV2BBffHZIbjHZqJNliFtS3jTAM+qkFJUxJp
         rkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721687; x=1698326487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgxKa8AO9ndn9A10MY0AzoFh3nJur0uCTmMfy39Eot8=;
        b=PYRG5xKuPtldafesFA0iAVmMVnITS3mvFck700f5NeSgSM85+ysDtMyZQA7BEF8wwY
         kRvIvC+yrI0Lx+N7FNBEFUdZ7wEJ3m2F0l651+/x4PnPc34HQzONKpPAYRi9pxrzd2Sw
         l6hWc0oaXHfcXWRvDJwGC8WQUtWVVwd47Iq6ITvk8m1O1d5mpfoJj7ZM/UDs7U+yekPa
         ugNAcH5SfM4huCNaFxqQfBbTGF0zVmrozE9NQFFVaEwd1jVb5fE++fzteTmjvZ43TDZ8
         gCHASE4Bk0y3RUOj/HkSCc7XrzKuB+gPXk0/D0SXr4+SkwbKcPEmeW8EZONWoaIRTQGM
         qvEA==
X-Gm-Message-State: AOJu0YymFGuuwOoLHaS/Js/d5XeiLBZBVVVoJia6OOnx3Db8fGYkkebj
        6sTTWai3dbzh8gFqEtmjvTM=
X-Google-Smtp-Source: AGHT+IGPYVxFFY4V5wJ9ZKXaFEG0/Ul9BCX45nfhQeyJcBnICEDGph1b8CwndVzz+OMYm+48TScO8w==
X-Received: by 2002:a05:6402:2813:b0:53d:f358:202c with SMTP id h19-20020a056402281300b0053df358202cmr1823338ede.5.1697721687185;
        Thu, 19 Oct 2023 06:21:27 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id s10-20020a508dca000000b005340d9d042bsm4358136edh.40.2023.10.19.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:21:26 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:21:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?utf-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: dsa/switch: Make
 'ethernet-port' node addresses hex
Message-ID: <20231019132123.3jcyky3ruxfgstoi@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:44:22PM -0500, Rob Herring wrote:
> 'ethernet-port' node unit-addresses should be in hexadecimal. Some
> instances have it correct, but fix the ones that don't.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
