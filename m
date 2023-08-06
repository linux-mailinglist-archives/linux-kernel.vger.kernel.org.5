Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3B677149D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHFL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFL4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:56:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E713E;
        Sun,  6 Aug 2023 04:56:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso498710166b.0;
        Sun, 06 Aug 2023 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691322962; x=1691927762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1iM8GHQL1XdOnpAjTy8EaoWLHbrJvqfgKPOE2jav7g=;
        b=r04NJdtL5Qz3EAmuH+PnzTOYxkO9VEshjMICuuV65Z4WFVXtSXcTUe81qGwrVr0Wpg
         QJIV/BzxgeeNeKiXRPYumO1mw/Cs5M76giYbWtOBx+RtqhBwnZ5dZ2tIOXVuzaybju4G
         lMdQmlk/LV5Afmzeqt7V6LHGRfJCTNEGxdV/TdMLgrXc/fS0vxlViwEaozgMf/O7rTWQ
         irRy8ULSc/YkzPR6b8mECqrPm6dyzoV9PajSXfj50HwtWZNM/3WI3rXYLqqWkOEiKyxL
         7SAN0MVx2RSg2lMPdgo7AnAPNwaCH+fWmCs+5MPciC0IvxCLUkDbLQkDvKFSYsRgNVqe
         GOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691322962; x=1691927762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1iM8GHQL1XdOnpAjTy8EaoWLHbrJvqfgKPOE2jav7g=;
        b=HosYnw7iCVAPHrGg1n5nPRHqAJiDobJR/rvg0gduO6D3138p72fQe0bPdsq/Nf2nmZ
         EnB2+JU7RcJaZ0lAgXCZxcabZyqKAeqjz4mf+6DrOq3sUZSm+uKZtT7RsAOkmZIlLqg0
         8k36Sb3W3wEbY2ubiTPv9g4ISE6MzlB4HanPDPoFeZzDzkg7OstwhpDtvuarPSQRqpyB
         LZFZjtNWper2rdK5C6c4HmkXbIqeqB94Sp/y5TWL5gKHRltFJG/ZMgnwh2HF7Rmx74WV
         kWJLx6JV9qDc4OIUoouufBc3XXkMYHiv9eGpOLt+kufuGvs9hivSN+d9cDGr6h+Deo1M
         HESQ==
X-Gm-Message-State: AOJu0YzmBEHPZSKjC1hW++puX5Lr8haxuRNnZo635KJaOpDkNu5qzzdH
        iWEzjhd19DUtZpZtbr6tkhe9uwtysaE+YA==
X-Google-Smtp-Source: AGHT+IH1W0zyeSdKweK3PY1lF8bG//t+dHTurQt0Pw2c4xKMHDBvAXvI1eiz/JcL1V6oFVRQkKKSlg==
X-Received: by 2002:a17:906:20dc:b0:99b:431b:a5e9 with SMTP id c28-20020a17090620dc00b0099b431ba5e9mr6201836ejc.45.1691322962073;
        Sun, 06 Aug 2023 04:56:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709063a4c00b0098e2eaec395sm3836658ejf.130.2023.08.06.04.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 04:56:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] sunxi: Orange Pi Zero 3 DT support
Date:   Sun, 06 Aug 2023 13:56:00 +0200
Message-ID: <8252315.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20230804170856.1237202-1-andre.przywara@arm.com>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
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

Dne petek, 04. avgust 2023 ob 19:08:53 CEST je Andre Przywara napisal(a):
> Hi,
> 
> quick update of the series, mostly cosmetic fixes, except for the
> regulator range. For a changelog, see below.
> 
> ==================
> Orange Pi recently released the Orange Pi Zero 3 board, which is some
> updated version of their former Zero 2 development board. Some component
> changes (Motorcomm PHY instead of Realtek, different PMIC), some board
> layout changes, and it ships with up to 4GB of DRAM now. The SoC is now
> labelled H618 instead of H616, which apparently is the same, just with
> more L2 cache.
> 
> Split the existing OPi Zero2 DT, to allow sharing most DT nodes, then
> add the binding documentation and DT for the new board.
> 
> Linux v6.5-rc boots out of the box (the PMIC driver just made it in),
> and most things work: UART, PSCI, GPIO, SPI flash, SD card, USB.
> Ethernet is somewhat working: I get an IP address via DHCP, and can
> for instance start SSH, but it hangs at some point. I suspect some
> PHY setup problem, though others have it working. Help or advice welcome.

Applied, thanks!

Best regards,
Jernej

> 
> Cheers,
> Andre
> 
> Changelog v1 .. v2:
> - rename common .dtsi file to sun50i-h616-orangepi-zero.dtsi
> - add required Motorcomm PHY DT property to enable clock
> - fix regulator ranges: VDD_CPU and VDD_GPU were swapped
> - add comment about broken SD card detect
> - reorder PMIC properties to match recommended order
> 
> Andre Przywara (3):
>   arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
>   dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
>   arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero.dtsi  | 134 ++++++++++++++++++
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
>  .../allwinner/sun50i-h618-orangepi-zero3.dts  |  94 ++++++++++++
>  5 files changed, 235 insertions(+), 118 deletions(-)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi create mode
> 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts




