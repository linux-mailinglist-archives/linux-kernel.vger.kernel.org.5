Return-Path: <linux-kernel+bounces-59587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF584F95D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4D51F21C19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF926F06C;
	Fri,  9 Feb 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J85cVTFp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AB692FC;
	Fri,  9 Feb 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494994; cv=none; b=U2Wu8MRaXCoklTlXE6rl14qJuHu30tg+CuWUoyBzDhAvpHFfBZl+XIcNuRP48NsWpL1Rd5/McaWOLOFFWMpOfLtrUndqZNMMsoM3vvFhs0+ju+F9x/2/FPD+7IKQT3miiYq+3EHS1HsIfWC5vP82liXr/TNE0ejwEPiEccXz2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494994; c=relaxed/simple;
	bh=EUXzE+XV0Oj4ZZNXbzhOpzuz3ry8oK+NgmkISiGpxaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1DLZ0qr6h8AKFXmogvO4jddcjPJ0B77W/qsLeFZFUEBxZCFivAflWjcigoY4FraFdmw/S3Wv5VR0vYaA1TiUQFHoSgy2qJLyKw9TbjSeVvWfDm8XvUVvYgw5GCr9URfUIYnFdjvm9mZ3ke0s5eJR/oQxbikghXGWESH9P7w5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J85cVTFp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419FDplQ009461;
	Fri, 9 Feb 2024 16:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=LjTE3A8
	lE4nDNt3ZeTTCb95wZLD7lbCAgOObtlD+fGw=; b=J85cVTFpxirgSclQkLmvOea
	JgwckbNRwZNVhjrnpCuDUFqRglXhuQdKpVXfPZ1pas+8eS8mKAqeAhfF+UBdBOAz
	OTRfGkvXR8QFAxFfpIV9GeqEmU+Y1lE4HMb1LFenCOBx6Mm0hhce4KZ7UvKpFgn+
	lrqTpgVEDzRsEmkobvcScK1eQOF70R6wnSNmJjZS3M21d8Sam7Xp3JSlvfJ7Dj5L
	2A3wm+MN2TcCgq7A7i2oiuYL4EwJus2zHbyjgMhgUIfl6p4LUAsu62tJVkra8K1V
	QAOh68OYkAoMOvXF5ERrttyMNw2SAklgmJlmcHZYphCZ3H2SkeFjWgwZw27q9CQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5pgpr429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 16:09:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419G9nSO013675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 16:09:49 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 08:09:48 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <adrian.hunter@intel.com>, <ritesh.list@gmail.com>,
        <quic_asutoshd@quicinc.com>, <quic_bjorande@quicinc.com>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2] MAINTAINERS: Update bouncing @codeaurora addresses
Date: Fri, 9 Feb 2024 09:09:34 -0700
Message-ID: <20240209160934.3866475-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2L590BeM-v4JjmVJM8zypswIPl5qHeVz
X-Proofpoint-GUID: 2L590BeM-v4JjmVJM8zypswIPl5qHeVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=500 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090119

The @codeaurora email domain's servers have been decommissioned for a
long while now, and any emails addressed there will bounce.

Asutosh has an entry in .mailmap pointing to a new address, but
MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
to match .mailmap for anyone reading the file directly.

Ritesh appears to have changed jobs, but looks to be still active in the
community.  Update Ritesh's address to the one used in recient community
postings.  Also Ritesh has indicated their entry should be changed from
Maintainer (M:) to Reviewer (R:) so make that update while we are making
changes to the entry.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---

v2: Change Ritesh to R: per Ritesh's suggestion

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4be2fd097f26..56b3311e51de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7832,8 +7832,8 @@ F:	drivers/media/usb/em28xx/
 
 EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
-M:	Ritesh Harjani <riteshh@codeaurora.org>
-M:	Asutosh Das <asutoshd@codeaurora.org>
+M:	Asutosh Das <quic_asutoshd@quicinc.com>
+R:	Ritesh Harjani <ritesh.list@gmail.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/cqhci*
-- 
2.34.1


