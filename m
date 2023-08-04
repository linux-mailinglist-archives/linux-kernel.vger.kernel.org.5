Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCD7708A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjHDTJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjHDTIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:08:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7494213;
        Fri,  4 Aug 2023 12:08:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so24153805e9.3;
        Fri, 04 Aug 2023 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691176103; x=1691780903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUct/82ZzJYoId4uQpyLnXW8CpRtqtjF90BwOBq+j0o=;
        b=Sw0i87+1TNyjnpxDcQG2yBq3mmDztmoLnSIvDewEdu7MsRTVLhilD7q5AKtBLX6bCP
         elMoZXCrptU3/c0hUjL82BhwCUtuwD234IiW92vDvJchvI9yWOV7n3ucy+Kx7L537UpN
         ipmvlloMQL3eFNqO481bhW999WW4XvMDm6ak4OyD64Rpj8BB6hwXU8YfbYPNYGs75uOd
         /SYwTd7gX9E3bMqFbqOqYohdq/v+V4XPSZkY26rQAtiQgPWjeUZjGKHlAxIk49TCmKSy
         gHGT/pFVmDRTERB+/+brCukvg2dEggQozIodxVeorNa5WTQs0TY+qbw22NEndee1NBb9
         N+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691176103; x=1691780903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUct/82ZzJYoId4uQpyLnXW8CpRtqtjF90BwOBq+j0o=;
        b=Ht52fNhzJrBVlv0oV37cZRYAiNfBlybDJIPQIUZzFcPw0s1X8CnSyz+QoJb90BkV6W
         gBZcREwCdjFf4BPXaI86BAd5L2XRn+mOWqReW6MELOkTDEVBSPDUR5242RZcQE2E4lGW
         6uyK4ubldWrwJ+huY0iLV8yg+MrMRKIsI+kDOtbBpShi7pTOFkaZN6vyyyP6N/kOrxKj
         DJwa4UJq8bFJVtfABj9ECZ6mLa+npbjMwDDehwGVy3cxBnHApQV15vH/jxZ4ZgCv7BE0
         1U8qLyXJip2GZR1YzrA1eGsDNlGfB/EVP+Bjfby2yGp84rkRjzzgoIm7R+GtEPO/V0U0
         fV6Q==
X-Gm-Message-State: AOJu0YwiEoegEAirdTTMA42FPNvR8LVeQ4ZkiixOLP82kcnhuyWOTYdT
        x/dzZJaSTk6rBo2Q94SgaZ0=
X-Google-Smtp-Source: AGHT+IEVrZLvF9EJvd/t1u18YqhdNyGjzTlFOtuLbcjUbAk5S3X8YO69YyZ5+NC4O8tskW7xE0E92w==
X-Received: by 2002:a7b:cbd3:0:b0:3fb:c9f4:1506 with SMTP id n19-20020a7bcbd3000000b003fbc9f41506mr2400916wmi.1.1691176102471;
        Fri, 04 Aug 2023 12:08:22 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id u24-20020a05600c00d800b003fa95f328afsm7461683wmm.29.2023.08.04.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:08:22 -0700 (PDT)
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
Subject: Re: [PATCH v2 16/23] bus: Explicitly include correct DT includes
Date:   Fri, 04 Aug 2023 21:08:19 +0200
Message-ID: <2151246.irdbgypaU6@jernej-laptop>
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 04. avgust 2023 ob 00:42:56 CEST je Rob Herring napisal(a):
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
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>  drivers/bus/fsl-mc/fsl-mc-msi.c | 2 --
>  drivers/bus/hisi_lpc.c          | 2 +-
>  drivers/bus/omap_l3_smx.c       | 1 -
>  drivers/bus/simple-pm-bus.c     | 2 ++
>  drivers/bus/sunxi-rsb.c         | 2 +-

for sunxi-rsb:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/bus/ti-pwmss.c          | 2 +-



