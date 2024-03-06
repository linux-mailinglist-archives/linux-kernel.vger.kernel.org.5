Return-Path: <linux-kernel+bounces-94508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED428740CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F132D1C20ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6A140E23;
	Wed,  6 Mar 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UEOayirL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0813F430;
	Wed,  6 Mar 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754652; cv=none; b=LJAQ4tcUlBd5hsJfqfi1VdOwYrs0P1zCki+DyEDeQT8D1M5tABk4J86A9xWFv0Pxms7p96R+/AwGPloan/ydViqbNlZp6lkLLEtJ1QBvBogiZYsLim3LV3z9fAjM8R9t6VpxMVk97sEEujS6naiXN0YrGVTU0VbMq1Z1YtgyHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754652; c=relaxed/simple;
	bh=3fA8gJPCiuKa/LhSe+6C5/QvoUfGPvYpezV5uQG1XT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AzChyoxEcI9NR0Npg8VYh30dc9T4i/6Tc67QjHvrUz0KgMt0zlwE2sXhxVP1sANXiW2TuIe1NolGXDRoDMEfCZE0YSPsaK4CzdVzG5+6FgPjvnPAljok8oBk0KJVbB73N9S2M6cmUahoSE3l47NAZnhJkFrDgtR3Nmy9vogvcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UEOayirL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426HS2cx011524;
	Wed, 6 Mar 2024 19:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cow2gXP
	FF/8lCz/5eh1CrmVLzXZTc3cY1rR9FaOT7/0=; b=UEOayirLC4D2LSZg51Tgnoo
	hRqIo9resNoZ72Z8b9oiHeTYEIXDht9KR75QEzXV4RW0DDtaVw93Y7+DuYEqWCmE
	tzKQDoKyqfGaJpZ/W5U8CTLj2hHKzpTlE2qK2kb+H+xKWw8TE3TQvK44Fk4sPG/G
	h3EHbBeSqhzDXA1zcuz8yAjSyRPHZV/qSzXly6caoUKLrSIbPd1ibmY63bNzJRUn
	sfVggdjZyD9PNFOro0UrQTeRhnZHj7KEvYYzrmdSGd2iHKhLAGz9/rgpNPCE0Jm1
	ry/u5/L1TvbQdlnOmiFYqP2U+pALvUQ2WZUhZfnWEzPywbEFpEfg/uw34vxkc5w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpvw60ag6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:50:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426JoefR022107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 19:50:40 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 11:50:39 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <swboyd@chromium.org>,
        <quic_jesszhan@quicinc.com>, <quic_parellan@quicinc.com>,
        <quic_khsieh@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] drm/msm/dp: move link_ready out of HPD event thread
Date: Wed, 6 Mar 2024 11:50:30 -0800
Message-ID: <20240306195031.490994-1-quic_abhinavk@quicinc.com>
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
X-Proofpoint-GUID: rdYwYO6FX7Vu3nL_dJP5r-hEyea_ge29
X-Proofpoint-ORIG-GUID: rdYwYO6FX7Vu3nL_dJP5r-hEyea_ge29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060160

There are cases where the userspace might still send another
frame after the HPD disconnect causing a modeset cycle after
a disconnect. This messes the internal state machine of MSM DP driver
and can lead to a crash as there can be an imbalance between
bridge_disable() and bridge_enable().

This was also previously reported on [1] for which [2] was posted
and helped resolve the issue by rejecting commits if the DP is not
in connected state.

The change resolved the bug but there can also be another race condition.
If hpd_event_thread does not pick up the EV_USER_NOTIFICATION and process it
link_ready will also not be set to false allowing the frame to sneak in.

Lets move setting link_ready outside of hpd_event_thread() processing to
eliminate a window of race condition.

[1] : https://gitlab.freedesktop.org/drm/msm/-/issues/17
[2] : https://lore.kernel.org/all/1664408211-25314-1-git-send-email-quic_khsieh@quicinc.com/

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 068d44eeaa07..e00092904ccc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -345,8 +345,6 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
 							 dp->panel->downstream_ports);
 	}
 
-	dp->dp_display.link_ready = hpd;
-
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->dp_display.connector_type, hpd);
 	drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
@@ -399,6 +397,8 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
 		goto end;
 	}
 
+	dp->dp_display.link_ready = true;
+
 	dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
 
 end:
@@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
 {
 	struct dp_display_private *dp = dev_get_dp_display_private(dev);
 
+	dp->dp_display.link_ready = false;
+
 	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
 
 	return 0;
@@ -487,6 +489,7 @@ static int dp_display_handle_port_status_changed(struct dp_display_private *dp)
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
 		if (dp->hpd_state != ST_DISCONNECTED) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
+			dp->dp_display.link_ready = false;
 			dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
 		}
 	} else {
-- 
2.34.1


