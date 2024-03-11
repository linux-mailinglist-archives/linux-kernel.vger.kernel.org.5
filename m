Return-Path: <linux-kernel+bounces-98879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C920878094
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34881F2167C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834583D54C;
	Mon, 11 Mar 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="T61uHLmG"
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD13C493
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163661; cv=none; b=U4khoyxhGHhQn3j4ZlheuBLwVZB/YEhXbE5R3LIeMAbJDvgBYGQY5maNXFxG2BEaSk9iEOB7P/g7u7D0NRYa8UGC6tszFu+l/6ydcmwDaDLaH+PQfv9j1bUlzfer/5ZDr3ARqVcHiYZSz5eWKV1/8HcoYZPO4BGuJUZIbz1HXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163661; c=relaxed/simple;
	bh=1tjvkLaj2qzxujHsEunH4hgb9C0xngPnOygHSLihI/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQZekbHh8L8f+9GDHtOXXSMBW/PIBcD1cUbSi71I6CYY1x+59zDO+z/N+vXTWXxuoRhlcSHBzYSYIuUk5v8xE3S6gxq85x1r2OUzKLQ6CA86XoVi7F2Gw8KX8ZekKCy4RAd1spUJuLU9cqXR3pbxoS415MQLoC19L4ma37AxRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=T61uHLmG; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1710163660; bh=2iRYH/AKaj8JjQAjivvq81LSzcAuZlufT7ff0QJCa4c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T61uHLmGgPHqKgAJsJsp9UC3ffblicjLh4NQwQKi/kmntOt0x0misyEq//LpJbwS1
	 5TAVo8xUNFBykgteRTRNCaaRI3CiXglOZFPU+gl5vCfk9g8lU1MDYXcpLA1oRnaXhS
	 LyxpZfDEE1cdzPSzb64gIG693N3ZcBx88VbYHL30W4nmwxqBHa8QDsij+32brIKbuC
	 Ckm2uxH6ozneQpfm2HHfjNehayswQ0KAb9bksSETvovIlmMS6uKyQKHW4viI0EtsLZ
	 o0wz2LnzZaTUktB5niOLBTBJwqQ1mhz2ZpOt+HplxUv0PMIMXFAwVjMZrSSCJAaB08
	 DKhsDywCLz/Yg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 35577C8011C;
	Mon, 11 Mar 2024 13:27:33 +0000 (UTC)
From: sxwjean@me.com
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH] mm/slub: Simplify get_partial_node()
Date: Mon, 11 Mar 2024 21:27:20 +0800
Message-Id: <20240311132720.37741-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NuU_XrVOMrf5qTyHgVrOyaY9XMuGi4Zf
X-Proofpoint-ORIG-GUID: NuU_XrVOMrf5qTyHgVrOyaY9XMuGi4Zf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403110034

From: Xiongwei Song <xiongwei.song@windriver.com>

Remove the check of !kmem_cache_has_cpu_partial() because it is always
false, we've known this by calling kmem_cache_debug() before calling
remove_partial(), so we can remove the check.

Meanwhile, redo filling cpu partial and add comment to improve the
readability.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a3ab096c38c0..62388f2a0ac7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2620,19 +2620,21 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 		if (!partial) {
 			partial = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
-		} else {
+
+			/* Fill cpu partial if needed from next iteration, or break */
+			if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))
+				continue;
+			else
+				break;
+		}
+
+		if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)) {
 			put_cpu_partial(s, slab, 0);
 			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
-		}
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (!kmem_cache_has_cpu_partial(s)
-			|| partial_slabs > s->cpu_partial_slabs / 2)
-			break;
-#else
-		break;
-#endif
 
+			if (++partial_slabs > s->cpu_partial_slabs/2)
+				break;
+		}
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return partial;
-- 
2.34.1


