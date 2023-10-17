Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD17CCE63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJQUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:45:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEC92
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ca6809fb8aso18213685ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575518; x=1698180318; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxSIBmQz2nzN43tuJvXgr33AyYK24pg3YInpukZ8g2Y=;
        b=B9y2TqsSYT6/6+G+1/RsWCVwv9khIshp+yAoaoh7JocCjM5A6AK9jrGKPkAQ8rErzQ
         vNqhEnK/Kky5b9k3Bme8b327MAk0LqAhssQMERMtfcRCQ3f6gtbrvUNdCaDFFnHrvVDD
         0ffRgp957HvYVtH9KU+i6zc/DT8KEiaRR30B+8+W2K7zfDAAyuplB5r4GnF+ld5diBl3
         j1qGd1vMgJ5Jmw2PRUarRZaEebZSMBuoGZoMaNA+RbDNLGfMOiYP+5aIk+jKuzzfSXSU
         owfQVgtAblKD++6C3oGQ9DeXbSRym67yJ6VjZZrmkoCycJrNI4NgYUocIsm85jEmErjF
         VfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575518; x=1698180318;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxSIBmQz2nzN43tuJvXgr33AyYK24pg3YInpukZ8g2Y=;
        b=UQ6O9qhzVnfOee+3Og/+oNVMoeOfjjis+LL+pHvS7NGcExKJTPjEtbVW9Bh0M1F0no
         5zfH3lnovbxlTAs4w9pjDg5A9jTwG9C0I5Vdq7C8FAOPTDlquFt0piLqzVsnEXcLBoMP
         CNxRvMasipPe3UXQbo7vByRdVsWwwxwvUJsvhXvdWXQM1mXCf7MIuXiTtJWD0+3Ema76
         3hlnvjzxBzwWIghmpeGto8gfUcgZ3cyIDsNiR+b1RPHmdYBPxMe87j+9QvjVQXocWyAW
         av0feIdBUGx20YMIJGlSgyT0iDHrQ2IcZ12P4M1ycELSrPx/7yApwDTP6EtGUc6YKaox
         Z2SA==
X-Gm-Message-State: AOJu0YyS0XlZfbQVP6ycgAHLn9Roh8n4KSRgtLWUGq/h7ayT8EmcpMic
        gwMrsZEdyWR3SeXp96N2mXqGQg==
X-Google-Smtp-Source: AGHT+IFzJBpA/osTxmw5CvOrsRL5plxYtpf8lG+Mm3dt4Rotbz+ybbQ/LDywALGz5jTJgjIGw8pp0w==
X-Received: by 2002:a17:90a:f016:b0:27d:5562:7e13 with SMTP id bt22-20020a17090af01600b0027d55627e13mr3240948pjb.39.1697575517762;
        Tue, 17 Oct 2023 13:45:17 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:17 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 0/7] RISC-V: Add eMMC support for TH1520 boards
Date:   Tue, 17 Oct 2023 13:43:46 -0700
Message-Id: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALyLmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Nz3ZIMQ1MjA93c3GTdJPNkc6Mk8zRTs+QUJaCGgqLUtMwKsGHRsbW
 1AASy3pBcAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=5162;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=K6rdsAPr1vXHC5xTVFVy88n0dRbfsZMxmc2k9uxN7lo=;
 b=Lt9RrBX66jSFJmoddQy70k+my3zF/pfH9E0S2dA14umnHcFtXPuS1Wjqv6MwoMNDeEykaC5+Q
 ahCGi0feIs3CMydlzfeYmCl0KyGCaaVc9QrO4s3LkP0nvKdmrDwKwkY
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the eMMC on the BeagleV Ahead and the
Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
eMMC.

I tested on top of v6.6-rc6 with riscv defconfig. I was able to boot
both the Ahead [1] and LPi4a [2] from eMMC. The following prerequisites
are required:

  [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [3]

I pushed a branch [4] with this patch series and the above patch for
those that find a git branch easier to test.

Please note that only the MMC controller connected to the eMMC device
is enabled in the device trees for these two boards. I did not yet
attempt to configure and use the microSD card slot. My preference is to
address that in a future patch series.

References:
[1] https://gist.github.com/pdp7/7850027e8d256b6fd9cd53080240f0f6
[2] https://gist.github.com/pdp7/fae4637378426723508b679420a0a5a1
[3] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kernel.org/
[4] https://github.com/pdp7/linux/tree/b4/th1520-mmc

Changes in PATCH v2:
- make use of BIT(), GENMASK(), FIELD_PREP(), FIELD_GET()
- add EXPORT_SYMBOL_GPL(__sdhci_execute_tuning)
- call th1520_phy_1_8v_init() when FLAG_IO_FIXED_1V8 is set
- set DWCMSHC_CARD_IS_EMMC when mmc caps contains MMC_CAP_NONREMOVABLE
- remove manipulation of AT_CTRL_AT_EN from th1520_set_uhs_signaling()
- remove unneccessary cycle of enabling and disabling AT_CTRL_AT_EN in
  th1520_execute_tuning()
- remove th1520_phy_1_8v_init_no_pull()
- remove th1520_phy_3_3v_init_no_pull()
- remove FLAG_PULL_UP_EN from priv->flags
- remove thead,phy-pull-up device tree property

Changes in PACH v1:
https://lore.kernel.org/all/20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com/
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
Drew Fustini (7):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
      mmc: sdhci: add __sdhci_execute_tuning() to header
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520
      riscv: defconfig: Enable mmc and dma drivers for T-Head TH1520
      riscv: dts: thead: Add TH1520 mmc controller and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC controller
      riscv: dts: thead: Enable LicheePi 4A eMMC controller

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  14 +
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  14 +
 arch/riscv/boot/dts/thead/th1520.dtsi              |  15 +
 arch/riscv/configs/defconfig                       |   2 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 358 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 8 files changed, 407 insertions(+), 1 deletion(-)
---
base-commit: f4c03b3d6c4bdafbb7885ccb84b095001eab1b88
change-id: 20231017-th1520-mmc-b7c72b7f56cd

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

