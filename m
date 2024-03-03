Return-Path: <linux-kernel+bounces-89671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2786F3FB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299AC1C20FA7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB9A957;
	Sun,  3 Mar 2024 08:22:10 +0000 (UTC)
Received: from regular1-03.263.net (regular1-03.263.net [211.150.70.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205D945A;
	Sun,  3 Mar 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.150.70.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454129; cv=none; b=Iq8M0GBDBDQaTSkfI5FAxWef4kWJ+128K/1+55J4Z+YD2CHi/BR/wvYjn0T70cazTOvANaJ81QJtTCIsKIyyjM8rdLaCuswxYWtyNmVPCw7davVnDVSf37PA84U2RM9vZf5X2MSbKP2o6wqjJMISVe/b9CUWJgREMvHJYklBmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454129; c=relaxed/simple;
	bh=qO9SV8llceR6KpdDQN8ljn/YpWs1GR0zI28k4g9IsJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxolZPSjPndlYLumwhs6cBMWiw37mhkqwpJo9CBFhAZ+mqg37WH0pzy3ansfE+QZaWIrcgQU6FgTIFB+PG7Q924ybYxhRNe3a39DwJsb1OdEE0zw1IvW6SHTZqEseRjgzlz/L9PYVMXwPjSo4qXAj5G1O6KHpnzcA5cpl7sR1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com; spf=pass smtp.mailfrom=techyauld.com; arc=none smtp.client-ip=211.150.70.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techyauld.com
Received: from localhost (unknown [192.168.167.32])
	by regular1-03.263.net (Postfix) with ESMTP id BA0F01BCA;
	Sun,  3 Mar 2024 16:18:17 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ADDR-CHECKED4:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost (unknown [118.193.106.122])
	by smtp.263.net (postfix) whith ESMTP id P6063T140435683841792S1709453896918313_;
	Sun, 03 Mar 2024 16:18:17 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:yzheng@techyauld.com
X-SENDER:yzheng@techyauld.com
X-LOGIN-NAME:yzheng@techyauld.com
X-FST-TO:rogerq@kernel.org
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:118.193.106.122
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<fb985bd55e43264275113590ea1f06ac>
X-System-Flag:0
Date: Sun, 3 Mar 2024 16:18:17 +0800
From: Brock Zheng <yzheng@techyauld.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
	Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the sub-devices
Message-ID: <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
 <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
 <beacb55c-951b-4177-83ab-94fda44cd2b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beacb55c-951b-4177-83ab-94fda44cd2b7@kernel.org>

On TI-AM335x，FPGA under GPMC local-bus can not work on 6.x kernel.

GPMC <--> FPGA  <--> sub-devices....

I found that the platform sub-devices are in wrongly organized
hierarchy.  The grandchildren are now under the GPMC device directly,
not under it's father(FPGA).

Signed-off-by: Brock.Zheng <yzheng@techyauld.com>
---
 drivers/memory/omap-gpmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 80d038884207..1f2568e43086 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2175,6 +2175,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	int ret, cs;
 	u32 val;
 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+	struct platform_device *child_pdev = NULL;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
@@ -2330,11 +2331,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 no_timings:
 
 	/* create platform device, NULL on error or when disabled */
-	if (!of_platform_device_create(child, NULL, &pdev->dev))
+	child_pdev = of_platform_device_create(child, NULL, &pdev->dev);
+	if (!child_pdev)
 		goto err_child_fail;
 
 	/* create children and other common bus children */
-	if (of_platform_default_populate(child, NULL, &pdev->dev))
+	if (of_platform_default_populate(child, NULL, &child_pdev->dev))
 		goto err_child_fail;
 
 	return 0;
-- 
2.44.0




