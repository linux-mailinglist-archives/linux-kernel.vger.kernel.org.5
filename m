Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E781CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHTHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHTHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:35:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA96E6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:34:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3385297e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692516872; x=1693121672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6tLuLD++BQvtPqr+6W85PTyjvuOfHBFRdTsdV0IpdU=;
        b=e7nzwYaFWQx61iKPJENX92vHtkW2gMXKzGibwJSliKlUyjxeCqSOHfxPtlcCTmdSYX
         aAL/wOyV0kM64RplgZelyFqCkZq4zQNBv9WrYTQp0poEfBuEBPafl7z/9d4C8JX+9z45
         xmw3A0hKmcNe1DHFr+ydynsfPYAOoOmEEHAodnthnOW7yWfJ+qEA0T44PP5jZzCsxdIm
         h2V2QDlcFSCI2BOCvTv+aaictNI9KJQltG7HXNNk/ZBSyffs0C7J9zIuOFvcFQlEY4t2
         6+IsqK8SBkcr3cgbsdrjoTIQWdKzQR/1S5k8GOuULgNuiwOZPpEFls7IOP+o+dcQOTFl
         +r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692516872; x=1693121672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6tLuLD++BQvtPqr+6W85PTyjvuOfHBFRdTsdV0IpdU=;
        b=EBfOAXoPh4+JPTfbRVpCTLC+vikUiofavtlnLLnJGH4mfg1N2cV8J0eaBy15ETx2ZF
         oM+4D7BkIbdmxnOYHYEMG/Y/c6mD2vVOcY278aqRKe3AKCWWr08BpSm1Lvt+qRbCizEx
         KFal20EAQze/oXGl4+KoBpojmPs5tKaAjVTpl77Ye0/y4YBmNv3Rvwza0l2iWWj/Zo9J
         gY4e3WS5fO8fnvBwxhtrFeqnDi2AjBqDcgB/Tl6pFiycRiMalEfCt+lDVAxvprA9Td+z
         wTXZVPT20s8dby+rQI6zogVytMl+ffCAitSxlWINIS3VBgTn8njTeHc641Fh9yNWP4qp
         nGYQ==
X-Gm-Message-State: AOJu0Yw4zr9/yx3GrQBanIO26PPy9J0q4VuhjrFSOGVbT+oN3kN9zqBw
        62yKzEj0LAltt8gxJ/LoH2czsUpbxDLP6KLVai4=
X-Google-Smtp-Source: AGHT+IGTlwDtllwhmcd3CgyHAJvbhZrkf+x4N/xPpPA8SZhot/IZi3eQMY8owGPvMR9WrGsk4rylVw==
X-Received: by 2002:a05:6512:2305:b0:4fe:c98:789a with SMTP id o5-20020a056512230500b004fe0c98789amr3440222lfu.37.1692516872535;
        Sun, 20 Aug 2023 00:34:32 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k9-20020a056402048900b0052540e85390sm3792062edv.43.2023.08.20.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 00:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.6
Date:   Sun, 20 Aug 2023 09:34:29 +0200
Message-Id: <20230820073429.9069-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few commits for Samsung clock drivers.

Best regards,
Krzysztof


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.6

for you to fetch changes up to b3f9581affb03ed28ff1905b649e66904f29b9e4:

  dt-bindings: clock: samsung: remove define with number of clocks (2023-08-15 07:50:15 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.6

Remove from the bindings the #defines with number of clocks supported by
each clock controller driver.  This number can vary, e.g. when we
implement more clocks in the driver.  Having the number in the bindings
prevents changing it.  Instead, this should be just a #define inside the
driver.

----------------------------------------------------------------
Krzysztof Kozlowski (11):
      clk: samsung: exynos3250: do not define number of clocks in bindings
      clk: samsung: exynos4: do not define number of clocks in bindings
      clk: samsung: exynos5250: do not define number of clocks in bindings
      clk: samsung: exynos5260: do not define number of clocks in bindings
      clk: samsung: exynos5410: do not define number of clocks in bindings
      clk: samsung: exynos5420: do not define number of clocks in bindings
      clk: samsung: exynos5433: do not define number of clocks in bindings
      clk: samsung: exynos7885: do not define number of clocks in bindings
      clk: samsung: exynos850: do not define number of clocks in bindings
      clk: samsung: exynoautov9: do not define number of clocks in bindings
      dt-bindings: clock: samsung: remove define with number of clocks

 drivers/clk/samsung/clk-exynos3250.c             | 11 ++--
 drivers/clk/samsung/clk-exynos4.c                |  5 +-
 drivers/clk/samsung/clk-exynos4412-isp.c         |  5 +-
 drivers/clk/samsung/clk-exynos5250.c             |  5 +-
 drivers/clk/samsung/clk-exynos5260.c             | 41 ++++++++++-----
 drivers/clk/samsung/clk-exynos5410.c             |  5 +-
 drivers/clk/samsung/clk-exynos5420.c             |  5 +-
 drivers/clk/samsung/clk-exynos5433.c             | 65 ++++++++++++++++--------
 drivers/clk/samsung/clk-exynos7885.c             | 14 +++--
 drivers/clk/samsung/clk-exynos850.c              | 35 +++++++++----
 drivers/clk/samsung/clk-exynosautov9.c           | 29 +++++++----
 include/dt-bindings/clock/exynos3250.h           | 18 -------
 include/dt-bindings/clock/exynos4.h              |  5 --
 include/dt-bindings/clock/exynos5250.h           |  3 --
 include/dt-bindings/clock/exynos5260-clk.h       | 25 ---------
 include/dt-bindings/clock/exynos5410.h           |  2 -
 include/dt-bindings/clock/exynos5420.h           |  3 --
 include/dt-bindings/clock/exynos5433.h           | 42 ---------------
 include/dt-bindings/clock/exynos7885.h           |  4 --
 include/dt-bindings/clock/exynos850.h            | 10 ----
 include/dt-bindings/clock/samsung,exynosautov9.h | 18 -------
 21 files changed, 154 insertions(+), 196 deletions(-)
