Return-Path: <linux-kernel+bounces-4754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C717381819C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C31F2403C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DA8820;
	Tue, 19 Dec 2023 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YirwQ/ie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BDC12F;
	Tue, 19 Dec 2023 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0KpYQ024067;
	Tue, 19 Dec 2023 06:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=kNbP2WlWBMrLu1QgfSgeqIA5z2OMYRWHwqSpmbR+bdg=;
 b=YirwQ/ie7u9Cxw08FpLPGFW44zPI5efwqp623twqguPDS+RxGNkx00z0zU8v+jfmd/4I
 qpS1IWWPtImBOKN6y8RRkH21cDePs/yqBVaopccA0qn18JaqROFAS3oaxzgpsT6uxSys
 EdQHPAGrZnw7BxTJUBlndg86CRoDjTudg/zQELYj6k9nSJD5DOcWhv3cYq/P7/6b7osw
 qj+Mz94ouDq0y70wPp3j2chKklL6F9Y9LCBUkcStgVp5wmfcLjPEtFiaAy8olnsfxGsU
 Kr0qsKWwvxBcVdOS0+0lBerqNO4luz+ahT1NhdmfiI8YnCE8aLVXaXjwf7eJiI1J4KIs wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb50aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:36:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ5k2pJ028994;
	Tue, 19 Dec 2023 06:36:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b67x79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:36:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ6agEv022292;
	Tue, 19 Dec 2023 06:36:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b67x6q-1;
	Tue, 19 Dec 2023 06:36:42 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Lee Jones <lee@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] usb: yurex: Fix inconsistent locking bug in yurex_read()
Date: Mon, 18 Dec 2023 22:36:35 -0800
Message-ID: <20231219063639.450994-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190047
X-Proofpoint-ORIG-GUID: eft87yRi825x-nhKuNnaynBwYrOUUb09
X-Proofpoint-GUID: eft87yRi825x-nhKuNnaynBwYrOUUb09

Unlock before returning on the error path.

Fixes: 86b20af11e84 ("usb: yurex: Replace snprintf() with the safer scnprintf() variant")
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202312170252.3udgrIcP-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/usb/misc/yurex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 5a13cddace0e..9a0649d23693 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -414,8 +414,10 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 		return -ENODEV;
 	}
 
-	if (WARN_ON_ONCE(dev->bbu > S64_MAX || dev->bbu < S64_MIN))
+	if (WARN_ON_ONCE(dev->bbu > S64_MAX || dev->bbu < S64_MIN)) {
+		mutex_unlock(&dev->io_mutex);
 		return -EIO;
+	}
 
 	spin_lock_irqsave(&dev->lock, flags);
 	scnprintf(in_buffer, MAX_S64_STRLEN, "%lld\n", dev->bbu);
-- 
2.42.0


