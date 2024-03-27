Return-Path: <linux-kernel+bounces-121419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5E88E7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4E63044CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69550145332;
	Wed, 27 Mar 2024 14:23:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EC144D08
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549397; cv=none; b=PvE+rkZ1iDKRvf49zasg8zXpC+3sxk2iWol5YUAc4id2xkGjkjKMD0D68phHDYy8bE77zvOUwKQjlOroxqiWIJkgeO2rEaZDOMw7ks1vVblZpunDZFXzcoKbEJYLIWOcWcMSAn3eIh3SA6qlxoSfDC45vIK/Hksh0GxMoGEB2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549397; c=relaxed/simple;
	bh=zRI5GV7a1ReZEinUIATHZ6Ua1rtRrj/S/oB2DPjv1eE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdY5bV7vjNwHv/S2A9xc/7dYSd4XEuJh3yU0kO4drbpOI5FuKz8dEVqu+1kaS7dOR58R4WIQdlxPWsHOWDZnhnfURLYsmn61i3UkVoUWL/8m8sV4Z66UbhK0YqxQgfi81ehR9xV7ozZZBzyu0wwzUi+206yoMCSf7dOdIiu5zrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V4TN94sBJzXjx6;
	Wed, 27 Mar 2024 22:20:25 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 047BF140258;
	Wed, 27 Mar 2024 22:23:13 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 22:23:12 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <maz@kernel.org>, <wanghaibin.wang@huawei.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Tsahee Zidenberg
	<tsahee@annapurnalabs.com>, Antoine Tenart <atenart@kernel.org>
Subject: [PATCH] irqchip/alpine-msi: Fix off-by-one on allocation error path
Date: Wed, 27 Mar 2024 22:23:05 +0800
Message-ID: <20240327142305.1048-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)

When alpine_msix_gic_domain_alloc() returns an error, there is an
off-by-one in the number of IRQs to be freed.

Fix it by passing the number of successfully allocated IRQs, instead of the
relative index of the last allocated one.

Fixes: 3841245e8498 ("irqchip/alpine-msi: Fix freeing of interrupts on allocation error path")
Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <atenart@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-alpine-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 9c8b1349ee17..a1430ab60a8a 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
-- 
2.33.0


