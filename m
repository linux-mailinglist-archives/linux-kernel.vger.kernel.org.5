Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7880845B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjLGI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjLGI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:57:12 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1310C8;
        Thu,  7 Dec 2023 00:57:18 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fa26074783so485813fac.1;
        Thu, 07 Dec 2023 00:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939437; x=1702544237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P11i5JtOr3fzuVQuonrXRUS+CyP/6OsLPEuxS5gelmY=;
        b=Z6uW96ELdejKG/oxlqbq8xw6VHpb0BsLFo3RAEuiCTa4U1Vmc8sCAl5uP/Dk0iJkNO
         xH8GLs9ZQrcoHiITSrwJpCndQVkqg4hdBF2YEtJ8Eb/33Y/nusdfXZIix+o4/XqAfIIs
         pwHRogEqqVbhZAh7i2N7YITnEA/z5bpUvO1jhJbJ5Vd8sB+jAhHPe/MG8jrdplisd9ss
         5hsIGUhgjTX8G+skY1c/5oJsyK2vSts84gpTxPS/6e+9pGIm9ChuzyyF1zpYSoRDYoZF
         M8O81IfGmCIJlXPPaMpHvr+rDpWEDiR33bwfBJFo96CXBKGCYvUE+0lnROEmWp+F2nBh
         UW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939437; x=1702544237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P11i5JtOr3fzuVQuonrXRUS+CyP/6OsLPEuxS5gelmY=;
        b=vUbpKOopEpOLh7npE15dXKD6ZDWJgVqOgdE4lJ0U/WXYJxNwfkZ9xvK+fYTW480v8e
         k0lFtyM60Udsimj3IavahV0sAzGHTkbB6qsqV24G/xA7Vk9NUyI8bjor7f54WHBkW4Gy
         oIsmvUvsFUxqXYUf54TXMgLrYlntq8CC4n55dqnOfrlCUNyTgnLrH2SvYnQD91xuHxCC
         6//bjwHSP9EIBOJRUbSFUdlw0Q+vhzwy+/iV4cDO0Rn5quXHdyoOTKjobzQllr5ASE7r
         XSx2hUzeX+GFKV7KjfvY4dhR5E2mQd+xkKzN7ejCbzXNX0kBPOn9CBmQ/wwRlemz8Ybw
         /83A==
X-Gm-Message-State: AOJu0YzrISQH2/kJptSV8024EJjzkKp3fdlbx6qjBYHuSEKCcN9f/Woh
        t1L76wo9AcnRD8SDHUfn2nhRA1/Zha0=
X-Google-Smtp-Source: AGHT+IG+OMWXh5ex62HGUtjYZmXteSSK4FPbvT8j0LXO3oexmhrhNGFilq45ksVwbmYi2Otc8uB6ag==
X-Received: by 2002:a05:6870:296:b0:1fa:fcd5:9ba6 with SMTP id q22-20020a056870029600b001fafcd59ba6mr2467290oaf.53.1701939437235;
        Thu, 07 Dec 2023 00:57:17 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id lw11-20020a0568708e0b00b001fb4aaf261csm193168oab.32.2023.12.07.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:57:16 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 0/4] riscv: sophgo: add clock support for sg2042
Date:   Thu,  7 Dec 2023 16:57:08 +0800
Message-Id: <cover.1701938395.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

This series adds clock controller support for sophgo sg2042.

Thanks,
Chen

---

Changes in v5:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [6].
  - dt-bindings: improved yaml, such as:
    - add vendor prefix for system-ctrl property for clock generator.
    - Add explanation for system-ctrl property.
  - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
  - fixed bugs for driver Makefile/Kconfig
  - continue cleaning-up debug print for driver code.

Changes in v4:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [5].
  - dt-bindings: fixed a dt_binding_check error.

Changes in v3:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [3].
  - DTS: don't use syscon but define sg2042 specific system control node. More
    background info can read [4].
  - Updating minor issues in dt-bindings as per input from reviews.

Changes in v2:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [2].
  - Squashed the patch adding clock definitions with the patch adding the
    binding for the clock controller.
  - Updating dt-binding for syscon, remove oneOf for property compatible;
    define clock controller as child of syscon.
  - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
    property of osc to board devicethree due to the oscillator is outside the
    SoC.
  - Fixed some bugs in driver code during testing, including removing warnings
    for rv32_defconfig.
  - Updated MAINTAINERS info.

Changes in v1:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [1].

Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v1 [1]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v2 [2]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v3 [3]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v4 [5]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v5 [6]

---

Chen Wang (4):
  dt-bindings: soc: sophgo: Add Sophgo system control module
  dt-bindings: clock: sophgo: support SG2042
  clk: sophgo: Add SG2042 clock generator driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   53 +
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     |   34 +
 MAINTAINERS                                   |    7 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |    4 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   79 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1355 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  226 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  169 ++
 12 files changed, 1939 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.25.1

