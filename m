Return-Path: <linux-kernel+bounces-143596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BCA8A3B43
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AA11C21257
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8B1CABF;
	Sat, 13 Apr 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="remnbn8I"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E633C5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990467; cv=none; b=Cs7a9hfy7UVRtWis3d3rSVHHKzAxP7LTu6KX+uM+Xp2og+UC92tF/EjBDnITXLdPNePqNrJ25uY4MzpYp2lKZvEgOwvDEOt8cGNoAkKmCILD/KOChQo2zabCcf+pgnqfTrKOAQZ44hAasE5AJNu5la9ILMSCcFpTVawXWOW4s1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990467; c=relaxed/simple;
	bh=zfO/QxmQJ/t1TEDAe6rBSwFvFvCziigNdI3WcpmvD+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUqfqO9aGsC78upwDCylluCHkEKnq5pvaoHwuWrYhGmlUW6oaNaEb8hidwF4hM6XB52z0QHRfYaGpFHfxRHLYDqG7nDNfyplBhl1rKJLOKi0tVZNjeT4uRXKFS7vdGnzOQLch1y9thYlrYRJk0Up7E+ggrtOpBMx6jhW6LAttwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=remnbn8I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712990454; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/OZ68aDj4lKRSYMfEx7Rvi/TenxwyTAvkYzYhYxFPtE=;
	b=remnbn8IJoKMPgkzpHjGcNlc5PtjCYMD9wnj0D8+3acYJ9C8VX8OxR4Kv4EtEkAS4bSOBcVFHzeojGnqeyK0ciQkkzjQMeuCb1PIul3VUkqEGWETQ3zKfa5yAJcZKhmdkZtW0oxLPTL9L14m/y5sV9Kxihelr2jaTC2zXt/JMts=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4Q.spW_1712990452;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4Q.spW_1712990452)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 14:40:53 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v4 1/2] irqchip/gic-v3-its: Fix double free on error
Date: Sat, 13 Apr 2024 14:40:50 +0800
Message-Id: <20240413064051.31315-1-guanrui.huang@linux.alibaba.com>
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
 drivers/irqchip/irq-gic-v3-its.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..2305f6b524a9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4561,13 +4561,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
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


