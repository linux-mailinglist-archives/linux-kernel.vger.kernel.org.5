Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FC7D4156
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJWVHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:07:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B3BE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:07:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso3089858b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698095226; x=1698700026; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxRjmIExa0NCWi/ierGnShMAGgwQw0v6YfA7TKsSgfk=;
        b=FOl4AiAcvKTumIcCd5WLaavvPNy0XGjKPHf7w03zxKRFKL+fztriNU8Bira+SwJPp5
         BrNTKfvnE3nNcXxbSBbgFsQd/t6bHD3rnBOtrr0UP0tLxN/MBAWwaf8i5pN6jHqvMovg
         dlokkBmiqFOd3p5k09nYw7Ydl6no6/Zpi02ifUS3/DJXaWYFXtmeIKKy0xu2ivdkb0va
         GHny/xObvBcF3EVB/B6P2loC6SWsaXB7QNlKqc2tk2xTJbpuym32qn1nSNnALvDS94AM
         mEVnIFsW+uEhnT9vFOfp7BT9XvZfvkZkHwUBqLjQzNZfiX09Em7KcLF4v3rzdB5F+3dV
         Dgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095226; x=1698700026;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxRjmIExa0NCWi/ierGnShMAGgwQw0v6YfA7TKsSgfk=;
        b=Xo32tLKKl9cX3hstvVJH9rMYeI/YrcrbkGdf0JRRcPm+adP+iSmjFlkk+9cy/yN1SA
         vT20dS9I+R82JxDM2EDuPOzl1ZuHKPcN1/r8/0xGsSei60ok4h9ycmQCbDm8EoS18d5n
         EBT1Bs1n3vRt0pjdnXcfX2mJoNFjToQqFdf9NZqWth+0/7lTSD82iwxNj2SoVWS4r0w1
         sXH4vrD+fzWPH4rzyT2yqbcXL/H1y8tzPwv2Fa7I0G/vL6Sa0tLae3JEVZw5LU/zxp70
         PA+GqaT0YJq3Nu24uonViuiN+2y15L/FU5pmgwNkEy2FgB0kMfLKgUU1STDRCWYqx8Qo
         aZHA==
X-Gm-Message-State: AOJu0Yz2FCxyrkfelSqKUdDgEI3q8qib+c35yHf6dBO6Cqwi4Wz6WcHL
        eUSMomgiY8URZ81pxdlpcMDe3w==
X-Google-Smtp-Source: AGHT+IEoVvEEKGNGxVa0n9CRdhi7Ihz0IMoJxlBRs0dTzoIAAFxOorZeJxrH4V6npo3yp+XogKZ02w==
X-Received: by 2002:a05:6a00:2295:b0:68a:4103:9938 with SMTP id f21-20020a056a00229500b0068a41039938mr9387407pfe.0.1698095226097;
        Mon, 23 Oct 2023 14:07:06 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b9a0:8714:407c:4146])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6573066pfp.47.2023.10.23.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:07:05 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3 0/7] RISC-V: Add MMC support for TH1520 boards
Date:   Mon, 23 Oct 2023 14:07:01 -0700
Message-Id: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXgNmUC/23MQQ6DIBCF4auYWZcGEIV01Xs0LmTEMknRBgypM
 dy91HWX/0ved0BykVyCW3NAdJkSrUuN9tIA+nF5OkZTbZBctoILzTYvOslZCMisRi2tnrseJ6i
 Hd3QzfU7sMdT2lLY17qed5W/9y2TJOFO9NmgQFVfmbsf9RTa6K64BhlLKF/3IbDinAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698095224; l=5536;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=GA2saEZ7Ng9DFUZVB2Ta7tnKvGxz/8BX1kSEaH8UI2g=;
 b=XrIwcdiSWadi5ZFufTxN6I76b4sqwaR/ja7juxyXW9ipudXcCdVIhttKyXXwNm2H79zio3rXz
 UaNyohV5nkYDCPnXvPc2lVUqETp9jMxbv1GT/qAlOQiVdQnx88moi2t
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the MMC controller in the T-Head TH1520
SoC, and it enables the eMMC and microSD slot on both the BeagleV
Ahead and the Sipeed LicheePi 4A.

I tested on top of v6.6-rc6 with riscv defconfig. I was able to boot
both the Ahead [1] and LPi4a [2] from eMMC. The following prerequisites
are required:

  [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [3]

I pushed a branch [4] with this patch series and the above patch for
those that find a git branch easier to test.

Note: I have only tested eMMC and microSD. I have not yet configured
or tested the mmc controller used for SDIO WiFi yet.

References:
[1] https://gist.github.com/pdp7/7850027e8d256b6fd9cd53080240f0f6
[2] https://gist.github.com/pdp7/fae4637378426723508b679420a0a5a1
[3] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kernel.org/
[4] https://github.com/pdp7/linux/tree/b4/th1520-mmc

Changes in PATCH v3:
- always call th1520_sdhci_set_phy() in th1520_set_uhs_signaling()
  and not only when timing is MMC_TIMING_MMC_HS400. This allows the
  microSD slot to work as th1520_phy_3_3v_init() is called from
  th1520_sdhci_set_phy().
- add mmc1 node for mmc controller connected to the microSD slot
- add enable mmc1 and add properties for microSD on the Ahead and LPi4A

Changes in PATCH v2:
https://lore.kernel.org/r/20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com
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
      riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
      riscv: dts: thead: Enable LicheePi 4A eMMC and microSD

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  20 ++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  20 ++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  23 ++
 arch/riscv/configs/defconfig                       |   2 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 357 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 8 files changed, 426 insertions(+), 1 deletion(-)
---
base-commit: f4c03b3d6c4bdafbb7885ccb84b095001eab1b88
change-id: 20231017-th1520-mmc-b7c72b7f56cd

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

