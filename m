Return-Path: <linux-kernel+bounces-118655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9888BDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC463B24C41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B176129E9E;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxaV0gA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46976EB72;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=uxPTAUAbwu0AHik+ifUnzbFSUAGl62q5kQOBk3fPqKdECewvoUg2B5J6nOrYHZrKUOj93lyWeJrH4yqWhX5X27slGdw58JNE+bqGAQsZqYecviD0V8onPkeMF8r6kG9X0RMGIz5WyHhVZg6aH1/ZlI9DQcKpzxA7k+2S8Ykhnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=SGXoMlY26vISdHvZzmwBAflrGzKbs6k3UUldXLz/FXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FINB6xklfVlZFWoUm2wpYRr9FVwRzo4sxxMoCd8rxhAzNFMae7kDSotZjmPLuzqi0xPFmLyZPlswtz8aibxfeBwkE+9yxi/rp1Zlds6skdj2ndoHRLa8D/J2/1p2Io+BUxBH2UVsMLQAEs0e4WZmm4q9h62YUAIWQ4Gp/5wEamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxaV0gA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D457C4AF6A;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=SGXoMlY26vISdHvZzmwBAflrGzKbs6k3UUldXLz/FXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oxaV0gA+blIDy7NtGMmiT78FvpLhQG8dAjPQiWo/NAscT+TE0wZo6BVr6V5txIjMq
	 eojMvUntQbMZ4r+fO+FkiRO7V1+VaNddj3+q4aeEo8CtTqn/fGwXQxs4C2MWaZWDFs
	 zt6MuqPbv1z87zdc+14qW1AUe81PAT6P9nKVknzKge5iTHywWwabSXow0W7SPxrAcZ
	 z+/8/dyPnMhyk3xy4CytQaFinRBRR/wjx8rQba1Yztd+uSKUua0QIblsz92yXOX8Cm
	 3xXJCRr/M0t3HXkKQ/AFIB9WfC57oSws60syrxf7o4gBBw6xr0uB9usBasy5gVfxjc
	 31Pz15xVHS0VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB76CD11DF;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:48 +0300
Subject: [PATCH v9 21/38] ata: pata_ep93xx: add device tree support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-21-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=5839;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=J/0jofmjgTG/7stXmnaHaXQdUGd+YYpzoDObEyCoEqo=;
 b=pfo/KQMvaQ6t/kvSdjzDjCJNquZSwDOBWz9ev+UTH9ruBsKxMmgiRr1JFKM+N973yxAdASELAHvn
 eJsW+7RMBZpM66AKy4pK1y2c0DGyDCPF7u41M3JYcYVxK4GvrGyQ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

- add OF ID match table
- drop platform DMA and filters
- change DMA setup to OF, so we can defer probe

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/ata/pata_ep93xx.c | 80 +++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c84a20892f1b..13246a92e29f 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -44,8 +44,8 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/ktime.h>
+#include <linux/mod_devicetable.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #define DRV_NAME	"ep93xx-ide"
@@ -126,7 +126,7 @@ enum {
 };
 
 struct ep93xx_pata_data {
-	const struct platform_device *pdev;
+	struct platform_device *pdev;
 	void __iomem *ide_base;
 	struct ata_timing t;
 	bool iordy;
@@ -135,9 +135,7 @@ struct ep93xx_pata_data {
 	unsigned long udma_out_phys;
 
 	struct dma_chan *dma_rx_channel;
-	struct ep93xx_dma_data dma_rx_data;
 	struct dma_chan *dma_tx_channel;
-	struct ep93xx_dma_data dma_tx_data;
 };
 
 static void ep93xx_pata_clear_regs(void __iomem *base)
@@ -637,20 +635,13 @@ static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
 	}
 }
 
-static bool ep93xx_pata_dma_filter(struct dma_chan *chan, void *filter_param)
+static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 {
-	if (ep93xx_dma_chan_is_m2p(chan))
-		return false;
-
-	chan->private = filter_param;
-	return true;
-}
-
-static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
-{
-	const struct platform_device *pdev = drv_data->pdev;
+	struct platform_device *pdev = drv_data->pdev;
+	struct device *dev = &pdev->dev;
 	dma_cap_mask_t mask;
 	struct dma_slave_config conf;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -660,22 +651,16 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * to request only one channel, and reprogram it's direction at
 	 * start of new transfer.
 	 */
-	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_rx_data.direction = DMA_DEV_TO_MEM;
-	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
-	drv_data->dma_rx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
-	if (!drv_data->dma_rx_channel)
-		return;
+	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
+	if (IS_ERR(drv_data->dma_rx_channel))
+		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel),
+				     "rx DMA setup failed\n");
 
-	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_tx_data.direction = DMA_MEM_TO_DEV;
-	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
-	drv_data->dma_tx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
-	if (!drv_data->dma_tx_channel) {
-		dma_release_channel(drv_data->dma_rx_channel);
-		return;
+	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(drv_data->dma_tx_channel)) {
+		ret = dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
+				    "tx DMA setup failed\n");
+		goto fail_release_rx;
 	}
 
 	/* Configure receive channel direction and source address */
@@ -683,10 +668,10 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_DEV_TO_MEM;
 	conf.src_addr = drv_data->udma_in_phys;
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_rx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure rx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
-		return;
+	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure rx dma channel");
+		goto fail_release_dma;
 	}
 
 	/* Configure transmit channel direction and destination address */
@@ -694,10 +679,20 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_MEM_TO_DEV;
 	conf.dst_addr = drv_data->udma_out_phys;
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_tx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure tx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
+	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure tx dma channel");
+		goto fail_release_dma;
 	}
+
+	return 0;
+
+fail_release_rx:
+	dma_release_channel(drv_data->dma_rx_channel);
+fail_release_dma:
+	ep93xx_pata_release_dma(drv_data);
+
+	return ret;
 }
 
 static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
@@ -954,7 +949,9 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	drv_data->ide_base = ide_base;
 	drv_data->udma_in_phys = mem_res->start + IDEUDMADATAIN;
 	drv_data->udma_out_phys = mem_res->start + IDEUDMADATAOUT;
-	ep93xx_pata_dma_init(drv_data);
+	err = ep93xx_pata_dma_init(drv_data);
+	if (err)
+		return err;
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
@@ -1021,9 +1018,16 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	ep93xx_ide_release_gpio(pdev);
 }
 
+static const struct of_device_id ep93xx_pata_of_ids[] = {
+	{ .compatible = "cirrus,ep9312-pata" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
+
 static struct platform_driver ep93xx_pata_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ep93xx_pata_of_ids,
 	},
 	.probe = ep93xx_pata_probe,
 	.remove_new = ep93xx_pata_remove,

-- 
2.41.0



