Return-Path: <linux-kernel+bounces-145453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D48A5655
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53780B221FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1647F460;
	Mon, 15 Apr 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rpufZYtm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB478C6D;
	Mon, 15 Apr 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194764; cv=none; b=YJcNKNc2F62bL7TJ++lD/NzpNMoM7hOM9sE6A93H5PC4NhvPytzMQuB8jmLaA04f7MU9TO/ZSlL0hCBYRSCu1JibrE1gJ8rplEeEWvUaO2p/kaFyCYAOIWXiqnnqOYoXsNPMG1fn7iaM33pECtYmdTgxCI5DL5Jg2c3N0e8oGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194764; c=relaxed/simple;
	bh=tSlXTR1QKZXk2pfdOpSseZfCaKNekp47ZScfnD+Fa2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUPll3YNhC1yb0Lk5ns5m4CnWVZ5Y+jZtRThISgs9P6lRiW1/Y1j4H+68mvR2+/OoZgWIqUnAwL3jaFj8UDuCdGD7XLbv4gkFyZxa+D53/XL1vhPERASA1A9uFrLE0Xy8wwuEuo3dshtK0Pdf+wFfo29JaS3djfZWe67afvVhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rpufZYtm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FFOZFa025533;
	Mon, 15 Apr 2024 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qpf3+bKZA3IFFAh2Zgq/tCvKv4L+adz2xvIinaCNjGg=;
 b=rpufZYtmTe3Q74Tj0FiexgmThAOyEKrWKyyJJ0HJmCmVBeYXyMGTn0b6Lv1TeHjb0ZFd
 mwr+kWMqUb8IDYns7kspzlieWWS++b6tFxw0fM7yIbL33luw2Ik8dAXYuhu8N6aH7BkZ
 hFU0xIZgsG2FDYC7pPqj9vq6in5YR7G0yJJkfuTbJHQHTqXYsAjKKtPt/S4hqn4EuC38
 gMwwy8xVmkCLCV1utiprC9NjjnQPVwM2xQZTmCFZxqB/spLp6sukcQ5H8mfVhMJA8QgG
 PU5aAgZW1nTZobZS9D63OT60BD6gybx4N5+FDnZbfjAW0MmALjRpnRsQNcnUcDOLvUc0 Sw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgmufhv1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCqrtS023582;
	Mon, 15 Apr 2024 15:26:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnrk8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFPwE312190402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:26:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C64758060;
	Mon, 15 Apr 2024 15:25:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7557B58043;
	Mon, 15 Apr 2024 15:25:57 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.81.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:25:57 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v5 3/5] s390/vfio-ap: Ignore duplicate link requests in vfio_ap_mdev_link_queue
Date: Mon, 15 Apr 2024 11:25:53 -0400
Message-ID: <20240415152555.13152-4-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415152555.13152-1-jjherne@linux.ibm.com>
References: <20240415152555.13152-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJN3EdsMsngpkOybxIIY08cpVpY_6uBx
X-Proofpoint-ORIG-GUID: JJN3EdsMsngpkOybxIIY08cpVpY_6uBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150100

vfio_ap_mdev_link_queue is changed to detect if a matrix_mdev has
already linked the given queue. If so, it bails out.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e01f53a3c5b7..1499c2181122 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -794,10 +794,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
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


