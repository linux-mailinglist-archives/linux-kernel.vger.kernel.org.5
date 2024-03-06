Return-Path: <linux-kernel+bounces-94023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F287388E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213971C2094C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659EE1339A4;
	Wed,  6 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qE8yZ4xI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA507133983;
	Wed,  6 Mar 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734133; cv=none; b=bzB27EDFxqxA1xf9kVEjVCRwjG8svpSU4tTiVCAbIvHk14iP/2R+UmZxOuuWKDkazIIxU0pgLrCn46bJl83SPlVkwaMskzsF4Z1IGwOw1LF00R5abKu1m8enEAn1gyukNmVlXszzyYoRVkjwTbyBJw4K/gsuJ5xVbigxPdHNRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734133; c=relaxed/simple;
	bh=4IID6LPN9K8zYIsFYymwirnkhJdBoOJSJ4xLr0OLViU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3GZ7lCDJ78mMDbMKBJ+tpeWZ59SDNKczgzsVCM7ox8WElSPWE/mVDcKDmlIsCq49qGRbIvMdfLK17qt1nnw006aBwZ0K2JxmwTAhFFnFeWmB/bE8IAXE58g7n/01NirBshZ6XhHK0ByZxBz9V4AdlCF7AgyPK6QDweuL8Jw1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qE8yZ4xI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426E8Zt2016405;
	Wed, 6 Mar 2024 14:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l9TT7zLQfLtl5v9k6D80hIILIygBrOzp5/OnDDCsHmQ=;
 b=qE8yZ4xIFWLIykC/tNRu7OP4wPpt14sSyQlYcNQqOAdbV2yMGJfCLXjIAlX9Fy4idGww
 clnZAIrby33hT0Tt/05lqv6yJ4C8iwM6tp2ntZYmcaoo3pR7eyDAY8i7BP80Ogug/J0Z
 /aZDImCDNLrX2z47Cg5i2En+4jfBSEKOUDgo9Bs/VnbFeZZGX7OCiWaoQrRMtj0azKBJ
 ko3QQLoOFWDQX5YvDhc9KDqGPRoQdy8gcYloXPVvtMZbl2HMdpsoJeh6kiecylvrWpZW
 X54tQrHoeb0n0jpEETh9IFo/zMca2pn8GIqjEz6e1PQjJIjj5FAHSdlxDvRme4l7YJP8 GA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsyxr065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426BWXef010886;
	Wed, 6 Mar 2024 14:08:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52emjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426E8kMw32309742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:08:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DAD858065;
	Wed,  6 Mar 2024 14:08:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB02E58071;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.164.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v2 3/5] s390/vfio-ap: Ignore duplicate link requests in vfio_ap_mdev_link_queue
Date: Wed,  6 Mar 2024 09:08:41 -0500
Message-ID: <20240306140843.10782-4-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306140843.10782-1-jjherne@linux.ibm.com>
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZcP-uevQ6_0GbRyoYZ96JNMcetMVJCEy
X-Proofpoint-ORIG-GUID: ZcP-uevQ6_0GbRyoYZ96JNMcetMVJCEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060113

vfio_ap_mdev_link_queue is changed to detect if a matrix_mdev has
already linked the given queue. If so, it bails out.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b1c1dc0233e1..259130347d00 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -781,10 +781,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
 				    struct vfio_ap_queue *q)
 {
-	if (q) {
-		q->matrix_mdev = matrix_mdev;
-		hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
-	}
+	if (!q || vfio_ap_mdev_get_queue(matrix_mdev, q->apqn))
+		return;
+
+	q->matrix_mdev = matrix_mdev;
+	hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
 }
 
 static void vfio_ap_mdev_link_apqn(struct ap_matrix_mdev *matrix_mdev, int apqn)
-- 
2.41.0


