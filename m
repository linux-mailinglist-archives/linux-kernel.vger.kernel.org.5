Return-Path: <linux-kernel+bounces-20372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14D827DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F63C28562E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3C6126;
	Tue,  9 Jan 2024 04:15:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B896104
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T8Hdb36tCz1Q7Ps;
	Tue,  9 Jan 2024 12:14:59 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 2268618005E;
	Tue,  9 Jan 2024 12:15:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 9 Jan 2024 12:15:41 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <rppt@kernel.org>
CC: <linux-mm@kvack.org>, <mawupeng1@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] efi: Disable mirror feature during crashkernel
Date: Tue, 9 Jan 2024 12:15:36 +0800
Message-ID: <20240109041536.3903042-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

If system have no mirrored memory or use crashkernel.high while
kernelcore=mirror is enabled in cmdline, during crashkernel,
there will be limited mirrored memory and this usually lead to
OOM.

To solve this problem, disable mirror feature during crashkernel.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mm_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..513bad672708 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -381,6 +382,11 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			goto out;
 		}
 
+		if (is_kdump_kernel()) {
+			pr_warn("The system is under kdump, ignore kernelcore=mirror.\n");
+			goto out;
+		}
+
 		for_each_mem_region(r) {
 			if (memblock_is_mirror(r))
 				continue;
-- 
2.25.1


