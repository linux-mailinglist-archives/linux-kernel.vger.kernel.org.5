Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8AE79CDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjILKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjILKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:14:49 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AED270D;
        Tue, 12 Sep 2023 03:14:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 43F5E60009;
        Tue, 12 Sep 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694513668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/hnjNqsaagOSukxcS80c/aCdruHerKJJ05eKAMv1qs=;
        b=Q6JeriUFD7Bk1gIIMDBDp//cbNvIovDPdkDRacYJerfZf0v7V3UyV0n6UiLSr5jYZOZLJl
        GPDPwALM6MRDCru6UdtRXukeuq0ElWR3282lv3SZ3b3fEMMaAenw+Z52QisM6kyo06Whql
        OLq2us8sUyMRgpWgIf7EHI+FuEVQaIitbMI2ltE5waniZc0e/t4VaQJUQZJfSth98td4LL
        20rUny/56OVOuYJcFHSTuQP9OdbObkjwjQ2JPw6jwBUwRApQLpWitEvWuM2C0TLa961c2v
        dRfnspjtN+wvq1WSnqQfcl1eZ4CEi1Ptgh2ijORCf15d9aRfwEVvEAszrEnSMQ==
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
Subject: [PATCH v5 22/31] soc: fsl: cpm1: qmc: Introduce functions to change timeslots at runtime
Date:   Tue, 12 Sep 2023 12:14:25 +0200
Message-ID: <20230912101425.225728-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912081527.208499-1-herve.codina@bootlin.com>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
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
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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

