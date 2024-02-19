Return-Path: <linux-kernel+bounces-71697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78485A91E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC228355E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB340BE7;
	Mon, 19 Feb 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HGAVD8yE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BB405D3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360821; cv=none; b=b0euAqqoDAwJ2xLOZjCKzjVl4XK8lyC1NkJS0ufHSBKzinRHrS2wApLcCFO4BjZDfOp0mGnRJaa2TrNgxzFw6AN4e4QusCfowft/FFXM8/j3duGDMO6h4ErpvNha3EwECdN2kctCAqbbIMJ3qnoHDNR2HEdvaxoKbyP3rExXJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360821; c=relaxed/simple;
	bh=JzgpMbb5vfhhk7STctFxuswkVJQw83y6pxdVZBYT7nE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j7KrpBeinGtk/h/DirUDuMT1lapc/D8qPPVVBmBp2IJp52OCjGoYJlA0WRga00RvyyjBWHxE6rd3zSi+Y1UwaDVxBU3HnLVO5id0pllluJQ/ab5tZbjzN3zRBsyoIXrbtlljBfH+ZJZVnnbI9mYAamzJSiWJMJt7DilB5ogFlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HGAVD8yE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JDh20N004975;
	Mon, 19 Feb 2024 16:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=YsBlBje
	RtZ5nUFLrFLHaUA8DOFE+PkpC+n1Iaw3boDk=; b=HGAVD8yE+KTApMsJv5XADxc
	TGl5QNyXuEHvm7WKLHsFzvOVC/cBDZ6DJfdpwUzGnSSJpdq313KdzGdmGn8FSGEK
	BypinMZXLn2ub3ddipqma47znQkfmZB0Jztc5UtnbJRmqkY5/V2XvJwIR0LnF2wX
	S4jiyN6AoW7ep73hMudvPVnHhlseVUTNnCn2SYB6MRCvF9rmHkk+9ZSTYP/pTWbE
	GMrKA/zjLHCLlxTLWLzEAuMxGvaDU6RkRnTjENt0n1mBgdq2hUoyIkh4zIz+Sv0x
	/3qRwo5n00miyuTPNPuG2YdNBI8+ipHNncABcIsMAQzI322AlLADK51/NAwohhA=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc4qx0w88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:40:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41JGeAeh013079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:40:10 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 08:40:08 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] firmware_loader: Suppress warning on FW_OPT_NO_WARN flag
Date: Mon, 19 Feb 2024 22:09:54 +0530
Message-ID: <20240219163954.7719-1-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E6y-MUpSL30mpFFAnTPSTvUl-6IbqTeN
X-Proofpoint-ORIG-GUID: E6y-MUpSL30mpFFAnTPSTvUl-6IbqTeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=961 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190124

Some of the warnings are still being printed even if FW_OPT_NO_WARN
is passed for some of the function e.g., firmware_request_nowarn().
Fix it by adding a check for FW_OPT_NO_WARN before printing the warning.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ea28102d421e..da8ca01d011c 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -551,12 +551,16 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 						       file_size_ptr,
 						       READING_FIRMWARE);
 		if (rc < 0) {
-			if (rc != -ENOENT)
-				dev_warn(device, "loading %s failed with error %d\n",
-					 path, rc);
-			else
-				dev_dbg(device, "loading %s failed for no such file or directory.\n",
-					 path);
+			if (!(fw_priv->opt_flags & FW_OPT_NO_WARN)) {
+				if (rc != -ENOENT)
+					dev_warn(device,
+						 "loading %s failed with error %d\n",
+						 path, rc);
+				else
+					dev_dbg(device,
+						"loading %s failed for no such file or directory.\n",
+						path);
+			}
 			continue;
 		}
 		size = rc;
-- 
2.43.0.254.ga26002b62827


