Return-Path: <linux-kernel+bounces-46159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D984843B60
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC434B24545
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F66B6994C;
	Wed, 31 Jan 2024 09:45:29 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE9651B6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694328; cv=none; b=BLchih8/Jal/4DZIN22mI+sPHGI4rKqQgwQYqUbaiTUK2N3nKnFEv+Eh8BVsauIzGDox//hIl5ItTHeZD8HSz6LljoW/eWHE2u1BQTDFfXwa2wijw2dsQBhk+8dewFIl+LZaNh1rdyrzrvUnENyQ5zUrcHudcO/7oCqgkwybwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694328; c=relaxed/simple;
	bh=D6eznrYTizelXVC+1WiaExzhSVE5xxoSmqRhN0MH9Lk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uc4+jVq9nFDiUJaEkNf+nVoMafU9dxDoBUOMzF7lYU05R0j9iKfb/pXly3oOqHPpDEdNnqV46zaehtWWCDsHDUH0fg19Z5ZOu0wwbIKTSqwp5XUNQYX2PmrGDQwMudpiqHYiKqtzR5gNBuu5sKxkJWfCekoGQvCw3P5ypIA0ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40V9jBE2056964;
	Wed, 31 Jan 2024 17:45:11 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TPxlf3hQNz2SBJpV;
	Wed, 31 Jan 2024 17:37:34 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jan 2024 17:45:09 +0800
From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Fangzheng Zhang
	<fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
Date: Wed, 31 Jan 2024 17:44:42 +0800
Message-ID: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40V9jBE2056964

In order to enhance slab debugging, we add slabreclaim flag to
slabinfo. Slab type is also an important analysis point in slabinfo
for per slab, when various problems such as memory leaks or memory
statistics occur.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
---
 mm/slab_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..aeeb2bfe6dda 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_file *m)
 	seq_puts(m, "slabinfo - version: 2.1\n");
 	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
 	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <slabreclaim>");
 	seq_putc(m, '\n');
 }
 
@@ -1071,8 +1071,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 
 	seq_printf(m, " : tunables %4u %4u %4u",
 		   sinfo.limit, sinfo.batchcount, sinfo.shared);
-	seq_printf(m, " : slabdata %6lu %6lu %6lu",
-		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
+	seq_printf(m, " : slabdata %6lu %6lu %6lu %6u",
+		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail,
+		   !!(s->flags & SLAB_RECLAIM_ACCOUNT));
 	slabinfo_show_stats(m, s);
 	seq_putc(m, '\n');
 }
-- 
2.43.0


