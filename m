Return-Path: <linux-kernel+bounces-6717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED830819C85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D90B26BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4F210F5;
	Wed, 20 Dec 2023 10:14:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m12826.netease.com (mail-m12826.netease.com [103.209.128.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341820DF1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BD44F26015D;
	Wed, 20 Dec 2023 13:57:44 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kexec: Fix potential out of bounds in crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 13:57:32 +0800
Message-ID: <20231220055733.100325-3-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxhPVk5IHksdTE0ZGk8YGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c85cd2dbc0276kunmbd44f26015d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Nxw6PzErFVEBDAMPCwgq
	Ng4aCj5VSlVKTEtIS05KQ01NSUNIVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSExKNwY+

When the split does not occur on the last array member, the current code
will not return an error. So the correct array out-of-bounds check should
be mem->nr_ranges >= mem->max_nr_ranges.

When the OOB happen, the cmem->ranges[] have changed, so return early to
avoid it.

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 kernel/crash_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..b1ab61c74fd2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		}
 
 		if (p_start > start && p_end < end) {
+			/* Split happened */
+			if (mem->nr_ranges >= mem->max_nr_ranges)
+				return -ENOMEM;
 			/* Split original range */
 			mem->ranges[i].end = p_start - 1;
 			temp_range.start = p_end + 1;
@@ -626,10 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	if (!temp_range.end)
 		return 0;
 
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
 	/* Location where new range should go */
 	j = i + 1;
 	if (j < mem->nr_ranges) {
-- 
2.42.0


