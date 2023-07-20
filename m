Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27BA75B16A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGTOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGTOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:41:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7BC6;
        Thu, 20 Jul 2023 07:41:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-993a37b79e2so149942866b.1;
        Thu, 20 Jul 2023 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689864081; x=1690468881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwRHBU9c5xadzNDMxPmHn7wr/vyd2lyd2aWFINCC4iE=;
        b=IYkSaw2fLykXQ37NjequnMJ89wJMsFWbIVL50S52MQzxYG63+qLDBbKhKOzKcstmwT
         DaVvF46+YFdhnZvP2A/d93w496r8YnDadWvHbA4T3oCiPcNj1sC84g+IGWuhZwf8GUQn
         94IuCvbFlswK4ZwAmHrXsT+8APe6vS3OzdOTj+Unfk4V/O2sFYPaG24DiTAaU0woO16f
         yMkNztL3l//kUK4segexWIMRNNtFZEogs7zloT/Bnio4to1kJAF9HWGeOX9M6y0W1WVO
         bXVSVky/EgyU7/NsBP4QiB84Ru+t6+KTTJasF2ZecHQC7w863ODzrKLuSLCOmFAq7epZ
         FB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864081; x=1690468881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwRHBU9c5xadzNDMxPmHn7wr/vyd2lyd2aWFINCC4iE=;
        b=NqEdaBmFjbXL6bwUcQdIWPAyRvDYKJLejVWE6Zn7t3s+SfwRvnS9+M1bQUCmaW4xrp
         MsakprGjPePxLifCOa/j10G4wzFlDvPnAojZuhXheHh3WfYeJ1FP/7nn4m+V9NYen7ei
         AHQ1FAKPkfxCfaXsfx7vuZqy1nHI8VNCWfBOj1x9tsRQVzEjlkN/P4a51Bo5P6+OMI+m
         vwmt32s6On/sLP17exggNehNVmCwGWnbQE8HzhuMqI/6wFk78LS1X8da8Iv1E2nkvQd8
         OO77C4WevoZZgzJFximGDsPTP6xGh9SOvWgmdjrvhiDPRj/ZBZBFmi8AdLYrmy7fjEFZ
         sjMg==
X-Gm-Message-State: ABy/qLaygAbxUPTxzr/mr9kLuXr2/p5uP0U8mSyhDFbMPrtJTSZglXXJ
        kYf1kg+IxEvNSAVEmiuwfvA=
X-Google-Smtp-Source: APBJJlHb0tKAQTS3OU1oBfmdDrT4eFmQjBmNHPnnE8cgWVrDPBMDuvkwOC0e1Hj67ZrNMamXYvALYg==
X-Received: by 2002:a17:906:31d2:b0:994:4f08:2bad with SMTP id f18-20020a17090631d200b009944f082badmr5214427ejf.69.1689864081292;
        Thu, 20 Jul 2023 07:41:21 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906274500b009932337747esm788354ejd.86.2023.07.20.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:41:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] pwm: Explicitly include correct DT includes
Date:   Thu, 20 Jul 2023 16:41:15 +0200
Message-ID: <168986404883.1519829.12505785794624953835.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714174852.4062251-1-robh@kernel.org>
References: <20230714174852.4062251-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:48:50 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] pwm: Explicitly include correct DT includes
      commit: 8d171282110fcde89bb4289c4010a15aca5cec95

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
