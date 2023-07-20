Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AD75AE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGTM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:27:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D8A2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:27:02 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6BgJ17GYzNmQV;
        Thu, 20 Jul 2023 20:23:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 20:27:00 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <liyihang6@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <shenyang39@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH] irqdomain: Fix driver re-inserting failures when IRQs not being freed completely
Date:   Thu, 20 Jul 2023 20:24:29 +0800
Message-ID: <20230720122429.4123447-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4615fbc3788d ("genirq/irqdomain: Don't try to free an
interrupt that has no mapping"), we have found failures when
re-inserting some specific drivers:

[root@localhost ~]# rmmod hisi_sas_v3_hw
[root@localhost ~]# modprobe hisi_sas_v3_hw
[ 1295.622525] hisi_sas_v3_hw: probe of 0000:30:04.0 failed with error -2

This comes from the case where some IRQs allocated from a low-level domain,
e.g. GIC ITS, are not freed completely, leaving some leaked. Thus, the next
driver insertion fails to get the same number of IRQs because some IRQs are
still occupied.

Free a contiguous group of IRQs in one go to fix this issue.

A previous discussion can be found at:
https://lore.kernel.org/lkml/3d3d0155e66429968cb4f6b4feeae4b3@kernel.org/
This solution was originally written by Marc Zyngier in the discussion, but
no code ends up upstreamed in that thread. Hopefully, this patch could get
some notice back.

Fixes: 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt that has no mapping")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 kernel/irq/irqdomain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f34760a1e222..f059e00dc827 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1445,13 +1445,24 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int nr_irqs)
 {
 	unsigned int i;
+	int n;
 
 	if (!domain->ops->free)
 		return;
 
 	for (i = 0; i < nr_irqs; i++) {
-		if (irq_domain_get_irq_data(domain, irq_base + i))
-			domain->ops->free(domain, irq_base + i, 1);
+		/* Find the largest possible span of IRQs to free in one go */
+		for (n = 0;
+			((i + n) < nr_irqs) &&
+			 (irq_domain_get_irq_data(domain, irq_base + i + n));
+			n++)
+			;
+
+		if (!n)
+			continue;
+
+		domain->ops->free(domain, irq_base + i, n);
+		i += n;
 	}
 }
 
-- 
2.30.0

