Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4466B7B141B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjI1HJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjI1HJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:09:35 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4E1FD7;
        Thu, 28 Sep 2023 00:07:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 6AC3720005;
        Thu, 28 Sep 2023 07:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695884878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6W9oVhEO6bMU8YfnlBol3aSpzYKADclXRgrQd2t+5FA=;
        b=cw6UES8Ozo+nKRsAv4QbC/IyD2eYF2P5KPwVmKo0OvBCE8bhJBW5CDZvca3kln6SHfeAjK
        E2ELgc/EBR6408+Y/IZuQ+eoy2NdD7dc028zQO7VPv2SMqAcH2cbfjgywl1nc6bBwv3TVu
        VeR3AV9U1sqMLV1PVOJZbLV9zL0oaz4sDvxjlBmGpE5jgnPoe06x9/8UCThoCBbXPmShXa
        Ao1s7XYsCNDNCswMKs/QDBXluhMhE9SaXEZu5XiatP8qIrqwRRQlQPaDLMhO+fQu8M8g3w
        ntmUEgOAQ1XwNprPM17U2v9NEFowUayg2d/o/jMa+SPR7oSY1Hsk3mURT+jckA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 15/30] soc: fsl: cpm1: qmc: Remove no more needed checks from qmc_check_chans()
Date:   Thu, 28 Sep 2023 09:06:33 +0200
Message-ID: <20230928070652.330429-16-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928070652.330429-1-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced qmc_chan_setup_tsa* functions check that the
channel entries are not already used.
These checks are also performed by qmc_check_chans() and are no more
needed.

Remove them from qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 8e8bd1942c08..1189e6076e37 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -884,10 +884,7 @@ EXPORT_SYMBOL(qmc_chan_reset);
 static int qmc_check_chans(struct qmc *qmc)
 {
 	struct tsa_serial_info info;
-	bool is_one_table = false;
 	struct qmc_chan *chan;
-	u64 tx_ts_mask = 0;
-	u64 rx_ts_mask = 0;
 	u64 tx_ts_assigned_mask;
 	u64 rx_ts_assigned_mask;
 	int ret;
@@ -911,7 +908,6 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
 			return -EINVAL;
 		}
-		is_one_table = true;
 	}
 
 	tx_ts_assigned_mask = info.nb_tx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_tx_ts) - 1;
@@ -922,27 +918,11 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (tx_ts_mask & chan->tx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Tx TS\n", chan->id);
-			return -EINVAL;
-		}
 
 		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (rx_ts_mask & chan->rx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Rx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		if (is_one_table && (chan->tx_ts_mask != chan->rx_ts_mask)) {
-			dev_err(qmc->dev, "chan %u uses different Rx and Tx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		tx_ts_mask |= chan->tx_ts_mask;
-		rx_ts_mask |= chan->rx_ts_mask;
 	}
 
 	return 0;
-- 
2.41.0

