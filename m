Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0524D7639E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjGZPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjGZPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:03:17 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9632722;
        Wed, 26 Jul 2023 08:03:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 791041C0017;
        Wed, 26 Jul 2023 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690383785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeXkoiPhEUaHsmtIb9tUxxG+VJJBT8uhU6sNdVa597o=;
        b=CSDicE8XjKlFK0Hc0ao3XkfMg3O+IvAXHFbDBE9Fyt7kc4KUM1enUtDF9TfYTuM3v/Z1Ga
        D9sCDywh5obq4K4wah7gA949agWc2MMKQ7LSaCrzREU/+dyb4sJRT8Lujo8F0XreySegKV
        aOBtE3wAb7e6j2zPI4wWwGdRd9GA86Kl+m2gEAyuPQCUqDGn5INJrYZUCF7Fc0nmHfd1dI
        IB8KZGHiNnvUeV3DQpUzGMjPZ+y8mIa6R9rIPaTDChAXZhdTRXKI2oXUvkjaTO87K8SClY
        UZFHj9HRk15/dnDMglVORqUgl2Is0gYlYUOWX5dL4qFu8kAnLTV8mLZyTpEU4Q==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 08/28] soc: fsl: cpm1: qmc: Introduce available timeslots masks
Date:   Wed, 26 Jul 2023 17:02:04 +0200
Message-ID: <20230726150225.483464-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726150225.483464-1-herve.codina@bootlin.com>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Available timeslots masks define timeslots available for the related
channel. These timeslots are defined by the QMC binding.

Timeslots used are initialized to available timeslots but can be a
subset of available timeslots.
This prepares the dynamic timeslots management (ie. changing timeslots
at runtime).

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 2d2a9d88ba6c..21ad7e79e7bd 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -177,7 +177,9 @@ struct qmc_chan {
 	struct qmc *qmc;
 	void __iomem *s_param;
 	enum qmc_mode mode;
+	u64	tx_ts_mask_avail;
 	u64	tx_ts_mask;
+	u64	rx_ts_mask_avail;
 	u64	rx_ts_mask;
 	bool is_reverse_data;
 
@@ -875,7 +877,8 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 			of_node_put(chan_np);
 			return ret;
 		}
-		chan->tx_ts_mask = ts_mask;
+		chan->tx_ts_mask_avail = ts_mask;
+		chan->tx_ts_mask = chan->tx_ts_mask_avail;
 
 		ret = of_property_read_u64(chan_np, "fsl,rx-ts-mask", &ts_mask);
 		if (ret) {
@@ -884,7 +887,8 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 			of_node_put(chan_np);
 			return ret;
 		}
-		chan->rx_ts_mask = ts_mask;
+		chan->rx_ts_mask_avail = ts_mask;
+		chan->rx_ts_mask = chan->rx_ts_mask_avail;
 
 		mode = "transparent";
 		ret = of_property_read_string(chan_np, "fsl,operational-mode", &mode);
-- 
2.41.0

