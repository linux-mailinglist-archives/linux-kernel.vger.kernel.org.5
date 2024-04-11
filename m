Return-Path: <linux-kernel+bounces-140458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AF8A14E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F4B2896FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24021143C76;
	Thu, 11 Apr 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dzGsU5Fe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AA1E4A0;
	Thu, 11 Apr 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839589; cv=none; b=bwSBSQc73QayqHgLue7Hts4Pph4VmwQVpqaCf3my/9cjNy+hhWmsu4RQlt9vXQfjycQ6EEP9pUspYraaZKGvVU6Zci5ZTrrFIdoqsD8NsRa45XJcl3M8HH0GSP7LniIYdHgQQQRk/GGpfAQs4MH0rZjcLz2QYTbc1+ZNV15wHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839589; c=relaxed/simple;
	bh=0HBx/V3ie6EYfvZeus2BhytdEBFjKVzzxd71k0El80k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmcvizDfzNueTBMEIV680NX+H8IB/NHYvvQOi26bMIWwlRQUkDl005cPb5/8n/ceBmilOA32Rj4OmRWZeRaFjr1wvujeqD1B6oyGdl/jC0T9S7XLzPv9xZUEs+YHU/efsRuzEUe9lvcTpVQDOH1uzYdKH2Wdnn0nuZJkjKuAvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dzGsU5Fe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BAnMO3011841;
	Thu, 11 Apr 2024 12:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=up4cLKg
	7EE/kMScgPBOrCCRKmY4MNpxpojlOjsxtvV4=; b=dzGsU5FeM4mmlqA6msalEi6
	dhOhKHS6SEbC0ZepW+o6Ncd9oC5IiTM4mFFGouWaLVNQCL9zixmQviNiZGWAl+QU
	fQ93rs0Gd8Rs7db2N1xB/1vYnxBYlo1nYSKePIwG0nh7bhj+LbgWjXlEHDJmCtbW
	qf1/K9P2BHUkz6+rLUWT1cKyl0N3dIY7nwBc5FfplCL9agg8NYQcjHi2mF8SXnl3
	gXKRlwKbZpwkN4SWpErRR7wUoMtQI2l8SdzC9+q1DbxX0Ai6aXfgMVlHKsxs779G
	+utM0P16NmUGlJxXa8iYj6rIygc3Z80SySCcq7RO7BFDhu89Hl4IJS0iCGq/T7Q=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6dh2w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BCkJQt024040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:19 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 05:46:16 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v3 0/8] Move camss version related defs in to resources
Date: Thu, 11 Apr 2024 15:45:35 +0300
Message-ID: <20240411124543.199-1-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ia4MSDh51Qy-ygPSaCBhYNwyfCb1XMd1
X-Proofpoint-ORIG-GUID: Ia4MSDh51Qy-ygPSaCBhYNwyfCb1XMd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110093

The different resources required for different camss soc versions are
split in to two groups:

1. Camss device related. In this group are all resources described
in the device tree, clocks, regulators etc.

2. Sub-device specific resources. In the initialization
of the each sub-device, the version of camss is passed.
Based on this version the sub-device adds: hw layer support,
per pad formats, number of dma's etc.

The code for "1" group lives in camss.c. However the "2" group
is spread across all sub-device implementations including video device.

This kind of separation is not very convenient when adding new camss soc
version. The reason is that you need to add support in all sub-device
implementations.

There were some improvements in this direction where some of the
hw version related definitions were moved in to the "1". One
example is attaching of the hw operations.

This series aim to improve the things more and add additional definitions
in to the "1".

What is included:

- Remove all format definitions from camss video. The will be passed
  by the parent sub-device

- Make camss generic format definition mapping, containing mbus to
  v4l2 mapping, mbus bpp and other required fields used by the
  sub-device and video node.

- Add per sub-device type union in the resources, different
  sub-devices are using different resources, as an example: is_lite flag.

- Move camss link operation in to the resources. Currently one
  function supports different topologies depending of the number
  of devices. As hw version support increases this is not good
  way of supporting different topologies.

- Add parent device ops in to the resources. This resolves
  inter-dependencies of vfe and csid. Csid requests the clocks
  regulators etc from parent device instead calling directly vfe
  functions.

- Some cleanups in csid code for split the configuration of
  RX and testgen and RDI.

Changes in V3:
- Incorporate missing changes in resources reported and fixed by
  Bryan O'Donoghue <bryan.odonoghue@linaro.org> taken from the branch:
  https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/sc8280xp-6.9-rc1-camss-resource-change-verification?ref_type=heads
- Added missing signed-off to the changes submitted by me.

Changes in V2:
- Rebased on top of sc8280xp v6.
- The change "Designate lite subdevices in resources" was dropped,
  it was already merged in previous series.

Atanas Filipov (1):
  media: qcom: camss: Decompose register and link operations

Milen Mitkov (2):
  media: qcom: camss: Split testgen, RDI and RX for CSID 170
  media: qcom: camss: Decouple VFE from CSID

Radoslav Tsvetkov (5):
  media: qcom: camss: Add per sub-device type resources
  media: qcom: camss: Attach formats to VFE resources
  media: qcom: camss: Attach formats to CSID resources
  media: qcom: camss: Attach formats to CSIPHY resources
  media: qcom: camss: Move format related functions

 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../platform/qcom/camss/camss-csid-4-1.c      | 132 +---
 .../platform/qcom/camss/camss-csid-4-7.c      | 160 +---
 .../platform/qcom/camss/camss-csid-gen2.c     | 410 ++++------
 .../media/platform/qcom/camss/camss-csid.c    | 512 +++++++++++-
 .../media/platform/qcom/camss/camss-csid.h    |  32 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  74 +-
 .../media/platform/qcom/camss/camss-csiphy.h  |  23 +-
 .../media/platform/qcom/camss/camss-format.c  |  98 +++
 .../media/platform/qcom/camss/camss-format.h  |  67 ++
 .../media/platform/qcom/camss/camss-vfe-17x.c |  10 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   4 +-
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   6 +-
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   6 +-
 .../platform/qcom/camss/camss-vfe-gen1.c      |   8 +-
 drivers/media/platform/qcom/camss/camss-vfe.c | 483 +++++++-----
 drivers/media/platform/qcom/camss/camss-vfe.h |  22 +-
 .../media/platform/qcom/camss/camss-video.c   | 295 +------
 .../media/platform/qcom/camss/camss-video.h   |   5 +-
 drivers/media/platform/qcom/camss/camss.c     | 729 +++++++++++++-----
 drivers/media/platform/qcom/camss/camss.h     |  28 +-
 21 files changed, 1767 insertions(+), 1338 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.h

-- 
2.17.1


