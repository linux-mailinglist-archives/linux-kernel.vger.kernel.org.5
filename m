Return-Path: <linux-kernel+bounces-18699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31B82614C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48421C21778
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E0E57C;
	Sat,  6 Jan 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mkzBSV6h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06783DF4C;
	Sat,  6 Jan 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 406J28af002663;
	Sat, 6 Jan 2024 19:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=WKPh7IvIQvD2msUo8q8oDJlSIRzNpjO+foZ7NbVBD7Y=; b=mk
	zBSV6hRIGDBTvzZVt6pO7ERtsyePf6+pqA2Z3kf2O/V8etCmXaV6XZ5zhV3xDVfT
	SP/s2ZNL9M9Por2qoZm5p0XGDB5ATwg8W4r44rEtzZeA+FHPveLEeuoiqcrUGj/D
	u9NwbaTNPHBlGC3xqjyywOLBAWE8HPmBWcA1NkpKeZiUQzV3JbpfisQR2JuhEGEZ
	oXMnkVGSORjVMyLkEocyeJPDAUVPmnpJ/s4VlAU36hG/Elx6VcXoKAT0HBRXg5zH
	sxO8NCJCYv8HwS5NADSTeD3GkwhHTka9U2A+42xAhMhW9ejJNsoC+MuHeRotWZFU
	mk2/12cN7wMfSe9zF4pA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3veymm91kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 19:15:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 406JFPqH030897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Jan 2024 19:15:25 GMT
Received: from codeaurora.org (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 6 Jan
 2024 11:15:23 -0800
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf
 Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH] thermal/sysfs: Always enable hysteresis write support
Date: Sun, 7 Jan 2024 00:45:02 +0530
Message-ID: <20240106191502.29126-1-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mqo0o9bUz5b5aII9FhGjleUms7yd-vG9
X-Proofpoint-GUID: Mqo0o9bUz5b5aII9FhGjleUms7yd-vG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=748 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401060128

The commit 2e38a2a981b2("thermal/core: Add a generic
thermal_zone_set_trip() function") adds the support to update
trip hysteresis even if set_trip_hyst() operation is not defined.
But during hysteresis attribute creation, if this operation is
defined then only it enables hysteresis write access. It leads
to a case where hysteresis sysfs will be read only for a thermal
zone when its set_trip_hyst() operation is not defined.

Fix this by removing the check whether set_trip_hyst() operation
is defined or not during hysteresis attribute initialization.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/thermal_sysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index eef40d4f3063..08be016d7221 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -504,13 +504,9 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
 		tz->trip_hyst_attrs[indx].attr.attr.name =
 					tz->trip_hyst_attrs[indx].name;
-		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO | S_IWUSR;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
-			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_hyst_attrs[indx].attr.store =
-					trip_point_hyst_store;
-		}
+		tz->trip_hyst_attrs[indx].attr.store = trip_point_hyst_store;
 		attrs[indx + tz->num_trips * 2] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}


