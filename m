Return-Path: <linux-kernel+bounces-50138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A230B8474BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6429060C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203EA148301;
	Fri,  2 Feb 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WQ/63cc8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC046B8;
	Fri,  2 Feb 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891473; cv=none; b=Exdj93Ex/hKwobnhRGjZVnLFQLbxBVkzAv3fBbvzEAZl0KeCVvdItE4uOVy2X+kIlYRm8bgkJmWxMZ5OeFLkfXCRhkmcm4ahQ5jDnybP/iFz27dNmQQRUzyV07Fg5l+jI6M8zgv++u6Avq/BQVqPTT0UouvvARtHiOC7HU1sxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891473; c=relaxed/simple;
	bh=yKgE/9g7vRyNy30moyBXyF8aGfIwx1dSSGfkPJHiizQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgDsu9G+FDU5eHPZK+Dqk16jAT6HOPoZ4vMetsjKy4xz2MSv/QvQBIzTRjdHK9YlPvBqyKfJMLvvixWf0a1k/3MRnMMQCglPcXqGs4v+bdxYCv8ods1xqCsppWUWBx18dS6pLkCj8rt+LM04mFtsE62LcxIAYeUe/yY4lQP2n/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WQ/63cc8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412DvFgF002570;
	Fri, 2 Feb 2024 16:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=z22DRcp
	b18EG3CYYYQQ2JSvxQk/U5MOIshn0k8Bbp50=; b=WQ/63cc8AjuksePMV8uIcoA
	f2/mYRa0vpwxL6ApSczRJZaiGr4kVcbw1W9nd4D/ef3LXI8C9wCiazUbLUkGfDpj
	eXMTh+WnOHMlwHb+rYmGE3T0wwzYEf2dpjiNgxfH/ovOkmkRAE6gm1fEid8Ii49v
	6odudk1riWnlZ6dVkcDm2YUexkRStjMyGASTQyOa/PWxSJKpm0uZ5Nz6LVAq7ydz
	g+5a3siLnVm+mJ8g0cDzNz26irSwF+L6LQCGGb6YWJ1GcHvKYg/JnOLZSM2mp/Rk
	pQPaD2EMGcMHDhQHqnu2O4YPOBbvq16i0WORVSCbuv+z8B1E0qXrDVYADlbBh0A=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvhuff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:31:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412GV8Pm029920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 16:31:08 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 08:31:07 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <adrian.hunter@intel.com>, <ritesh.list@gmail.com>,
        <quic_asutoshd@quicinc.com>, <quic_bjorande@quicinc.com>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] MAINTAINERS: Update bouncing @codeaurora addresses
Date: Fri, 2 Feb 2024 09:30:38 -0700
Message-ID: <20240202163038.4080702-1-quic_jhugo@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YuGQw5Q0EFASQlS0bYrK1Rat7uABXYQo
X-Proofpoint-ORIG-GUID: YuGQw5Q0EFASQlS0bYrK1Rat7uABXYQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=413 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020119

The @codeaurora email domain's servers have been decommissioned for a
long while now, and any emails addressed there will bounce.

Asutosh has an entry in .mailmap pointing to a new address, but
MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
to match .mailmap for anyone reading the file directly.

Ritesh appears to have changed jobs, but looks to be still active in the
community.  Update Ritesh's address to the one used in recient community
postings.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e5dfd169a19..ac7e524cd8f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7803,8 +7803,8 @@ F:	drivers/media/usb/em28xx/
 
 EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
-M:	Ritesh Harjani <riteshh@codeaurora.org>
-M:	Asutosh Das <asutoshd@codeaurora.org>
+M:	Ritesh Harjani <ritesh.list@gmail.com>
+M:	Asutosh Das <quic_asutoshd@quicinc.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/cqhci*
-- 
2.34.1


