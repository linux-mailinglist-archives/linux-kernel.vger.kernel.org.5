Return-Path: <linux-kernel+bounces-146824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B78A6B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F4E1C21A90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3E12BF1D;
	Tue, 16 Apr 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PnuH0l0l"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7D12C531
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271987; cv=none; b=jj8un3O8YsQQMpTID0Bz1ZOM7YlpyqKTZEQEYYfmQpdFQ1aS1pna/Y31BeM10ZTD2MROJVauIxiFp5J6NLSEWJ0Chu5Sy0H6HHx4ku4/P/1XEHjENJNC6ypDGy78JnKQFY/I5QRM8Fxx8shck3ru8WR16iUId8SAzBR8DHkVnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271987; c=relaxed/simple;
	bh=sl5SRuv0DrtHW5bkZkmZdN6IxP9VaaJTX0VeczM4sbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMg7HFM2qNJU20THc2Md0VmX9b1hKheOkPlZlL9T2nMeE9l598GY/waC3w9zEvB4HQH69IW8gOTeuzblysinmP7GqYg4KtwDhAYBAUvolpT3MgsdIllKPuFxXWIufu+oWNepiGoNCAWhxzsrA4cvqqjm4MMLLJ/axg3xC9pJ01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PnuH0l0l; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D802D20007;
	Tue, 16 Apr 2024 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSCKVt3PzenyfZAdSt+Uuc2sxOPAq2JS3OulPvLdYig=;
	b=PnuH0l0lvmrlNI/TjKBPEceAakQIcg0D6nTXGLXNxcGQuomiZOgahc2w4WGZgh9cmqZe+p
	5x4UiNap8ydEjSPxH9upz/z131/oOvV0EACCmwXeS5EV8CeYFtpHXI4tFYOD+SalMWYnIo
	hbO4BoowDHIYbb0DNNX3Pt0WvuySI5NdsOT6xABNYzj4+OEDLUiQLJbMvJE3liEcC40thk
	F8/z9UxoaKHCjs6PGx5FR3k6D4sWFdtP9urojSMl+Hc9dOQYRcF/1uai3BNEbKLpuwdHk1
	gIb5Ovj4fEx1Iaj25SJW9774f8ewuEoCGtDk0vX3w6TUIaSdqvKrSGjUHUSgPQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:32 +0200
Subject: [PATCH 3/8] phy: ti: phy-j721e-wiz: add resume support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-j7200-phy-s2r-v1-3-f15815833974@bootlin.com>
References: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
In-Reply-To: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

Add resume support.
It has been tested on J7200 SR1.0 and SR2.0.

Co-developed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ba670109e7ad..7f626c597025 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1659,12 +1659,41 @@ static void wiz_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 }
 
+static int wiz_resume_noirq(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	struct wiz *wiz = dev_get_drvdata(dev);
+	int ret;
+
+	/* Enable supplemental Control override if available */
+	if (wiz->sup_legacy_clk_override)
+		regmap_field_write(wiz->sup_legacy_clk_override, 1);
+
+	wiz_clock_init(wiz);
+
+	ret = wiz_init(wiz);
+	if (ret) {
+		dev_err(dev, "WIZ initialization failed\n");
+		goto err_wiz_init;
+	}
+
+	return 0;
+
+err_wiz_init:
+	wiz_clock_cleanup(wiz, node);
+
+	return ret;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(wiz_pm_ops, NULL, wiz_resume_noirq);
+
 static struct platform_driver wiz_driver = {
 	.probe		= wiz_probe,
 	.remove_new	= wiz_remove,
 	.driver		= {
 		.name	= "wiz",
 		.of_match_table = wiz_id_table,
+		.pm	= pm_sleep_ptr(&wiz_pm_ops),
 	},
 };
 module_platform_driver(wiz_driver);

-- 
2.39.2


