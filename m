Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD147C4A36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjJKGQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJKGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:16:07 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5AFF1;
        Tue, 10 Oct 2023 23:15:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 05CBFE0008;
        Wed, 11 Oct 2023 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697004945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/xbDf8eMD5E6WB0NjH/5DUWVpmxRzR+EOenyt8frKM=;
        b=d6utmxaYZ/UokS2v4tX4PyoKpGnG55n32mEnVFgFUIiwNij5Ia/XlH7RGe8ugQvm2QFakR
        +JJPw+bPMtuiWCxhkz1CpQahFJEsWvHg4La026iIS6DEqPSl2b9dtQDhDjOTJIpLkI/blP
        zaNgsMrv4YcTSRtqq+FC6G9tJR8TJGr29B+3Bn7e5Lv0j2CFo8aQfpsl9PwkP4AYr79xHw
        xQ+MJvZhh5FLjdr0eZCcTdO1UpfiBZomzoGjajwisY/j8/5FMwJcQbVRx98G78befP0prv
        kJvbQTjX6lY8y5c9e62eBM+nPqufngWzdKnCKWMJORpn4uHAoI3g2eTZ0AvUTA==
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
        alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v8 16/30] soc: fsl: cpm1: qmc: Check available timeslots in qmc_check_chans()
Date:   Wed, 11 Oct 2023 08:14:20 +0200
Message-ID: <20231011061437.64213-17-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061437.64213-1-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timeslots checked in qmc_check_chans() are the timeslots used.
With the introduction of the available timeslots, the used timeslots
are a subset of the available timeslots. The timeslots checked during
the qmc_check_chans() call should be the available ones.

Simply update and check the available timeslots instead of the used
timeslots in qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 1189e6076e37..269d10cd3c7a 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -914,13 +914,13 @@ static int qmc_check_chans(struct qmc *qmc)
 	rx_ts_assigned_mask = info.nb_rx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_rx_ts) - 1;
 
 	list_for_each_entry(chan, &qmc->chan_head, list) {
-		if (chan->tx_ts_mask > tx_ts_assigned_mask) {
-			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
+		if (chan->tx_ts_mask_avail > tx_ts_assigned_mask) {
+			dev_err(qmc->dev, "chan %u can use TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
 
-		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
-			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
+		if (chan->rx_ts_mask_avail > rx_ts_assigned_mask) {
+			dev_err(qmc->dev, "chan %u can use TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
 	}
-- 
2.41.0

