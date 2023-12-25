Return-Path: <linux-kernel+bounces-10933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7C81DEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BEA281B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3133E0;
	Mon, 25 Dec 2023 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lwaGuJ7x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7B23A8;
	Mon, 25 Dec 2023 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP6iKBS023016;
	Mon, 25 Dec 2023 07:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=C01KwbOTHikN
	+ObGKHLL1aw5uF4LVRLi/jy5fguvFJc=; b=lwaGuJ7xCrrhAFbtq4jj/TmzJVZL
	Q5IiOAppxLS3JcmIYbfEeen9imPsDwCmgGuBqM44sodFVTtBOT9oTsG4/wEZnUPx
	XiGNMzYq4oPRLEcbDFOybXlrB+RmSgAfc81+G3zl46hMmUWzMDHVgcgvgpN5Al7W
	1ArSK7ky34kD+TDTg3Wkaq2JvH6HnXmLE3V2CXz/g4IRCmapbZxN8Q41noGk80zB
	EnV1QEweevTVEiTRm0SGd+dYyANowteMD+iSg2FQcv5sNF1eH8sTfsQVd/Zo8CNq
	+1QohgJ1zHoddZ5VtMQWLBGic7YfMLl0EYsQRffKugqF6UQkKXV15sGg+g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5q54k5u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 07:47:59 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BP7lvra021511;
	Mon, 25 Dec 2023 07:47:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3v5rmkh1qu-1;
	Mon, 25 Dec 2023 07:47:57 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BP7lvLp021506;
	Mon, 25 Dec 2023 07:47:57 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3BP7luYj021504;
	Mon, 25 Dec 2023 07:47:57 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id DEA525699; Mon, 25 Dec 2023 15:47:55 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Bhaumik Bhatt <quic_bbhatt@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter EDL
Date: Mon, 25 Dec 2023 15:47:54 +0800
Message-Id: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: llpIygQ1XhDkRaG-q8XS8SDMgXHN-Wd9
X-Proofpoint-GUID: llpIygQ1XhDkRaG-q8XS8SDMgXHN-Wd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312250057
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>

Forcing the device (eg. SDX75) to enter Emergency Download Mode involves
writing the 0xEDEDEDED cookie to the channel 91 doorbell register and
forcing an SOC reset afterwards. Allow users of the MHI bus to exercise the
sequence using a sysfs entry.

Signed-off-by: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/init.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/internal.h |  1 +
 include/linux/mhi.h             |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 65ceac1..4654bc5 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -120,10 +120,46 @@ static ssize_t soc_reset_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(soc_reset);
 
+static ssize_t force_edl_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0) {
+		dev_err(dev, "Could not parse string: %d\n", ret);
+		return ret;
+	}
+
+	if (!val)
+		return count;
+
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret)
+		return ret;
+
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	mhi_write_db(mhi_cntrl, mhi_cntrl->edl_db, 0xEDEDEDED);
+	mhi_soc_reset(mhi_cntrl);
+
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+	return count;
+}
+static DEVICE_ATTR_WO(force_edl);
+
 static struct attribute *mhi_dev_attrs[] = {
 	&dev_attr_serial_number.attr,
 	&dev_attr_oem_pk_hash.attr,
 	&dev_attr_soc_reset.attr,
+	&dev_attr_force_edl.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mhi_dev);
@@ -524,6 +560,7 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 
 	/* Setup wake db */
 	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
+	mhi_cntrl->edl_db = base + val + (8 * MHI_EDL_DB);
 	mhi_cntrl->wake_set = false;
 
 	/* Setup channel db address for each channel in tre_ring */
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 30ac415..c414ebf 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -128,6 +128,7 @@ enum mhi_pm_state {
 #define CMD_EL_PER_RING					128
 #define PRIMARY_CMD_RING				0
 #define MHI_DEV_WAKE_DB					127
+#define MHI_EDL_DB					91
 #define MHI_MAX_MTU					0xffff
 #define MHI_RANDOM_U32_NONZERO(bmsk)			(get_random_u32_inclusive(1, bmsk))
 
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d0f9b522..c754d32 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -298,6 +298,7 @@ struct mhi_controller_config {
  * @bhi: Points to base of MHI BHI register space
  * @bhie: Points to base of MHI BHIe register space
  * @wake_db: MHI WAKE doorbell register address
+ * @edl_db: MHI EDL channel 91 doorbell register address
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
@@ -387,6 +388,7 @@ struct mhi_controller {
 	void __iomem *bhi;
 	void __iomem *bhie;
 	void __iomem *wake_db;
+	void __iomem *edl_db;
 
 	dma_addr_t iova_start;
 	dma_addr_t iova_stop;
-- 
2.7.4


