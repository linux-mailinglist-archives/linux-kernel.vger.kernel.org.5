Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E77586C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGRVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:24:42 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01DD9D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:24:40 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1B03F3F5C7;
        Tue, 18 Jul 2023 23:24:38 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v3 00/15] drm/msm: Add SM6125 MDSS/DPU hardware and enable
 Sony Xperia 10 II panel
Date:   Tue, 18 Jul 2023 23:24:36 +0200
Message-Id: <20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQDt2QC/23NSw6CMBgE4KuYrq3pA1p05T2Miz5+oAm0pJVGQ
 7i7hZVGlzPJN7OgBNFBQpfDgiJkl1zwJfDjAZle+Q6wsyUjRhgnglU4jYKyGttpxgqsOQsuAaR
 GBWiVAOuovOkL8fMwlHKK0Lrn/nC7l9y79AjxtR9murV/tzPFBFNbK8EbA7pl1xRG5fzgPJxC7
 NC2ldmnl1+eFU84VJwoRmRjfvy6rm+B3UzY/gAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring up the SM6125 DPU now that all preliminary series (such as INTF
TE) have been merged (for me to test the hardware properly), and most
other conflicting work (barring ongoing catalog *improvements*) has made
its way in as well or is still being discussed.

The second part of the series complements that by immediately utilizing
this hardware in DT, and even enabling the MDSS/DSI nodes complete with
a 6.0" 1080x2520 panel for Sony's Seine PDX201 (Xperia 10 II).

The last patch ("sm6125-seine: Configure MDSS, DSI and panel") depends
on (an impending v2 of) my Sony panel collection series [1].

[1]: https://lore.kernel.org/linux-arm-msm/20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org/

---
Changes in v3:
- Drop status="disabled" from MDSS dt-bindings example;
- Use "nom" instead of "svs" OPP for dsi-phy PD, matching downstream;
- Add "retention" OPP to dispcc PD;
- Reword dsi-phy required-opps documentation;
- Rebased on latest -next and fixed conflicts in DT and DPU catalog;
- Link to v2: https://lore.kernel.org/r/20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org

Changes in v2:
- Moved dispcc DT clock reordering to the right patch (--fixup on the
  wrong hash) (Dmitry, Konrad multiple times);
- Drop removal of GCC_DISP_AHB_CLK in dispcc bindings.  While it is
  unused in the current driver, it is likely used to ensure a guaranteed
  probe order between GCC and DISPCC downstream, as well as currently
  relying on the fact that GCC_DISP_AHB_CLK is CLK_IS_CRITICAL and never
  turned off (Bjorn);
- Add GCC_DISP_GPLL0_DIV_CLK_SRC at the end of the dispcc clock list to
  maintain some form of ABI stability (Krzysztof);
- Use SoC-prefix format for 14nm DSI PHY qcom,sm6125-dsi-phy-14nm
  compatible (Dmitry, Krzysztof);
- Add patch to drop unused regulators from QCM2290 14nm DSI PHY (Konrad,
  Dmitry);
- Reuse QCM2290 14nm DSI PHY config struct for SM6125 compatible
  (Konrad);
- s/sde/mdss in pdx201.dts pinctrl node names and labels (Konrad);
- Use MX power domain in DSI PHY with SVS OPP (Dmitry);
- Use CX power domain with (already-existing) OPP table in DSI CTRL
  (Konrad, Dmitry);
- Rebased on top of DPU catalog rework [1] by inlining macro
  invocations, and validated by diffing stripped dpu_hw_catalog.o that
  there are no unexpected changes;
- Unset min_llcc_ib because this platform has no LLCC (Konrad);
- Fix UBWC comment to mention "encoding" version (Dmitry);
- Reordered DT nodes to follow Konrad's requested sorting;
- Add power-domains and required-opps properties to dsi-phy-14nm.yaml;
- Link to v1: https://lore.kernel.org/r/20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org

The discussions and this list ran quite long, apologies if I missed or
mis-resolved anything in advance!

[1]: https://lore.kernel.org/linux-arm-msm/20230619212519.875673-1-dmitry.baryshkov@linaro.org/

---
Marijn Suijten (15):
      drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config
      arm64: dts: qcom: sm6125: Sort spmi_bus node numerically by reg
      dt-bindings: clock: qcom,dispcc-sm6125: Require GCC PLL0 DIV clock
      dt-bindings: clock: qcom,dispcc-sm6125: Allow power-domains property
      dt-bindings: display/msm: dsi-controller-main: Document SM6125
      dt-bindings: display/msm: sc7180-dpu: Describe SM6125
      dt-bindings: display/msm: Add SM6125 MDSS
      drm/msm/dpu: Add SM6125 support
      drm/msm/mdss: Add SM6125 support
      dt-bindings: msm: dsi-phy-14nm: Document SM6125 variant
      drm/msm/dsi: Reuse QCM2290 14nm DSI PHY configuration for SM6125
      arm64: dts: qcom: sm6125: Switch fixed xo_board clock to RPM XO clock
      arm64: dts: qcom: sm6125: Add dispcc node
      arm64: dts: qcom: sm6125: Add display hardware nodes
      arm64: dts: qcom: sm6125-seine: Configure MDSS, DSI and panel

 .../bindings/clock/qcom,dispcc-sm6125.yaml         |  24 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/dsi-phy-14nm.yaml         |  11 +
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  14 ++
 .../bindings/display/msm/qcom,sm6125-mdss.yaml     | 211 +++++++++++++++++
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |  59 +++++
 arch/arm64/boot/dts/qcom/sm6125.dtsi               | 255 +++++++++++++++++++--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h | 236 +++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   7 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   2 -
 drivers/gpu/drm/msm/msm_mdss.c                     |   8 +
 14 files changed, 810 insertions(+), 23 deletions(-)
---
base-commit: 535ce75f2d80a47ce5407681014cd5a976646e38
change-id: 20230624-sm6125-dpu-aedc9637ee7b

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

