Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098897ACBC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjIXT7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIXT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:59:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751DA6;
        Sun, 24 Sep 2023 12:58:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so4949566f8f.2;
        Sun, 24 Sep 2023 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585534; x=1696190334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4gxioHy8aGHDnCuZrlWWRKNJpX1fQ4gmtJqtKMaNZU=;
        b=aUFN193+l7nPZoi6l4QiuaEOll46fM1uExThbr4M2kyPUZkHLL7HJ8Y2aJns8duzQH
         8MyXWbU4dv5VNzP47qWPv5L8vRqUdMAZ6tYCsW96aqMWUOFtpheIzcqKP1WeF9kMIZJu
         Fd0z8wYbZxYOVpu656gHXRj0W+/uUEQ0M9NcqsQrD1ZoX1oY8u6jilUQR0n0eXHpK5mi
         FKP3cv6S2q7nmk1c92QwRIv5OVJB10CC1wLFvEYIi7nyiwTMqu4aj7lGr2b6iTWOKoYe
         3KDWyVJqFMh3PbGvcZaBNwpnJSynNiWIczMku10KcfL8aYfAxVpafNjfyoGo3E10rMRR
         rnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585534; x=1696190334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4gxioHy8aGHDnCuZrlWWRKNJpX1fQ4gmtJqtKMaNZU=;
        b=P9GNGxEFrqyfxaIVmiUtMs2Iri2ibQy7l+oUYKMmFFPhNAnmIp7ALJkMKrX8l33HHL
         gTHy7xT2PG1SISV2O77NpEZx3t81V92Q1Dcx4BS1HTsrpybQX0l8aTbbS6LkUtxVtCBv
         R1zsUCvIoqpzs0IDet20XcdRNelUPlJX9m3SGjEH9kqJC5cgPoHnidFbEWvnafTTbJLx
         RS6Iqwy2t+5GnkrcE762VQZOyYktDl/UrTEM2s7G4o+R+j6HJ66Y287jj/wN8hFzRz2N
         jfBcZhxrPMFXpSVyKjGnw825MPnSsf1v/vfnau2FE0N71eyeRDXRmuS/wD0br9zgbTS/
         BO+A==
X-Gm-Message-State: AOJu0Yy/hJF0ub0ce8pRDoBPVXMXXNHUm7Eg06gLU+ZbwpXLdh5me+n9
        Ezba2Urwr26c/1yBdyDMrFs=
X-Google-Smtp-Source: AGHT+IFlK2jRwDE9nvD4C1P7Ijq53OoCIw27RVycf2mZqkl8y5ZnNXsf3pn/9aRnLQW1RA3FdTAfUQ==
X-Received: by 2002:adf:feca:0:b0:320:4cf:5b50 with SMTP id q10-20020adffeca000000b0032004cf5b50mr4726656wrs.5.1695585534137;
        Sun, 24 Sep 2023 12:58:54 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id dt18-20020a170906b79200b0099bcf9c2ec6sm5311658ejb.75.2023.09.24.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:58:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v6 0/4] Add BigTreeTech CB1 SoM & Boards
Date:   Sun, 24 Sep 2023 21:58:50 +0200
Message-ID: <7571855.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
References: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
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

Dne torek, 12. september 2023 ob 13:20:46 CEST je Martin Botka napisal(a):
> Hello,
> This series adds a vendor prefix for BigTreeTech and adds BigTreeTech CB1,
> Manta board and BigTreeTech Pi.
> 
> CB1 is just an SoM thats based on AllWinner H616.
> BigTreeTech Manta boards are expander boards for CB1 and BigTreeTech Pi
> is an CB1 in Rpi style with few additional things like IR receiver and fan port
> on GPIO.
> 
> This work started before I was hired by BigTreeTech and thus majority of the
> patches are from SoMainline email and few are from my work email.
> 
> This series depends on commit https://lkml.org/lkml/2023/8/28/1073
> and https://lkml.org/lkml/2023/8/2/801
> 
> Cheers,
> Martin

Applied, thanks!

Best regards,
Jernej

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in v6:
> - Remove SPI node from BTT Pi (To be used via overlays)
> - Rebase on top of 6.6-rc1
> 
> Changes in v5:
> - Removal of wifi node comments that were obvious from properties
> 
> Changes in v4:
> - Extend the range of vcc-dram to 1.5V (Max of 1.35V caused issues with booting up)
> 
> Changes in v3:
> - Add missed semicolons
> - Move model string from dtsi to board dts
> - Add cb1 compatible to manta
> - Remove extra empty lines
> - Add pinctrl for SPI0
> 
> Changes in v2:
> - Fix alphabetical order in vendor prefixes
> - Remove CB1 SoM from bindings (Its not standalone)
> - Fixed whitespace errors
> - Move UART into carrier boards and BTT Pi
> - Remove usb1-vbus regulator
> - Fix ranges and naming of AXP313A rails
> - Add comment why broken-cb in mmc0 is needed
> - Rename sdio_wifi to wifi
> - Add model string to BTT Pi
> - Enable IR receiver for BTT Pi
> - Enable SPI0
> 
> ---
> Martin Botka (4):
>       dt-bindings: vendor-prefixes: Add BigTreeTech
>       dt-bindings: arm: sunxi: Add BigTreeTech boards
>       arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
>       arm64: dts: allwinner: h616: Add BigTreeTech Pi support
> 
>  Documentation/devicetree/bindings/arm/sunxi.yaml   |  11 ++
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  arch/arm64/boot/dts/allwinner/Makefile             |   2 +
>  .../sun50i-h616-bigtreetech-cb1-manta.dts          |  35 ++++++
>  .../dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi | 138 +++++++++++++++++++++
>  .../dts/allwinner/sun50i-h616-bigtreetech-pi.dts   |  63 ++++++++++
>  6 files changed, 251 insertions(+)
> ---
> base-commit: cc19c78b3b3f1af285182dd800a3def22227f9a2
> change-id: 20230814-b4-cb1-4b18801ecf6e
> 
> Best regards,
> 




