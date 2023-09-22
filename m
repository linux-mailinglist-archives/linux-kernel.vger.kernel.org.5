Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24817AABB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjIVICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjIVIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:01:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8901BC7;
        Fri, 22 Sep 2023 01:00:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id C4ED51BF207;
        Fri, 22 Sep 2023 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695369652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3si6n+8C/3nGddG/bex4gaYwAJkDU16eps4QpP35QQ=;
        b=kyIF+vCZmNBkMCaBkgjNRE4zeGrnBBBrkKgL/6VDgdBIOH5Pqtgk8xMSbJeYArcE2DKpc5
        XGAUsbQvJplQQENA8z9Cv0jsEEvmYC6lMZrFzBPqWkmI9SEi0kpDdo3CobcLoDENPfY4ak
        LrOqybxZcWdnJmLgSm5c/9PW0fuTQni7qEb2lgI1fR51xQAP16K9LYzJ0kZAaBP70OCOan
        BUv1qAItqkyQkpWDpLLHcdkEDLSUmQFyJgL1um2/cHtfVBNQYxrf6hzyRjt+xWy/thoOnH
        VMkhqE9GXOe1FmWodE/OlbUj6z0lOckGftp3yCPbDeg+zEao44u8VsJPBzCeow==
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
Subject: [PATCH v6 22/30] soc: fsl: cpm1: qmc: Introduce functions to change timeslots at runtime
Date:   Fri, 22 Sep 2023 09:58:57 +0200
Message-ID: <20230922075913.422435-23-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922075913.422435-1-herve.codina@bootlin.com>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce qmc_chan_{get,set}_ts_info() function to allow timeslots
modification at runtime.

The modification is provided using qmc_chan_set_ts_info() and will be
applied on next qmc_chan_start().
qmc_chan_set_ts_info() must be called with the channel rx and/or tx
stopped.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 51 ++++++++++++++++++++++++++++++++++++++++
 include/soc/fsl/qe/qmc.h | 10 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index b63b54ec0a3a..6e22b96b4e7a 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -290,6 +290,57 @@ int qmc_chan_get_info(struct qmc_chan *chan, struct qmc_chan_info *info)
 }
 EXPORT_SYMBOL(qmc_chan_get_info);
 
+int qmc_chan_get_ts_info(struct qmc_chan *chan, struct qmc_chan_ts_info *ts_info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->ts_lock, flags);
+
+	ts_info->rx_ts_mask_avail = chan->rx_ts_mask_avail;
+	ts_info->tx_ts_mask_avail = chan->tx_ts_mask_avail;
+	ts_info->rx_ts_mask = chan->rx_ts_mask;
+	ts_info->tx_ts_mask = chan->tx_ts_mask;
+
+	spin_unlock_irqrestore(&chan->ts_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(qmc_chan_get_ts_info);
+
+int qmc_chan_set_ts_info(struct qmc_chan *chan, const struct qmc_chan_ts_info *ts_info)
+{
+	unsigned long flags;
+	int ret;
+
+	/* Only a subset of available timeslots is allowed */
+	if ((ts_info->rx_ts_mask & chan->rx_ts_mask_avail) != ts_info->rx_ts_mask)
+		return -EINVAL;
+	if ((ts_info->tx_ts_mask & chan->tx_ts_mask_avail) != ts_info->tx_ts_mask)
+		return -EINVAL;
+
+	/* In case of common rx/tx table, rx/tx masks must be identical */
+	if (chan->qmc->is_tsa_64rxtx) {
+		if (ts_info->rx_ts_mask != ts_info->tx_ts_mask)
+			return -EINVAL;
+	}
+
+	spin_lock_irqsave(&chan->ts_lock, flags);
+
+	if ((chan->tx_ts_mask != ts_info->tx_ts_mask && !chan->is_tx_stopped) ||
+	    (chan->rx_ts_mask != ts_info->rx_ts_mask && !chan->is_rx_stopped)) {
+		dev_err(chan->qmc->dev, "Channel rx and/or tx not stopped\n");
+		ret = -EBUSY;
+	} else {
+		chan->tx_ts_mask = ts_info->tx_ts_mask;
+		chan->rx_ts_mask = ts_info->rx_ts_mask;
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&chan->ts_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(qmc_chan_set_ts_info);
+
 int qmc_chan_set_param(struct qmc_chan *chan, const struct qmc_chan_param *param)
 {
 	if (param->mode != chan->mode)
diff --git a/include/soc/fsl/qe/qmc.h b/include/soc/fsl/qe/qmc.h
index 166484bb4294..2a333fc1ea81 100644
--- a/include/soc/fsl/qe/qmc.h
+++ b/include/soc/fsl/qe/qmc.h
@@ -40,6 +40,16 @@ struct qmc_chan_info {
 
 int qmc_chan_get_info(struct qmc_chan *chan, struct qmc_chan_info *info);
 
+struct qmc_chan_ts_info {
+	u64 rx_ts_mask_avail;
+	u64 tx_ts_mask_avail;
+	u64 rx_ts_mask;
+	u64 tx_ts_mask;
+};
+
+int qmc_chan_get_ts_info(struct qmc_chan *chan, struct qmc_chan_ts_info *ts_info);
+int qmc_chan_set_ts_info(struct qmc_chan *chan, const struct qmc_chan_ts_info *ts_info);
+
 struct qmc_chan_param {
 	enum qmc_mode mode;
 	union {
-- 
2.41.0

