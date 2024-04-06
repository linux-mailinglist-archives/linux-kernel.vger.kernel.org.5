Return-Path: <linux-kernel+bounces-133736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6989A7E5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BA61F23AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E417C2;
	Sat,  6 Apr 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="auLtYgNM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E957363;
	Sat,  6 Apr 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362658; cv=none; b=jRskRNNCHRTesjtMVwoSnxUREiYjRSF2Pv9nUkNefGQMrBRjT9TwQkZ1GbJMTt1L6XvGvpFPnlbVWDKCp7I/Db/MeO0MUgOB7IX7vVGNMMKEDyggALnIfpkwjE7YFp59hY1D0MfWBdZd/yf9FpAdw781HL0ZTApoCEIGR6p5LTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362658; c=relaxed/simple;
	bh=BTulhtY/9Oy572CYjZLRFkgUKDeK+wOMHOC+bJntT4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UgoC1C4U1gOeWQ28z4Fdk2YFdqbrSb1beaujU3dbLTEHglpDHc8eGc79PdrZDzKyqGy/kcB/hBVvp1noBzB5qv+SLHKYjrLiijuUS81SX8/eOkRSEHIEzQ9uQQk9BFTKJK9bnSnDY0sDmmsaqyr8WpKqEmUb/bTZga+mTidiRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=auLtYgNM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435NouIN020781;
	Sat, 6 Apr 2024 00:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=PcooOqL
	N8RXngIbQhg9Z61r/5fHlOoN76fVOjQMWr3Y=; b=auLtYgNMAysPBT9X/DiTO15
	Q7WXK4DC0s7MFmBfcqmSVJ1h00CNKk6hhkxGspVXm2RKwHK16iiBrmdZtqE5DY7T
	I9v/5P7tDskN5hoZWLEVA9/7n9hLtQDSu+zeSxoEl1TPCnajexfZLbEo/8HSSPjX
	DOhyGfXxkB/B/8AFPlcQ10/Wbcc+fg19qFev79cOQ5Z+IsVzkEFIZqCJo5AOIREz
	gO4PCxAZcmYYWWLy7DpOf2+6rQBvAkITpk5Yk0UrGc6oCN+HHurFBqS1Z9nY3UMh
	P0umQSssWxge69NXlHf7Iuy3gKICcBOd3WxdUVkwZawEphLKS+RUnLASYEJNzxQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc2f9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 00:17:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4360HOMf024602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 00:17:24 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 17:17:23 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        "Kuogee
 Hsieh" <quic_khsieh@quicinc.com>
CC: <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_jesszhan@quicinc.com>,
        <quic_bjorande@quicinc.com>, <johan@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle() directly for external HPD
Date: Fri, 5 Apr 2024 17:17:14 -0700
Message-ID: <20240406001715.8181-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.43.2
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
X-Proofpoint-GUID: c6CjJTsfoP7elp0HjNKekg1Y4Lb4eZf1
X-Proofpoint-ORIG-GUID: c6CjJTsfoP7elp0HjNKekg1Y4Lb4eZf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_29,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404060000

From: Kuogee Hsieh <quic_khsieh@quicinc.com>

In the external HPD case, hotplug event is delivered by pmic glink to DP driver
using drm_aux_hpd_bridge_notify().

The stacktrace showing the sequence of events is below:

dp_bridge_hpd_notify+0x18/0x70 [msm]
drm_bridge_connector_detect+0x60/0xe8 [drm_kms_helper]
drm_helper_probe_detect+0x94/0xc0 [drm_kms_helper]
drm_helper_probe_single_connector_modes+0x43c/0x53c [drm_kms_helper]
drm_client_modeset_probe+0x240/0x1114 [drm]
drm_fb_helper_hotplug_event.part.26+0x9c/0xe8 [drm_kms_helper]
drm_fb_helper_hotplug_event+0x24/0x38 [drm_kms_helper]
msm_fbdev_client_hotplug+0x24/0xd4 [msm]
drm_client_dev_hotplug+0xd8/0x148 [drm]
drm_kms_helper_connector_hotplug_event+0x30/0x3c [drm_kms_helper]
drm_bridge_connector_handle_hpd+0x84/0x94 [drm_kms_helper]
drm_bridge_connector_hpd_cb+0xc/0x14 [drm_kms_helper]
drm_bridge_hpd_notify+0x38/0x50 [drm]
drm_aux_hpd_bridge_notify+0x14/0x20 [aux_hpd_bridge]
pmic_glink_altmode_worker+0xec/0x27c [pmic_glink_altmode]
process_scheduled_works+0x17c/0x2cc
worker_thread+0x2ac/0x2d0
kthread+0xfc/0x120

There are three notifications delivered to DP driver for each notification event.

1) From the drm_aux_hpd_bridge_notify() itself as shown above

2) From output_poll_execute() thread which arises due to
drm_helper_probe_single_connector_modes() call of the above stacktrace
as shown in more detail here.

dp_bridge_hpd_notify+0x18/0x70 [msm]
drm_bridge_connector_detect+0x60/0xe8 [drm_kms_helper]
drm_helper_probe_detect+0x94/0xc0 [drm_kms_helper]
drm_helper_probe_single_connector_modes+0x43c/0x53c [drm_kms_helper]
drm_client_modeset_probe+0x240/0x1114 [drm]
drm_fb_helper_hotplug_event.part.26+0x9c/0xe8 [drm_kms_helper]
drm_fb_helper_hotplug_event+0x24/0x38 [drm_kms_helper]
msm_fbdev_client_hotplug+0x24/0xd4 [msm]
drm_client_dev_hotplug+0xd8/0x148 [drm]
drm_kms_helper_hotplug_event+0x30/0x3c [drm_kms_helper]
output_poll_execute+0xe0/0x210 [drm_kms_helper]

3) From the DP driver as the dp_bridge_hpd_notify() callback today triggers
the hpd_event_thread for connect and disconnect events respectively via below stack

dp_bridge_hpd_notify+0x18/0x70 [msm]
drm_bridge_connector_detect+0x60/0xe8 [drm_kms_helper]
drm_helper_probe_detect_ctx+0x98/0x110 [drm_kms_helper]
check_connector_changed+0x4c/0x20c [drm_kms_helper]
drm_helper_hpd_irq_event+0x98/0x120 [drm_kms_helper]
hpd_event_thread+0x478/0x5bc [msm]

We have to address why we end up with 3 events for every single event so something
is broken with how we work with the drm_bridge_connector.

But, the dp_bridge_hpd_notify() delivered from output_poll_execute() thread will
return the incorrect HPD status DP driver because the .detect() returns the value
of link_ready and not the HPD status currently.

And because the HPD event thread has not run yet and this results in the two complementary
events.

To fix this problem lets have dp_bridge_hpd_notify() call
dp_hpd_plug_handle/unplug_handle() directly instead of going through the
event thread.

Then the following .detect() called by drm_kms_helper_connector_hotplug_event()
will return correct value of HPD status since it uses the correct link_ready value.

With this change, the HPD status delivered by both drm_bridge_connector_hpd_notify()
and drm_kms_helper_connector_hotplug_event() will match each other consistently.

changes in v2:
	- Fix the commit message to explain the scenario
	- Fix the subject a little as well

Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d80f89581760..dfb10584ff97 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1665,7 +1665,8 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		return;
 
 	if (!dp_display->link_ready && status == connector_status_connected)
-		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+		dp_hpd_plug_handle(dp, 0);
 	else if (dp_display->link_ready && status == connector_status_disconnected)
-		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+		dp_hpd_unplug_handle(dp, 0);
+
 }
-- 
2.43.2


