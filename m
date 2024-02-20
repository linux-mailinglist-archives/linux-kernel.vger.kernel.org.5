Return-Path: <linux-kernel+bounces-72895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065CB85BA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7FC1F25216
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8E67C7A;
	Tue, 20 Feb 2024 11:21:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584567C70
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428096; cv=none; b=j6AFDKABsGKlcSSQy/lWxZnlvio6eReh2aLTHZiKdBnUvYnrUPxw3rUCWycaUQlgNWXyE0F51WiYWETE0fN+XyoFKNIfRCgyBWRbHFRfX4AlXIIkFNH36Y3/CpKCOpiTktb/QfD0Dwv+lgHr7wh8D6SULGJgF8gfWTPLBuEU7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428096; c=relaxed/simple;
	bh=p3qHs+8yUn4gJnTCAezckQGse3mRhKycMBb4P4eMPqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEgagW8+spTewfq7luwEFJSMyPaiKwLLbQCT81YGPphW30fB9fyJjA4XMDKRGe9uUAVA6sjxb0lw5ENYZR0UWlfTWM1maogE1Nw11JS/M6vx3AnPXfNE8zGr8uHhgmrZ3U3miuc0h3FN78lOV5JnqVdQYc51yUzRqg3dU38f+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TfH4h2Rpyz1xnyq;
	Tue, 20 Feb 2024 19:20:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id E18C2140118;
	Tue, 20 Feb 2024 19:21:25 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 19:21:25 +0800
From: =?UTF-8?q?=E9=99=88=E9=AA=8F?= <chenjun102@huawei.com>
To: <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <xuqiang36@huawei.com>, <chenjun102@huawei.com>
Subject: [PATCH v3] irqchip/mbigen: Don't use bus_get_dev_root() to find the parent
Date: Tue, 20 Feb 2024 19:14:29 +0800
Message-ID: <20240220111429.110666-1-chenjun102@huawei.com>
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

From: Chen Jun <chenjun102@huawei.com>

bus_get_dev_root() returns sp->dev_root set in subsys_register().
And subsys_register() is not called by platform_bus_init().

For platform_bus_type, bus_get_dev_root() always returns NULL.
This makes mbigen_of_create_domain() always return -ENODEV.

Don't try to retrieve the parent via bus_get_dev_root() and
unconditionally hand a NULL pointer to of_platform_device_create() to
fix this.

Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Cc: stable@vger.kernel.org
---
v3: Modify change log

v2: Modify change log
    https://lore.kernel.org/all/20240219085314.85363-1-chenjun102@huawei.com/

v1: https://lore.kernel.org/all/20240129130003.18181-1-chenjun102@huawei.com/

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


