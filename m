Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCA7811E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379052AbjHRRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379180AbjHRRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:23:14 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51CC49CC;
        Fri, 18 Aug 2023 10:22:00 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RS6zv0pwcz9vj0;
        Fri, 18 Aug 2023 18:40:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id axONG-mlx7_u; Fri, 18 Aug 2023 18:40:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RS6zl3NNRz9vhP;
        Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 670528B763;
        Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 02pNESDStCWP; Fri, 18 Aug 2023 18:40:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (PO17626.IDSI0.si.c-s.fr [172.19.54.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B88A8B780;
        Fri, 18 Aug 2023 18:40:01 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37IGdxXm142019
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:39:59 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37IGdx5n142018;
        Fri, 18 Aug 2023 18:39:59 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
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
Subject: [PATCH v4 19/28] soc: fsl: cpm1: qmc: Introduce functions to change timeslots at runtime
Date:   Fri, 18 Aug 2023 18:39:13 +0200
Message-ID: <a18f6c9b11a358d4cce7f4c096a85fa5e1729633.1692376361.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692376360.git.christophe.leroy@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692376735; l=3289; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=78wehWlqMiFqYxFZMxpjqZHHmzC9lp2SLom1hHjHEc0=; b=EH7Ypvhs7z/Y3OrSfBqFh17QEyqVrp0buZQDOR7eq0JQ1x67x/X1kUy7/Q+pHJwHVuZbuk79e XYTA/MXLFvZDQldKEezNeOYlhhMZAKzOjqczr1Ixz8QYRkMZcU/xiYt
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herve Codina <herve.codina@bootlin.com>

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
index b67e73ad7c1a..2ab21a0023a7 100644
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
index 6f1d6cebc9fe..802c161636bd 100644
--- a/include/soc/fsl/qe/qmc.h
+++ b/include/soc/fsl/qe/qmc.h
@@ -38,6 +38,16 @@ struct qmc_chan_info {
 
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

