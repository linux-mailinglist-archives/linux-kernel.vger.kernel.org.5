Return-Path: <linux-kernel+bounces-124413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F6891738
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1B1B2204C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75982880;
	Fri, 29 Mar 2024 10:56:51 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC807BB0D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709810; cv=none; b=h47ycFb53JCGm/ednXaPw81vZ6F/+bi4o5ItdidHEBkqgopziBZ/2HSc7vvwHEj6LIU37nFOhmjabG2m5N07rem8wnRuuvLpfh9jsan4JdnDL/I5MR0vqrr45fm1yEoF6qHilyiLVX5q403nijuPOvSIWSiFHnBgGUJQblNyFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709810; c=relaxed/simple;
	bh=GrV47NT5vn8t81Ahr/eNUVMeiZ6ilTSttqyQGbii5b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJy67qikKSmDhUnTV+nl2F42zx8hqVNx6Rv8ANC8ewRPnpDSo//wemZqJ/8aQaD2bvWfOxu0Ud9KutxZER1OMPTdmgDnak/Hj/s/YBsogpMmRFW6PiK7/sagYJhF863PIMVlbkadL4GvU073IwhtsnnBt2Ee9041V5LbtrmYaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 0791ead8-edbb-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 12:56:43 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/11] pinctrl: aw9523: Make use of dev_err_probe()
Date: Fri, 29 Mar 2024 12:55:22 +0200
Message-ID: <20240329105634.712457-9-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index f084dad5c88f9..fe398c59c2d11 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -816,10 +816,8 @@ static int aw9523_init_irq(struct aw9523 *awi, int irq)
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, aw9523_irq_thread_func,
 					IRQF_ONESHOT, dev_name(dev), awi);
-	if (ret) {
-		dev_err(dev, "Failed to request irq %d\n", irq);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq %d\n", irq);
 
 	girq = &awi->gpio.irq;
 	gpio_irq_chip_set_chip(girq, &aw9523_irq_chip);
@@ -1016,8 +1014,7 @@ static int aw9523_probe(struct i2c_client *client)
 
 	awi->pctl = devm_pinctrl_register(dev, pdesc, awi);
 	if (IS_ERR(awi->pctl)) {
-		ret = PTR_ERR(awi->pctl);
-		dev_err(dev, "Cannot register pinctrl: %d", ret);
+		ret = dev_err_probe(dev, PTR_ERR(awi->pctl), "Cannot register pinctrl");
 		goto err_disable_vregs;
 	}
 
-- 
2.44.0


