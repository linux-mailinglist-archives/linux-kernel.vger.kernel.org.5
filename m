Return-Path: <linux-kernel+bounces-151840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E000D8AB493
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778441F214F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76413C82D;
	Fri, 19 Apr 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j4j7oaQr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00513B7A6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549391; cv=none; b=WkcMgB1D+QWDukYrgZefeeW/zG4XOfYz+IzMZVSe1aDY7WgxiXMDB/Ngs+ZUSB9gmW98+XTdcHd//wF/A8zBaEpNnIuZF+PTSJxmvbbdQqhyf1M2XEoKQ3J6e3fBCK01jGF6DhEHgkkVj11ypgi/6CTSGCKfk6Jr0QhxvWpzXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549391; c=relaxed/simple;
	bh=VWTR8HOsv/sI4SJu0QdyOH5eya8dW2udTmWyDeoJXxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4EJIW2HePkBX+TBnj/wYgFdxyw9VgZYwBxbMJVJhunimeM+FLa889VL2EPfY8WQ+FfQEifyjiAafDEpeyQ6pFgAUAPT97LxcJbX8HQBvXbW/Is7wHrhP6ZgVyDiuL18yZ0VuU4rkD+3+yj/jFoQt3RDBSYiQKcJvPLpSe4udoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j4j7oaQr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JGiiJF007533;
	Fri, 19 Apr 2024 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=bsbvgyQd3N2o4z+XaeSxWb9HErpReSjR0K5j0Z+qNLg=;
 b=j4j7oaQrnxmDcqnDNWQW1YUe0vnk2KwsvXDsIaBhwTGzycPx04GWqXaN/TyFLsD6MokI
 XWnAEaFW/CXcDX0XfTKZKrUZ2XnQ+LgMVS4c6K8ZrMqzSNUFAhUbtOnDUL45KkOvb/wC
 fHO8F9+ITZ1jo1xinSVbWcY9oBfclkGARDN3y1avJIANwqjIS4TSQKDcw7A/WEVZVEp+
 WjqueqDZnjTvX7zr6xS40TjiWwLL9j9tUUEzgn0jN8lqUMzTlVF743Ujs7S8zfn7CVjD
 WH+cNvFDX0aMdHLgqaUoK5qKoNYqpKOAsmmIAw9xSkZjhaGyZeQbZGAsVaxGUOhREaMw mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycwer1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 17:56:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JH48SI005568;
	Fri, 19 Apr 2024 17:56:12 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-230-131.vpn.oracle.com [10.159.230.131])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xkc7xd76r-2;
	Fri, 19 Apr 2024 17:56:12 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: vbabka@suse.cz, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com
Subject: [PATCH v3 1/2] slub: introduce count_partial_free_approx()
Date: Fri, 19 Apr 2024 10:56:10 -0700
Message-ID: <20240419175611.47413-2-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
References: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_13,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190137
X-Proofpoint-ORIG-GUID: GxkjSI6Zb372cMx3xe4mFXOWggEqqXOn
X-Proofpoint-GUID: GxkjSI6Zb372cMx3xe4mFXOWggEqqXOn

When reading "/proc/slabinfo", the kernel needs to report the number
of free objects for each kmem_cache. The current implementation uses
count_partial() to get it by scanning each kmem_cache_node's partial
slab list and summing free objects from every partial slab. This
process must hold per-kmem_cache_node spinlock and disable IRQ, and
may take a long time. Consequently, it can block slab allocations on
other CPUs and cause timeouts for network devices, when the partial
list is long. In production, even NMI watchdog can be triggered due
to this matter: e.g., for "buffer_head", the number of partial slabs
was observed to be ~1M in one kmem_cache_node. This problem was also
confirmed by others [1-3].

Iterating a partial list to get the exact count of objects can cause
soft lockups for a long list with or without the lock (e.g., if
preemption is disabled), and may not be very useful: the object count
can change after the lock is released. The approach of maintaining
free-object counters requires atomic operations on the fast path [3].

So, the fix is to introduce count_partial_free_approx(). This function
can be used for getting the free object count in a kmem_cache_node's
partial list. It limits the number of slabs to scan and avoids scanning
the whole list by giving an approximation for a long list. Suppose the
limit is N. If the list's length is not greater than N, output the exact
count by traversing the list; if its length is greater than N, output an
approximated count by traversing a subset of the list. The proposed
method is to scan N/2 slabs from the list's head and N/2 slabs from
the tail. For a partial list with ~280K slabs, benchmarks show that
it performs better than just counting from the list's head, after slabs
get sorted by kmem_cache_shrink(). Default the limit to 10000, as it
produces an approximation within 1% of the exact count for both
scenarios. Then, use count_partial_free_approx() in get_slabinfo().

Benchmarks: Diff = (exact - approximated) / exact
* Normal case (w/o kmem_cache_shrink()):
| MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
| 1000        |  0.43  %              |  1.09  %              |
| 5000        |  0.06  %              |  0.37  %              |
| 10000       |  0.02  %              |  0.16  %              |
| 20000       |  0.009 %              | -0.003 %              |

* Skewed case (w/ kmem_cache_shrink()):
| MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
| 1000        |  12.46 %              |  6.75  %              |
| 5000        |  5.38  %              |  1.27  %              |
| 10000       |  4.99  %              |  0.22  %              |
| 20000       |  4.86  %              | -0.06  %              |

[1] https://lore.kernel.org/linux-mm/
alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
[2] https://lore.kernel.org/lkml/
alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
[3] https://lore.kernel.org/lkml/
1e01092b-140d-2bab-aeba-321a74a194ee@linux.com/T/

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/slub.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..993cbbdd2b6c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3213,6 +3213,43 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
+#define MAX_PARTIAL_TO_SCAN 10000
+
+static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
+{
+	unsigned long flags;
+	unsigned long x = 0;
+	struct slab *slab;
+
+	spin_lock_irqsave(&n->list_lock, flags);
+	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
+		list_for_each_entry(slab, &n->partial, slab_list)
+			x += slab->objects - slab->inuse;
+	} else {
+		/*
+		 * For a long list, approximate the total count of objects in
+		 * it to meet the limit on the number of slabs to scan.
+		 * Scan from both the list's head and tail for better accuracy.
+		 */
+		unsigned long scanned = 0;
+
+		list_for_each_entry(slab, &n->partial, slab_list) {
+			x += slab->objects - slab->inuse;
+			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
+				break;
+		}
+		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
+			x += slab->objects - slab->inuse;
+			if (++scanned == MAX_PARTIAL_TO_SCAN)
+				break;
+		}
+		x = mult_frac(x, n->nr_partial, scanned);
+		x = min(x, node_nr_objs(n));
+	}
+	spin_unlock_irqrestore(&n->list_lock, flags);
+	return x;
+}
+
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
@@ -7089,7 +7126,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
+		nr_free += count_partial_free_approx(n);
 	}
 
 	sinfo->active_objs = nr_objs - nr_free;
-- 
2.42.1


