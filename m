Return-Path: <linux-kernel+bounces-149552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441038A92CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C724CB2116E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D9657CF;
	Thu, 18 Apr 2024 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qqaWJN8e"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E6282F4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420668; cv=none; b=ffzTkp+QxpOvj9Dsvbt13vYH/c7Q/dGmki6FhKwa8NVfIa7UfdCy+gu7Qc40ec2beaBHNoohTPOcbvujGV87BrlMwz47rjznsCEznKUeL1Xvs8UxlvZk7ga+9B4JLFZnKru73DuBqm+mk02c+ooSf+Bd9aX4epao3qVd7YErj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420668; c=relaxed/simple;
	bh=2ovER/jZCFkIr5c1CVSCF8FTvQgnyZlDgKYt2Ty4uBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPnGxDNEIH+5JiJgDyN5AKN3O/r7zi5WNumimFNtPDBljGgu8ejTCkiEC4iiLDW1lcQlmt/JfZTkdyL2QYwZr2Sn4IoTjZuzvHncHGnZampfWjuC+7XgtfssPfzqomJTy+U9rAJJf6SpTBS5i17qUFdPHDsxVV1HMx9du32HD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qqaWJN8e; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713420662; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3bFz7uSfuqAzoxJEBrUhxQLNNZLWIx1u2o1PHn7m880=;
	b=qqaWJN8ejro5ibA8lJ1IF2mGGeNq4hoT5Jkw5U3njD+VK/2w6OlnZwKk9mYeh9h0aE4oJ2BYjwjClwZKPpekDR2CWsMLbCAZym9CWsLGnZnMTgtjixJg0QCrQzlFysfdBUCzt6dpmJkS2hwdCC690TnGJb4j3vPMryTSjbRbR/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guanrui.huang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4nY4IL_1713420661;
Received: from localhost(mailfrom:guanrui.huang@linux.alibaba.com fp:SMTPD_---0W4nY4IL_1713420661)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 14:11:01 +0800
From: Guanrui Huang <guanrui.huang@linux.alibaba.com>
To: maz@kernel.org
Cc: Markus.Elfring@web.de,
	yuzenghui@huawei.com,
	shannon.zhao@linux.alibaba.com,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>
Subject: [PATCH v5 0/2] irqchip/gic-v3-its: Fix double free on error 
Date: Thu, 18 Apr 2024 14:10:51 +0800
Message-Id: <20240418061053.96803-1-guanrui.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone, this is the v5 of the patch to fix double free 
in gic driver.

The differences from the v3 and v4:
1. modify description: add "Fixes" in patch 1, as suggested by Markus Elfring.

2. improve patch granularity: split 'remove BUG_ON' into a secord patch, 
   as suggested by Zenghui and Markus Elfring.

3. modify description: explain why the BUG_ON is useless in patch 2, 
   as suggested by Marc Zyngier.

Thanks,
Guanrui

Guanrui Huang (2):
  irqchip/gic-v3-its: Fix double free on error
  irqchip/gic-v3-its: remove BUG_ON in its_vpe_irq_domain_alloc

 drivers/irqchip/irq-gic-v3-its.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

-- 
2.36.1


