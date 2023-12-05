Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA68805C03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbjLEPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442302AbjLEPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:24 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554FB2;
        Tue,  5 Dec 2023 07:21:30 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 4FC6840009;
        Tue,  5 Dec 2023 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JegQGeg9h6K3SanbpVDQgW3INV0bHYQT8tL/y6V/fI4=;
        b=Z7UmF/Sx610v9Ui+3KrH/mI7zdwsmeCoVrZbR5VKLgwLW0MEgtpmghFKWVOEGn547KQNwf
        KBImIzahnVYXg5TP8Nv1lp1s2EkE8FjE2PmoJmwb+1oDb/vIr/pSE2zTPzHEAYoLjSrGn5
        HbVtLIQsbIR857y7VCw3a6P2zpVLsLuvX6vpM5C2ScuOBppIjzbsr0FbGMMBEc0onuVg2a
        tSuBIy0FPBt2Ne8A0PwWOda4riIWKQtjEwWrEEoAx5jeg8nDkYXV9tZEIoVh/wXjRak3YN
        aE8D7Dm5KX186VlZmzY/WjnwTbrHdnEVqdr4ZjwZUa95xTJzd60C1GMm9iFHKQ==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 03/17] soc: fsl: cpm1: qmc: Fix rx channel reset
Date:   Tue,  5 Dec 2023 16:21:00 +0100
Message-ID: <20231205152116.122512-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205152116.122512-1-herve.codina@bootlin.com>
References: <20231205152116.122512-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qmc_chan_reset_rx() set the is_rx_stopped flag. This leads to an
inconsistent state in the following sequence.
    qmc_chan_stop()
    qmc_chan_reset()
Indeed, after the qmc_chan_reset() call, the channel must still be
stopped. Only a qmc_chan_start() call can move the channel from stopped
state to started state.

Fix the issue removing the is_rx_stopped flag setting from
qmc_chan_reset()

Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 3f3de1351c96..2312152a44b3 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -685,7 +685,6 @@ static void qmc_chan_reset_rx(struct qmc_chan *chan)
 		    qmc_read16(chan->s_param + QMC_SPE_RBASE));
 
 	chan->rx_pending = 0;
-	chan->is_rx_stopped = false;
 
 	spin_unlock_irqrestore(&chan->rx_lock, flags);
 }
-- 
2.43.0

