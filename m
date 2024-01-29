Return-Path: <linux-kernel+bounces-42755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DE84063A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73FA1F25AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F8664AC;
	Mon, 29 Jan 2024 13:06:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C465BD8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533585; cv=none; b=AIIls3uPIQ0Po4fwNAT+UA7DrrTL93tPR4hJvvzWhsBtuc/Ska3jvJU2mrMrgouI93nIK9nHp0YA9OmYkwU7TFVzFSWOQmh73WFlaTmUNOSovg+jCIUa0KxAiUNDDzDzt+tiG6owNiIOvowJSipS9Ig2Tifa9+dRRKh2W3wJA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533585; c=relaxed/simple;
	bh=VZrE8f8zCIOoTX/qV216j37du50vp/T05X9GLljT+Mo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hi9j89Kh4yk/ZU5AuImFy3Gq7sXD0sbOxPYMgzzS99yUMHV4H786VHnjdNxKDnVLjQ+4PxUqE18NxorCc3l7TRYXMR96Nb36JB+gmVEt/QsekBDEXdHNkV/3ghGxCVRCqPUn7euDaDMLJTZ/vdnXnrwbfDtqpj+Yioisw8tZy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TNpRJ4QW8z29kmm
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:04:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id 657951404DB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:06:17 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 21:06:16 +0800
From: Chen Jun <chenjun102@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <xuqiang36@huawei.com>, <chenjun102@huawei.com>
Subject: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
Date: Mon, 29 Jan 2024 21:00:03 +0800
Message-ID: <20240129130003.18181-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)

bus_get_dev_root(&platform_bus_type) always returns NULL.
This makes mbigen_of_create_domain always return -ENODEV.

Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 5101a3fb11df..58881d313979 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -235,22 +235,17 @@ static const struct irq_domain_ops mbigen_domain_ops = {
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
-	struct device *parent;
 	struct platform_device *child;
 	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret = 0;
 
-	parent = bus_get_dev_root(&platform_bus_type);
-	if (!parent)
-		return -ENODEV;
-
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
-		child = of_platform_device_create(np, NULL, parent);
+		child = of_platform_device_create(np, NULL, NULL);
 		if (!child) {
 			ret = -ENOMEM;
 			break;
@@ -273,7 +268,6 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 		}
 	}
 
-	put_device(parent);
 	if (ret)
 		of_node_put(np);
 
-- 
2.17.1


