Return-Path: <linux-kernel+bounces-71796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E670E85AA96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B8283627
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49B481B3;
	Mon, 19 Feb 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AEPrsa0U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0247F6F;
	Mon, 19 Feb 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366092; cv=none; b=cER0hejLu7t1CYux/Pzza5juHsu9I4BlDkk/cpBLq2g8j3D2wLpRUwX3Ers8HP2NlT0YwIdPxscDqPj2y6Y9CFTexbDNUK3zXORS/n7haAxtGyfC6jzOg3KFlHIckVz/dOMIT11+ml3erpd2kqnPi/b6e73EPMkHfETDJWKRPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366092; c=relaxed/simple;
	bh=4eiR7frSCTGgzT1qgBT77iEwpFx1D8aIPX5PZQXLens=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAwec+vBX3/Gt+jPbAgp7wjqQN85gQ+IvXiqJqAg0+eOL33l/egmkef2AnE6jDWf+CrJwErx6bcAYU368H3CFRz8ROeFltSSPwCd7LJfVn9tsNdqbdkfDB/aSSOtm4udrYI8o57MQo8WzLxj0q2wQUgPO5Az6S7gdqH0hSX+I3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AEPrsa0U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JETmFc030847;
	Mon, 19 Feb 2024 18:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cAVBL+O
	daeFKi9D704TrJJ3AmyfV5HyuZTFTsrwuAz0=; b=AEPrsa0UavSgWBgdwysjGMP
	SDncXP9s6sOWvD0ikXSMQACmdsheMCcx56eCuUFrShfY4HKEjN1qveFvdREsi4gB
	66Yas55F/vhj+MflhKfjhgCoj4Oh5YmlKK0Z/FXWrTyAE5C8R3WituynzK6lIBEe
	P9ZEdWzIfLqH4VLgqTYGBHCxMknXcnDyM0lytU7Onw0HroujIX9Rvc/fTjiMDWbk
	C+3ZGixG3hIdSRRVBJBztYuQP0muPuFujXO4LB+IEBoHKuxYwF/yTxLrJC7AsrRW
	mPuajggCP3T6pQRyaN/PUY4WP80XdUszFuIuscP4pL++D3buAehgXG4KUWyS8YQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc6te8rvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 18:08:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41JI87MW029106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 18:08:07 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 10:08:07 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] Revert "bus: mhi: core: Add support for reading MHI info from device"
Date: Mon, 19 Feb 2024 11:07:48 -0700
Message-ID: <20240219180748.1591527-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ypKP3VoO7puJcXBGahpURqVWREplP5Uc
X-Proofpoint-ORIG-GUID: ypKP3VoO7puJcXBGahpURqVWREplP5Uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_15,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190136

This reverts commit 3316ab2b45f6bf4797d8d65b22fda3cc13318890.

The MHI spec owner pointed out that the SOC_HW_VERSION register is part
of the BHIe segment, and only valid on devices which implement BHIe.
Only a small subset of MHI devices implement BHIe so blindly accessing
the register for all devices is not correct. Also, since the BHIe
segment offset is not used when accessing the register, any
implementation which moves the BHIe segment will result in accessing
some other register.  We've seen that accessing this register on AIC100
which does not support BHIe can result in initialization failures.

We could try to put checks into the code to address these issues, but in
the roughly 4 years this functionality has existed, no one has used it.
Easier to drop this dead code and address the issues if anyone comes up
with a real world use for it.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/host/init.c     | 12 ------------
 drivers/bus/mhi/host/internal.h |  6 ------
 include/linux/mhi.h             | 17 -----------------
 3 files changed, 35 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 944da46e6f11..44f934981de8 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -914,7 +914,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	struct mhi_chan *mhi_chan;
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_device *mhi_dev;
-	u32 soc_info;
 	int ret, i;
 
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
@@ -989,17 +988,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
 	}
 
-	/* Read the MHI device info */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
-			   SOC_HW_VERSION_OFFS, &soc_info);
-	if (ret)
-		goto err_destroy_wq;
-
-	mhi_cntrl->family_number = FIELD_GET(SOC_HW_VERSION_FAM_NUM_BMSK, soc_info);
-	mhi_cntrl->device_number = FIELD_GET(SOC_HW_VERSION_DEV_NUM_BMSK, soc_info);
-	mhi_cntrl->major_version = FIELD_GET(SOC_HW_VERSION_MAJOR_VER_BMSK, soc_info);
-	mhi_cntrl->minor_version = FIELD_GET(SOC_HW_VERSION_MINOR_VER_BMSK, soc_info);
-
 	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 091244cf17c6..5fe49311b8eb 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -15,12 +15,6 @@ extern struct bus_type mhi_bus_type;
 #define MHI_SOC_RESET_REQ_OFFSET			0xb0
 #define MHI_SOC_RESET_REQ				BIT(0)
 
-#define SOC_HW_VERSION_OFFS				0x224
-#define SOC_HW_VERSION_FAM_NUM_BMSK			GENMASK(31, 28)
-#define SOC_HW_VERSION_DEV_NUM_BMSK			GENMASK(27, 16)
-#define SOC_HW_VERSION_MAJOR_VER_BMSK			GENMASK(15, 8)
-#define SOC_HW_VERSION_MINOR_VER_BMSK			GENMASK(7, 0)
-
 struct mhi_ctxt {
 	struct mhi_event_ctxt *er_ctxt;
 	struct mhi_chan_ctxt *chan_ctxt;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 474d32cb0520..77b8c0a26674 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -320,10 +320,6 @@ struct mhi_controller_config {
  * @hw_ev_rings: Number of hardware event rings
  * @sw_ev_rings: Number of software event rings
  * @nr_irqs: Number of IRQ allocated by bus master (required)
- * @family_number: MHI controller family number
- * @device_number: MHI controller device number
- * @major_version: MHI controller major revision number
- * @minor_version: MHI controller minor revision number
  * @serial_number: MHI controller serial number obtained from BHI
  * @mhi_event: MHI event ring configurations table
  * @mhi_cmd: MHI command ring configurations table
@@ -368,15 +364,6 @@ struct mhi_controller_config {
  * Fields marked as (required) need to be populated by the controller driver
  * before calling mhi_register_controller(). For the fields marked as (optional)
  * they can be populated depending on the usecase.
- *
- * The following fields are present for the purpose of implementing any device
- * specific quirks or customizations for specific MHI revisions used in device
- * by the controller drivers. The MHI stack will just populate these fields
- * during mhi_register_controller():
- *  family_number
- *  device_number
- *  major_version
- *  minor_version
  */
 struct mhi_controller {
 	struct device *cntrl_dev;
@@ -407,10 +394,6 @@ struct mhi_controller {
 	u32 hw_ev_rings;
 	u32 sw_ev_rings;
 	u32 nr_irqs;
-	u32 family_number;
-	u32 device_number;
-	u32 major_version;
-	u32 minor_version;
 	u32 serial_number;
 
 	struct mhi_event *mhi_event;
-- 
2.34.1


