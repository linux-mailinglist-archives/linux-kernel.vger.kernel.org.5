Return-Path: <linux-kernel+bounces-143597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743818A3B44
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F0F1C212F0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F931D555;
	Sat, 13 Apr 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CoOLueB/"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D761CFBB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990474; cv=none; b=XjwIMbxyHl10AfhAvodlOC7+atGifS8tQ67ql/ww39hKZ0fgsJIE49YAsxfq6NYT3g30MWaQ1Rl5ACEWn5NskDdW76bO8fx5MrWAbfM64iAKCfjcFK4sAA0URwc37tNfhNlEa6Sz/QrZ+K1nxh1MnSjN022aXxZNuLDW/kKpeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990474; c=relaxed/simple;
	bh=2EhM+76SClQt4KZVn6nga+M44kY20q50zA7m0bWWq1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRUYLm8D/f57VVT48cd6n0cuh80pzYluHzq0xrKpTeXKoedx+akZ0ygSm8A8ruNSpPtO1XR2gHUyeb+bekdrxNk91BPLHUvetFkCSoRgHt2UbMB7iPI/WQGqeF4FvDQvFS8dgYaqlZ59XMDgej6WwZdpHHfDmYtRECWntwY0r4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CoOLueB/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712990463; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QINZpNy4fyNIwPgJV/+sxBA/hpwDqIxyGlkaaIbfV+8=;
	b=CoOLueB/PQSVde+11329vCa02lmmp/JM161g2+H9qoMATrKUej8fiZB+wvnIejMgXyyBNJqewhnrtovKQn3d2k2ycINg5BkXlKwY4XsOlxD8O/7SXKP6G9XJYohIJwnfSf9oKi9hDAeAAN4MPbYRQ+PcCd+FB2nFcjcGV815x44=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4PzPfZ_1712990462;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4PzPfZ_1712990462)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 14:41:03 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v4 2/2] irqchip/gic-v3-its: remove BUG_ON in its_vpe_irq_domain_alloc
Date: Sat, 13 Apr 2024 14:40:51 +0800
Message-Id: <20240413064051.31315-2-guanrui.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240413064051.31315-1-guanrui.huang@linux.alibaba.com>
References: <20240413064051.31315-1-guanrui.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If vm is NULL in here, that means caller has a bug.
BUG_ON in here is useless, this will paper over bug.

So just remove this check.

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


