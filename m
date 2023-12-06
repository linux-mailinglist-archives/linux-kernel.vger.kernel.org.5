Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D70806921
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbjLFIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjLFIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:09:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BF1A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:09:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d053c45897so46860085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701850185; x=1702454985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUhuNFsiAvrHYnZLi2Em140Y4QPJessaIPRDZmEdsMw=;
        b=Io9eTDwxeQPqsLt96Rz6xCqdjG870CiP4zW502sefFMqFwzjoFSGXrGFUiV3w8jzoC
         bPiNPWwJGuJPV5rwblnY/6CiQour5bQGbZrXJ8eOFbRJucpb26xyUfpGqaPITFQ4OAh6
         i1BrpgP55mDz8OpsOlXyM+fKe4BXzukRC18FKWPPuRFsMyqcCMG67FWAi+CE8nY9xosg
         oAe49GChMVc9tt5H6xyjBgaMu4KSM1s7xmLtZRhTtK4s+QB8v0Bhdu/9gWvbNq7wMuWm
         7VEVenFSKDLZn2snvgdTmYA9co2UUXpP+tfINSm8oDJV0lErH/L5bcg2HIMZ9ha66VAs
         6eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850185; x=1702454985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUhuNFsiAvrHYnZLi2Em140Y4QPJessaIPRDZmEdsMw=;
        b=gUPBK+2OvgVXXPnzIYNXz5x2QtnfMKLm9O0UVGEzHc8fKdrioLlGxFElNNpTxkLBke
         I68Kd5z9Z1yaVOVW+Mb3+z4Bo6bHTscNOVgPGm1vNxHonnW3REGT8WcSCafvxaktMjSZ
         6JbE/3Mu7QLvxemT3NfmBOI7RvgeUjDpXn2mjKKGVo4ytYSW1R9RX3oRfUyObgLN5XNk
         5Z6M74kHO6jwRbJQrWM3Caxwvp6b3Szdk6AW7bFe6TfV2cLOXfYdIfUIdUveSK/EP3aq
         JOYPrWIgFzgNAyg+ZduwUxVwNcwCHmypZSthzo8CTqksYPvtPnkkvbasaJy4LvKnL+DC
         cJtQ==
X-Gm-Message-State: AOJu0YzBg1V938ukSZDRtGbr9K6g2nNIlP/qYd3iip3ctxm7ib7jW6Fd
        i9H9t59SORs5FXIv+l8H4TDayg==
X-Google-Smtp-Source: AGHT+IH3gRYGjosEd0BiJj75NNhlV088XtZ8mMy8bZQeahdEBG8P85BdfI6y2nZrTFPSVoonaAxNwA==
X-Received: by 2002:a17:902:b08e:b0:1d0:cd9e:424b with SMTP id p14-20020a170902b08e00b001d0cd9e424bmr475933plr.43.1701850185075;
        Wed, 06 Dec 2023 00:09:45 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:92e9:8fb4:700:680])
        by smtp.gmail.com with ESMTPSA id bd11-20020a170902830b00b001d0d312bc2asm1208668plb.193.2023.12.06.00.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:09:44 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 06 Dec 2023 00:09:21 -0800
Subject: [PATCH v8 1/4] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-th1520_mmc_dts-v8-1-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701850181; l=951;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=4RIHUzQaxou3jWGQo/iOBjqUj+fsmX35ctdJCieIZQA=;
 b=MY1Zn/vpteELgknAAqVIXREnspLxXc/K9fvkAmxIH0O5NBcwu6+SJNZDx/iNZIPHhcMKHzFZn
 HlK6cjYNyhFADzUsGzTvSSr8g8A+4qXhyxs+w65zE8Zyoc9DoL/xiiI
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the mmc controller driver and dma controller driver needed for
T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
boot from eMMC storage.

Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..e635dc9d1997 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -214,6 +214,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_STARFIVE=y
@@ -223,6 +224,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_RZ_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y

-- 
2.34.1

