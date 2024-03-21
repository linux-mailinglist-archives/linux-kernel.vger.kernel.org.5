Return-Path: <linux-kernel+bounces-109917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4998857C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBED283F92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549ED57871;
	Thu, 21 Mar 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pB7SZ5iR"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65B57867
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019102; cv=none; b=CZPO1KjN8N4dY2998NTPWGPSZDug/iw7my/Ct62nZs0nIHuEK4eWOcjg9c/F5ehzswl0ieyKxFPxxl+m6YF4V56JjS13G3LvxlrYJTts7WRu8qdYKOnzC907hJJi6hRBLemH/AIbEuLrExQHaAR4D3p8mtsH4oimpCZB7JyXTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019102; c=relaxed/simple;
	bh=VBRBM2oRGtovU3QAPr0yqfOUTXB9pEcbpVux7u+dYK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d04b0VJk06Ugy0FkzaR9YE3K0OIHYMkn54xYYZTxsS/+XZM5tb1C+dpf54VVK4nR/D6fVJuGrxjdFZ/qRVSWkEg4lM6jovWCO6WsF9Y0oSPHqWZkiA0iCbNFpktWlmgCltRvvg8ktgMo2Q9UPyB0VhLez0HieMIYRex5HxmA7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pB7SZ5iR; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711019097; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XnmZ1grMEt1sDAoeQK50iTO5lrhMsdeymCczyI8HsBc=;
	b=pB7SZ5iRhhk0ktZFv8GZJKpqxk1fn49A1A8SRFIvFncIW1Ul9c9Pj0r+BvekxczIjr40ZWdA5Yp4h/CFmBvfM4X6ORHXC/F0h9u8LytnVmmdkGXTtAITt7ARCJ5XP/eFqXNSguAFyhTIK8Nal1xioXSEDu35CiUfoORtwsQ+z8c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3-bbO1_1711019095;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W3-bbO1_1711019095)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 19:04:56 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH] irqchip/gic-v3-its: Fix double free on error
Date: Thu, 21 Mar 2024 19:04:54 +0800
Message-Id: <20240321110454.89410-1-guanrui.huang@linux.alibaba.com>
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

Fix it by checking if bitmap is empty in its_vpe_irq_domain_alloc.
If bitmap is empty and i > 0, means that bitmap have been clear and free
in its_vpe_irq_domain_free.

Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..98a1be90caef 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4562,9 +4562,14 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	}
 
 	if (err) {
-		if (i > 0)
+		if (i > 0) {
 			its_vpe_irq_domain_free(domain, virq, i);
 
+			/* bitmap and vprop_page be freed in its_vpe_irq_domain_free */
+			if (bitmap_empty(bitmap, nr_ids))
+				return err;
+		}
+
 		its_lpi_free(bitmap, base, nr_ids);
 		its_free_prop_table(vprop_page);
 	}
-- 
2.36.1


