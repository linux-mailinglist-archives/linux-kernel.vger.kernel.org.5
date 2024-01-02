Return-Path: <linux-kernel+bounces-14161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B147C821898
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83D81C21578
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033363A6;
	Tue,  2 Jan 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cGw6QmI/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6453A9;
	Tue,  2 Jan 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 401LrrXc022395;
	Tue, 2 Jan 2024 08:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=IU3SKqS8arQ2vGYuJO5ap2cBUZGNq87a8rKkaitXfhw=;
 b=cGw6QmI/IzqfpMYf1EEhhH4YtRIYu8/J4rpE39vK9Eq8ODGKlyxQm7uQAwdn2HbuHxBm
 UTDQ2q+zJm/s0aFyH/Xp48bwaRoABwuAboDo7n4w7jE663D1xsPlli3J/JK24MpxIq7q
 o1oe4RBrr4qNzSJZQ3q8DYn2MC7zW0hou4PaVBuvlE2lzyR80Smx8JgRHAkCoHq2HRXu
 PE9GqIErsC69xRaHz8wOr7qMMb4NntvnSHdnPlHsp6EnZb8xC/dzDthxNhyvKEy8JuHd
 4R+GfCahTXvzIMRPYl8y2RrAUJNjWLW2174NeXhSYR+Hiv2ndbaMUBXXL6Iw4dmm+bHK ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa03tm7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 08:52:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4028VYo0024302;
	Tue, 2 Jan 2024 08:52:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9nd7xsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 08:52:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4028nKGJ019622;
	Tue, 2 Jan 2024 08:52:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3va9nd7xrr-1;
	Tue, 02 Jan 2024 08:52:49 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] scsi: fcoe: Fix unsigned comparison with zero in store_ctlr_mode()
Date: Tue,  2 Jan 2024 00:52:45 -0800
Message-ID: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_02,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020066
X-Proofpoint-ORIG-GUID: _QYeAAJrfGy_q1G6LBrusuXsKPieJl9t
X-Proofpoint-GUID: _QYeAAJrfGy_q1G6LBrusuXsKPieJl9t

ctlr->mode is of unsigned type, it is never less than zero.

Fix this by using an extra varibale called 'res', to store return value
from sysfs_match_string() and assign that to ctlr->mode on the success
path.

Fixes: edc22a7c8688 ("scsi: fcoe: Use sysfs_match_string() over fcoe_parse_mode()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch and only compile tested.
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 408a806bf4c2..c64a085a7ee2 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -263,6 +263,7 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
+	int res;
 
 	if (count > FCOE_MAX_MODENAME_LEN)
 		return -EINVAL;
@@ -279,12 +280,13 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			return -ENOTSUPP;
 		}
 
-		ctlr->mode = sysfs_match_string(fip_conn_type_names, buf);
-		if (ctlr->mode < 0 || ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
+		res = sysfs_match_string(fip_conn_type_names, buf);
+		if (res < 0 || res == FIP_CONN_TYPE_UNKNOWN) {
 			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
 					  buf);
 			return -EINVAL;
 		}
+		ctlr->mode = res;
 
 		ctlr->f->set_fcoe_ctlr_mode(ctlr);
 		LIBFCOE_SYSFS_DBG(ctlr, "Mode changed to %s.\n", buf);
-- 
2.39.3


