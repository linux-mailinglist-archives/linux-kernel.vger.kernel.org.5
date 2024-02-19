Return-Path: <linux-kernel+bounces-70672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE8859AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF03281785
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021623D7B;
	Mon, 19 Feb 2024 03:20:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362012103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312824; cv=none; b=J8ASHQ6cjD9vn+QLwLd2IEg9QJ+yIuWpw394jxHnL8WgbFum1T4ye2Oot9mSl6D7UAn8/WldIL2xcfaYii2FO4NHqk7n1IbupChbAddPm6RWsxMgPQmLdkG4O5wKRzHjIx2+a4HobwSYPTZPjoGyKRvGDEgJRJtZ81+3jgueea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312824; c=relaxed/simple;
	bh=Z+7vse2oVEMZGzwQc87EL46uYY5WpATXZyWpKmqnc5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqwH1mfl60iqfx4GQioBWL+PZjwSLJrRr/JLgyDt2XttlS/u4ZBrfRBzTz2h3lvLW8oMpNbLgONc4owUcZykh4COBCKB0frTltD2I3zKTzFImVDyvSystRo6Xv9QnuD+WAKwMh229hYCcrj2L9nyS18SUIXPqnbzFU+c5DwZxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41J3K3ud006324;
	Mon, 19 Feb 2024 11:20:03 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TdSSh0lVdz2KDdHY;
	Mon, 19 Feb 2024 11:19:32 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Feb 2024 11:20:00 +0800
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
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tkjos@google.com>,
        Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 1/2] mm/slab: Add slabreclaim flag to slabinfo
Date: Mon, 19 Feb 2024 11:19:10 +0800
Message-ID: <20240219031911.10372-2-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 41J3K3ud006324

In order to enhance slab debugging, we add slabreclaim flag to
slabinfo. Slab type is also an important analysis point in slabinfo
for per slab, when various problems such as memory leaks or memory
statistics occur.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
---
 mm/slab_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..fd865ca335ea 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1035,10 +1035,10 @@ static void print_slabinfo_header(struct seq_file *m)
 	 * Output format version, so at least we can change it
 	 * without _too_ many complaints.
 	 */
-	seq_puts(m, "slabinfo - version: 2.1\n");
+	seq_puts(m, "slabinfo - version: 2.2\n");
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
2.17.1


