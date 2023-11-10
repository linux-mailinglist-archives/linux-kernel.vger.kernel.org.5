Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4647E81B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjKJScd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbjKJSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E2184
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:11:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77bcbc14899so3594585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596659; x=1700201459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=SqNnB1jH6mb/MYWSqSifl/rgG8CG0cf01AYTjzN14rrtT0kITUUDzE8EQXVDSpUVfA
         VqQReYFdKzG4zxz6OcGQLEwMQY61Ws5uxWkDaYMB6tbS3HET10vtGZqrnFZxqxfA+tyG
         +5XQtFVthtKB0hMK75z7X5loOGQyBhKnOsxiJ5LZcm0V1bQFC+IsWpnxZca0h3WKpUIu
         yr5ybMyZK4uuoFEuxL0aQGrUmGqSNwnWC9kxX2TR/Sds6yXZb4Luhe647I1OsH/uUCIP
         htPfcMFq1yGIPcH1drvWWxlbR4jBf3PqGYrwYRRkWaFhlhVLhk2KISl2ShV3jCH0D1dR
         N9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596659; x=1700201459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=oMOWCNdbgY414P+w2ey3Z9nSpgKBR0tSUi/KZ2dQjuHmfoS3cIQOZ525pI/j0bb3Xe
         r0eneZP3rMtD0cG7hNRfWjn1fRSBv9ZhoFYhryUbxRblKZc3HPsL3In+0RpizfrZTBDR
         Y/v+cSWhaW0uFJr/TGXMs/AsMPWp2wFUjK37l+yd14LnktImqWD/Ge6XBckx7iowRT8K
         VzzmhCLiTmNAkWHB06Ytx/uUst+pW7//ybs2kbGaptUG909O1anCgvtcHXsvdlKP9eC9
         AraDMD1xa3vH+GDs57fwaZ/JThH+rCnx/sR3hKMYQY31vjGyqsNo7+304sOWkJpEY7D2
         JmHA==
X-Gm-Message-State: AOJu0Ywomlqt3ryJVeP02N9k3QYeV2uCOKB5eao9K1IBbDcoWeN/eDaJ
        MgvQ69Cm8rE78ZX+MR+3FwIwmumOEHeT2XGz/YRAWw==
X-Google-Smtp-Source: AGHT+IGXmrfa4qbmD8PufQBo8ECvg8/RA13eLrik89guDJz1lWQRgT5GoM06ddfpEcVwZ1Qo931DgQ==
X-Received: by 2002:a17:902:8c92:b0:1ca:8b90:1cbd with SMTP id t18-20020a1709028c9200b001ca8b901cbdmr6854012plo.0.1699594952706;
        Thu, 09 Nov 2023 21:42:32 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:32 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:14 -0800
Subject: [PATCH v5 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-4-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=915;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=ht5Rt9iMCRM1t5yThjxoCTbuOVz3OXmRTAYLzzfd3/s=;
 b=81YrMX/6Pup0Mk4t9Mpny542tULxqVs1k+13xNQqBbmGqkaQgZCsQjsJdqcuxcUGHQdm9Sdy0
 DormnbG2KwrClt9J1tjQHZ3FwqQMqAeqmWYK1a5r2HceKW/UQkdU9DC
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index ab86ec3b9eab..c5a8583236d0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -168,12 +168,14 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.34.1

