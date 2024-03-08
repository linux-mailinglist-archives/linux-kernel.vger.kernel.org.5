Return-Path: <linux-kernel+bounces-97221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C887672C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AB01F24156
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4641DDF6;
	Fri,  8 Mar 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XF6yIrsu"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B131D54D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911033; cv=none; b=bsw8EMrKIpgSAyBDlscHLGejmVtM3mmUPuU+X4UdrWjMW9HnpDL4XWFFpu1v74d7Ki43NkJyVVQZy6pVitUqK5K/7phGPpd0ZgfmaHD1TpwutL8W4NC5UwxTvXcqut1jAO8r29qX2G3MG6sxSBL31pVt5n5lIuC18zD3Eg+yYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911033; c=relaxed/simple;
	bh=L0GXK8sj0SWNJEA45uUS22w/R7Z6RwF0QpW+5FFjFLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8Sjgx8mA2Sf8OI8w+XUSj2/Bry47qb0iLMYJBKFaKMflOAyTrOvLfWeIgMKGt3BrQo/PNRJobr0XP7ZRTIdiAUTCyNx4gFudACBOzG2zX8d7sdLJbKQEB303hK2n7+xMshFn2CHK1z23n9ZoduJyZpw9GlICkzud2ivcD2cybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XF6yIrsu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428F22L4000388;
	Fri, 8 Mar 2024 15:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xD4BUagKz9NF9+nwODZKIkXZMdm0V3dM0BpUskdMkng=;
 b=XF6yIrsuOOauiwJrDttTORqWLU1Pm7KBaaR/cpr/TCyg/DzlAhiIgwgr2sAwpdfAYaZ5
 ahxw+C6pmcT+5UTdBXwWPGmIOrtJcxFirebHGBkGMSt+wzjek0YvOLmsOhDnMOsFwpSV
 NmSfr2ORSNYKN7eXagxp32naqzQWJjQW7h1pcAtT5S0UWOy4t+qfuBNG2LLCEkdlSlkH
 Ycs03HF3feLqy1seGkzPpcC5Vp3YFDDu1o56L87BKeTdvo89PFgxkiaEH6hEzjLadR55
 Pn4v7eCQvEWaECeLjzndnKjQr06Tl0FkccB/HSJVv7u/KKwGChjTIwlJT1NqHZrdV9sX ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4y788gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:41 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428F4Iro013691;
	Fri, 8 Mar 2024 15:16:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4y788ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DJ9Us024193;
	Fri, 8 Mar 2024 15:16:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsrd37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:16:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428FGYvP21365482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 15:16:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A475C2004F;
	Fri,  8 Mar 2024 15:16:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A4E120040;
	Fri,  8 Mar 2024 15:16:31 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 15:16:31 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v2 2/2] mm/numa_balancing:Allow migrate on protnone reference with MPOL_PREFERRED_MANY policy
Date: Fri,  8 Mar 2024 09:15:38 -0600
Message-Id: <369d6a58758396335fd1176d97bbca4e7730d75a.1709909210.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709909210.git.donettom@linux.ibm.com>
References: <cover.1709909210.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n2cYCcYTqRR81FJi3Lo2sRCKtpBExAl4
X-Proofpoint-ORIG-GUID: shpIrlyi5QEj0KPM72RBPFsGNGyQhM1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080123

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
node is not in the policy node mask, we do not allow numa migration.

Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/mempolicy.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e635d7ed501b..ccd9c6c5fcf5 100644
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
@@ -2515,15 +2516,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 		break;
 
 	case MPOL_BIND:
-		/* Optimize placement among multiple nodes via NUMA balancing */
+	case MPOL_PREFERRED_MANY:
+		/*
+		 * Even though MPOL_PREFERRED_MANY can allocate pages outside
+		 * policy nodemask we don't allow numa migration to nodes
+		 * outside policy nodemask for now. This is done so that if we
+		 * want demotion to slow memory to happen, before allocating
+		 * from some DRAM node say 'x', we will end up using a
+		 * MPOL_PREFERRED_MANY mask excluding node 'x'. In such scenario
+		 * we should not promote to node 'x' from slow memory node.
+		 */
 		if (pol->flags & MPOL_F_MORON) {
+			/*
+			 * Optimize placement among multiple nodes
+			 * via NUMA balancing
+			 */
 			if (node_isset(thisnid, pol->nodes))
 				break;
 			goto out;
 		}
-		fallthrough;
 
-	case MPOL_PREFERRED_MANY:
 		/*
 		 * use current page if in policy nodemask,
 		 * else select nearest allowed node, if any.
-- 
2.39.3


