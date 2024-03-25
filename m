Return-Path: <linux-kernel+bounces-117250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C288A914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23071F6316E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B101509B5;
	Mon, 25 Mar 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OliGHSCP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E175CDE9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376719; cv=none; b=NRhbCpCWk8LwMODaRySfy3L6GuAsQ8PlVWmrsSHnpV11KD/WqGb5S8UNfSSSgvvcliJsdYe6ZJAoG4bGjYJsC/td2NABG2yI5NDc8ooQnYHMxC5gH0Pxj46a+OW9i3+r/CjIh7YzBEq4f5BiTekFjrvYZya4FsPlqJQd19nfyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376719; c=relaxed/simple;
	bh=7jNdCfHO1rjUis85EuHgw8/eW4qRdxzuua3xi8tSxG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJihTLANRaZBQNxgTW6gNqTJ4IXSZsobogRtrny+LscHsVXu8bMvZy0oV5FIbh1bCzNDBmIqZ1iDmmzauMYfyhzmLWmn+um1zOXGtxHmfEoYibpW3lj7q8qOefuGROiHWHv3XX/OKLNTxxV9fOOVILXrqUpJh3EYsXFA9ANFolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OliGHSCP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDriE6019480;
	Mon, 25 Mar 2024 14:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XQmi1NL6YoDj3tFR//+jd2Zxi9HPg24JatSnWES+vWc=;
 b=OliGHSCPx7lnU9eV95ZrA24gYhWVFc80J1SLP0BNtYX6oEnoDKtLDea6FlAtDKpdpTVr
 TFFReDHlHqIL9e7AG5Y+fHH/1xuJELsAbSa6hPTgxwfLG8mX/buZ1dWHZxIrIjPVIfM5
 sLldFl7S89laIvP3mX5Fhw5/X4yLrgAr/mxtoh+czzEKeqAnOq3dD59SDOOtYueQw1As
 hE7KMzjrN3LPvE8sbl4QPp1zfM+Rc/pQEW6iIzrFJjNMMtdCSU6cJSOTEcJIC2t82Fh/
 yJpEZeGXk6vEVMV+ZHs1hTOF3tSxu8yVdzoYfreR/1/AVWgSS1Nqpk8SZu9p35YkdRQT ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x36e68m1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:46 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PEOjDL008406;
	Mon, 25 Mar 2024 14:24:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x36e68m1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDF7du016411;
	Mon, 25 Mar 2024 14:24:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dtsyfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PEOe6D32833910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 14:24:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20BF20043;
	Mon, 25 Mar 2024 14:24:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BECE20040;
	Mon, 25 Mar 2024 14:24:37 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 14:24:37 +0000 (GMT)
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
Subject: [PATCH v4 2/2] mm/numa_balancing:Allow migrate on protnone reference with MPOL_PREFERRED_MANY policy
Date: Mon, 25 Mar 2024 09:24:14 -0500
Message-Id: <158acc57319129aa46d50fd64c9330f3e7c7b4bf.1711373653.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1711373653.git.donettom@linux.ibm.com>
References: <cover.1711373653.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0HDwk0B_u03dHdcU1BTox6ml58Kw2LH3
X-Proofpoint-ORIG-GUID: ON7z38xTRC7wCB0Gk_w0WEurN4gTeR8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250079

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

Example:
On a 2-sockets system, NUMA node N0, N1 and N2 are in socket 0,
N3 in socket 1. N0, N1 and N3 have fast memory and CPU, while
N2 has slow memory and no CPU.  For a workload, we may use
MPOL_PREFERRED_MANY with nodemask N0 and N1 set because the workload
runs on CPUs of socket 0 at most times. Then, even if the workload
runs on CPUs of N3 occasionally, we will not try to migrate the workload
pages from N2 to N3 because users may want to avoid cross-socket access
as much as possible in the long term.

In below table, Process is the Process executing node and
Curr Loc Pgs is the numa node where page present(folio node)
===========================================================
Process  Policy  Curr Loc Pgs     Observation
-----------------------------------------------------------
N0       N0 N1      N1         Pages Migrated from N1 to N0
N0       N0 N1      N2         Pages Migrated from N2 to N0
N0       N0 N1      N3	       Pages Migrated from N3 to N0

N3       N0 N1      N0         Pages NOT Migrated  to N3
N3       N0 N1      N1         Pages NOT Migrated  to N3
N3       N0 N1      N2	       Pages NOT Migrated  to N3
------------------------------------------------------------

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


