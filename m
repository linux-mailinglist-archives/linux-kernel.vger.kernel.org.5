Return-Path: <linux-kernel+bounces-100316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F28795A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4905C1C229F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609597A72A;
	Tue, 12 Mar 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Ptf12zcd"
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CE78298
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252352; cv=none; b=a60/mFKZ+rSLz0vId6IWCRo0F3VG0F51XYsnA6oduVzN2bjS2uwLzC8gYsCF0tCa+HEkS1tapRYTttqksJ4JAK7ecGFYmtdCo+0Q4JFfZfQs4rh3o/N+gZkHvzuVGUe+owWtC/79jvp1+nbKRLYKBn6bkiEpV94BRu0WJzb2DO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252352; c=relaxed/simple;
	bh=hNF2+RXl//4KAAi3too/Os0YMBFOsoQcXZrz7NrJcss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yu9JsLWfQzI0Z9dFDDRamDlYLfnyc1xt+S7GCfZg7tWhzIi7m781m19triDZF5kI2+s1FNCsU9Un4NHnNZaEDEgqUyZ/XMIpRauc5MJ2DmOs1hKptzmD+QE7D5LJJM3HMBQWimvkETDOX4P0c7osADIdcPYhQS/IFhnlvrSVc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=Ptf12zcd; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1710252350; bh=BbMF8m5gDueYZRCHMsIy/5bezoPRbX1YTQWlc+gdLlw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ptf12zcd9lFsEaaDF/p/Gggh1EhsjloxWw6oFekA8cURMFejeQ+dSoz08KdnHnJJn
	 W1Ct1bd1k+raEfxyO/rDOMIAw1JFFkJTVy3Ip5zxgpaYqb4Ky5pkMnuI7A380O1cBi
	 ezAVztXyogKKqRvoFS5a7S66SoVyhEvDm99mbjYtUN5JY4akWbr0C2Wyobzu5q+b9G
	 rddlf8/8f6IrNppV75lKNP9UiVWl6XLeetDnjQrJO8iBe0vd93/gey3Ah6V5hjgV4b
	 eUlfW/LKNySQ3X2z97IfIgZ5chfpNRHf7b+lZyoKTEC4ZJtqQMoC3iM9QdLadbQrvB
	 7gMmr+zseC1Xw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id A13F0681BA5;
	Tue, 12 Mar 2024 14:05:45 +0000 (UTC)
From: sxwjean@me.com
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v2] mm/slub: Simplify get_partial_node()
Date: Tue, 12 Mar 2024 22:05:32 +0800
Message-Id: <20240312140532.64124-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Yn2ommIikT1KPMGk-GpetYDo4xMKhwyq
X-Proofpoint-ORIG-GUID: Yn2ommIikT1KPMGk-GpetYDo4xMKhwyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403120108

From: Xiongwei Song <xiongwei.song@windriver.com>

Remove the check of !kmem_cache_has_cpu_partial() because it is always
false, we've known this by calling kmem_cache_debug() before calling
remove_partial(), so we can remove the check.

Meanwhile, redo filling cpu partial and add comment to improve the
readability.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
Changes in v2:
 - Use "#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)" to instead 
   "if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))" to fix build error.
   (Thanks Chengming Zhou)
 - Add __maybe_unused for partial_slabs to prevent compiler warning.

v1: 
 https://lore.kernel.org/linux-kernel/20240311132720.37741-1-sxwjean@me.com/T/
---
 mm/slub.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a3ab096c38c0..ab526960ee5b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2588,7 +2588,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 {
 	struct slab *slab, *slab2, *partial = NULL;
 	unsigned long flags;
-	unsigned int partial_slabs = 0;
+	unsigned int __maybe_unused partial_slabs = 0;
 
 	/*
 	 * Racy check. If we mistakenly see no partial slabs then we
@@ -2620,19 +2620,21 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 		if (!partial) {
 			partial = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
-		} else {
-			put_cpu_partial(s, slab, 0);
-			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
+
+			/* Fill cpu partial if needed from next iteration, or break */
+			if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))
+				continue;
+			else
+				break;
 		}
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (!kmem_cache_has_cpu_partial(s)
-			|| partial_slabs > s->cpu_partial_slabs / 2)
+
+#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)
+		put_cpu_partial(s, slab, 0);
+		stat(s, CPU_PARTIAL_NODE);
+
+		if (++partial_slabs > s->cpu_partial_slabs/2)
 			break;
-#else
-		break;
 #endif
-
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return partial;
-- 
2.34.1


