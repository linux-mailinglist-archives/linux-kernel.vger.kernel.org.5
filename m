Return-Path: <linux-kernel+bounces-22297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C9829BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50241286F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDF495EB;
	Wed, 10 Jan 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXPEbR+h"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36063495CD;
	Wed, 10 Jan 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AD7Crh007939;
	Wed, 10 Jan 2024 14:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PfxT8EmwmFjjW5GAzJtI4xhYCxTVYs+9fiE3LzkKW0M=;
 b=aXPEbR+h7x2iTM4dXrKhvGGx9DczTf6raefRo5ojFWj+EhKTZkYnD+Bjn6p9a5Ndxoge
 N5VW28QlZBoH/Zl1C5WIzcjpwdcGjpY/LLMIRnhNMUj5HiwJaSMnS76hS9wHyebEmGJm
 WWowBOs4NJAIIWJ1v0BJ4OCJhSpLzUbMfKPxxxd9Byrz6ZJ6mQjQ+edXPfMW1vaDi2Af
 SCLvdPNi6yQ+BSNMMlbosNcmsb6h/5wB6NhehsqNYDv4o3Lw2x7uHong9dQFqLWN50FQ
 mzqnrz+SSbHG1OvrpxUv0F7fNrlTiSdQtOuD8LAgcE3N4c8iASnkn+5XOQBehaZtr6Ot tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhuu9h7fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:01:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ADjlMe004079;
	Wed, 10 Jan 2024 14:01:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhuu9h7ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:01:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40ACSXXI004395;
	Wed, 10 Jan 2024 14:01:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkwcmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:01:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40AE1bIF18350642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 14:01:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53D7A2004D;
	Wed, 10 Jan 2024 14:01:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BA7B20043;
	Wed, 10 Jan 2024 14:01:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jan 2024 14:01:37 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval
Date: Wed, 10 Jan 2024 15:01:27 +0100
Message-Id: <20240110140127.241451-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: akujshpMwAbrdtpK1D1VWpnTYq87mmYm
X-Proofpoint-ORIG-GUID: 1ES3chf0hnl4bulp882nvtBk7J5ErQgx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_06,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=913 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401100115

The set_memmap_mode() function stores the kernel parameter memmap mode
as an integer. However, the get_memmap_mode() function utilizes
param_get_bool() to fetch the value as a boolean, leading to potential
endianness issue. On Big-endian architectures, the memmap_on_memory is
consistently displayed as 'N' regardless of its actual status.

To address this endianness problem, the solution involves obtaining the
mode as an integer. This adjustment ensures the proper display of the
memmap_on_memory parameter, presenting it as one of the following
options: Force, Y, or N.

Fixes: 2d1f649c7c08 ("mm/memory_hotplug: support memmap_on_memory when memmap is not aligned to pageblocks")
Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 mm/memory_hotplug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b944e8bf1911..707027f69150 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -101,9 +101,11 @@ static int set_memmap_mode(const char *val, const struct kernel_param *kp)
 
 static int get_memmap_mode(char *buffer, const struct kernel_param *kp)
 {
-	if (*((int *)kp->arg) == MEMMAP_ON_MEMORY_FORCE)
-		return sprintf(buffer,  "force\n");
-	return param_get_bool(buffer, kp);
+	int mode = *((int *)kp->arg);
+
+	if (mode == MEMMAP_ON_MEMORY_FORCE)
+		return sprintf(buffer, "force\n");
+	return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops memmap_mode_ops = {
-- 
2.40.1


