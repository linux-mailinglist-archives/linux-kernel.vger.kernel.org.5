Return-Path: <linux-kernel+bounces-149553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5F8A92CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E5C1F2175A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234D6A8D2;
	Thu, 18 Apr 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lvf9mHGB"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523E3399B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420670; cv=none; b=VNanwkzrjKOHYTzWyQO/+b1eJS18GcFgbA7sTFaaRNK7GLT4i9zwiSs25UaRM6NN9UoCFdLWYYcPCdEwWm1zDgPGnNOukGY2XmPqdzSAREmzFLRhC2IgnZerUq3BF+7jB2wsPJdJaaprI0vPT8Bd43/cOxwhYooe1dhZccyzzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420670; c=relaxed/simple;
	bh=9AIO2yFVH27qbIsLPRxjt7VAjn7rXGEkOnY2v3eJ17o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htHueqwKlVR93ukGs4SMgYAZQn0fPTDnwU1YYx63IZ+BYn1Pi34nzqlhXrc57oCydVvCtWtrpRhtPmZ2EwfgNy8KXdvt+l8z9Omvv69T8PXGlw3PkAn4Jax5Dg+EnMG3Lay3+8NfI6MtR1cdv9zIFu4AkIpxYjqSVr4DS4vk+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lvf9mHGB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713420665; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j5xhT/xn+HoEPFQEH51jOs/5tUc6xggDrAbLHMmno6Y=;
	b=lvf9mHGBzKKwIlkHJboK1N1o6Mn6G+sT94VWxPNSeARreiT8bB5Vxm/QWhxzPiybfLTTHOjeLv2ym5TcpSyIbwTDHNZCxFp1s1Zhjaad+Wkr5Kt/N12zHNcnOFvxHhC4hNKqFTgkY1nBlZlKY/AfG2gMWP3gOa7YuMhfirT1aRk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4nc51F_1713420663;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4nc51F_1713420663)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 14:11:04 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: Markus.Elfring@web.de,
	yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v5 1/2] irqchip/gic-v3-its: Fix double free on error
Date: Thu, 18 Apr 2024 14:10:52 +0800
Message-Id: <20240418061053.96803-2-guanrui.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240418061053.96803-1-guanrui.huang@linux.alibaba.com>
References: <20240418061053.96803-1-guanrui.huang@linux.alibaba.com>
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

Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
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


