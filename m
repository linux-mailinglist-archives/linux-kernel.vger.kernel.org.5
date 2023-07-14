Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3293275413B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjGNRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjGNRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:48:54 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E073C0F;
        Fri, 14 Jul 2023 10:48:10 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3460aee1d57so9796265ab.0;
        Fri, 14 Jul 2023 10:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356855; x=1691948855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDBKh1VqZZK4ehWVaSmsxzgiQYgy5JJICAIdzSddEwU=;
        b=FkXggqBwT3br4TNOhtl+XdLJXWJH4mb7PgrVyz2uJotIvpCZwzO5b8g4mhG50C1J9S
         Ndutb+4SXmN31viEw+F+sMb3zgbECE10UTQ3bLcPZkeuG53PUI3pxX+h6fEwN9T+aAiO
         1Ii3fN1eZslLtbH0P7I33x4IuFsaCr914AV/uJ3mkgYDC9LHVp7CJSp5MU8GaRRiuHec
         ljWBCRToGpmRsJwx+GQ3qg/1Bn+4eGMVIqXbOosnMn7xEClVQw4UDPZt7uXNU37C+JYr
         odGnwdGfsKw2J7euQZyLLyGMYMgq6DzPEwg/zklJc/MqOWvgikynI/1Qm7h80xnjZD4N
         1uVQ==
X-Gm-Message-State: ABy/qLbf59eda5KmiBxOpEL7q4OUzPMPGbNwaw5VZzaKDc/aNVCFrOXF
        0isjYlCBMoXp8P5lCf/PHw==
X-Google-Smtp-Source: APBJJlGaUf1c1gtJRsX/jpyvUk8Whe6CozpcgEpnhi5jw7V/IrWta8mLMH6RA6gPRpUhLGi6gQ4Z8Q==
X-Received: by 2002:a92:cf4a:0:b0:345:aba5:3780 with SMTP id c10-20020a92cf4a000000b00345aba53780mr5028257ilr.22.1689356854714;
        Fri, 14 Jul 2023 10:47:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a92ce8a000000b003423875af1bsm2905782ilo.1.2023.07.14.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:34 -0700 (PDT)
Received: (nullmailer pid 4059467 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Benoit Parrot <bparrot@ti.com>, Sean Young <sean@mess.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] media: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:08 -0600
Message-Id: <20230714174712.4059313-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/media/cec/core/cec-notifier.c                         | 1 +
 drivers/media/cec/platform/stm32/stm32-cec.c                  | 1 -
 drivers/media/dvb-frontends/mn88443x.c                        | 2 +-
 drivers/media/i2c/imx290.c                                    | 2 +-
 drivers/media/i2c/imx296.c                                    | 2 +-
 drivers/media/i2c/imx415.c                                    | 2 +-
 drivers/media/i2c/ov2680.c                                    | 2 +-
 drivers/media/i2c/ov5640.c                                    | 2 +-
 drivers/media/i2c/video-i2c.c                                 | 2 +-
 drivers/media/platform/allegro-dvt/allegro-core.c             | 1 -
 drivers/media/platform/amphion/vpu_cmds.c                     | 2 --
 drivers/media/platform/amphion/vpu_core.c                     | 2 +-
 drivers/media/platform/amphion/vpu_drv.c                      | 4 ++--
 drivers/media/platform/amphion/vpu_malone.c                   | 2 --
 drivers/media/platform/amphion/vpu_mbox.c                     | 2 --
 drivers/media/platform/amphion/vpu_rpc.c                      | 2 --
 drivers/media/platform/amphion/vpu_windsor.c                  | 2 --
 drivers/media/platform/aspeed/aspeed-video.c                  | 1 -
 drivers/media/platform/chips-media/coda-common.c              | 3 ++-
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c        | 2 +-
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c        | 4 ++--
 drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c            | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c   | 3 ++-
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c    | 3 +--
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c   | 2 +-
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c    | 3 +--
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c      | 1 -
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                 | 4 ++--
 drivers/media/platform/nvidia/tegra-vde/vde.c                 | 3 ++-
 drivers/media/platform/nxp/imx-mipi-csis.c                    | 1 -
 drivers/media/platform/nxp/imx-pxp.c                          | 1 -
 drivers/media/platform/nxp/imx7-media-csi.c                   | 2 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c           | 2 +-
 drivers/media/platform/qcom/venus/core.c                      | 3 ++-
 drivers/media/platform/qcom/venus/hfi_platform.c              | 2 +-
 drivers/media/platform/renesas/rcar-isp.c                     | 2 +-
 drivers/media/platform/renesas/rcar-vin/rcar-core.c           | 1 -
 drivers/media/platform/renesas/rcar-vin/rcar-csi2.c           | 1 -
 drivers/media/platform/renesas/rcar_drif.c                    | 3 ++-
 drivers/media/platform/renesas/rcar_fdp1.c                    | 1 -
 drivers/media/platform/renesas/rcar_jpu.c                     | 1 -
 drivers/media/platform/renesas/renesas-ceu.c                  | 1 -
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c         | 1 -
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c         | 1 -
 drivers/media/platform/renesas/vsp1/vsp1_drv.c                | 1 -
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c           | 2 +-
 drivers/media/platform/samsung/exynos-gsc/gsc-core.c          | 1 -
 drivers/media/platform/samsung/exynos4-is/fimc-core.c         | 1 -
 drivers/media/platform/samsung/exynos4-is/media-dev.c         | 1 -
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c            | 1 -
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c            | 1 -
 .../media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c    | 1 -
 .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c         | 1 -
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c              | 4 ++--
 drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c      | 4 ++--
 drivers/media/platform/ti/cal/cal.c                           | 2 +-
 drivers/media/rc/meson-ir.c                                   | 2 +-
 drivers/media/rc/mtk-cir.c                                    | 3 ++-
 drivers/media/rc/sunxi-cir.c                                  | 3 ++-
 59 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/media/cec/core/cec-notifier.c b/drivers/media/cec/core/cec-notifier.c
index 389dc664b211..a41f24172b11 100644
--- a/drivers/media/cec/core/cec-notifier.c
+++ b/drivers/media/cec/core/cec-notifier.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
diff --git a/drivers/media/cec/platform/stm32/stm32-cec.c b/drivers/media/cec/platform/stm32/stm32-cec.c
index ada3d153362a..bda9d254041a 100644
--- a/drivers/media/cec/platform/stm32/stm32-cec.c
+++ b/drivers/media/cec/platform/stm32/stm32-cec.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index 2ce5692bc22c..bbdd0389ffa3 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <media/dvb_math.h>
 
diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index b3f832e9d7e1..89e9370c7084 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -13,7 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index c0b9a5349668..3b4539b622b4 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -9,7 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index 4b5d1ee9cc6b..3f00172df3cc 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -9,7 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index d06e9fc37f77..a34afcf0a7d5 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 36b509714c8c..995d19301745 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -13,8 +13,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 6f98abc7ccc1..537ebd9fa8d7 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -16,9 +16,9 @@
 #include <linux/kthread.h>
 #include <linux/i2c.h>
 #include <linux/list.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/media/platform/allegro-dvt/allegro-core.c
index ec03e17727d7..f9f9a6d4a0d5 100644
--- a/drivers/media/platform/allegro-dvt/allegro-core.c
+++ b/drivers/media/platform/allegro-dvt/allegro-core.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/syscon/xlnx-vcu.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index fa581ba6bab2..139dfc63f148 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 43d85a54268b..4410a4cfad7f 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -9,7 +9,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
index 4187b2b5562f..2bf70aafd2ba 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -10,8 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-map-ops.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index c1d6606ad7e5..f771661980c0 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/rational.h>
diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/amphion/vpu_mbox.c
index bf759eb2fd46..6d63b036f183 100644
--- a/drivers/media/platform/amphion/vpu_mbox.c
+++ b/drivers/media/platform/amphion/vpu_mbox.c
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include "vpu.h"
 #include "vpu_mbox.h"
diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/amphion/vpu_rpc.c
index 676f7da041bd..f626a9f835e0 100644
--- a/drivers/media/platform/amphion/vpu_rpc.c
+++ b/drivers/media/platform/amphion/vpu_rpc.c
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/svc/misc.h>
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index b245ff6a1102..5f1101d7cf9e 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/time64.h>
 #include <media/videobuf2-v4l2.h>
diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 374eb7781936..c0a8b90b6733 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index ac9a642ae76f..4c7608f1b98d 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -19,7 +19,8 @@
 #include <linux/irq.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 869068fac5e2..63532d50aa57 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <media/media-device.h>
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 71e85b4bbf12..787e18a34a2f 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -10,9 +10,9 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <media/media-device.h>
diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
index ad5fab2d8bfa..3501ac411242 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
@@ -7,8 +7,6 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include "mtk_mdp_comp.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index d41f2121b94f..99e9baaf1774 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -9,8 +9,9 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 777d445999e9..ab8c0adadc0b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -6,8 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_dec_hw.h"
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 5df0a22ff3b5..ead3d0dd289d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -9,8 +9,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 7055954eb2af..3e2d2c00a1bd 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -5,8 +5,7 @@
 */
 
 #include <linux/clk.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_enc_pm.h"
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index f214e6f67005..0bb4b48e4bc6 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -7,7 +7,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_drv.h"
diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 4c8f5296d120..7243604a82a5 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -9,10 +9,10 @@
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/media/platform/nvidia/tegra-vde/vde.c b/drivers/media/platform/nvidia/tegra-vde/vde.c
index 7157734a1550..81a0d3b76b88 100644
--- a/drivers/media/platform/nvidia/tegra-vde/vde.c
+++ b/drivers/media/platform/nvidia/tegra-vde/vde.c
@@ -12,7 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 05d52762e792..3c08d101d947 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/media/platform/nxp/imx-pxp.c b/drivers/media/platform/nxp/imx-pxp.c
index 90f319857c23..e62dc5c1a4ae 100644
--- a/drivers/media/platform/nxp/imx-pxp.c
+++ b/drivers/media/platform/nxp/imx-pxp.c
@@ -19,7 +19,6 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 0bd2613b9320..2ec1f3cd56a0 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 253e77189b69..186db02aa84e 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 2ae867cb4c48..3fa17d8cb890 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -11,7 +11,8 @@
 #include <linux/devcoredump.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
index f07f554bc5fe..b6c0b1f84b95 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
  */
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "hfi_platform.h"
 #include "core.h"
 
diff --git a/drivers/media/platform/renesas/rcar-isp.c b/drivers/media/platform/renesas/rcar-isp.c
index fee1a066f56b..5e300fffd676 100644
--- a/drivers/media/platform/renesas/rcar-isp.c
+++ b/drivers/media/platform/renesas/rcar-isp.c
@@ -12,7 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-core.c b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
index 3c4f5eb93be1..36f1bf5803a4 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
index 7a134c0eff57..e4aac84d0b5f 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 3a92f4535c18..06173cae354c 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -44,8 +44,9 @@
 #include <linux/ioctl.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <media/v4l2-async.h>
diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index ab39cd2201c8..a2565b269f3b 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -18,7 +18,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
diff --git a/drivers/media/platform/renesas/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
index 2b8cb50f54de..416b9824761f 100644
--- a/drivers/media/platform/renesas/rcar_jpu.c
+++ b/drivers/media/platform/renesas/rcar_jpu.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
index 5c9e27f8c94b..a5f9d7bcd172 100644
--- a/drivers/media/platform/renesas/renesas-ceu.c
+++ b/drivers/media/platform/renesas/renesas-ceu.c
@@ -22,7 +22,6 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 7a71370fcc32..baa9cf554910 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index d6489c62b081..7002b63f109e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index a9db84be4822..1aac44d68731 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 4762cb32353d..7a530bdc6a21 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <media/v4l2-fwnode.h>
diff --git a/drivers/media/platform/samsung/exynos-gsc/gsc-core.c b/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
index 1fb34de70649..618ae55fe396 100644
--- a/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <media/v4l2-ioctl.h>
 
 #include "gsc-core.h"
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 976b4f747ad4..bd2fc4de973a 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <media/v4l2-ioctl.h>
diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index c9cb9a216fae..d172581c85f4 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index d6e7d1b36083..ea5e98a26be1 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index e2723cfa4515..80e88e711e0c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index dce130b4c9f6..315fbab8e1f0 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -7,7 +7,6 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
index 23d32e198aaa..a99e03c31345 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
@@ -8,7 +8,6 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index e4b0fd793f55..90ab1d77b6a5 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -11,9 +11,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
diff --git a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
index bd0c4257bbff..0b025ec91826 100644
--- a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
+++ b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
@@ -9,9 +9,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 9c5105223d6b..ea4170d9b1cb 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
diff --git a/drivers/media/rc/meson-ir.c b/drivers/media/rc/meson-ir.c
index 49aa309d1a8c..31bde1211d60 100644
--- a/drivers/media/rc/meson-ir.c
+++ b/drivers/media/rc/meson-ir.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/bitfield.h>
diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index df9349330a93..4e294e59d3cb 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -8,7 +8,8 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <media/rc-core.h>
 
diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 75b7aed1579c..bf58c965ead8 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -13,7 +13,8 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <media/rc-core.h>
 
-- 
2.40.1

