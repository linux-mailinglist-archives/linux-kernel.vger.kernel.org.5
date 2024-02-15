Return-Path: <linux-kernel+bounces-67197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E58567EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E71C1C23EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97348133423;
	Thu, 15 Feb 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nGllkKwQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68000132C07;
	Thu, 15 Feb 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011237; cv=none; b=pDcSxcWkMSCSKfYdr083enVCZs4daSHrm4LZmDYjtHlwCYoQSTFCpzunmJC8K6x4jpMZZGRpOI5mxmxASYsN6yb3uDAO2RLHF3QpFOzhSy0QD4mMTXxRvOWEX8IVOV9+p0bc4xirAr9wxzZq9LpjHqoWUhoxm99IlVm/1ah7n1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011237; c=relaxed/simple;
	bh=QpPS49oK1eurDaNJnWrdAIx+QaBf1IHnSt389MR5rv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKB8BrJvnO4jkm1otEKhPWNowNkvcyL3Dw7iSPEWUlvmS/WmBRkGSb/XVeE1opzRaMwmPVm7o60H8Gp5c8ThAbMFnTykEjhFdrafgRg1DarevU3ZpoasQhp383lnSvVRJp2D4dGshWtpbLcCfvYc2LfAC9lfH8lEGr7cDjG1GV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nGllkKwQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFNVse010881;
	Thu, 15 Feb 2024 15:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sg+aoNSY4TJzQIzmQVERhni+tOhV8KJA1pX7OPh0Bd4=;
 b=nGllkKwQFM4jf8zFiqfMbnBQb8YLW33OZS/0ThT4KKGJKnGv3Ywit/QGqbBfH2OA+rXC
 igmWnl/QH1PKPpsgSv4skPq5M9GNW8cE1vGIvDDv+yxpn9WBS6L48kkDNPOcSv3M4tWJ
 tnC2KoHHIZMNhVge+m6QvMG5ZZ8llvHDGbCZQ5+5RWX8gyyVMdwYFWrSx95V1TtLG7Yz
 sv0fY58K+Jfm4rigmda64pJ3JJDudfJ0Fa/BEHuh726SoJIsPKp8D2IjG5Bantisr28S
 WgydUYLqPp9Yc96wChnlbAaN79Z95M8ZA5S2XIVoSj9KJIFqwSo4Pxl4x9+pYEJlXe1U vw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9n73g84v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:33:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FD3GYw009914;
	Thu, 15 Feb 2024 15:31:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p635463-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:31:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FFVkp651642970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 15:31:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B4558055;
	Thu, 15 Feb 2024 15:31:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6EEF5805B;
	Thu, 15 Feb 2024 15:31:45 +0000 (GMT)
Received: from li-4795344c-3451-11b2-a85c-ab40c30bcc43.ibm.com.com (unknown [9.61.11.51])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 15:31:45 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH] s390/vfio-ap: handle hardware checkstop state on queue reset operation
Date: Thu, 15 Feb 2024 10:31:44 -0500
Message-ID: <20240215153144.14747-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KO9wTbmw1cmeyp4pmphURgM60pUNsfA-
X-Proofpoint-GUID: KO9wTbmw1cmeyp4pmphURgM60pUNsfA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150125

Update vfio_ap_mdev_reset_queue() to handle an unexpected checkstop (hardware error) the
same as the deconfigured case. This prevents unexpected and unhelpful warnings in the
event of a hardware error.

We also stop lying about a queue's reset response code. This was originally done so we
could force vfio_ap_mdev_filter_matrix to pass a deconfigured device through to the guest
for the hotplug scenario. vfio_ap_mdev_filter_matrix is instead modified to allow
passthrough for all queues with reset state normal, deconfigured, or checkstopped. In the
checkstopped case we choose to pass the device through and let the error state be
reflected at the guest level.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 35 ++++++++++++++++---------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 983b3b16196c..fc169bc61593 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -659,6 +659,21 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
 			     AP_DOMAINS);
 }
 
+static bool _queue_passable(struct vfio_ap_queue *q)
+{
+	if (!q)
+		return false;
+
+	switch (q->reset_status.response_code) {
+	case AP_RESPONSE_NORMAL:
+	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * vfio_ap_mdev_filter_matrix - filter the APQNs assigned to the matrix mdev
  *				to ensure no queue devices are passed through to
@@ -687,7 +702,6 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
 	DECLARE_BITMAP(prev_shadow_aqm, AP_DOMAINS);
-	struct vfio_ap_queue *q;
 
 	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
@@ -716,8 +730,7 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
 			 * hardware device.
 			 */
 			apqn = AP_MKQID(apid, apqi);
-			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
-			if (!q || q->reset_status.response_code) {
+			if (!_queue_passable(vfio_ap_mdev_get_queue(matrix_mdev, apqn))) {
 				clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 
 				/*
@@ -1691,6 +1704,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
 	case AP_RESPONSE_DECONFIGURED:
+	case AP_RESPONSE_CHECKSTOPPED:
 		return 0;
 	case AP_RESPONSE_RESET_IN_PROGRESS:
 	case AP_RESPONSE_BUSY:
@@ -1747,14 +1761,6 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			/*
-			 * When an AP adapter is deconfigured, the
-			 * associated queues are reset, so let's set the
-			 * status response code to 0 so the queue may be
-			 * passed through (i.e., not filtered)
-			 */
-			if (status.response_code == AP_RESPONSE_DECONFIGURED)
-				q->reset_status.response_code = 0;
 			if (q->saved_isc != VFIO_AP_ISC_INVALID)
 				vfio_ap_free_aqic_resources(q);
 			break;
@@ -1781,12 +1787,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		queue_work(system_long_wq, &q->reset_work);
 		break;
 	case AP_RESPONSE_DECONFIGURED:
-		/*
-		 * When an AP adapter is deconfigured, the associated
-		 * queues are reset, so let's set the status response code to 0
-		 * so the queue may be passed through (i.e., not filtered).
-		 */
-		q->reset_status.response_code = 0;
+	case AP_RESPONSE_CHECKSTOPPED:
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
-- 
2.41.0


