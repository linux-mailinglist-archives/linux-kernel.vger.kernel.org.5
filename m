Return-Path: <linux-kernel+bounces-165849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA48B925E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE92282E94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F19168B18;
	Wed,  1 May 2024 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YqTkUYed"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AED168B0A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606044; cv=none; b=YECKkHC40otqA1c31khRRFK97VghGsqd0L8hPzR8e8qvP6Jzx+cC79gB4S/WHlcvG+n5YtftQZfaglYQQje630jZ0Hf2yFn+f1CcqEf/xUOOE157jZqaRfXwkYD0e+tiQybSLlNxub7Hoy8+Y0HlgmW9OO27I6GXnXX75/BuU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606044; c=relaxed/simple;
	bh=KF22Q91ftKg+StGyAe4vPvXYgZR+4DvQ7bXUDl4Lk1M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Brept6HSU5FaHvqx+FgUd648YoJRimg1FLtwFOrHFo8Ju0g17rLr2ieK4aHcz1K6XLFHpjRaIvCxPIcf5aKTxdLEGuxJrPoPwtp9pkpZhQznBxf2qs/08PhpsTgl+C/Oz/lt7/Sams2shs7NGK5pRCDWAtFJaEPQHTtEyV+A2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YqTkUYed; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441MK3Z7031546;
	Wed, 1 May 2024 23:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=5+PFPryu85fPUhHvvBmVJI7+H9PqDvUVFzqR0jjWF1Y=;
 b=YqTkUYedogVvSCK4kM9rrwbF71TU1YEkkcaGMRNRVzcr5cYLUKudzAv2KpqTh1pqZf7o
 yf/vsAFC3dRx6rMA3QENwyJU9JR9PIcxGFE9OdEaKQoWvq952Oxl+wQHo4jRXbJBi23x
 GLVk6+R2bl8f8l0OAKpMxHgKrN3vzXIPTlWZSi21JstIa68JsvTqb7F7YIrSNjbfm6Yq
 zbzBGMzXFZyX9z6osQz+o3Aygge3m/lkbjjvRgn5YbFU2gNB8/dbfwj41VQ+ObswyI3f
 cE2r6bZ1SexRuIeYBzpfidVbO1O5kz9LGAZ+mc55QU8Wpw9tJpctx6flchfQQQNCf/5q Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvsyk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 23:26:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441MBS4B033172;
	Wed, 1 May 2024 23:25:08 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt9vbuq-3;
	Wed, 01 May 2024 23:25:08 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
Date: Wed,  1 May 2024 17:24:57 -0600
Message-Id: <20240501232458.3919593-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240501232458.3919593-1-jane.chu@oracle.com>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010165
X-Proofpoint-GUID: xYRc7ttZpJPOgWhFHPkn8aug1OV-_T7v
X-Proofpoint-ORIG-GUID: xYRc7ttZpJPOgWhFHPkn8aug1OV-_T7v

The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
a synchrous way in a sense, the injector is also a process under
test, and should it have the poisoned page mapped in its address
space, it should legitimately get killed as much as in a real UE
situation.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1a073fcc4c0c..eaeae5252c02 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1127,7 +1127,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
+			ret = memory_failure(pfn, MF_ACTION_REQUIRED | MF_COUNT_INCREASED | MF_SW_SIMULATED);
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		}
-- 
2.39.3


