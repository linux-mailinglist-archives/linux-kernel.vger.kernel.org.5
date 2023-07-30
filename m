Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E387D7687F8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjG3Ubh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjG3Ubg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:31:36 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B6113;
        Sun, 30 Jul 2023 13:31:33 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 842B83F0AC;
        Sun, 30 Jul 2023 22:31:30 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v5 0/2] dts: qcom: Use labels with generic node names for
 ADC channels
Date:   Sun, 30 Jul 2023 22:31:24 +0200
Message-Id: <20230730-generic-adc-channels-v5-0-e6c69bda8034@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJzIxmQC/0WMQQ6CMBBFr0K6dsi0YBtceQ/josIAQ2BKWjQmh
 Ltb3bj6ecl/b1eJIlNSl2JXkV6cOEiG86lQ7ehlIOAuszJoKnQVwkCSjRZ818L3ITQnsNgYRKc
 f2muV1TVSz+9f9nbP3MewwDZG8v9YrTFvo11pametBQ2LjzxJmZ48bSTXFBbPMrNQGeKgjuMD4
 3scNq4AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [1] it is more convenient to use a generic `channel`
node name for ADC channels while storing a friendly - board-specific
instead of PMIC-specific - name in the label, if/when desired to
overwrite the channel description already contained (but previously
unused) in the driver [2].

The same `channel` node name pattern has also been set in
iio/adc/adc.yaml, but this generic binding is not inherited as base for
qcom,spmi-vadc bindings due to not having any other generic elements in
common, besides the node name rule and reg property.

Replace the .* name pattern with the `channel` literal, but leave the
label property optional for bindings to choose to fall back a channel
label hardcoded in the driver [2] instead.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/

Changes since v4:
- Dropped iio (dt-bindings) patches that have been merged, leaving only
  ARM/arm64 DTS patches;
- Rebased against next-20230728.

v4: https://lore.kernel.org/linux-arm-msm/20230410202917.247666-1-marijn.suijten@somainline.org/

Changes since v3:
- Switch generic node name to `channel`, matching iio/adc/adc.yaml;
- Besides switching arbitrary names to `channel`, now also rename all
  existing `adc-chan` names to `channel`, including ARM tree;
- Rebase on next-20230406 and apply rename to newer PMIC files.

v3: https://lore.kernel.org/linux-arm-msm/20230201204447.542385-1-marijn.suijten@somainline.org/T/#u

Changes since v2:
- Reorder DT changes before dt-bindings changes;
- Update adc-chan generic node name in tm5 example bindings.

v2: https://lore.kernel.org/linux-arm-msm/20230119212632.185881-1-marijn.suijten@somainline.org/T/#u

Changes since v1:
- Require adc-chan name in dt-bindings;
- Replace more node names with adc-chan and a descriptive label, that
  were found by running dtbs_check on adjusted bindings;
- sm8250-mtp.dts: Fix accidental adc-chan2 node name with pa_therm
  label, which should have been adc-chan with pa_therm2 label.

v1: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/

--
2.40.0

---
Marijn Suijten (2):
      ARM: dts: qcom: Use labels with generic node names for ADC channels
      arm64: dts: qcom: Use labels with generic node names for ADC channels

 arch/arm/boot/dts/qcom/qcom-pm8226.dtsi            | 12 +++----
 arch/arm/boot/dts/qcom/qcom-pm8941.dtsi            | 14 ++++----
 arch/arm/boot/dts/qcom/qcom-pma8084.dtsi           | 12 +++----
 arch/arm/boot/dts/qcom/qcom-pmx55.dtsi             |  8 ++---
 arch/arm64/boot/dts/qcom/pm6125.dtsi               | 18 ++++++----
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  8 ++---
 arch/arm64/boot/dts/qcom/pm660.dtsi                | 33 ++++++++++++------
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 ++++++-------
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |  6 ++--
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |  8 ++---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |  6 ++--
 arch/arm64/boot/dts/qcom/pm8916.dtsi               | 14 ++++----
 arch/arm64/boot/dts/qcom/pm8950.dtsi               | 39 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/pm8953.dtsi               | 12 +++----
 arch/arm64/boot/dts/qcom/pm8994.dtsi               | 12 +++----
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi              | 12 +++----
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi          |  6 ++--
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi          |  6 ++--
 arch/arm64/boot/dts/qcom/pmp8074.dtsi              | 27 ++++++++++-----
 arch/arm64/boot/dts/qcom/pms405.dtsi               | 21 ++++++++----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 15 ++++++---
 .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +--
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  3 +-
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 +-
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  3 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  4 +--
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 26 +++++++--------
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         | 10 +++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 12 +++----
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   | 15 ++++++---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  6 ++--
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            | 21 ++++++++----
 41 files changed, 254 insertions(+), 186 deletions(-)
---
base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
change-id: 20230730-generic-adc-channels-60920071b1a1

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

