Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1357AA6C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjIVBvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjIVBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:51:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F5F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:51:09 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dc3f17952bso886269fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695347468; x=1695952268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxT7MI2lb7w2tzMJaLbHsAOT60s7Ptz9WOHyKvQ6hKs=;
        b=ReEltBg7i4JzFYOEMGbVDmxmSfz6tZBl2XDeJnEbkWTOyOr+5yEceEnzcST+MTHZXw
         BUoHTearrgjamTummhwPgDjWQfNhDPV9xoUvuQ9Cq7fzn9lkD8oNFLlxnMCf1dqVOGY7
         5dmlxJ6gWKounPkoml7T9CjejdFAc0BNRflw8QnYyhkX84N0LsweTHq9wiwEoDgBK4rH
         +ER+qGLnIy2MAW/LrLOKS1a7zaTaz39ltMimBhEXJ4SiUmCwt+F4jXiJ8VycsDGChdxU
         Vv36swcCH5NNwMR2iwTEKno0i89oKXUQzBV8HWAMweVhiQArFJjVXrBf6YWvENz5rjoo
         16ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347468; x=1695952268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxT7MI2lb7w2tzMJaLbHsAOT60s7Ptz9WOHyKvQ6hKs=;
        b=dUSVmfeytu6kWYbZyWyyYZ309tOpIm18Yl+Fqcp0/3uX9apbFiJBAaxh+TRBmjsj/1
         mId3eKKOLbtnIXujXVJnfgZN0r5YIvBmwh1TQk1sCoZFwMIhWv5DaXu4E8L+4DCDLATk
         ohHfDsElzcgnSiwwOsKJTGldxJcuJgtMeN2WE6X7rS/MQjpLbUymSxju2llmabJCwHBs
         YUC6KEcuCi9kolL+uq27FYh/e7X3oYaiaYZTXCyrrbvy8yKkvIj26r28i0boKX/bURY9
         sdHjA4x/uNp/H9CDXZ3w9kBC4egWd2WfY3nKSkSiygI4++ltqIAoh0eoG74xcnc4rufM
         2Vsg==
X-Gm-Message-State: AOJu0YwhXOBvexu4HX27dk7Ltd9sdZlOkfityjEQc71NwigP5insIPWA
        SRymG+vYvTHHc06AK/nCvaQwiA==
X-Google-Smtp-Source: AGHT+IGOiY0FLBw9/6j89iCI7nDLKyeDUufvwojlifiaXgKtUsAKGuckLBp4bSf3j5HZEVnEu1sWxA==
X-Received: by 2002:a05:6870:ac14:b0:1b5:688b:5c24 with SMTP id kw20-20020a056870ac1400b001b5688b5c24mr8317953oab.32.1695347468248;
        Thu, 21 Sep 2023 18:51:08 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:fa26:6227:be1c:67f0])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm1973856pge.4.2023.09.21.18.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:51:07 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
Date:   Thu, 21 Sep 2023 18:49:47 -0700
Message-Id: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvyDGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyND3ZIMQ1MjA93c3GRdU0MLCwOzxERT00QLJaCGgqLUtMwKsGHRsbW
 1AIE3bOtcAAAA
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695347467; l=4409;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=TsJ18vOw1amlgVGcXat8klPQchAwNWl+YaMuYvHoF+4=;
 b=jzGQw+gp4aQ3WssWlcCJ1CI8Sw57dIEOlnAyzTpnSGcOZB8Lx3iKdYt+JyPlSiyQsOsVmJuKf
 AF4jEadFNIQDU2cggKSGH2Ca4Dk+nYeA71n5PgMAVwKOLUzbvLlKMtf
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the eMMC on the BeagleV Ahead and the
Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
eMMC.

I tested on top of v6.6-rc2 with this config [1]. I was able to boot
both the Ahead [2] and LPi4a [3] from eMMC. The following prerequisites
are required:

  [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]

I pushed a branch [5] with this patch series and the above patch for
those that find a git branch easier to test.

Please note that only the MMC controller connected to the eMMC device
is enabled in the device trees for these two boards. I did not yet
attempt to configure and use the microSD card slot. My preference is to
address that in a future patch series.

References:
[1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
[2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
[3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
[4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kernel.org/
[5] https://github.com/pdp7/linux/tree/b4/th1520-mmc

Changes since RFC v2:
- ADMA mode now works correctly due to a patch from Jisheng on the list
  ("riscv: dts: thead: set dma-noncoherent to soc bus") and this commit
  from Icenowy that is now merged: 8eb8fe67e2c8 ("riscv: errata: fix
  T-Head dcache.cva encoding").
- Expose __sdhci_execute_tuning from sdhci.c so that it can be called
  from th1520_execute_tuning()
- Refactor the define macros for all the PHY related registers to make
  it easier to understand the bit fields that the code is manipulating
- Replace magic numbers in the PHY register writes with proper defines 
- Replace non_removable in dwcmshc_priv with check of mmc_host.caps
- Drop dt prop "thead,io-fixed-1v8" and instead check for existing
  properties: "mmc-ddr-1_8v", "mmc-hs200-1_8v", or "mmc-hs400-1_8v"
- Rename dt prop from "thead,pull-up" to "thead,phy-pull-up" and
  improve the description in the dt binding
- Replace pull_up_en in dwcmshc_priv with bit field in new flags field
- Create th1520_set_uhs_signaling() and call dwcmshc_set_uhs_signaling()
  from it instead of adding th1520 code to dwcmshc_set_uhs_signaling()
- Return -EIO instead of -1 upon errors in th1520_execute_tuning()

Changes in RFC v2:
https://lore.kernel.org/linux-riscv/20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com/
- Expand dwcmshc_priv based on driver in the T-Head 5.10 kernel:
  delay_line, non_removable, pull_up_en, io_fixed_1v8
- New boolean property "thead,pull-up" indicates phy pull-up config
- New boolean property "thead,io-fixed-1v8" indicates that io voltage
  should be set to 1.8V during reset
- Add th1520_phy_1_8v_init() as voltage_switch op
- Add th1520_execute_tuning() as the platform_execute_tuning op
- Added th1520_sdhci_reset() as the .reset op. This function will set
  io voltage to 1.8V after calling the standard sdhci_reset() function.
- Modified dwcmshc_set_uhs_signaling() to enable SDHCI_CTRL_VDD_180 when
  io_fixed_1v8 is true
- Add many defines for register offsets and settings based on the mmc
  support in the T-Head downstream v5.10 kernel

RFC v1 series:
https://lore.kernel.org/r/20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Drew Fustini (6):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
      mmc: sdhci: add __sdhci_execute_tuning() to header
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520
      riscv: dts: thead: Add TH1520 mmc controller and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC controller
      riscv: dts: thead: Enable LicheePi 4A eMMC controller

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   4 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  15 +
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  15 +
 arch/riscv/boot/dts/thead/th1520.dtsi              |  15 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 456 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   2 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 7 files changed, 507 insertions(+), 1 deletion(-)
---
base-commit: 3d01adbee80b2237c43e2e06d59e05aa243a0fe6
change-id: 20230921-th1520-mmc-518806aa55a8

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

