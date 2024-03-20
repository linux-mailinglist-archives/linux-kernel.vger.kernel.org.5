Return-Path: <linux-kernel+bounces-108956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D688127E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4B2869D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4247F48;
	Wed, 20 Mar 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fs/pI/jS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B211CD1D;
	Wed, 20 Mar 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942175; cv=none; b=FcLVOnGknZz1W3ZHxF+eY0+AsqNXbAbZ1kwMCzJF4w8JufDrUt5s+DV1tHh2QV158VcrTpjMpuFAPdNgANzOPhsgYZ1hApnTRuYp2zBjJkCkL6ACyj+mJjW3fCMn2fQwOIH/eMi+gdqoElOTRE1Z7LiWdJxo5GGaNEgmqapdJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942175; c=relaxed/simple;
	bh=AH7TDRqzam+wc6fjabuqQvfYB0R0X9EFttJ6umY4PSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sl3ZtGoL/DZpSn6WK0diLavyTHT4AxjYr0FlmN7dMRh2cuBlnGU3CJb9R6Rgkn33SbJoqnnvzV1ats3FDTMS6gX1qxiX6HdA9SWBFdKWBC5BdOY1PfnCkZp78qQZDGtnS+9b5DynovGJ0Aa/oo22fYQfmOk2N8Sx0vzfjFpQrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fs/pI/jS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KBj2LR018340;
	Wed, 20 Mar 2024 13:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=uBlYCP3C3SsY5VY7iT+E
	kSZrVAy7mvH1RiFc+YVnXWs=; b=fs/pI/jSlJ3k9yDvQYIFFV66BXQgClx281cs
	N2/R2+P7hGaBclpkdIeKGJzWNSO//JGUld99YwUfAV5iozVE3v3IgdHHSIGymKpb
	6e1GYTKZtgJLldVD8jqQXHe6sQXtDmBkG2VHvHVz9bFA+9x7mpWo2VK8WKD4IpbA
	dZz1UquuHD3VduhwH2mbGz2psn6eBsHFNTluO9BiSfGL/SfCLLs3U4If5lluwCyk
	/ZLvMSRwrd8jMGoIcrU492gMl54+orXVpfzpv/X3396x9tZ1jY2w+PAp3KDaaC+e
	2rexs7wN24j5xX/06eZOKnHwcJncjOBZkp/kecjjaa6Y0MvPlA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyxq90aks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDglHC018116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:47 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:42:44 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 0/8] media: qcom: camss: Add sm8550 support
Date: Wed, 20 Mar 2024 19:12:19 +0530
Message-ID: <20240320134227.16587-1-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QWba4sJliUw1Gsk6Xdg3aWU3CO0qUDL5
X-Proofpoint-GUID: QWba4sJliUw1Gsk6Xdg3aWU3CO0qUDL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=852
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200107

SM8550 is a Qualcomm flagship SoC. This series adds support to
bring up the CSIPHY, CSID, VFE/RDI interfaces in SM8550.

SM8550 provides

- 3 x VFE, 3 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE
- 3 x CSID
- 2 x CSID Lite
- 8 x CSI PHY

This series is rebased based on：
https://patchew.org/linux/20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org/

The changes are verified on SM8550 AIM300 board, the base dts for AIM300 is
https://patchew.org/linux/20231117101817.4401-1-quic._5Ftengfan@quicinc.com/

Depeng Shao (3):
  media: qcom: camss: Add new params for csid_device
  media: qcom: camss: Add CSID gen3 driver
  media: qcom: camss: Add sm8550 support

Yongsheng Li (5):
  media: qcom: camss: Add CAMSS_8550 enum
  media: qcom: camss: Add subdev notify support
  media: qcom: camss: Add new csiphy driver 2-1-2
  media: qcom: camss: Add new VFE driver for SM8550
  media: qcom: camss: Add sm8550 resources

 drivers/media/platform/qcom/camss/Makefile    |   3 +
 .../platform/qcom/camss/camss-csid-gen3.c     | 639 ++++++++++++++++++
 .../platform/qcom/camss/camss-csid-gen3.h     |  26 +
 .../media/platform/qcom/camss/camss-csid.c    |  19 +
 .../media/platform/qcom/camss/camss-csid.h    |  10 +
 .../platform/qcom/camss/camss-csiphy-2-1-2.c  | 343 ++++++++++
 .../media/platform/qcom/camss/camss-csiphy.c  |   1 +
 .../media/platform/qcom/camss/camss-csiphy.h  |   3 +
 .../media/platform/qcom/camss/camss-vfe-780.c | 455 +++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c |   7 +
 drivers/media/platform/qcom/camss/camss-vfe.h |   3 +
 .../media/platform/qcom/camss/camss-video.c   |   1 +
 drivers/media/platform/qcom/camss/camss.c     | 395 +++++++++++
 drivers/media/platform/qcom/camss/camss.h     |   8 +
 14 files changed, 1913 insertions(+)
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-780.c

-- 
2.17.1


