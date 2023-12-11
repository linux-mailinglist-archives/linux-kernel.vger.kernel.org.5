Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48780DE94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjLKWqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:46:08 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A85BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:13 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso75522921fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702334772; x=1702939572; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t85LLIZQoq/0uYuT3AgeozVMbJL+kvjO/m7san6lR4c=;
        b=ZAuUeFlt480rmZ1DBuLCSdXlr7feEFhHvA7fEjzsA+FzCvcERv4N1FvBp6N5wDJzSt
         vtW0ASv8tHw7T72S+tD1A0ZR6x1fR0ZXoj5oky+/hsz6u/GotZt2c6aglzQUc/keamwL
         Iom+zDWX+0I7SKIVKKHnXoLHnrp2uZ1oUiw7bd00SI0LwsR+0YqaTat9aY8YCC8ru1tj
         d1OQSCJHFmACluBskwxBZCFizVvDXGFzgnnpLDaB5sh3TayW2U9rUgQ7f4zi6i9hlD2B
         y4PxSIbQdl81nf5aLuPZe+ddQD38KfxoUSKsexyez0eFIXr807pcSyU3ooerxwH/qMKN
         ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334772; x=1702939572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t85LLIZQoq/0uYuT3AgeozVMbJL+kvjO/m7san6lR4c=;
        b=DsbMCu4RVlDGVzYJ1zJFp8TACqoPWhDsKQJfHhopXiN5QMtn2vsTdEpYykLQxodYMo
         YQx50X/cz30kpSwg/L6swPKLTEX1uZnIR6lKxJMlRopT1+vYbTH1Ud/TDhUnysOo0kJm
         0Xw4k4sGIoCpAtFDqmLJO8LFi38LVU0HzV5Q5y7iRGRRYppQu7+VduRXssvYjodA1yfN
         t6KzWKHG/d+ykHN3AsN/bxillg2D5zW4f9TpJHoTAW2JPhPVpzADs/BUIvV6Cv4IfdZd
         ubpFi6N8QGfiflZuvXF4cQEmklKXEgEYcx7e2lP8GrD1vU+zh9RkPeIM282Z1hyC1rSa
         Ul1g==
X-Gm-Message-State: AOJu0YwDf+bd3D/+tHEIltCRdnF7VojUbxrNdi0rwyt1FofbeO/f2mAJ
        S5KV94KUp4wa5skz6QKDdLnpQA==
X-Google-Smtp-Source: AGHT+IG98sV0CrJ9EM1uWc/0gBq7KGO+1S15MorZEU2yTn9piSQO9Ixm7HFp7oIVtJngBFMaHwWKQQ==
X-Received: by 2002:a2e:9607:0:b0:2c9:fde5:a35a with SMTP id v7-20020a2e9607000000b002c9fde5a35amr2265453ljh.80.1702334771570;
        Mon, 11 Dec 2023 14:46:11 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm4091789edb.59.2023.12.11.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:46:11 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 00/10] clk: qcom: Add TCSR, GPU, CAM and DISP clock
 controllers for X1E80100
Date:   Tue, 12 Dec 2023 00:45:40 +0200
Message-Id: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABSRd2UC/z2OQQrCMBBFr1Jm7eAktli8irhI4tQGQ0YyQQqld
 zdVcPn4vMdfQblEVrh0KxR+R42SG5hDB2F2+cEY743Bkj0ZSwYXwyMZIgxJwhOD5FokJS6K3vX
 W03AeptFBC3injL64HOY94fvjX/5NIhWroM6c0i68Ck9x+b653rbtA3IMlFWdAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MUgBtyNX28dceKLimFFthIHdxEZFj6+ep2sI3cJjt3E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBld5EeI+9IfHIYfWIgMULb8y5P7dqKmGCLYMlcu
 V+RIezPIe2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXeRHgAKCRAbX0TJAJUV
 VtEcD/9ueuMEDr9aCafxUoSTEZP42N/QKolas5rBsf9hFYGpTYXLdQyyoOAt3P1nq71J0QGh3O+
 lmQsyMOUMkTjsniGI7AZtQr5+oYcY8ONOEvFJ40DppUK92MHpClYGcHILXrSqURgJwchWL636gd
 Qg+3TYlpER3TS2GND0SuQxIhs7zH26e1AbCcS2TOnA4ceDv9UX8u1UVmJSyhJ03dMDd83ICZlIy
 SnkHZprQ2bJpANtZWDVGLVaJTWQsi+HVSsHwG7tIxDAh0yVEL80y4LWKo99x3CF1R2p2qh8mUJI
 R+5n/yN5OrFMfw4QrBqF/kA9UWuvT5yOTCZ51tUwJhTHnPtLc3/oBgYDSH5sajCfN7YuDk1C6N7
 VeveoQf4UjyH7x8CPfxcWrv6utnSzvy1y44XnYAcdVNO0a20OUTBmZhdrD8f9X0WH9zsuMotQ2p
 3NDaM+zDemo/eq6gaxJqVVLsL/YWpC1kxLCcUeuZj5+HwJaBPBKZzxGREzu9g0py891Rgi798Yn
 q2eKwq0b/osu97r9TK6ocZn3Jl/zgef3tWtxdOcVU6RCwF7OqzeMbrx5rnRXJ8aRamTZ4qJUTD6
 CqjhI60FMY+L3/qvnwxt3jYyFtBfUHAbgbmvXH1oRQp15J5uXNkiO0+vln9fCAx9PvibIElADIP
 d8SkQoembB8rhQA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds all the missing clock controllers for Qualcomm X1E80100
platform. Another important change is the dropping of the dedicated
schema of the SM8650 DISP CC as a preparatory work for documenting the
DISP CC compatible for X1E801800.

Initially, the TCSR clock controller was sent separately, but in order
to avoid merge conflicts, all other clock controllers have been added.
https://lore.kernel.org/all/20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org/

Changes to TCSR clock controller since up-mentioned version:
- called qcom_cc_probe instead of qcom_cc_really_probed, like Konrad
  suggested

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: clock: Drop the SM8650 DISPCC dedicated schema
      dt-bindings: clock: qcom: Document the X1E80100 TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for x1e80100

Rajendra Nayak (7):
      dt-bindings: clock: qcom: Document the X1E80100 Display Clock Controller
      dt-bindings: clock: qcom: Document the X1E80100 GPU Clock Controller
      dt-bindings: clock: qcom: Document the X1E80100 Camera Clock Controller
      clk: qcom: clk-alpha-pll: Add support for zonda ole pll configure
      clk: qcom: Add dispcc clock driver for x1e80100
      clk: qcom: Add GPU clock driver for x1e80100
      clk: qcom: Add camcc clock driver for x1e80100

 .../bindings/clock/qcom,sm8450-camcc.yaml          |    2 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    7 +-
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../bindings/clock/qcom,sm8650-dispcc.yaml         |  106 -
 drivers/clk/qcom/Kconfig                           |   35 +
 drivers/clk/qcom/Makefile                          |    4 +
 drivers/clk/qcom/camcc-x1e80100.c                  | 2489 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   26 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 drivers/clk/qcom/dispcc-x1e80100.c                 | 1699 +++++++++++++
 drivers/clk/qcom/gpucc-x1e80100.c                  |  659 ++++++
 drivers/clk/qcom/tcsrcc-x1e80100.c                 |  285 +++
 include/dt-bindings/clock/qcom,x1e80100-camcc.h    |  135 ++
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   |   98 +
 include/dt-bindings/clock/qcom,x1e80100-gpucc.h    |   41 +
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     |   23 +
 include/dt-bindings/reset/qcom,x1e80100-gpucc.h    |   19 +
 18 files changed, 5528 insertions(+), 107 deletions(-)
---
base-commit: 10b6aabadfd16f52a85603443a4778083f70882c
change-id: 20231201-x1e80100-clock-controllers-ba42b0575f8a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

