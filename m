Return-Path: <linux-kernel+bounces-84776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A086AB67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F8282105
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC536B0E;
	Wed, 28 Feb 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g1i/ND/s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DB33987
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112895; cv=none; b=sNbO/lDyo/t5ymRRWneNZLe1kFtIoesPg7g5Z9jaPn9nrBlmwmN34MTmSY1/8WHEw58EFBQ+ozH+tvhBJgYZoSaz7RGDk19RnKCjx86xybQjmb0mVnsxjVw+YMsFnfzrk5dJ7p1O8Y43vuitaRTkU4Tj1KOojkJ5240jNEmgLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112895; c=relaxed/simple;
	bh=6orYZl3wn2cOkF4brbe/Asz5vqmU0uEkBFM9m2BCNjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhQvovF2mrJFcsmQ4+07v0TGpvKUOTXtYqU7wTo7HIDJvwvWioB9/zy1irfDxERTr88G3SUQXru7LnOUd56Dypvi240jBBSHZUxdci6SV1kpsc7IL8J35fpbscfn/zSqIgJjcmPGMxa0dWHl/H6G+p03faVSNG99j8k2vaAP0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g1i/ND/s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5jrJv016379;
	Wed, 28 Feb 2024 09:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=mC1TlTHZ8OiOtXr093yL
	IlnoHBATtQ3OA9nN4jcVblw=; b=g1i/ND/sZO/H2i6FS46xY1bww0ZvGUKstbVl
	volNPgdvfaeQyRA3ztISsnloUuMfRScZXDL69ZYjyXByMau4LqE5MueVqjR0YDeh
	L1KLhSMBsy33wsnMrr/Af1F3GJfe/mB3AmUQdgxkhqsnXSq1Ujt8S2Vp7aBnoJp6
	jSwxWp53PumrX9HdbpQYuXMazuUWstIace17BZEqkMpFgBG2nYmaHa1XwebOOSni
	sUU+w6yv4g5aCw4L7SXSF7HBYGyDyZ6FqwU0VzXy0OK96eFdA6yN7/aHV0Pwwi+p
	uzy1/uGBXAcekIGmCo87G+C6a+UZEcB4QjOrLmtrHLFMTPQmqA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whp65sepy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:34:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41S9YaQQ018749;
	Wed, 28 Feb 2024 09:34:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3wf9hkux7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:34:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S9YaRR018744;
	Wed, 28 Feb 2024 09:34:36 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41S9YZFH018743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:34:36 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id 9729524176; Wed, 28 Feb 2024 15:04:34 +0530 (+0530)
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
To: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: andersson@kernel.org, vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Subject: [PATCH v1] i3c: master: Enable runtime PM for master controller
Date: Wed, 28 Feb 2024 15:04:07 +0530
Message-Id: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JLMJw9ph6eLPqoAJlm04ymWsw6_J4r7L
X-Proofpoint-ORIG-GUID: JLMJw9ph6eLPqoAJlm04ymWsw6_J4r7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280074

Enable runtime PM for i3c master node during master registration time.

Sometimes i3c client device driver may want to control the PM of the
parent (master) to perform the transactions and save the power in an
efficient way by controlling the session. Hence device can call PM
APIs by passing the parent node.

Here, I3C target device when calls pm_runtime_get_sync(dev->parent)
couldn't invoke master drivers runtime PM callback registered by
the master driver because parent's PM status was disabled in the
Master node.

Also call pm_runtime_no_callbacks() and pm_suspend_ignore_children()
for the master node to not have any callback addition and ignore the
children to have runtime PM work just locally in the driver. This
should be generic and common change for all i3c devices and should
not have any other impact.

With these changes, I3C client device works and able to invoke
master driver registered runtime PM callbacks.

Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3afa530c5e32..a3dc88974f92 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -2812,6 +2813,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
 
+	pm_runtime_no_callbacks(&master->dev);
+	pm_suspend_ignore_children(&master->dev, true);
+	pm_runtime_enable(&master->dev);
+
 	/*
 	 * We're done initializing the bus and the controller, we can now
 	 * register I3C devices discovered during the initial DAA.
@@ -2849,6 +2854,7 @@ void i3c_master_unregister(struct i3c_master_controller *master)
 	i3c_master_i2c_adapter_cleanup(master);
 	i3c_master_unregister_i3c_devs(master);
 	i3c_master_bus_cleanup(master);
+	pm_runtime_disable(&master->dev);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(i3c_master_unregister);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


