Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD480E403
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjLLFnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjLLFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:43:42 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF8BD;
        Mon, 11 Dec 2023 21:43:43 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9dadc3dc0so3923875a34.1;
        Mon, 11 Dec 2023 21:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359823; x=1702964623;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G/kRQnlrmzAaEgbJW/nHYsdkLSYAXxTeBfYcPh2ZwjE=;
        b=P1XzrPVWGP6ie+YFuOl9VUB0psNVvZrEQgyMWN3DG2OhY/dWMd7lfBZYI1vUF0OG93
         oOHDnOglvErCBw5uBGbTttnX2ulFWrza9dwocAJ/XbiTnZLy+cGBfdSLwE1l0OiRqDae
         iamVAcuydQrJbKCSg6bDEkn//6lm10NjQ/JGW9A9mwSkJTAXwGRLlLlBDopkby3KXb1e
         xKzopaJbfVOd0jRS50HmgdX/ZfCXZz1+LTQJuzQyP/smkXfYqZyI6mhO+vbXEZEh+OpV
         BBLU9Jdt2AdY1lOGJne/k5Ejplk4g3izXeBvmsdqHecjUEfH9DZ9mzP7+c4xeuXueIRO
         KsOQ==
X-Gm-Message-State: AOJu0Yxu9w5JlzxaRhWNkqlfgEXrm949UyuR620x+23jyuJVtabGiU4a
        Fodjq/b/Q9MtiyZg4SuI7g==
X-Google-Smtp-Source: AGHT+IHfJVsFVCXlkAo5HjVP5AjAq4xIe1OLORfTZofd6AI7iHeRszHF1WOfLlCCf48/2Or6Rr6kNw==
X-Received: by 2002:a05:6830:20d9:b0:6d8:49a1:c52b with SMTP id z25-20020a05683020d900b006d849a1c52bmr5865800otq.27.1702359822924;
        Mon, 11 Dec 2023 21:43:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a9d7506000000b006ce2fce83cbsm2071485otk.25.2023.12.11.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:43:41 -0800 (PST)
Received: (nullmailer pid 39734 invoked by uid 1000);
        Tue, 12 Dec 2023 05:43:35 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Vinod Koul <vkoul@kernel.org>, John Crispin <john@phrozen.org>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        devicetree@vger.kernel.org, Alexander Couzens <lynxis@fe80.eu>,
        netdev@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Qingfang Deng <dqfext@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <5859da6629b8b6c100eca4062dd193105bf829ba.1702352117.git.daniel@makrotopia.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <5859da6629b8b6c100eca4062dd193105bf829ba.1702352117.git.daniel@makrotopia.org>
Message-Id: <170235981509.39662.6730294984307830032.robh@kernel.org>
Subject: Re: [RFC PATCH net-next v3 6/8] dt-bindings: net: mediatek: remove
 wrongly added clocks and SerDes
Date:   Mon, 11 Dec 2023 23:43:35 -0600
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


On Tue, 12 Dec 2023 03:48:10 +0000, Daniel Golle wrote:
> Several clocks as well as both sgmiisys phandles were added by mistake
> to the Ethernet bindings for MT7988.
> 
> This happened because the vendor driver which served as a reference
> uses a high number of syscon phandles to access various parts of the
> SoC which wasn't acceptable upstream. Hence several parts which have
> never previously been supported (such SerDes PHY and USXGMII PCS) have
> been moved to separate drivers which also result in a much more sane
> device tree.
> 
> Quickly align the bindings with the upcoming reality of the drivers
> actually adding full support for this SoC.
> 
> Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 32 ++++---------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dts:18:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/5859da6629b8b6c100eca4062dd193105bf829ba.1702352117.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

