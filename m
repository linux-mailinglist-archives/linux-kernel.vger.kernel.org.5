Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42998065BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376516AbjLFDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjLFDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:39:43 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619DD4D;
        Tue,  5 Dec 2023 19:39:49 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d52e0065fso233404eaf.0;
        Tue, 05 Dec 2023 19:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833989; x=1702438789;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Cp6B76RfEovozKgFZOSkZEc0z4IdQhSv0EPMVtgG3c=;
        b=VL29NtxPH7uxZiBjVslU/xBn9dt4nYOwFagKUHrntyzOB9AcYeiB+Owrk+WQncm8cB
         jI6xdsKjRQx5AfezksUpsWw7N6IDIWe9UyTMJ9/mRwybDB8Ft1a21hGjGRfo4NMbIfPK
         Ftdeh19Ld5w9YWB83fVtn9pzX7A6LbO1d13S1QfT9qXR/vpUIwjnAqMLT8qJ3UsbM9Rm
         2BDzqxnJfyiuozJBzWvi6Q+0fD+yyoYLNBLpudsFqjoCzQdGWTK7CQLePN0dec6HZ2XL
         KUQg13yBV7zjE2J5/YoNimljF3Ww6DZO4HhVvzVtM4Ssze0if1Dbg74YNx1L5fqn/y3X
         Ksww==
X-Gm-Message-State: AOJu0YyogHbiLYu9HOH5shoHHi6X9oPl4lvAgq3eojYiMbeBCI1yDaqs
        MLNNYe6Mh6fQV/HjXrA3og==
X-Google-Smtp-Source: AGHT+IGHF5dD63okkY1uvYpYaFlmCqd+PhAofHIUKjCT14hyHnztdFSRU2uuzJg0QPWdJ+poKIuuKw==
X-Received: by 2002:a05:6820:2c08:b0:58e:1ca4:cb7d with SMTP id dw8-20020a0568202c0800b0058e1ca4cb7dmr992708oob.9.1701833988882;
        Tue, 05 Dec 2023 19:39:48 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id br6-20020a0568201a4600b0058a0d3fb333sm2492975oob.37.2023.12.05.19.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:48 -0800 (PST)
Received: (nullmailer pid 463143 invoked by uid 1000);
        Wed, 06 Dec 2023 03:39:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        John Crispin <john@phrozen.org>
In-Reply-To: <567c6aaa64ecb4872056bc0105c70153fd9d9b50.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <567c6aaa64ecb4872056bc0105c70153fd9d9b50.1701826319.git.daniel@makrotopia.org>
Message-Id: <170183397601.463117.12810951410156171210.robh@kernel.org>
Subject: Re: [RFC PATCH v2 7/8] dt-bindings: net: mediatek,net: fix and
 complete mt7988-eth binding
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


On Wed, 06 Dec 2023 01:45:02 +0000, Daniel Golle wrote:
> Complete support for MT7988 which comes with 3 MACs, SRAM for DMA
> descriptors and uses a dedicated PCS for the SerDes units.
> 
> Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 148 +++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/mediatek,net.example.dts:231:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
  231 |         #include <dt-bindings/clock/mediatek,mt7988-clk.h>
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/mediatek,net.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/567c6aaa64ecb4872056bc0105c70153fd9d9b50.1701826319.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

