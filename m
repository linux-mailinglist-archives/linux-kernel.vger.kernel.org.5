Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8E770D74
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHEDP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEDPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:16 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707204EE7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:15:14 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56c4457c82eso1841460eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205313; x=1691810113;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6Qt1tAikNugWjQbI8lPvA/5LjhxOjzsVL1TcMtfGQ=;
        b=VUDPufE0qnsNjRNmMFNmGkO/KZ1iM8USBm7tTVJUN+t2lBBLWjhTpcSIc4zRrrmhK2
         +g+0dMsvRVZWdSIspTynGRO84gAMGxdVTb3wac+Iv+ahtByPo6CtpdYmw7zo7cxW1fLC
         bIkRLEK0u+kyfQbcLdou3zsN9VbBP74f9Z+c9yIE3/wR2Lh4qdNyyA3u1zHWLSPeMeqE
         WqPNBCoXhP0VsdvdGhMKQKANf52T2tQMZNeZDJPAs7Ni0CJ9oZDXQzOMslpn0bHn6mlw
         RA/w78OksTGfh0EO5YG6HhP7xsLQWEPOjKhrJmd8v8D4FMRnN+A6/0gg8lnCZdUA9d5l
         Yu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205314; x=1691810114;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY6Qt1tAikNugWjQbI8lPvA/5LjhxOjzsVL1TcMtfGQ=;
        b=R13T89zWSFTf7DF4i0SB+ZdtHbOV/rkSo2rSamIGEemxqVj2MAShQGj352JqaLG/YG
         xLhJClIAwCp/yZm64AJNRamhacAcC3B1dnltWW+MuprVBacXL0IH2UuU7xws2KVwRzxI
         +fHJgOvXcW1I6vaX/Bm3nt10jGq2+rsXppVZh62x1c1qV5E7/rjymbYlDI7ZbU5CmtdJ
         qDsUvz61WXnktA4w7/GAWdXRoDeQoPOPqofrQk/zb4GWZpFZElnPpAz8ghzOAyyEiBex
         6KiqND91CGpoN6uX9Tyvpvq+OnWx/xTCXuJ884qSD1JWQP0zlMp8QGvYWez/jEzEcrAO
         YhOw==
X-Gm-Message-State: AOJu0YxVkyjvsz6uG3MU0Ou6UbqwUQcj3gOmDUAOgd4emN9ywX1qZmjZ
        AaMNEKKtzHd5XpGLEJ+ZzJyg9w==
X-Google-Smtp-Source: AGHT+IHL8VoBkjiy6ix6rUaziMQ7E0AbDt4CLGJy+4lZeUtAQqUNnPPxmUVzSmsimNjPpF87HkxP8w==
X-Received: by 2002:a05:6358:70e:b0:135:99fa:a118 with SMTP id e14-20020a056358070e00b0013599faa118mr3869509rwj.4.1691205313617;
        Fri, 04 Aug 2023 20:15:13 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:13 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH RFC v2 0/4] RISC-V: Add basic eMMC support for BeagleV
 Ahead
Date:   Fri, 04 Aug 2023 20:14:44 -0700
Message-Id: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKS+zWQC/22Oyw6CMBBFf4XM2iGltYCuTEz8ALeGRR+jbWLBt
 IRICP9uYe3yvnLuAomipwTnYoFIk09+6LPghwKMU/2L0NusgTMuWMOPOLpKcoYUgsFGGEuntmX
 S1pAXWiVCHVVv3LYJKo0UsS4lRiO2wifS03933APutyt02XQ+jUOc9wtTtUd/aVOFDI1RleZSC
 Kv4Rav57XWk0gwBunVdfzwVCL/PAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=3402;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=MDLsxhc5w3dyfm/SSn/2wE/4REaaADp4oj0jvET2NTw=;
 b=438X54c0dRVAnrP9QJgUt1TUf9yWkmyAhDMglNZx0q12/H3btZjjYx6J4ca3FyvqtD4jty8/G
 qOq286cmPc9Ct35GAf2WWHC4bLrczRXFAAUC0G8dwY5Rljr2Qrw19yN
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

This series adds initial support for the eMMC on the BeagleV Ahead
board. This allows the kernel to boot with the root fs on eMMC.

I tested [1] on top of v6.5-rc3 with this config [2] along with the
prerequisite series [3] that adds the BeagleV Ahead dts file.

I am submitting this as an RFC for other people that want to test
booting from the eMMC with mainline. There are several issues that need
to be resolved before this code can progress beyond an RFC:

  - Only the MMC controller connected to the eMMC is enabled. I did
    not yet attempt to configure or use the microSD card slot.

  - The thead,th1520-dwcmshc compatible sets quirks which disable DMA
    and forces the use of inefficient PIO mode. I need to determine the
    correct configuration for the SDMA and ADMA modes.

  - th1520-specific code is needed in dwcmshc_set_uhs_signaling() for
    MMC_TIMING_MMC_HS400. I have not figured out add proper way to make
    that code conditional so that it only runs on th1520. One method
    could be to add a th1520 flag to dwcmshc_priv but that seems like a
    hack. Alternatively, set_uhs_signaling in sdhci_dwcmshc_th1520_ops
    could point to a th1520-specific function, but that new function
    would have to duplicate all the code in the current
    dwcmshc_set_uhs_signaling().

NOTE: I combined schema, dts and driver patches into this one series to
simplify review and testing of this RFC.

References:
[1] https://gist.github.com/pdp7/09995be1e30df0a04b9b9cd31420f9d5
[2] https://gist.github.com/pdp7/e4585311eb2cd27df7b50c87babc15fd
[3] https://lore.kernel.org/linux-riscv/20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com/

Changes in v2:
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

v1 series:
https://lore.kernel.org/r/20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Drew Fustini (4):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
      riscv: dts: thead: Add TH1520 mmc controller and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC controller
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   9 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  17 ++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  17 ++
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 336 +++++++++++++++++++++
 4 files changed, 379 insertions(+)
---
base-commit: cb8c874afdc063290797ae1776a5d410fecb06cb
change-id: 20230724-th1520-emmc-73cde98805d6

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

