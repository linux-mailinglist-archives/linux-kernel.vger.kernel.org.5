Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C959A8065BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376577AbjLFDjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376525AbjLFDjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:39:48 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF2D44;
        Tue,  5 Dec 2023 19:39:54 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d9a1a2fb22so1827987a34.0;
        Tue, 05 Dec 2023 19:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833994; x=1702438794;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27O2bZEy3+KAENa38gDF53q97pnYbs0pdHxflIPcivY=;
        b=ahDm9Ri6+2YPjIRhEi1NZjpE3PxWHwkURHGocDi5tcwDS/6c2m7ukYWxTQtekM6yL5
         IO81dGtIuBvKBb3xW8cHa984MfKHEXz0FTJKCKoD3HFFXmzDyhUxXsb/YGeZE9awrbSf
         yQuzK5Xu8vs+XIItY/ToUhbstjlbVgbo1Ta52gsGS4fZHu4nzkyas9ju4JPClFfogA0/
         1seGof0vmVTbxvqUBAHpYDuKwNTNBhIuXu1BRD3ajmVgIvG4z+JJTo3DdG02M59MLvEg
         PMb6S73YV+Ygk+w4me7bHt6M2RXRk8RBGnyaggwxX7MS4FOEbktTLsvoPhSdHc8BlsOA
         gOXw==
X-Gm-Message-State: AOJu0Yy4m42a+pR2UBaYCZDDe+Y7LzCwuvlbd1mW5w4zXmZekbgRN+yX
        mXRLtdB+/37POAVsqfaoxA==
X-Google-Smtp-Source: AGHT+IFZmK9knTyK6Z7myA7wKKOiYLq1oWKaL2xsWe/rjiSvG5jsqRqMq+F3g+GgI8/d743m1gQK6g==
X-Received: by 2002:a05:6870:8086:b0:1fb:75a:c425 with SMTP id q6-20020a056870808600b001fb075ac425mr215974oab.78.1701833993921;
        Tue, 05 Dec 2023 19:39:53 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds52-20020a0568705b3400b001fae2d2630dsm3272321oab.18.2023.12.05.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:53 -0800 (PST)
Received: (nullmailer pid 463137 invoked by uid 1000);
        Wed, 06 Dec 2023 03:39:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Qingfang Deng <dqfext@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        John Crispin <john@phrozen.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-mediatek@lists.infradead.org,
        Paolo Abeni <pabeni@redhat.com>, linux-phy@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org>
Message-Id: <170183397366.463026.10686567364320956476.robh@kernel.org>
Subject: Re: [RFC PATCH v2 4/8] dt-bindings: net: pcs: add bindings for
 MediaTek USXGMII PCS
Date:   Tue, 05 Dec 2023 21:39:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 01:44:27 +0000, Daniel Golle wrote:
> MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
> it in order to configure and monitor the Ethernet SerDes link in
> USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
> legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
> interface modes are also available.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dts:18:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

