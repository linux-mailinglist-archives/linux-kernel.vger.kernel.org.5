Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EA4770340
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjHDOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHDOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:38:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903D46B2;
        Fri,  4 Aug 2023 07:38:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea147034so20705885e9.0;
        Fri, 04 Aug 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159895; x=1691764695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM5R+rkSeL9WIp21l2emysOOucIRf/CjafaqigjE3ns=;
        b=P52o47d9dHG1aUMZwk0pd23gUMU1gSEcAaorjtm0PUBSc4CTskirX886xdzRJezLg6
         M4MtQIA6juxB9+sFPFH3EPWi9hMPTVDd1wwyWh3PmXuu1po0m+repmiBQFo72mEPoUaF
         CKzmuVyB06487jxO3URnO0OYZ2cjQP/ZYPY+Ly4YmQO1h8Ul1MwxJiS6CzfTEpBkUg4D
         GvHC2AtRasiPCNfOkLFtYCr2iYrhUrXdaNuwr9xpfY5akGkjLPDtWAHv3doGspA8ZqzA
         BVho52Djxf/ClpbDDROl0ciKQJHwoe5ELFkv+xQsoTFDKnytt8GlFd+Ntd6Geakv25p/
         LA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159895; x=1691764695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM5R+rkSeL9WIp21l2emysOOucIRf/CjafaqigjE3ns=;
        b=RzuENfrf4WDdQiNx2JfdKQd4j0iAj6GskMAll5mFiqF2hbDgW+8Jgh+tvXEZPF4dq3
         agFe/M4H1nG+elZoO2ZEI/2vXTaKY9YmuG5STIU2XxscYTKOveUkDbpn3kl6xuutg/s/
         30zmgm7LWV5AiZ1zvfKZCXC5rApMaiSokthK2179175DZMG9gInvvPPQ1jyTBRzYJ/We
         1CVyRyXUq1i8C2yyc+0zUq4Vk7RFY53zuQv0XP7OGiAWCDKefzTwK8YZoKQpLby1tMOf
         pvRQWabiuVDvdX1I9cj9vHlL1wqWgfrp+4GIeH1qaOCeyB6cweBuo8dBnZgVxPKPo36N
         WeIg==
X-Gm-Message-State: AOJu0YyKk+vedSQRcxOEDUOWb0772KeJ6HvdG9HbfG6ifgdoj0XGfkOs
        g8iueHMP0px2V1qj3WrVQwk=
X-Google-Smtp-Source: AGHT+IFR8gDqjRYqyXRMOxF0JJDJ3mrxElW64dDSszEM8SNr/lPevhKIntH0L12mO9e2OcoWVt3KOw==
X-Received: by 2002:a1c:7c05:0:b0:3fb:e4ce:cc65 with SMTP id x5-20020a1c7c05000000b003fbe4cecc65mr1591896wmc.25.1691159894687;
        Fri, 04 Aug 2023 07:38:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003fba92fad35sm6833727wml.26.2023.08.04.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:38:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     soc@kernel.org, Patrice Chotard <patrice.chotard@foss.st.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Has him <shiraz.linux.kernel@gmail.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jay Fang <f.fangjian@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 21/23] soc: sunxi: Explicitly include correct DT includes
Date:   Fri, 04 Aug 2023 16:38:11 +0200
Message-ID: <2690872.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-21-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-21-d8de2cc88bff@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 04. avgust 2023 ob 00:43:01 CEST je Rob Herring napisal(a):
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Should I take this through sunxi tree?

Best regards,
Jernej

> ---
> v2:
>  - Drop sun20i-ppu.c which moved
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 4c4864cd2342..4458b2e0562b 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -15,7 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>




