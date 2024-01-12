Return-Path: <linux-kernel+bounces-24223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7A82B950
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3958FB22AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999751118;
	Fri, 12 Jan 2024 02:08:23 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E17ED7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-R94xv_1705024971;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W-R94xv_1705024971)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 10:03:00 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tglx@linutronix.de
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] lib/group_cpus: Fix unsigned expression compared with zero
Date: Fri, 12 Jan 2024 10:02:50 +0800
Message-Id: <20240112020250.48087-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nr_present and nr_others is defined as unsigned int type,
if(nr_present < 0) and if(nr_others < 0 )is invalid. At the same time, the
return value of function __group_cpus_evenly also of type int. so modified
the types of nr_present and nr_others to int.

lib/group_cpus.c:380 group_cpus_evenly() warn: unsigned 'nr_present' is never less than zero.
lib/group_cpus.c:396 group_cpus_evenly() warn: unsigned 'nr_others' is never less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7890
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/group_cpus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 3a0db0f51f09..08e31f2f053f 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -354,7 +354,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) = alloc_node_to_cpumask();
 	struct cpumask *masks __free(kfree) = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 	cpumask_var_t npresmsk __free(free_cpumask_var);
-	unsigned int curgrp, nr_present, nr_others;
+	unsigned int curgrp;
+	int nr_present, nr_others;
 
 	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		return NULL;
-- 
2.20.1.7.g153144c


