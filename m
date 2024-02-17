Return-Path: <linux-kernel+bounces-69717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBF858DB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D3F1F222DC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41081CF96;
	Sat, 17 Feb 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbfT29f8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D1CD28
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155161; cv=none; b=nmeqgFBM7yT0vhhKOfoPQZYmROPzjjvKT5XFcxUEsPyEOKBptK34XDmovjTUW7gmhIZhP/1Z5ujuVJnjq20gdGzRunJBwU6nRlHwZMDBO0R4HLa1xts6JvV/sD5bu0THQaWNDv9apUk+33oPLU5RuI7GQu0Jjb8mjLKnPCZ+22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155161; c=relaxed/simple;
	bh=PiQwLTmZ6W5HTM2z6PZFxaEnlW+S6lS3/1uTGO6XgjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpwSVUS3Pcupkod00SVvDmd9w8kbymYDvWYIwnvmJRe7gFe1lOJmJNJRPn0khGeOrU+SIxpA+F0c8zq1VkduqzIC9sp4RChtMWzQRh6h3bY/SbhNQ7OkpSj5XSS3IO+5zqk9L2dJBNY97CBtmE2tPW9CwSLmBAU4gohBEG452Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbfT29f8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H6gu7b011493;
	Sat, 17 Feb 2024 07:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qNdnXOL/mCGBemUkNo77c+l0ZD3S/yNBwt3aziQTX6E=;
 b=WbfT29f8MSInX04uIWKE1R4g4T4wDLqm2Q0+GtfRgUg8RRlhTkOlh/pUMOPmEYnenrCR
 AKZFo3ViieOyFuey9IE2W8C4mC7joVXQbScMGvMJmCj3HsXfFlyCHBw/kvTaAd4MxTwA
 uvIqoBWM1tjQghekGbfbiLW7zr53YcsfRPKyi5JRcz4CN4Cm2FynNfNGCIN0DoSwi3MS
 Epq/DXu3E11Mv2gU7ajZva5PcyzkvqrOtp3Kjj4QaA6wSNOyItBBd/hqsLt+mnkTCJYN
 rXfNcroAyuUE0GW3Da9WtgypR7CpqVZ5jcYIQad59SlxIWAxQTLjaZe4lLvzyvQXGPYX 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waqs30jmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:48 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41H7UPCA013204;
	Sat, 17 Feb 2024 07:31:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waqs30jm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41H55V6k010050;
	Sat, 17 Feb 2024 07:31:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmg88w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41H7VhcM18940586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 07:31:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4832004F;
	Sat, 17 Feb 2024 07:31:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FFD52004B;
	Sat, 17 Feb 2024 07:31:40 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Feb 2024 07:31:39 +0000 (GMT)
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
Subject: [PATCH 2/3] mm/mempolicy: Avoid the fallthrough with MPOLD_BIND in mpol_misplaced.
Date: Sat, 17 Feb 2024 01:31:34 -0600
Message-Id: <bf7e6779f842fb65cf7bb9b2c617feb2af271cb7.1708097962.git.donettom@linux.ibm.com>
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
X-Proofpoint-GUID: RFIikoKL5ffHBWAyVD9mrafMHgu0IRNd
X-Proofpoint-ORIG-GUID: sLIiKqq1v8CAfDTE3aGBn-xbDlUw40Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_04,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170058

We will update MPOL_PREFERRED_MANY in the follow up patch. This change
is required for that.

Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/mempolicy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8478574c000c..73d698e21dae 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2515,7 +2515,15 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 				break;
 			goto out;
 		}
-		fallthrough;
+
+		if (node_isset(curnid, pol->nodes))
+			goto out;
+		z = first_zones_zonelist(
+				node_zonelist(thisnid, GFP_HIGHUSER),
+				gfp_zone(GFP_HIGHUSER),
+				&pol->nodes);
+		polnid = zone_to_nid(z->zone);
+		break;
 
 	case MPOL_PREFERRED_MANY:
 		/*
-- 
2.39.3


