Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE37C5115
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjJKLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjJKLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:03:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA198
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:03:54 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE63666072F1;
        Wed, 11 Oct 2023 12:03:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697022232;
        bh=pd3akVqI8dkkMzhP5JhWVVOmj85PgCcSmSnRfDQT6n0=;
        h=From:To:Cc:Subject:Date:From;
        b=jOD7sTj5bstFuQi3fGxysynPaKavon9shpP3bHHXCMk04xXrPB4Gn3HmINRWzsNkC
         BOF0T6+eunk//BSJ+HUyFRF+W5rwqhb+HAv66E2xc4Wk7HyO1SVYThhvkpXGvBrl1T
         pAqxttIDGK4Yy4RKgrIDliX2pYRZ0+EYHd9UKCTvBTr/z2IGfRzQwNZz07AhHtjlD9
         tTGQIYCqWuHK0SfBZnH7RTQ08qrvjsPN17qf1U/WSFksEW2NUH2VfKTcWDSAkUyutN
         Dskwm1UbYWOor9nBcJ3IPqXuxgnIY5SiQGSm/Q5TFVQ/qQ3HjdJus8AvzJho25DwZI
         jLIom/AWlCyOg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     jassisinghbrar@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux@roeck-us.net,
        wenst@chromium.org, kernel@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
Subject: [PATCH] mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend
Date:   Wed, 11 Oct 2023 13:03:09 +0200
Message-ID: <20231011110309.164657-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek found an issue with display HW registers configuration, and
located the reason in the CMDQ Mailbox driver; reporting the original
comment with the analysis of this problem by Jason-JH Lin:

  GCE should config HW in every vblanking duration.
  The stream done event is the start signal of vblanking.

  If stream done event is sent between GCE clk_disable
  and clk_enable. After GCE clk_enable the stream done event
  may not appear immediately and have about 3us delay.

  Normal case:
  clk_disable -> get EventA -> clk_enable -> clear EventA
  -> wait EventB -> get EventB -> config HW

  Abnormal case:
  clk_disable -> get EventA -> clk_enable -> EventA delay appear
  -> clear EventA fail -> wait EventB but get EventA -> config HW

From his analysis we get that the GCE may finish its event processing
after some amount of time (and not immediately after sending commands
to it); since the GCE is used for more than just display, and it gets
used frequently, solve this issue by implementing Runtime PM handlers
with autosuspend: this allows us to overcome to the remote processor
delay issues and reduce the clock enable()/disable() calls, while also
still managing to save some power, which is something that we wouldn't
be able to do if we just enable the GCE clocks at probe.

Speaking of which: if Runtime PM is not available there will obviously
be no way to get this power saving action so, in this case, the clocks
will be enabled at probe() time, kept enabled for the entire driver's
life and disabled at remove().

Reported-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

The 100ms autosuspend delay was estimated in a worst-case scenario and
was tested on MT8192 and MT8195 Chromebooks, with internal display and
external display running to maximize the number of CMDQ messages being
sent through.
That value can probably be decreased to half of what I've set, but on
that I prefer being cautious and keep it at 100ms.

P.S.: This also solves microstuttering issues that I've randomly seen
on all MediaTek Chromebooks.

 drivers/mailbox/mtk-cmdq-mailbox.c | 80 +++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4d62b07c1411..de862e9137d5 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -13,10 +13,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
 #include <linux/of.h>
 
+#define CMDQ_MBOX_AUTOSUSPEND_DELAY_MS	100
+
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
 #define CMDQ_GCE_NUM_MAX		(2)
@@ -283,10 +286,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 			break;
 	}
 
-	if (list_empty(&thread->task_busy_list)) {
+	if (list_empty(&thread->task_busy_list))
 		cmdq_thread_disable(cmdq, thread);
-		clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
-	}
 }
 
 static irqreturn_t cmdq_irq_handler(int irq, void *dev)
@@ -307,9 +308,26 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
 		spin_unlock_irqrestore(&thread->chan->lock, flags);
 	}
 
+	pm_runtime_mark_last_busy(cmdq->mbox.dev);
+
 	return IRQ_HANDLED;
 }
 
+static int cmdq_runtime_resume(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+}
+
+static int cmdq_runtime_suspend(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+
+	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	return 0;
+}
+
 static int cmdq_suspend(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
@@ -333,16 +351,14 @@ static int cmdq_suspend(struct device *dev)
 	if (cmdq->pdata->sw_ddr_en)
 		cmdq_sw_ddr_enable(cmdq, false);
 
-	clk_bulk_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
-
-	return 0;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int cmdq_resume(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 
-	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
+	WARN_ON(pm_runtime_force_resume(dev));
 	cmdq->suspended = false;
 
 	if (cmdq->pdata->sw_ddr_en)
@@ -358,6 +374,9 @@ static int cmdq_remove(struct platform_device *pdev)
 	if (cmdq->pdata->sw_ddr_en)
 		cmdq_sw_ddr_enable(cmdq, false);
 
+	if (!IS_ENABLED(CONFIG_PM))
+		cmdq_runtime_suspend(&pdev->dev);
+
 	clk_bulk_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 	return 0;
 }
@@ -369,13 +388,20 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
 	unsigned long curr_pa, end_pa;
+	int ret;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
 
+	ret = pm_runtime_get_sync(cmdq->mbox.dev);
+	if (ret < 0)
+		return ret;
+
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
-	if (!task)
+	if (!task) {
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
 		return -ENOMEM;
+	}
 
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
@@ -384,8 +410,6 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	task->pkt = pkt;
 
 	if (list_empty(&thread->task_busy_list)) {
-		WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
-
 		/*
 		 * The thread reset will clear thread related register to 0,
 		 * including pc, end, priority, irq, suspend and enable. Thus
@@ -424,6 +448,9 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	}
 	list_move_tail(&task->list_entry, &thread->task_busy_list);
 
+	pm_runtime_mark_last_busy(cmdq->mbox.dev);
+	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+
 	return 0;
 }
 
@@ -439,6 +466,8 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 
+	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev));
+
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto done;
@@ -457,7 +486,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	}
 
 	cmdq_thread_disable(cmdq, thread);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
 
 done:
 	/*
@@ -467,6 +495,9 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	 * to do any operation here, only unlock and leave.
 	 */
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
+
+	pm_runtime_mark_last_busy(cmdq->mbox.dev);
+	pm_runtime_put_autosuspend(cmdq->mbox.dev);
 }
 
 static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
@@ -477,6 +508,11 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 	u32 enable;
+	int ret;
+
+	ret = pm_runtime_get_sync(cmdq->mbox.dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
@@ -497,10 +533,12 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	cmdq_thread_resume(thread);
 	cmdq_thread_disable(cmdq, thread);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
 
 out:
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	pm_runtime_mark_last_busy(cmdq->mbox.dev);
+	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+
 	return 0;
 
 wait:
@@ -513,6 +551,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 		return -EFAULT;
 	}
+	pm_runtime_mark_last_busy(cmdq->mbox.dev);
+	pm_runtime_put_autosuspend(cmdq->mbox.dev);
 	return 0;
 }
 
@@ -642,12 +682,28 @@ static int cmdq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	/* If Runtime PM is not available enable the clocks now. */
+	if (!IS_ENABLED(CONFIG_PM)) {
+		err = cmdq_runtime_resume(dev);
+		if (err)
+			return err;
+	}
+
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
+
+	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	return 0;
 }
 
 static const struct dev_pm_ops cmdq_pm_ops = {
 	.suspend = cmdq_suspend,
 	.resume = cmdq_resume,
+	SET_RUNTIME_PM_OPS(cmdq_runtime_suspend,
+			   cmdq_runtime_resume, NULL)
 };
 
 static const struct gce_plat gce_plat_v2 = {
-- 
2.42.0

