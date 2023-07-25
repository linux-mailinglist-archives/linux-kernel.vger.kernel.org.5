Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09576047F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGYBAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGYBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:00:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7F10F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-553b2979fceso2026314a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690246843; x=1690851643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjptT1JAo6APLrBCr3T/Njj8Ut+EIbCwxhdTzUr/jGY=;
        b=RsS/Dxo4J7mrQnCESvRMUJ4+qmObT0YYUvWIc6OBoeiaLJaKoXMvlYFI25EqtRWSBt
         wtOVt5gCFn7knLF52RL66/YXJEI8dJVaiFzJSyf9rCfKXDFYqKvs2NIUKFpZWbvBXxA0
         EOoPX0xKOaL4LfQTdSu4tvwqNXnJdETYOTMVbT7FCZ/WgbEKg+ZThX1PumPiGd4ptnEu
         VOGijO1mhvegyIY+qzaWiAlxgvfxOvLrhbUk980wndp4Z/KN+PYMplBCrrraRlaGQC+u
         A4QwPS9j/dUeKkEUdXWJ+YLpNq9aZNIKMBSEcYg9r96urm0cHsU+MQbpzeeWPukv+RMq
         1sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690246843; x=1690851643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjptT1JAo6APLrBCr3T/Njj8Ut+EIbCwxhdTzUr/jGY=;
        b=aNHMy4Zy40mXjIcapq5gfhL4l/r/dyZ+8je4LBg1WQeqt51Vs27r4Q8X9JyATs+IvQ
         yuszm9TyOYtc7Cd+K5tRFqik3jtYkNWAvyNA6FxJ9Wv3g2aNS4UV2QMLi0UubO4qe6/a
         P7pKXcz+zJKkF9yvJS1o8SLLtDyzcz9cIP69Kl2ZaS8PLpCN9pUus0FUUV3ta06Mh7hl
         5fub0gjZ69L9ZyWL598ggITrhRyrDvnp8JAAUvaMgU5FxXZlxLfzRINbk5B2W5gaBkWk
         CKlWOI1/7tAdNYOEh1J5RVgwRimqL36de+uQz6CLSDrcjy82TIzML/+Jd3GU1+ZiXbI/
         sqlA==
X-Gm-Message-State: ABy/qLa0II8EJyVCyckdb30hk2fy8RDs41JxWu/SiI3zPgYvryHgcGRI
        CfuVWG7XuG7oBOxzvupnWXNPVg==
X-Google-Smtp-Source: APBJJlH2wjLOOW96TXK80PRQDJaUMRx9PYau8YGE4KcjOBDpRvW12RY7PzL7XRjA1UgvKTGGDzI0LQ==
X-Received: by 2002:a05:6a20:8e1b:b0:138:3302:1471 with SMTP id y27-20020a056a208e1b00b0013833021471mr12436514pzj.6.1690246842890;
        Mon, 24 Jul 2023 18:00:42 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm8576900pfn.17.2023.07.24.18.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:00:41 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH RFC 0/4] RISC-V: Add basic eMMC support for BeagleV Ahead
Date:   Mon, 24 Jul 2023 17:59:14 -0700
Message-Id: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIev2QC/x2NQQrCMBAAv1L27EqamLZ6FfoAr+IhTVaTQ6Lsl
 iKU/t3U48AMs4IQJxK4NCswLUnSu1RoDw346MqLMIXKoJU2qtcnnGNrtULK2WNvfKDzMCgbOqj
 F5IRwYld83JvsZCbG7miRvdmFD9Mzff+7O9zGKzy27QeBonZkgwAAAA==
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690246840; l=2518;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=AUPEwpyDxsigwBWm3NiT3sK0EsmNOZWp0bCGe7BGOA0=;
 b=se8Hk4XUDD1D8YXFzAuuvFR2cNqx5kl7XVjj2BXZe6pCsgL4MebKjhHyl85LVO10JXmnkqHti
 P2KpzCT59ToBGEmvQMO0EQQ57q9wKGnwwViW3oPnYn+IIVx1IJWuCAF
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for the eMMC on the BeagleV Ahead
board. This allows the kernel to boot with the root fs on eMMC.

I tested [1] on top of v6.5-rc3 along with the prerequisite series [2]
that adds the BeagleV Ahead dts file.

I am submitting this as an RFC for other people that want to boot
mainline Liunx from the eMMC. There several issues that need to be
addressed in order to claim that MMC fully supported on TH1520:

  - Only the MMC controller connected to the eMMC is enabled. I did
    not attempt to configure or use the microSD card slot.

  - The new th1520 compatible in the sdhci-of-dwcmshc driver turns off
    DMA and just uses the inefficient PIO mode, because I did not yet
    get into the correct configuration for DMA support.

  - The new th1520 compatible in sdhci-of-dwcmshc turns the reset op
    into a no-op. The vendor boot loader [3] fully configures the mmc
    controller and the phy. The kernel does not yet know how to do that
    so it avoids doing a reset. This is essentially a hack and not the
    correct way to handle the situation.

Fortunately, Jisheng is the original author of sdhci-of-dwcmshc so I
am sure Jisheng will know many ways in which this can be improved.

NOTE: I combined schema, dts and driver patches into this one series for
the purposes discussing the RFC but that is probably not the correct
structure for a real patch series.

Thanks,
Drew

[1] https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6
[2] https://lore.kernel.org/linux-riscv/20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com/
[3] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-u-boot

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Drew Fustini (4):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 compatible
      riscv: dts: thead: Add TH1520 mmc controller and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC controller
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  1 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 14 ++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi              | 17 +++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 42 ++++++++++++++++++++++
 4 files changed, 74 insertions(+)
---
base-commit: cb8c874afdc063290797ae1776a5d410fecb06cb
change-id: 20230724-th1520-emmc-73cde98805d6

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

