Return-Path: <linux-kernel+bounces-20638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1148282CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D596B22ADC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170032E851;
	Tue,  9 Jan 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LwPgBZ8F"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70629CF1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4099ExJF002379;
	Tue, 9 Jan 2024 09:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=+xyrwDFS099oTZr80eG8tqlbdegvI+EmzfeYorlmT8s=;
 b=LwPgBZ8FNFDr95rT4pYF6Jb9Nqwk0ExICiU9LTw94K2MnYwAKMqPES5Gl+aCvrBTSYct
 avy/AXVkQTv0Ai57iyzSAjwoPBcQAVebzTw5Vd2P5MifynPKWR+VLclqSDUZFofatJCy
 e2g0siJ4Nc4iaKZmqnZA+PP2ti9ocd/97qw+vHJzmmGQIHOQXMsJP2X9bL3funAg168J
 rp1qc9trPCBRXDP9l9xw63G/i6G34XtAXm0wvtxxSJIVx+BC8Rl6QFvWHsizZVuG1cwg
 1+GtlU1DxhfifcLdypb8Ae0VryLpdb3HCjc56Ax9XFtcYg+sLvxNqHkoETBCzebA/8Vq eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh3bd0020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 09:15:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4098Xsuf006721;
	Tue, 9 Jan 2024 09:15:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur3f6rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 09:15:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4099FCea007613;
	Tue, 9 Jan 2024 09:15:13 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-139-172.vpn.oracle.com [10.159.139.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vfur3f6r8-1;
	Tue, 09 Jan 2024 09:15:12 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianfeng Wang <jianfeng.w.wang@oracle.com>
Subject: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
Date: Tue,  9 Jan 2024 01:15:11 -0800
Message-ID: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090073
X-Proofpoint-ORIG-GUID: 89_hUgsNPu7_jKHX54smR6a95sDi_sq1
X-Proofpoint-GUID: 89_hUgsNPu7_jKHX54smR6a95sDi_sq1

The oom_reaper tries to reclaim additional memory owned by the oom
victim. In __oom_reap_task_mm(), it uses mmu_gather for batched page
free. After oom_reaper was added, mmu_gather feature introduced
CONFIG_MMU_GATHER_NO_GATHER (in 'commit 952a31c9e6fa ("asm-generic/tlb:
Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y")', an option to skip batched
page free. If set, tlb_batch_pages_flush(), which is responsible for
calling lru_add_drain(), is skipped during tlb_finish_mmu(). Without it,
pages could still be held by per-cpu fbatches rather than be freed.

This fix adds lru_add_drain() prior to mmu_gather. This makes the code
consistent with other cases where mmu_gather is used for freeing pages.

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/oom_kill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde34a..e2fcf4f062ea 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -537,6 +537,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 			struct mmu_notifier_range range;
 			struct mmu_gather tlb;
 
+			lru_add_drain();
 			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
 						mm, vma->vm_start,
 						vma->vm_end);
-- 
2.42.1


