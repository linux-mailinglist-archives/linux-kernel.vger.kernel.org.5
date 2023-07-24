Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291A75FB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGXPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGXPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:47:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24C8E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:47:48 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD9E366070FA;
        Mon, 24 Jul 2023 16:47:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690213666;
        bh=flPkR3SRjDLi+RNF2WkNTZKoq2tsI/OK155ZonGqn4A=;
        h=From:To:Cc:Subject:Date:From;
        b=Qy5xx3gGDwqwBrZBgp56f6+q2TqOzrXFEq94G5S1SGm/UZbw9pAvkbgAcunHvvbfz
         EoLSy3/W1Mba17Wbof7ha6IbzSbLkyW5u01VvV0E9XtsIlnjAXioBwD/JNY129NOQs
         oiFaJm6GYdzKqmI8nu8eKg367AYQGmtxlqgis/f3gg/r2F9sDPuCETZ+obAN2+DYYF
         b7zLnqvykrnGejPEV0A1TjPtRRWBaUrsKFay7UN0+xu9BYg97pqrq4k8r2V27DiOR1
         2ZKF5xj4Bi5cBIIFxBcKuobX1Zd3JMIDlgrWlfUVQnfqFTedcnXu7/vMfE6gDQ39H8
         sl/X2d93RShdg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@google.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] spmi: mtk-pmif: Serialize PMIF status check and command submission
Date:   Mon, 24 Jul 2023 11:47:33 -0400
Message-ID: <20230724154739.493724-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before writing the read or write command to the SPMI arbiter through the
PMIF interface, the current status of the channel is checked to ensure
it is idle. However, since the status only changes from idle when the
command is written, it is possible for two concurrent calls to determine
that the channel is idle and simultaneously send their commands. At this
point the PMIF interface hangs, with the status register no longer being
updated, and thus causing all subsequent operations to time out.

This was observed on the mt8195-cherry-tomato-r2 machine, particularly
after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
drivers between 5.10 and 5.15") was applied, since then the two MT6315
devices present on the SPMI bus would probe assynchronously and
sometimes (during probe or at a later point) read the bus
simultaneously, breaking the PMIF interface and consequently slowing
down the whole system.

To fix the issue at its root cause, introduce locking around the channel
status check and the command write, so that both become an atomic
operation, preventing race conditions between two (or more) SPMI bus
read/write operations. A spinlock is used since this is a fast bus, as
indicated by the usage of the atomic variant of readl_poll, and
'.fast_io = true' being used in the mt6315 driver, so spinlocks are
already used for the regmap access.

Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Switched to raw spinlock to avoid overhead in PREEMPT_RT
- Moved spin_unlock to after marking the channel ready on the error
  paths

Changes in v2:
- Added missing spin_unlocks to error paths
- Moved memcpy outside spinlock region in the write_cmd function
- Reworded commit message to make clear that issue can happen at any
  point in runtime, not only during boot

 drivers/spmi/spmi-mtk-pmif.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index b3c991e1ea40..54c35f5535cb 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -50,6 +50,7 @@ struct pmif {
 	struct clk_bulk_data clks[PMIF_MAX_CLKS];
 	size_t nclks;
 	const struct pmif_data *data;
+	raw_spinlock_t lock;
 };
 
 static const char * const pmif_clock_names[] = {
@@ -314,6 +315,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	struct ch_reg *inf_reg;
 	int ret;
 	u32 data, cmd;
+	unsigned long flags;
 
 	/* Check for argument validation. */
 	if (sid & ~0xf) {
@@ -334,6 +336,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
+	raw_spin_lock_irqsave(&arb->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
 	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
@@ -343,6 +346,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		/* set channel ready if the data has transferred */
 		if (pmif_is_fsm_vldclr(arb))
 			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&arb->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
@@ -350,6 +354,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	/* Send the command. */
 	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
 	pmif_writel(arb, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&arb->lock, flags);
 
 	/*
 	 * Wait for Software Interface FSM state to be WFVLDCLR,
@@ -376,7 +381,8 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 	struct ch_reg *inf_reg;
 	int ret;
-	u32 data, cmd;
+	u32 data, wdata, cmd;
+	unsigned long flags;
 
 	if (len > 4) {
 		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
@@ -394,6 +400,10 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
+	/* Set the write data. */
+	memcpy(&wdata, buf, len);
+
+	raw_spin_lock_irqsave(&arb->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
 	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
@@ -403,17 +413,17 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		/* set channel ready if the data has transferred */
 		if (pmif_is_fsm_vldclr(arb))
 			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&arb->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
 
-	/* Set the write data. */
-	memcpy(&data, buf, len);
-	pmif_writel(arb, data, inf_reg->wdata);
+	pmif_writel(arb, wdata, inf_reg->wdata);
 
 	/* Send the command. */
 	cmd = (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) | addr;
 	pmif_writel(arb, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&arb->lock, flags);
 
 	return 0;
 }
@@ -488,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
 	arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
 
+	raw_spin_lock_init(&arb->lock);
+
 	platform_set_drvdata(pdev, ctrl);
 
 	err = spmi_controller_add(ctrl);
-- 
2.41.0

