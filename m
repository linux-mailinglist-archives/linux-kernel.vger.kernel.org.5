Return-Path: <linux-kernel+bounces-140294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDC8A1257
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A43281FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75961474D6;
	Thu, 11 Apr 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k7FnvYZ6"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28391474C6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833000; cv=none; b=rVscB7+XiQPo/JaOBFRDLvmSNrhDEZZeLYgmVzTpv1ttZa94RTxyTIS2c5U1DszhTM8EjVOZ3AYe0pPhHw2ZjT703eXbRD/Ia3f78ntzDC7MFSRkT0Lb8jwoh36vGIH61LGyzQ3beZWW2I9HKCB9EtkyO4nXYaxkRjjR9Gz8hIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833000; c=relaxed/simple;
	bh=bCGez7Zr35rx0+sUoV3vqCls4p+x42fcEzmrFD5v1IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYB6BJ+DsHsRWHT9JI/fLVgIcSsK/0V7Eb2e4Nq0Q3SHB+HOxfffBGV7puuY1ivIyBdLy3fRYAZ8YtLZnzZFmW9DNFthZGZXfbOyweZTHDO2nWo0xPPtagp42W+LfN/kLibZrnKP7YVjW/vCoARx/rez7MW7AvYJPTE5pONCjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k7FnvYZ6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712832995; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GiBl0LMtxt6BozD22E9xHhmW9Pl0IRFogPVyKcLUuRA=;
	b=k7FnvYZ62iHfYDuSfVw2ZF93psQ8dH710e3q3SJ1FduUZ0w72iKi42LaTiPd8lCr5a0iHdn8KeSQWcDu4Faw1oBR1nlkglCmkBxqueWN9RfPk5eXxpVFQ6tYBpIocfl5p0dBP7zVTR+aofccE8AYnGVg2DHu7LDKj+XRag3JZlY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4L2auc_1712832994;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4L2auc_1712832994)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 18:56:35 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v2] irqchip/gic-v3-its: Fix double free on error
Date: Thu, 11 Apr 2024 18:56:30 +0800
Message-Id: <20240411105630.53865-1-guanrui.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error
with i > 0, its_vpe_irq_domain_free may free bitmap and vprop_page,
and then there is a double free in its_vpe_irq_domain_alloc.

Fix it by calling its_vpe_irq_domain_free directly, bitmap and
vprop_page will be freed in this function.

And check whether its_vm is equal to domain->host_data to make sure
its_vpe_irq_domain_free handle right its_vm.

Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..72c44e555c88 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4523,6 +4523,9 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 	BUG_ON(!vm);
 
+	if (vm != domain->host_data)
+		return -EINVAL;
+
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
@@ -4561,13 +4564,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
-	if (err) {
-		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i);
-
-		its_lpi_free(bitmap, base, nr_ids);
-		its_free_prop_table(vprop_page);
-	}
+	if (err)
+		its_vpe_irq_domain_free(domain, virq, i);
 
 	return err;
 }
-- 
2.36.1


