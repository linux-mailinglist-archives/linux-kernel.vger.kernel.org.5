Return-Path: <linux-kernel+bounces-109972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF73885862
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA521C215FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F258ACC;
	Thu, 21 Mar 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UGM3RtES"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFCD58AA3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020737; cv=none; b=pXc281OZrhoNfD0nKdOX1hJ7b0RIFeanvohLXJRr276ZOXoGSGvjj+ESjfyNwZfV0L841FquDy3W44HQExEbVZ4mAW6me2edTPGiv5oc1xYan2m2CqR5+OGvfbzb63EymIHWpuSGOssR35yG79DrNzqFwY8KY8OyKgVnRUrMXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020737; c=relaxed/simple;
	bh=wTvinnt0DOHGAhm7RHQdDvRHZ4C+zFBUwv35gW5mle0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqLQPi6/Kw6FrDgU6qV7/VulKHeU5WuBrXHdEkY0RFJPoADzAzHIW47rJ8i0+lM8YASrlAs7pMNI7v6fBobIgXwZ/7yCChKbUSfx5PjdP33aJRG8KGNjg9II6zaHlfjaOsbQvrGaJz5eKVve+0eing7gGSIUUVDULUj3hoHHasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UGM3RtES; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBCqGt001660;
	Thu, 21 Mar 2024 11:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X3hz2VPzVZOEkd8yWvn5oS5lDp/KJJL1DQQq8W3Frm4=;
 b=UGM3RtESnozu5OiOcI3+fihab4r9+/RXiL01seVABSbuemgeCUbPkN6nOGK5VEy5+/QQ
 BgONPZWPXOw3myg+9nQ7BLocKn+AnsfsSl4FV2E1tCNp5Kn1ckphV8+4C9SY5tBpLjjt
 IasiT5E1khMuxX2o9fqFO6jvYKr19XXVUJftmy9lDk6Hmf40MjpKWMHA8upEUSTrpSqc
 H0MqiuMK/D+3Nkj0Tm9I1JAywQLPSR0S//04QAIHiU4CKixwx87pSOK2jtZXAOFnj60T
 bIJPQ0HEXXJ3JirrpNzxKFuH0o7+cnoYvq4DZHHDiVVg8PBcIKBLafKqzkXq8G8mgSEs zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0ktd81hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:30:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LBUapA000324;
	Thu, 21 Mar 2024 11:30:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0ktd81hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:30:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L8qijm015792;
	Thu, 21 Mar 2024 11:30:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50cvkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:30:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LBUVr716318820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 11:30:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE342006A;
	Thu, 21 Mar 2024 11:30:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A8752005A;
	Thu, 21 Mar 2024 11:30:28 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 11:30:27 +0000 (GMT)
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
Subject: [PATCH v3 2/2] mm/numa_balancing:Allow migrate on protnone reference with MPOL_PREFERRED_MANY policy
Date: Thu, 21 Mar 2024 06:29:51 -0500
Message-Id: <b1599085e1d2f3e48dc71c7991283b8aaa0fe00c.1711002865.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1711002865.git.donettom@linux.ibm.com>
References: <cover.1711002865.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6tqmExyYJedqdWzycIOEnWNwKfC9t0vE
X-Proofpoint-GUID: i0C2nB4_Vyn4lJwcM9z3m0RrA2GKLa-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210080

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
index aa48376e2d34..13100a290918 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1504,9 +1504,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
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
@@ -2770,15 +2771,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
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


