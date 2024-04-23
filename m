Return-Path: <linux-kernel+bounces-154873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4078AE241
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E201C21997
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F917580A;
	Tue, 23 Apr 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MfDgEw2J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC74501F;
	Tue, 23 Apr 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868437; cv=none; b=Xqxak7uSweIwC41C5FEpVkRqcnbBGZI0ZGb5xLlqchd/XrsfTXKB3nQqeWUc69PFN+CJi5D/Mbo9buptbrfO7hMRlzEFvrMFCDlVwFE3LCP99LA6X3v2KjYLQ1voMe9f3MbZTsz7RjdRXHNIPwVzn22+mQyLRPky2tUpdiqaQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868437; c=relaxed/simple;
	bh=XIPYcrQ3GunBqF7O2yX/Nrd0N+vABpiohMutuXWlHLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WhUgwgFZtgUYlOc7tR+AayNnrCB89ZDrLPyR6XRKpb6Qc9r04QArcFFChqO6Wlzo/PxZb6BfWaYNaKN4umCzn+X/ujmuwNXb61KmdWr0PYYEYwqHYWxxAWZ624YQwQdi7ScwZ4Wcc4A0FRr9te9TFUCbc8ElgAvzDYO5XtfUCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MfDgEw2J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5Tj4Z012462;
	Tue, 23 Apr 2024 10:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=MiYKtVjiYGayHJ4uhB0s6D821r2mrG8hS7wgv8FbeJE=; b=Mf
	DgEw2JukuSF2ZlcjBATtdQWwUtmQLG7phAvAuxvSF+UgR5IGzoY6YGBLOQ555a2x
	IfOTalO9VDEXmdD1IErFxmoi3fdBHL+TIJc3UzuiMj1CRQlFcow0wd7lCoKen512
	1qzs5iDR5ZL/7x5OddxyIhcSpv7ucPks89DWkXTtebyu8liDq6y6guXfS7X7iMfX
	UBvj7EDa0JI4JCTFzZcg404taKPy+qIXk4ybiuONv/xEkd8B674tF2Dq8pwvJmih
	2/vJ0ejEKYJEAaevGN75ttY6WxSsdOIwLjVgcpTYnCRemdf9eaT9+pocHRZDwBe8
	5GJdlPK4Z7Pw0a91/sNw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtn9qxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:33:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43NAXf3F030334;
	Tue, 23 Apr 2024 10:33:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6skdt6e-1;
	Tue, 23 Apr 2024 10:33:41 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NAXfuX030329;
	Tue, 23 Apr 2024 10:33:41 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43NAXeX4030328;
	Tue, 23 Apr 2024 10:33:41 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id EE2955B14; Tue, 23 Apr 2024 18:33:39 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 2/3] bus: mhi: host: Add a new API for getting channel doorbell address
Date: Tue, 23 Apr 2024 18:33:36 +0800
Message-Id: <1713868417-37856-3-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O8X6Ht0mrDFJqmpmjiWc153Lxw9F5fBe
X-Proofpoint-ORIG-GUID: O8X6Ht0mrDFJqmpmjiWc153Lxw9F5fBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230028
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some controllers may want to know the address of a certain doorbell. Hence
add a new API where we read CHDBOFF register to get the base address of
doorbell, so that the controller can calculate the address of the doorbell
it wants by adding additional offset.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/init.c |  6 ++----
 drivers/bus/mhi/host/main.c | 16 ++++++++++++++++
 include/linux/mhi.h         |  6 ++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7104c18..6e0fa79 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -541,11 +541,9 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	dev_dbg(dev, "Initializing MHI registers\n");
 
 	/* Read channel db offset */
-	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read CHDBOFF register\n");
+	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
+	if (ret)
 		return -EIO;
-	}
 
 	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
 		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 15d657a..4de7567 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1691,3 +1691,19 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
 	}
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	void __iomem *base = mhi_cntrl->regs;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, chdb_offset);
+	if (ret) {
+		dev_err(dev, "Unable to read CHDBOFF register\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_get_channel_doorbell_offset);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d968e1a..cb3b676 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -816,4 +816,10 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
  */
 bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_get_channel_doorbell_offset - Get the channel doorbell offset
+ * @mhi_cntrl: MHI controller
+ * @chdb_offset: Channel doorbell offset
+ */
+int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset);
 #endif /* _MHI_H_ */
-- 
2.7.4


