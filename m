Return-Path: <linux-kernel+bounces-19310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C083F826B44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1A1F21229
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CC13AED;
	Mon,  8 Jan 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUTZFRtA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D9134A9;
	Mon,  8 Jan 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086N2Fn026671;
	Mon, 8 Jan 2024 09:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=4AG70ZZD8AAH
	D2Fs+zR905tqXlX/qaQrZbUl1GaL3Zk=; b=hUTZFRtAPMxAYdiuhvI1JH4vz3Lq
	pHQ07bQqItg11TtDaCqfbprCGOZ94jS4IdqlYpQ2vaZldThWRIc4UDvC2qZFySl3
	dgzHhW166tZoiYTlgWW9sTISAzeCn6EIp1HUSdZpcY2rVkW3HyMK37gVjSPJ87wG
	jzIS9TpCi9zzMOlBq3wO/T5BcFvLAfSW+FhVkGrXFOTJ7ZTPwodcKdgci375FN4R
	+GgKakvF5fqPA1bk156a3/EvcGGbHv2vhYEOXL11uYbPOK8/Y5pNNYA+odTvssOl
	KTUrXYeheiAbP94sFmbAIMqO3OB+EAyn2afXlAT82iDLRKV2Kd9TQEAD1A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8mw8qmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:59:16 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4089xDUu022553;
	Mon, 8 Jan 2024 09:59:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3veyxkkdk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 08 Jan 2024 09:59:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4089xCXc022537;
	Mon, 8 Jan 2024 09:59:12 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4089xCSt022533;
	Mon, 08 Jan 2024 09:59:12 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id 37F2B5001CB; Mon,  8 Jan 2024 15:29:11 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        sumit.semwal@linaro.org
Subject: [v2 0/2] Add support for Novatek NT36672E LCD DSI panel
Date: Mon,  8 Jan 2024 15:29:00 +0530
Message-Id: <20240108095902.22725-1-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPA-baj-yxhNRL88lHf2TJV5ZpI0aEeD
X-Proofpoint-ORIG-GUID: EPA-baj-yxhNRL88lHf2TJV5ZpI0aEeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=661 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for the 1080x2408 Novatek NT36672E LCD DSI mode panel
found on the Qualcomm QCM6490 MTP board.

The driver will come with the uncompressed video mode support.

---
v2: Fixed review comments from Krzysztof
      - renamed to novatek,nt36672e, since the driver is for the IC and
        not the panel. Adjusted internal function names to reflect the same.
      - updated dt-bindings.
---

Ritesh Kumar (2):
  dt-bindings: display: panel: Add Novatek NT36672E LCD DSI
  drm/panel: Add support for Novatek NT36672E panel driver

 .../display/panel/novatek,nt36672e.yaml       |  66 ++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 643 ++++++++++++++++++
 4 files changed, 720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36672e.c

-- 
2.17.1


