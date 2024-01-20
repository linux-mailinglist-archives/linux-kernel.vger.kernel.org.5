Return-Path: <linux-kernel+bounces-31657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C583320D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71351F22402
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F21809;
	Sat, 20 Jan 2024 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RIeAIHmJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F648650
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712908; cv=none; b=nDB/87o81iW2lWHtwZO4EhtTTLWM3+ed8Ifip+c/hjVzzxxW4eyeB0b26YoOM36Ra55zY//p9/xsO/6aSx5Kvr6IrZSebfWoL/BgL3nGN2glkQhc2jrtb3WVg2Rz7U3AOeTru232VV/idRbxvFMBdfGtv8ztZZIi5RH4+1c+pew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712908; c=relaxed/simple;
	bh=0JlUEmgQLOHzMuAhTteuxg5xb2SSQWi1UYNI4bu6NXQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qXQpVGwhlBKfNW5+BTbgzoqhz7u9FQhTat6ey6P7Zu/wlSYUCNxm5iODnqAI1GiVl1Bfznnf7zrvRhEYZg0UpDCeXTqSLHDQbw7EV8CUvv5HkQzw/JZEHF4meM/9FemJkXmPYTHvQQELMbRw55on/Etu+5IropqjIF0cC2ke5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RIeAIHmJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JN72gt027918;
	Sat, 20 Jan 2024 01:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=sltGnzFHEhyuMAYtQh/kNQsctmX5DQoOH2S/S0KV5tQ=;
 b=RIeAIHmJk59QuXsjd/uSRCa7+TWXXg7wNeUshVTjJOI5UQPcwmlNIQT6V1aSVi68mFB1
 dAwAOiq1BD2wTjivqFeYKExdrIwCdd9z+nCdZ7jybJA9iTwLNByyxEIx4Gxd3Z/por2Y
 EDoJQrdsQkrEj5eET3KUc98jgZQkRs9L1sbdVuONdfEoTWzJgHVErw8VBgKLsN+vn/Y+
 WAPgo5hYXHJZqJto/DxRR/3ZrsxzSr6SOtuTup6TRmONerrb0AkRv/lKDir9uLDYgwjA
 +UJlEFpUI9O41J0Ol3MI2OVUGNLOG3imvwvxQreR2NUzmfsTFVGZT0TfknWUVpPYDJZO vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hyper-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 01:08:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40JNNUL9010140;
	Sat, 20 Jan 2024 01:08:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgygbmwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Sat, 20 Jan 2024 01:08:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40K18Ack027919;
	Sat, 20 Jan 2024 01:08:10 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgygbmpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Sat, 20 Jan 2024 01:08:10 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, mike.kravetz@oracle.com, akpm@linux-foundation.org
Subject: [PATCH] Hugetlb pages should not be reserved by shmat() if SHM_NORESERVE
Date: Fri, 19 Jan 2024 17:17:52 -0800
Message-Id: <1705713472-3537-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401200007
X-Proofpoint-GUID: cGRV4LHMiZcnQF8uuuu02ldcl0LYJsPZ
X-Proofpoint-ORIG-GUID: cGRV4LHMiZcnQF8uuuu02ldcl0LYJsPZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For shared memory of type SHM_HUGETLB, hugetlb pages are reserved in
shmget() call. If SHM_NORESERVE flags is specified then the hugetlb
pages are not reserved. However when the shared memory is attached
with the shmat() call the hugetlb pages are getting reserved incorrectly
for SHM_HUGETLB shared memory created with SHM_NORESERVE.

Ensure that the hugetlb pages are no reserved for SHM_HUGETLB shared
memory in the shmat() call.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 fs/hugetlbfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f757d4f..93cafd2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -141,7 +141,13 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	if (!hugetlb_reserve_pages(inode,
+
+	/*
+	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
+	 * reserving here. Note only for SHM hugetlbfs file, the inode
+	 * flag S_PRIVATE is set.
+	 */
+	if (!(inode->i_flags & S_PRIVATE) && !hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
 				vma->vm_flags))
-- 
2.7.4


