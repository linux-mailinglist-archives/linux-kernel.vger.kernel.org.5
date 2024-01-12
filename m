Return-Path: <linux-kernel+bounces-24807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2A82C2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48336286609
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828566EB7C;
	Fri, 12 Jan 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X7632k/F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081E6EB57;
	Fri, 12 Jan 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CDOrcn023577;
	Fri, 12 Jan 2024 15:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=Q11XAhYvlT+pPYbbmi3t
	nqbrEGmbsowZ/Otmw6pZCPw=; b=X7632k/Fs4ESIA4H4gaa1MPB+AoDv7rcdtsr
	4SqNWWz2brnMjN0jtiLQ3hADObwF7ScIYxC5BL0F/o8DvgJZMtC5LQoWKG5FP5su
	ctlaRRisjeF0emWFo3ngQzvRLTmw1yIt430PSbYuyEwBoHWBtvu8Y0XzxmniIUKR
	z52qUtz+SOR+DI8CA3+tGteuqh9fSnTXIP2ACHyoBdypyy9ad1zayFAcR60+5boo
	385vnkHmAXhaiAvqrBswEft6TrOhkV07Lm9MqnFxkzOWVXXNOGenfLnui25D0iEq
	UbfQb5/dfyXEAB60v2+dC1IbHMSWNZhlsCPtbo/+302uT3RYgg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjjjj3425-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:33:56 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40CFXqno032668;
	Fri, 12 Jan 2024 15:33:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3veyxnj2y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Jan 2024 15:33:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CFXp1v032660;
	Fri, 12 Jan 2024 15:33:51 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40CFXpi3032657;
	Fri, 12 Jan 2024 15:33:51 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
	id 5435E572C41; Fri, 12 Jan 2024 21:03:50 +0530 (+0530)
From: Nitin Rawat <quic_nitirawa@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V1 0/2] Refactor phy powerup sequence
Date: Fri, 12 Jan 2024 21:03:46 +0530
Message-ID: <20240112153348.2778-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: fV1al1rQQFm9ktPOmNbbSJEkyTvavawf
X-Proofpoint-GUID: fV1al1rQQFm9ktPOmNbbSJEkyTvavawf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=424
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120121

Refactor phy_power_on and phy_calibrate callbacks.

In Current code regulators enable, clks enable, calibrating UFS PHY,
start_serdes and polling PCS_ready_status are part of phy_power_on.

UFS PHY registers are retained after power collapse, meaning calibrating
UFS PHY, start_serdes and polling PCS_ready_status can be done only when
hba is powered_on, and not needed every time when phy_power_on is called
during resume. Hence keep the code which enables PHY's regulators & clks
in phy_power_on and move the rest steps into phy_calibrate function.

Since phy_power_on is separated out from phy calibrate, make separate calls
to phy_power_on and phy_calibrate calls from ufs qcom driver.

Also for better power saving, remove the phy_power_on/off calls from
resume/suspend path and put them to ufs_qcom_setup_clocks, so that
PHY's regulators & clks can be turned on/off along with UFS's clocks.

This patch series is tested on SM8550 MTP, SM8350 MTP and SA8775p.

There is functional dependency between ufs-qcom and phy-qcom-qmp-ufs
and hence both the patches should be part of same merge window.

Nitin Rawat (2):
  scsi: ufs: qcom : Refactor phy_power_on/off calls
  phy: qcom: Refactor phy_power_on and phy_calibrate callbacks

 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 183 +++++++++---------------
 drivers/ufs/host/ufs-qcom.c             | 104 +++++++++-----
 drivers/ufs/host/ufs-qcom.h             |   4 +
 3 files changed, 139 insertions(+), 152 deletions(-)

--
2.43.0


