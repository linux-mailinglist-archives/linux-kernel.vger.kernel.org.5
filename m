Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAE76F474
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjHCVIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjHCVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:07:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFA2D42;
        Thu,  3 Aug 2023 14:07:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31792ac0fefso1186147f8f.2;
        Thu, 03 Aug 2023 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691096877; x=1691701677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV2T2OCkDPOD2y9vwdb/sVwgTjjoO8j3LsqgAxgNS4w=;
        b=rNblyVf9qOGCo4i1pPmmxUMzU51K2jyibaaf+9Y5one6V9+/s7RyVW6rxLXbyK1fk/
         drqUfyVBWwjGhJBEoFhlWsK7FQiiue5WZ9YJRGMBeRpzkz4ck466mZ8yw8UTmUIlOydn
         5U2vchkHWclmxFOvyUlOGd+YhHFh5LC8ziwpRNx6yZpm373t2q1CjwWUulnPOcrchbuq
         fKGRjOIymLkHnxFaNekbwOg6f02wDpfSlkuZqLX+ITu8alJx+FhPcvz1pA7cqGlTiB2G
         mpp+6QyBmNlbkHToTtUrkaH93c/sBUEjr8KYX5W6TGCoDiCozEQMOl8NvWf61rq5B9sr
         m7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096877; x=1691701677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV2T2OCkDPOD2y9vwdb/sVwgTjjoO8j3LsqgAxgNS4w=;
        b=TAUEAa3yqyjZDKu/g3gVNEIKn44EqVEl//CG87cnaEx00nmzJie744SEb+0JMHyxAv
         tscXaU2A5318VcQGzlD5WKuVa2rQYFgXSdZHnMOrqa1yq5RcBPILikhIkHeNryf6+DCE
         WhkGMSMWsFbzpfxjQ+kQ7jb7XCblhZvJpMRJUy/1qURNrD06bNGN/vY4eox1V8RaTaE2
         2H+n/Of50O0Mjq532K56It8AOoNrNsq7dUvpvWJSF4Zbge149W8G3mDwAOHD/SuilTnn
         bbbNvhrIIXzmC5oW+VHUEQxgJP6Y2Mv/SVZ748XqvFfvz/sJ7u8TUK5ZiqdPgrVNgImQ
         EIdQ==
X-Gm-Message-State: ABy/qLajfA0/sxmVAIvQxTqg8M5R6dVKZBXmmj99ihTC0mPxNckXMDuL
        SR1s07R13YJHELuK2kB3dYA=
X-Google-Smtp-Source: APBJJlFbf/p8gPAXX1UNOGK+nb3Jhui7ytdP6KvPWP5G4wM44bHi2ILSW1Op3AGS0935rVyVKY5a1w==
X-Received: by 2002:a5d:408a:0:b0:314:ac1:d12a with SMTP id o10-20020a5d408a000000b003140ac1d12amr8845698wrp.26.1691096876584;
        Thu, 03 Aug 2023 14:07:56 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b003179d5aee63sm752635wrp.91.2023.08.03.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:07:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sunxi: Orange Pi Zero 3 DT support
Date:   Thu, 03 Aug 2023 23:07:55 +0200
Message-ID: <3751904.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20230731011725.7228-1-andre.przywara@arm.com>
References: <20230731011725.7228-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 31. julij 2023 ob 03:17:22 CEST je Andre Przywara napisal(a):
> Hi,
> 
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
> Ethernet is almost working, I get an IP address via DHCP, but no further
> packets come through. Might be either a problem with the new Motorcomm
> PHY driver, or some missing delay settings, I have to investigate, any
> help or advice welcome.

When I worked with Motorcomm PHYs, I had to add 

motorcomm,clk-out-frequency-hz = <125000000>;

and usual reset gpio related properties. Have you tried that? In any case, 
it's not 100% reliable, but I don't know why.

Best regards,
Jernej

> Also let me know if the DT split is a good idea or not, happy to roll
> that back if requested.
> 
> Cheers,
> Andre
> 
> Andre Przywara (3):
>   arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
>   dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
>   arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
>  .../allwinner/sun50i-h616-orangepi-zerox.dtsi | 131 ++++++++++++++++++
>  .../allwinner/sun50i-h618-orangepi-zero3.dts  |  86 ++++++++++++
>  5 files changed, 224 insertions(+), 118 deletions(-)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi create mode
> 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts




