Return-Path: <linux-kernel+bounces-5176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCF81879C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F9F286D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4818638;
	Tue, 19 Dec 2023 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A5iGsgYA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FA18623;
	Tue, 19 Dec 2023 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ794Gs022908;
	Tue, 19 Dec 2023 12:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=NawkK+6zy7f2PHuiiEWPPizPr1GY7iL4+ANOhbIBr24=; b=A5
	iGsgYAB9IulXPv8qIjiNFJjEAnPAzXSadoBF0mcDcLqxHpe1XqlrSvPSOhG9LM8P
	fWJR8vzUEavJYLzI7EWaa0okX4vyyHrrovChdZ+TMUxez5cmgBKMfslVSE8BCMEg
	Cg7GqxJ+4MQsEKBC1Cje5eZO6UZny5JKr/C6DVUCCdg6y1pgKLXe9Piud2mzpjx8
	Hy1RjYYs+6ZTHHKSq+iEO4W/nmuOdyuR4WOhYhesJnJyD493fqt/3nt5uCOUKk2X
	f5XxpqXETEPzq1oChEtK9XnXejePl1O3v6JhJGaIIES0jUmeP+kXm0eb6n4047Yr
	A5JYT2F6fNUgGRNFRYzg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v34bj95c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 12:37:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJCbjAg021044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 12:37:45 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 04:37:40 -0800
From: Maramaina Naresh <quic_mnaresh@quicinc.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias
 Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V6 0/2] Add CPU latency QoS support for ufs driver
Date: Tue, 19 Dec 2023 18:07:04 +0530
Message-ID: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dLMfhtIfVGhVU1qbDhObTZkch_cbmNJC
X-Proofpoint-ORIG-GUID: dLMfhtIfVGhVU1qbDhObTZkch_cbmNJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=716 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190094

Add CPU latency QoS support for ufs driver. This improves random io
performance by 15% for ufs.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 37101.3
	Random Write(IPOS) | 41065.13

2. With PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 42943.4
	Random Write(IPOS) | 46784.9
(Improvement with PM QoS = ~15%).

This patch is based on below patch by Stanley Chu [1]. 
Moving the PM QoS code to ufshcd.c and making it generic.

[1] https://lore.kernel.org/r/20220623035052.18802-8-stanley.chu@mediatek.com

Changes from v5:
- Addressed bvanassche comment to use kstrtobool instead kstrtou32
- Addressed bvanassche comment to add sys attribute into an existing group

Changes from v4:
- Addressed angelogioacchino's comment to update commit text
- Addressed angelogioacchino's comment to code alignment

Changes from v3:
- Removed UFSHCD_CAP_PM_QOS capability flag from patch#2

Changes from v2:
- Addressed bvanassche and mani comments
- Provided sysfs interface to enable/disable PM QoS feature

Changes from v1:
- Addressed bvanassche comments to have the code in core ufshcd
- Design is changed from per-device PM QoS to CPU latency QoS based support
- Reverted existing PM QoS feature from MEDIATEK UFS driver
- Added PM QoS capability for both QCOM and MEDIATEK SoCs

Maramaina Naresh (2):
  ufs: core: Add CPU latency QoS support for ufs driver
  ufs: ufs-mediatek: Migrate to UFSHCD generic CPU latency PM QoS
    support

 drivers/ufs/core/ufs-sysfs.c    | 49 ++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c       | 50 +++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-mediatek.c | 17 -----------
 drivers/ufs/host/ufs-mediatek.h |  3 --
 include/ufs/ufshcd.h            |  6 ++++
 5 files changed, 105 insertions(+), 20 deletions(-)

-- 
2.17.1


