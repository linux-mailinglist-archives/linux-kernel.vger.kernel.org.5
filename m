Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF569805B88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442425AbjLEPVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442399AbjLEPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:25 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76700BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:21:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 5018140010;
        Tue,  5 Dec 2023 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTsZ03wdLe2jX7b5CbBFQq2qQh274AFtQjsKmPdMnuY=;
        b=aLiE+WIn02wlJInTUmiuNrEeMsfvNJmP7q6RldXeW/G25MZb729t/cgIKuJGxVcNsU3gKt
        yvZzMFxGU9YZnZlfEWiKTD2RNIxQBJuokUuPgJ53ASN2X9Xw96NIn4WbdG1dph+GCwb2kK
        ppWks68v0d9y3Z3jSX5BA89LGb3MeRs4ewEchlwZbuP87dhRmffbmoxQHRNLY4oZcY5RJS
        WCl9khI+xSADBPielBK1VtS5RH0IhUSdhUS+WptRYPunN0Yhjkg/0bqdgOyaCwOsIPxy8O
        IIXvHo61rc+Cb2+RlLo/yINWTHchEu1t/jJ03IIwDhkW8fZ3Y/+iVpp0nYyJbA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 04/17] soc: fsl: cpm1: qmc: Extend the API to provide Rx status
Date:   Tue,  5 Dec 2023 16:21:01 +0100
Message-ID: <20231205152116.122512-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205152116.122512-1-herve.codina@bootlin.com>
References: <20231205152116.122512-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HDLC mode, some status flags related to the data read transfer can be
set by the hardware and need to be known by a QMC consumer for further
analysis.

Extend the API in order to provide these transfer status flags at the
read complete() call.

In TRANSPARENT mode, these flags have no meaning. Keep only one read
complete() API and update the consumers working in transparent mode.
In this case, the newly introduced flags parameter is simply unused.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c      | 29 +++++++++++++++++++++++++----
 include/soc/fsl/qe/qmc.h      | 15 ++++++++++++++-
 sound/soc/fsl/fsl_qmc_audio.c |  2 +-
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 2312152a44b3..4b4832d93c9b 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -166,7 +166,7 @@
 struct qmc_xfer_desc {
 	union {
 		void (*tx_complete)(void *context);
-		void (*rx_complete)(void *context, size_t length);
+		void (*rx_complete)(void *context, size_t length, unsigned int flags);
 	};
 	void *context;
 };
@@ -421,7 +421,8 @@ static void qmc_chan_write_done(struct qmc_chan *chan)
 }
 
 int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
-			 void (*complete)(void *context, size_t length), void *context)
+			 void (*complete)(void *context, size_t length, unsigned int flags),
+			 void *context)
 {
 	struct qmc_xfer_desc *xfer_desc;
 	unsigned long flags;
@@ -454,6 +455,10 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 	xfer_desc->rx_complete = complete;
 	xfer_desc->context = context;
 
+	/* Clear previous status flags */
+	ctrl &= ~(QMC_BD_RX_L | QMC_BD_RX_F | QMC_BD_RX_LG | QMC_BD_RX_NO |
+		  QMC_BD_RX_AB | QMC_BD_RX_CR);
+
 	/* Activate the descriptor */
 	ctrl |= (QMC_BD_RX_E | QMC_BD_RX_UB);
 	wmb(); /* Be sure to flush data before descriptor activation */
@@ -485,7 +490,7 @@ EXPORT_SYMBOL(qmc_chan_read_submit);
 
 static void qmc_chan_read_done(struct qmc_chan *chan)
 {
-	void (*complete)(void *context, size_t size);
+	void (*complete)(void *context, size_t size, unsigned int flags);
 	struct qmc_xfer_desc *xfer_desc;
 	unsigned long flags;
 	cbd_t __iomem *bd;
@@ -527,7 +532,23 @@ static void qmc_chan_read_done(struct qmc_chan *chan)
 
 		if (complete) {
 			spin_unlock_irqrestore(&chan->rx_lock, flags);
-			complete(context, datalen);
+
+			/*
+			 * Avoid conversion between internal hardware flags and
+			 * the software API flags.
+			 * -> Be sure that the software API flags are consistent
+			 *    with the hardware flags
+			 */
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_LAST  != QMC_BD_RX_L);
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_FIRST != QMC_BD_RX_F);
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_OVF   != QMC_BD_RX_LG);
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_UNA   != QMC_BD_RX_NO);
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_ABORT != QMC_BD_RX_AB);
+			BUILD_BUG_ON(QMC_RX_FLAG_HDLC_CRC   != QMC_BD_RX_CR);
+
+			complete(context, datalen,
+				 ctrl & (QMC_BD_RX_L | QMC_BD_RX_F | QMC_BD_RX_LG |
+					 QMC_BD_RX_NO | QMC_BD_RX_AB | QMC_BD_RX_CR));
 			spin_lock_irqsave(&chan->rx_lock, flags);
 		}
 
diff --git a/include/soc/fsl/qe/qmc.h b/include/soc/fsl/qe/qmc.h
index 3c61a50d2ae2..6f1d6cebc9fe 100644
--- a/include/soc/fsl/qe/qmc.h
+++ b/include/soc/fsl/qe/qmc.h
@@ -9,6 +9,7 @@
 #ifndef __SOC_FSL_QMC_H__
 #define __SOC_FSL_QMC_H__
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 struct device_node;
@@ -56,8 +57,20 @@ int qmc_chan_set_param(struct qmc_chan *chan, const struct qmc_chan_param *param
 int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 			  void (*complete)(void *context), void *context);
 
+/* Flags available (ORed) for read complete() flags parameter in HDLC mode.
+ * No flags are available in transparent mode and the read complete() flags
+ * parameter has no meaning in transparent mode.
+ */
+#define QMC_RX_FLAG_HDLC_LAST	BIT(11) /* Last in frame */
+#define QMC_RX_FLAG_HDLC_FIRST	BIT(10) /* First in frame */
+#define QMC_RX_FLAG_HDLC_OVF	BIT(5)  /* Data overflow */
+#define QMC_RX_FLAG_HDLC_UNA	BIT(4)  /* Unaligned (ie. bits received not multiple of 8) */
+#define QMC_RX_FLAG_HDLC_ABORT	BIT(3)  /* Received an abort sequence (seven consecutive ones) */
+#define QMC_RX_FLAG_HDLC_CRC	BIT(2)  /* CRC error */
+
 int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
-			 void (*complete)(void *context, size_t length),
+			 void (*complete)(void *context, size_t length,
+					  unsigned int flags),
 			 void *context);
 
 #define QMC_CHAN_READ  (1<<0)
diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 56d6b0b039a2..bfaaa451735b 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -99,7 +99,7 @@ static void qmc_audio_pcm_write_complete(void *context)
 	snd_pcm_period_elapsed(prtd->substream);
 }
 
-static void qmc_audio_pcm_read_complete(void *context, size_t length)
+static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned int flags)
 {
 	struct qmc_dai_prtd *prtd = context;
 	int ret;
-- 
2.43.0

