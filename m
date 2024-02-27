Return-Path: <linux-kernel+bounces-83219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE461869067
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C38B2ABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBC13B28B;
	Tue, 27 Feb 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QiXTSOo7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0D13A273;
	Tue, 27 Feb 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036690; cv=none; b=DBJGp+dz5d1vwaeLp+mudSKqjTX6I7fAf+3G1L1x9ARrEymPcwprz2B4zwFYy4u8ILzDh4PAGkiaimRBOvQzx8wTCiwKcU1UBOwVZ0LxaPNKlqbNQCy/DuElc/QsfbcG1hVUariKWAq4iRUNc4eYpEljTReTyhEX9/23+7gULro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036690; c=relaxed/simple;
	bh=aVwTDpgYEdrZI3vDH6C4TNu2Fx5LABUkuIt5XlkGYq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pHakDffHSgHCPyxJLDnJGXiEVk1aSQFA/Gx/yfssDleLNQq7WdENLz2ULXpH7LxyUnj3mx+Cc5x+DZLN4gtq/fkyCLVkYAlVRTPqhhVOv3ba3emWwfYHZ1sOo5zX4A1RIu+JiSaGx6ciVuZRSjsUBVqOM8hLZ/UPPRPXMyFqHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QiXTSOo7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9YfbS000519;
	Tue, 27 Feb 2024 12:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IE0VW1j
	h448aXmao0Jg+0epM3kKiquSK6nql7Ie2IiI=; b=QiXTSOo708baJAvVb21hQKP
	TOBdJL+Tct79R0Ufi4KMUV2gwvbvfqhEHme2KnoM35HIvTjEvX0au/IkefuCkvet
	gVo/cwx9o8eBHnBOy8bhLsgVkQ2MRWQg6uOr1MeKGAC+A5E0kP2yfleD1uU/T/tH
	FcNSYjwzn9ve92ZW8dQKp9YZ9TRV1p9zRoYYrWGS667xLNVnr8JAf2IGdQe5HWqe
	fOjb1Egp3cWzp19apgiJkk5LsYNyu1trolep4qT9XHL+AzGYnjAXUctikvn9vArY
	vMVoCH/HqaDzWYG+PSpqspwgHyWQomfyy11Tk979CXk1a7OyYUlL9sAhy2nc5fA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrh5f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:24:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RCOfwQ012738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:24:41 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 04:24:38 -0800
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH 0/9] Move camss version related defs in to resources
Date: Tue, 27 Feb 2024 14:24:06 +0200
Message-ID: <20240227122415.491-1-quic_grosikop@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DPlZSTGkA2ZjpVmzaoz_y-UkkIArSU5m
X-Proofpoint-ORIG-GUID: DPlZSTGkA2ZjpVmzaoz_y-UkkIArSU5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=938 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270097

The different resources required for different camss versions are
split in to two groups:

1. Camss device related. In this group are all resources described
in the device tree, clocks, regulators etc.

2. Sub-device specific resources. In the initialization
of the each sub-device, the version of camss is passed.
Based on this version the sub-device adds: hw layer support,
per pad formats, number of dma's etc.

The code for "1" group lives in camss.c itself. However the "2" group
is spread across all sub-device implementations including video device.

This kind of separation is not very convenient when adding new hw
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

Atanas Filipov (1):
  media: qcom: camss: Decompose register and link operations

Milen Mitkov (3):
  media: qcom: camss: Designate lite subdevices in resources
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
 .../platform/qcom/camss/camss-csid-4-7.c      | 160 +----
 .../platform/qcom/camss/camss-csid-gen2.c     | 410 +++++--------
 .../media/platform/qcom/camss/camss-csid.c    | 512 +++++++++++++++-
 .../media/platform/qcom/camss/camss-csid.h    |  32 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  73 +--
 .../media/platform/qcom/camss/camss-csiphy.h  |  23 +-
 .../media/platform/qcom/camss/camss-format.c  |  98 +++
 .../media/platform/qcom/camss/camss-format.h  |  67 ++
 .../media/platform/qcom/camss/camss-vfe-170.c |  10 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   4 +-
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   6 +-
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   6 +-
 .../platform/qcom/camss/camss-vfe-gen1.c      |   8 +-
 drivers/media/platform/qcom/camss/camss-vfe.c | 483 +++++++++------
 drivers/media/platform/qcom/camss/camss-vfe.h |  22 +-
 .../media/platform/qcom/camss/camss-video.c   | 294 +--------
 .../media/platform/qcom/camss/camss-video.h   |   5 +-
 drivers/media/platform/qcom/camss/camss.c     | 577 +++++++++++++-----
 drivers/media/platform/qcom/camss/camss.h     |  28 +-
 21 files changed, 1656 insertions(+), 1295 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-format.h

-- 
2.17.1


