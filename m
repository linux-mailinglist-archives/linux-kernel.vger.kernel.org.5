Return-Path: <linux-kernel+bounces-141808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625198A23B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F7AB219F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150EDD53E;
	Fri, 12 Apr 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ghAXNGFA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2D523A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712888176; cv=none; b=XomalhGjCOyKA0wueF4yAcPfFcemrJX9EqESxfzwvRhkVq3ure08jAjGoRsHxqukojjsAJTYdcHZmtqYRNzsFKs1UqKW/Tv3BTc4gDm/sQ/UlOLdDnGwffW9soB8tq4UYWfEbQpTk2wKfbAln4CQK0KOUR46tD2sUCp+jkNstO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712888176; c=relaxed/simple;
	bh=6Oqt1E6GfOWPlz1n2ESZHY8iTumq9W1oUZclyVVpVyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7t6alKN1SkWT2BfioYRXlAarjLhXpubtqpw26mEFt3Q8m4TqNjgpizV+W8iRpcrrqSCh1SFxaNZLIxAlIHZSUpTkZPWSOa/MS6fr/FdTSqA+jY3gl1Q+FadA1JXn8G6r7+pw8Yg4yfdpKEiDSOjnOXJ+zagcu4tsYnVowiVRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ghAXNGFA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712888165; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6ygufD2xWuJO70bpPihWRfbEPHVY2rVQDU1CikGww1Y=;
	b=ghAXNGFAVdJxoi4H3g5/CFMbiNajE7+UDZqO6Opsbu5O/nAed634jjf0rMXob2lJCOod5cB/de9xDrYt/4EMjwrh0XcjvqX7Vq4CjF7Yl9DDwRNHxeHUVlHMt/dN3iesB3U90FzMEWN9/KDO/0y3M2g8+9G+DJ/AiFX+er8GjAU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4MZxGL_1712888164;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4MZxGL_1712888164)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:16:05 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v3] irqchip/gic-v3-its: Fix double free on error
Date: Fri, 12 Apr 2024 10:15:56 +0800
Message-Id: <20240412021556.101792-1-guanrui.huang@linux.alibaba.com>
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

Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..55c83e19719d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4521,8 +4521,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err = 0;
 
-	BUG_ON(!vm);
-
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
@@ -4561,13 +4559,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
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


