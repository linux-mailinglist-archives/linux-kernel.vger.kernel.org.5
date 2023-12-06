Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7288070F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378569AbjLFNeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbjLFNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:34:00 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C662122;
        Wed,  6 Dec 2023 05:34:06 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d9d29a2332so46603a34.0;
        Wed, 06 Dec 2023 05:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869646; x=1702474446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKUyAGPVNJ2iCz/byc+vad2U0HtCXFR/OKxsFSUjBSo=;
        b=Afr08ZZnZPflUMyXwsoWEYz2ezular9v0AiFuR2H+yREBvoQX07sLYoUN1csfE0M+8
         8PFV9eOsxWT0meHHZO1crWjhhg43dFoZzpO6zXKYHHMuZLwgEyiEsUbfoEvwfw7k1Bon
         k/5rHG6bmLPccVJXadEyU5UMQAFgUaPgaZENS3TqYv6/u5s34JrZBuI9+cRYIp3SQhsJ
         pmfKxQcZ6MQ8h/oIH4NZ3EbISQRsDEd1Qe7SdztxRKOg9MW21Df8+wmNng6jmdekriMQ
         k+vKln7W/rb4lWYGX4+H98wPgcDGAXRi2ppCT66RFbElC2uGqNSWzeP1J7PC7NrPLelF
         fmlw==
X-Gm-Message-State: AOJu0Yx9KzH4HMzc1IhChQbqOCTauqXBaUXDiRYCJf5R50ZA2EG3k/V+
        6TkQpIqJ1ylDVDYY5MOs1g==
X-Google-Smtp-Source: AGHT+IHWs8BDYeEsQ9p7nU50NuMdIrEA5NhSUWcTgZm0IYA+OhimehJYkLAie1qpwHIrrcHjciYBFA==
X-Received: by 2002:a05:6830:2aaa:b0:6d8:74e2:552a with SMTP id s42-20020a0568302aaa00b006d874e2552amr431988otu.22.1701869645696;
        Wed, 06 Dec 2023 05:34:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2665206otk.45.2023.12.06.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:34:05 -0800 (PST)
Received: (nullmailer pid 1911334 invoked by uid 1000);
        Wed, 06 Dec 2023 13:34:03 -0000
Date:   Wed, 6 Dec 2023 07:34:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII PCS
Message-ID: <20231206133403.GA1894508-robh@kernel.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
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

On Wed, Dec 06, 2023 at 01:44:38AM +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    |  46 +-

Why are you changing the binding you just added?

In any case, bindings are separate patches.

>  MAINTAINERS                                   |   2 +
>  drivers/net/pcs/Kconfig                       |  11 +
>  drivers/net/pcs/Makefile                      |   1 +
>  drivers/net/pcs/pcs-mtk-usxgmii.c             | 413 ++++++++++++++++++
>  include/linux/pcs/pcs-mtk-usxgmii.h           |  26 ++
>  6 files changed, 456 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
>  create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h
