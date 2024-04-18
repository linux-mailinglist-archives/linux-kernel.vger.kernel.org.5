Return-Path: <linux-kernel+bounces-149554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA48A92CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24E21F21BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961374BE5;
	Thu, 18 Apr 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jYShVdTS"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4F657D4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420672; cv=none; b=fnAwWeMU1uZoTAQwmIXMMBKMf9Fy9sd7qQPT2njBU5srWuECU7Gjnj/h/zTw5BlHsyfde3eWTjOpsGhEiR0LwD+jUF9Yg+6yZz7M5RAzf7vLxfXv2ze6CdnswWQM1p72KnbDUoEftdxTo8x7iZOtnLtrugdUayczwQngOzPTEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420672; c=relaxed/simple;
	bh=oowkozNmjGlW79z1tpDz5ibUt4Y1kS++h4P0yyQeaZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAb2+etOpit9Fmi8PY71pmOiY8HpAM2nm2qX0HmGk4CEmmjtCoOd2lxnuHJ/KNUK3nzofv9vU09n9qjVR2gJbgZqYEFzcH8PpiucPgIPD5/EXVui6yD2NUlsknUv8ZhCqLRXlnHgby3WdL+pcps3eYPcggqIhYXiAFQ4rp7CxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jYShVdTS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713420667; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9VRYN2yD2V4/lnqB6El/L7sh5NLW7Fn4xEq3YHYUc+U=;
	b=jYShVdTScQQXvUNEoScD6ccm/SgKWkLB3c5EjSJfw/mA+CwVdBZxjNne9XphNWBE07xWCefusL2idiXNRjG7TCb6jFyHCvDtNlrIQD16uYEjRhRPzZL2gG4BUP/b4oxLdRBaoUXAalfK+tqJrZ8VOBfkCoVCiWRGJpoQkWGmbEY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4nb0yv_1713420666;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4nb0yv_1713420666)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 14:11:06 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: Markus.Elfring@web.de,
	yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v5 2/2] irqchip/gic-v3-its: remove BUG_ON in its_vpe_irq_domain_alloc
Date: Thu, 18 Apr 2024 14:10:53 +0800
Message-Id: <20240418061053.96803-3-guanrui.huang@linux.alibaba.com>
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

This BUG_ON() is useless, because the same effect will be obtained 
by letting the code run its course and vm being dereferenced,
triggering an exception.

So just remove this check.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2305f6b524a9..55c83e19719d 100644
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
-- 
2.36.1


