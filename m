Return-Path: <linux-kernel+bounces-118648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B788BDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC6D1C390C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E8173D;
	Tue, 26 Mar 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMCcj3Iw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBD6BB4E;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=OGvgrHs3hSpY0hG/1ro0GhEdTKwpl2JZA2XTTCUBnrAntBJxMZkzj31i0teGI7afWHsRzVplulZs8QgjJEFnJGD+10A03HWZsStSG+BzB8uqz1tzNofawmh4Skv3TrmOy9o1PVMZXWQ0dVkVNahLuX0oyQWltCaDZID5u7t3GiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=Sspovqk7sjCW8ib9CskROQtqG9mbNkTfAN1CZudc4Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utZWDVItAiNIfnxH1koHD6eQILZs48Wrch5fc80o7i/yF4Al0YhUlAScjPVb9WhA7J150csoNNrUoJV7m99n6mttTyvfpVw9/4MoaqQp901/nubVOFQcv0geeR8du87CVExnUvPHrwcODXkTAxg0LerwtudFtB29j9qCSqENfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMCcj3Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94FECC32792;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444841;
	bh=Sspovqk7sjCW8ib9CskROQtqG9mbNkTfAN1CZudc4Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vMCcj3Iw4gbo5IiWsHMndE+L4xed7RVWxayPON5G9Qvv7ABLUmv9Lh7n4bMFZKvu8
	 U8WjOTCMYzaTAzfEgL6WLFBq4oH1ni7Xp5bE7I/aD4xnRpJj7dCUEP1qBPyyM1e1O6
	 jyLWmHz69XJzGnHfR8c9LRBOeCItK3lxQoOoVRSVmNXwTPApfw1T5FhwAvHQenBDCV
	 QxIoiJNNViWhERVa3w7Mew+OXkIMfjkgpo6ebNsu8AuFjNbRvPcJcjjI2A5EYd57JK
	 EaLuBJjIcOsZ1X0Tq1rlvyOtQgsTrFqlGiitVTJRFl/mbIm1ydWqOBHQ64HoeIkqeP
	 uRhfXBdL350Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FEC54E58;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:40 +0300
Subject: [PATCH v9 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240326-ep93xx-v9-13-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=1116;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=bnZYfiHGnAA0LBZBO2ZRFOvx5iMvZSL9xKTsTR1fprw=;
 b=txn0wzJejIYEIiKnmDpW6W8W3gidg19PTn/IRptM5x7DPKSscr8072p+gMBypsr1p0iSv7/RZDXj
 wkLlQdeFAxph9/XNxqSd9BETWTCDW7l1tlE0gHSr40S/c/+fSKFG
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 666f2954133c..67c3fdbf7ae3 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -188,9 +189,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_pwm_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-pwm" },
+	{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pwm_of_ids);
+
 static struct platform_driver ep93xx_pwm_driver = {
 	.driver = {
 		.name = "ep93xx-pwm",
+		.of_match_table = ep93xx_pwm_of_ids,
 	},
 	.probe = ep93xx_pwm_probe,
 };

-- 
2.41.0



