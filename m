Return-Path: <linux-kernel+bounces-70673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE0859AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9056C2817BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5D5238;
	Mon, 19 Feb 2024 03:20:35 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237C4C90
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312834; cv=none; b=U+9gBxPChz/YwQBnh0SEsLCLiH40ZisZA3a7cx4qtIcOjzTK6mMqaQge8MgnNMRt8Nq4OeukJDzuChGZBpg6tBKZigzSLCjXwGkJ1J1compb/6rRiVEDRRWxM93soeipOjjdtyYMr2KxF3mQR9whHKiEcg39TtU6KchLJ8qToSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312834; c=relaxed/simple;
	bh=qZ3QP/O+dKCUtJMzLtIoEE1u0enCWJg3RGRx2cIFbdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXWjJHk99R8Do9KTjwACro26QqEJ12WAPdfHkvc35XHZu/QdcQsyI+j7AVT9YUSPv76PEb3WoCU9IorPK+2zP3e/qqjDTm5PbRoOTvW4/qH+J3Rki4Gm9EMgHopwg5NeAfSplvLSI85C6NKVLHzfjMoz3YxJ+mbPsKNWo10cF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41J3KDic006816;
	Mon, 19 Feb 2024 11:20:13 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TdSSt0CC8z2KDdHY;
	Mon, 19 Feb 2024 11:19:42 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Feb 2024 11:20:10 +0800
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
Subject: [PATCH V2 2/2] Documentation: filesystems: introduce proc/slabinfo to users
Date: Mon, 19 Feb 2024 11:19:11 +0800
Message-ID: <20240219031911.10372-3-fangzheng.zhang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41J3KDic006816

Supplement slabinfo-version 2.2 details in proc.rst, so that
users can have the status of slabinfo at a glance. And mark
the optimization work that will be performed on proc/slabinfo
in the next step.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
---
 Documentation/filesystems/proc.rst | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 104c6d047d9b..89ab92f6be2d 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -892,6 +892,39 @@ Linux uses  slab  pools for memory management above page level in version 2.2.
 Commonly used  objects  have  their  own  slab  pool (such as network buffers,
 directory cache, and so on).
 
+Example output. You can have all of these fields in slabinfo - version: 2.2.
+
+::
+
+    > cat /proc/slabinfo
+
+    slabinfo - version: 2.2
+    # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> <slabreclaim>
+    zspage              2240   2240     72   56    1 : tunables    0    0    0 : slabdata     40     40      0      0
+    zs_handle          17408  17408      8  512    1 : tunables    0    0    0 : slabdata     34     34      0      0
+    f2fs_xattr_entry-254:48    312    312    208   39    2 : tunables    0    0    0 : slabdata      8      8      0      1
+    imsbr_flow           102    102     80   51    1 : tunables    0    0    0 : slabdata      2      2      0      0
+    ......
+    ext4_groupinfo_4k    312    312    208   39    2 : tunables    0    0    0 : slabdata      8      8      0      1
+    dm_verity_fec_buffers      8      8   4048    8    8 : tunables    0    0    0 : slabdata      1      1      0      0
+    dm_bufio_buffer       28     28    144   28    1 : tunables    0    0    0 : slabdata      1      1      0      1
+    ......
+    kernfs_iattrs_cache   4010   4116     96   42    1 : tunables    0    0    0 : slabdata     98     98      0      0
+    kernfs_node_cache  67169  67232    128   32    1 : tunables    0    0    0 : slabdata   2101   2101      0      0
+    mnt_cache           5624   5700    320   25    2 : tunables    0    0    0 : slabdata    228    228      0      0
+    filp               15840  17400    320   25    2 : tunables    0    0    0 : slabdata    696    696      0      0
+    ......
+    kmalloc-32         30398  32384     32  128    1 : tunables    0    0    0 : slabdata    253    253      0      0
+    kmalloc-16         31566  31744     16  256    1 : tunables    0    0    0 : slabdata    124    124      0      0
+    kmalloc-8          51623  51712      8  512    1 : tunables    0    0    0 : slabdata    101    101      0      0
+    kmem_cache_node      416    416    128   32    1 : tunables    0    0    0 : slabdata     13     13      0      0
+    kmem_cache           416    416    256   32    2 : tunables    0    0    0 : slabdata     13     13      0      0
+
+Note, <slabreclaim> comes from the collected results in the file
+/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/slabinfo
+as deprecated and recommend the use of either sysfs directly or
+use of the "slabinfo" tool that we have been providing in linux/tools/mm.
+
 ::
 
     > cat /proc/buddyinfo
-- 
2.17.1


