Return-Path: <linux-kernel+bounces-27021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514582E948
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CBE28560D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C4F9F6;
	Tue, 16 Jan 2024 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PG8Q6D3y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9610A05;
	Tue, 16 Jan 2024 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G5nMma009648;
	Tue, 16 Jan 2024 05:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=HvhkSfs
	4OWQhwFT+pyBuEHGhB1zniyzSVAICUYt6Mok=; b=PG8Q6D3yqAIGO0XRfqCbA9t
	MU4uo6Y0B9fGXFDW6o/h7YzyOCNCSCvs7D+EPH5dICHzW98P9VzpOP59amaOZZtx
	ITTwBbCg7Geur3vjFdkbSNPcOZMua7sHg/9Q4DhjtpCyf8WpJdUU0c98tb0+jZDJ
	cmCNkJc5dIVERtGCXqxQcshs43VRXk8Npf6AMpRdPuPKsDZOVhW2KmmWJqehn5oR
	TJbYTZ/1Gmn7p6SGDeADvfGuo9dHeLz7l/KvDGQ4YlbNfcLH/okSlTlktnNHizNM
	xDnBNKeha9/TZRfNv39W3rfwX2V0KvZCFbI3WIERdDLAPuzEQHk9wgPGX85xDww=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn28shyay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:58:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G5wTK0027507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:58:29 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 21:58:26 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v3 0/2] Set XHCI_SG_TRB_CACHE_SIZE_QUIRK for DWC3 devices
Date: Tue, 16 Jan 2024 11:28:14 +0530
Message-ID: <20240116055816.1169821-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lq_s_F1wyhOuXSBQu4LYSBiSIV4N6lNV
X-Proofpoint-ORIG-GUID: lq_s_F1wyhOuXSBQu4LYSBiSIV4N6lNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=514 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160044

XHCI_SG_TRB_CACHE_SIZE_QUIRK was introduced in XHCI to resolve
XHC timeout while using SG buffers, which was seen Synopsys XHCs.
The support for this isn't present in DWC3 layer, this series
enables XHCI_SG_TRB_CACHE_SIZE_QUIRK since this is needed for
DWC3 controller.

In Synopsys DWC3 databook,
Table 9-3: xHCI Debug Capability Limitations
Chained TRBs greater than TRB cache size: The debug capability
driver must not create a multi-TRB TD that describes smaller
than a 1K packet that spreads across 8 or more TRBs on either
the IN TR or the OUT TR.

More information about this XHCI quirk is mentioned on the
following thread.
https://lore.kernel.org/all/20201208092912.1773650-3-mathias.nyman@linux.intel.com/

Changes in v3:
Updated the props[] array size from 4 to 5 in dwc3/host.c

Changes in v2:
Changed implementation using device property instead of priv_data
Split the single patch into 2 patch series, v1 is mentioned below
https://lore.kernel.org/all/20231121135936.1669167-1-quic_prashk@quicinc.com/

Prashanth K (2):
  usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK
  usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK

 drivers/usb/dwc3/host.c      | 4 +++-
 drivers/usb/host/xhci-plat.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1


