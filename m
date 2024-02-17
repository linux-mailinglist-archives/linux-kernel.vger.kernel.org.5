Return-Path: <linux-kernel+bounces-69719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C44858DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93E01F222D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854C1CD03;
	Sat, 17 Feb 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Un47yEWj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DA33CA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155329; cv=none; b=tMEwR4VUYbKk6lT4otddDAl1jAfunA+XorcilIVThUNEcoZ6yLym9h/abDY405SzXNjubzRdFUjVssWenV/Lb8+f1pDRqGxtG+V0hlCjUm5iKMP8KQUHXR5A0IZnB+0T8+N7byDiwIqjU9S23NsqtU/rL3J0jSiyk/YktL8s7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155329; c=relaxed/simple;
	bh=BdwHYDKb048UZTl6QADSK7S6tKXeJACzVDM50YdF/Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReXdpFG6LxjfGmP0Eh3Hw6OYtfZGhIMrUQs9p5D7FnMT4rgJkHnlE75upPS79Zzxsx9ZqOW/PJ0Xhu/bBU/8ODAKoPN6D9b6cPUMm/g736H+M9U8sPJ+qL253p42pnZ8V36N0UHitjGDyv7HOJ2KdmRgpi10pHaN1JCgI/eQVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Un47yEWj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H7RRfW027691;
	Sat, 17 Feb 2024 07:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UEk1JLmSe642sbxXn82ubc2FynSt0QvkkNE3uRZNLGc=;
 b=Un47yEWjBJrXA7SRBOmHqumVs/CmT+bDxvgxxOB6VSGHCYsXQwVjcHhkMgpiqs0VOPVg
 ablU7Tn7MaO5zzux203BbR0YUwQ9bSGeQ90DoV34e106psNEmiZNhi1yHB9o2swwuK+t
 sRqH14kohmKY1/8WxnHxb4/TnnmJk4tdOAAbN3jZRu398pygs6xRKejGMAwRv/1WvzkM
 SFMZyAahBPvO9o1SpOODWF+WcztaTs0+9lmz9NbF0Rzlx3VWDxk40ayscvUsCVoIX723
 by13UFvrr5eZ+zsbbzzBHgnARjNxlalWZGzPHxs0Jys/Lrz2+h6wc+g/+W1NZaMpleCP wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wardu821e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:35:02 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41H7Z2XP012248;
	Sat, 17 Feb 2024 07:35:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wardu81ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:35:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41H3lSrS016307;
	Sat, 17 Feb 2024 07:31:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6myn8j72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41H7VkN957475338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 07:31:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CEE420063;
	Sat, 17 Feb 2024 07:31:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9EC20040;
	Sat, 17 Feb 2024 07:31:43 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Feb 2024 07:31:43 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone reference with MPOL_PREFERRED_MANY policy
Date: Sat, 17 Feb 2024 01:31:35 -0600
Message-Id: <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cIL8LtNuI-z2kC5XRafsucUMhsTTru8H
X-Proofpoint-ORIG-GUID: NZM7zSCbHzkgOUkllOLT3YhqdAxSxFIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_04,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402170058

commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
nodes") added support for migrate on protnone reference with MPOL_BIND
memory policy. This allowed numa fault migration when the executing node
is part of the policy mask for MPOL_BIND. This patch extends migration
support to MPOL_PREFERRED_MANY policy.

Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
MPOL_F_NUMA_BALANCING. This causes issues when we want to use
NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
the kernel should not allocate pages from the slower memory tier via
allocation control zonelist fallback. Instead, we should move cold pages
from the faster memory node via memory demotion. For a page allocation,
kswapd is only woken up after we try to allocate pages from all nodes in
the allocation zone list. This implies that, without using memory
policies, we will end up allocating hot pages in the slower memory tier.

MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
allocation control when we have memory tiers in the system. With
MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
of faster memory nodes. When we fail to allocate pages from the faster
memory node, kswapd would be woken up, allowing demotion of cold pages
to slower memory nodes.

With the current kernel, such usage of memory policies implies we can't
do page promotion from a slower memory tier to a faster memory tier
using numa fault. This patch fixes this issue.

For MPOL_PREFERRED_MANY, if the executing node is in the policy node
mask, we allow numa migration to the executing nodes. If the executing
node is not in the policy node mask but the folio is already allocated
based on policy preference (the folio node is in the policy node mask),
we don't allow numa migration. If both the executing node and folio node
are outside the policy node mask, we allow numa migration to the
executing nodes.

Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 73d698e21dae..8c4c92b10371 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1458,9 +1458,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
 	if (*flags & MPOL_F_NUMA_BALANCING) {
-		if (*mode != MPOL_BIND)
+		if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
+			*flags |= (MPOL_F_MOF | MPOL_F_MORON);
+		else
 			return -EINVAL;
-		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
 	}
 	return 0;
 }
@@ -2463,6 +2464,23 @@ static void sp_free(struct sp_node *n)
 	kmem_cache_free(sn_cache, n);
 }
 
+static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
+					    struct mempolicy *pol)
+{
+	/* if the executing node is in the policy node mask, migrate */
+	if (node_isset(exec_node, pol->nodes))
+		return true;
+
+	/* If the folio node is in policy node mask, don't migrate */
+	if (node_isset(folio_node, pol->nodes))
+		return false;
+	/*
+	 * both the folio node and executing node are outside the policy nodemask,
+	 * migrate as normal numa fault migration.
+	 */
+	return true;
+}
+
 /**
  * mpol_misplaced - check whether current folio node is valid in policy
  *
@@ -2526,6 +2544,12 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		break;
 
 	case MPOL_PREFERRED_MANY:
+		if (pol->flags & MPOL_F_MORON) {
+			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
+				goto out;
+			break;
+		}
+
 		/*
 		 * use current page if in policy nodemask,
 		 * else select nearest allowed node, if any.
-- 
2.39.3


