Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A35763766
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjGZNWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjGZNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:22:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E4128;
        Wed, 26 Jul 2023 06:22:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so1204795e87.2;
        Wed, 26 Jul 2023 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690377723; x=1690982523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPWzpufJv6n62uslZTbP65dBXeCecv6//7U8vz226A4=;
        b=ewpF9oz+uxhIZKk+HzUv370fc6StqAv+3SfLkcmwF3t5VfkJFS3RbGlFqoCCyoynRc
         W8tOXEg1WJzADL8UXDNNoyqdobUJ9cpKVE0SNXiBf7ZlFgMJcEkt17f+vqVi++vFoysW
         0wXqYnl2qvhmh6/BVHYZ+WHProF1bCivgcoLiUa4EtjPkZhZMS8ABJY1CQHWFmbm6eHD
         lP77rpRYF/5JIePlt61ThEqkGf+tmcFnHh6kDyBe7X7D7qVqmdvYc7l9sNgDtISlllIA
         9W1DRoTQnLozR2kCMMkmo7/9Ivuv2Iwkt/PoMNWJ3Wg1tGqMhoBEsBf+CtpmJfIbV8kO
         nFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377723; x=1690982523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPWzpufJv6n62uslZTbP65dBXeCecv6//7U8vz226A4=;
        b=MkM/t4TG/u3r5Pn404M+whZg813p4chZQ1s3hdcYDfV5UUovbvpwCbfIHITbxoBSaQ
         tjOPmR29tn+nT2NwZPjtGHgG5wbymP//GB0bBEQkzvPVJLakRDt/6rGOnLBn/GKh4ptS
         EBYM67H4hBpvI76XpIbilDFi2gL3d45mMkqegyodPQWUORaiIXblBZK1RDOKd6NdYJ4x
         LIlJE9xw+vEKc+tRfq1cdde/xtnFm0+Aqz20kZqupkl/7eH2KjKt2/TeJbThjtzxjFul
         nYaIGmepvdwaTSissRtzU3eHXm7Cb3eQxxJpmy/AOWec31/4qjobrUurNLq/u0bou03y
         575w==
X-Gm-Message-State: ABy/qLZ5+XFStFqDD8yX90EaLTgETALghSLFtnn4PKTHOjWFt+piLRvo
        R5iZuNNQNFodBQOd9KAUXKU=
X-Google-Smtp-Source: APBJJlGrVtjZgA1ReJiDb3S0p0zyLFY5w1xsxsReaY7BnpGYnv56qAkNuEZZeM3E1fI6AMEfVisIOw==
X-Received: by 2002:a19:e05d:0:b0:4fc:6e21:ff53 with SMTP id g29-20020a19e05d000000b004fc6e21ff53mr1406574lfj.11.1690377722464;
        Wed, 26 Jul 2023 06:22:02 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b003141f96ed36sm19868392wrr.0.2023.07.26.06.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:22:02 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:21:59 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        George McCollister <george.mccollister@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] net: dsa: Explicitly include correct DT includes
Message-ID: <20230726132159.rni7zc5ayu67tkxv@skbuf>
References: <20230724211859.805481-1-robh@kernel.org>
 <20230724211859.805481-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724211859.805481-1-robh@kernel.org>
 <20230724211859.805481-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:18:58PM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
