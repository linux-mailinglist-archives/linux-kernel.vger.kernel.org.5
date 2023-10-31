Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB617DCA47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjJaJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJaJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:58:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E1C1;
        Tue, 31 Oct 2023 02:58:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V9UkJ0027053;
        Tue, 31 Oct 2023 09:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Gdsn8RvUGRQmpC+q5c4oSWzT6FRBqEnaD/NJccy9m8E=;
 b=ReVNT7TIUD1MmIrUzyJ2asBcJq7hdVKOQznLDjreHtJCizUrhF0Mx62ju7hLVe/02Nu/
 pxOLloI4/nxM8D+jiofia8pEKHrT9ZqC/0qkeOFy/ZrIwemv2XPqV1g30FFZ6mfmclXz
 BkzX+Dsf+yPVNyIWu42lq1CoL8icJZR9PukpSfwKddHLnrgKbB/kZN2yuBFUR68AelB4
 K4ufkqKNg0vvkoXLojyAiRmW2thzBgv9H0Fb6DHkFeYNOHmU5cYsUeE5lw9J54+qRiwk
 UUBoV0VleSh2BiJeDtB0lFBrjpy+c4ZPSQg/58Ucw8XNJjGBWWQ2aU3MbFj4A7rqesSV xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fcb22d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 09:57:59 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39V9t3ux029981;
        Tue, 31 Oct 2023 09:57:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3u27vdbsp0-1;
        Tue, 31 Oct 2023 09:57:58 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V9ul1Z032042;
        Tue, 31 Oct 2023 09:57:58 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 39V9vwp3000671;
        Tue, 31 Oct 2023 09:57:58 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id E146D20A64; Tue, 31 Oct 2023 02:57:52 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] scsi: ufs: ufs-sysfs: Expose UFS power info
Date:   Tue, 31 Oct 2023 02:53:04 -0700
Message-Id: <1698745992-5699-1-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7lgSjNLUic-hLbpSsslZAN6jXY79TgJy
X-Proofpoint-GUID: 7lgSjNLUic-hLbpSsslZAN6jXY79TgJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310077
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having UFS power info available in sysfs makes it easier to tell the state
of the link during runtime considering we have a bunch of power saving
features and various combinations for backward compatibility.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---

v1 -> v2:
1. Incorporated comments from Bart, Nitin and Mani.
2. Added explanations for gear/lane/rate/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs

---
 Documentation/ABI/testing/sysfs-driver-ufs | 88 ++++++++++++++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 71 ++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf..dd2cbac 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1223,6 +1223,94 @@ Description:	This file shows the total latency (in micro seconds) of write
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/lane
+What:		/sys/bus/platform/devices/*.ufs/power_info/lane
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows how many lanes are enabled on the UFS link,
+		i.e., an output 2 means UFS link is operating with 2 lanes.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
+What:		/sys/bus/platform/devices/*.ufs/power_info/mode
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the UniPro power mode of UFS link:
+		==  ====================================================
+		1   FAST_MODE
+		2   SLOW_MODE
+		4   FASTAUTO_MODE
+		5   SLOWAUTO_MODE
+		==  ====================================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
+What:		/sys/bus/platform/devices/*.ufs/power_info/rate
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the speed rate of UFS link:
+		==  ====================================================
+		0   Indicates that the gear is in PWM mode
+		1   HS_MODE_A - High Speed Rate A
+		2   HS_MODE_B - High Speed Rate B
+		==  ====================================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
+What:		/sys/bus/platform/devices/*.ufs/power_info/gear
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the gear of UFS link. 'rate' indicates whether
+		the gear is in PWM mode or High-Speed mode.
+		==  ====================================================
+		1   PWM_GEAR1
+		2   PWM_GEAR2
+		3   PWM_GEAR3
+		4   PWM_GEAR4
+		5   PWM_GEAR5
+		6   PWM_GEAR6
+		7   PWM_GEAR7
+		==  ====================================================
+		1   HS_GEAR1
+		2   HS_GEAR2
+		3   HS_GEAR3
+		4   HS_GEAR4
+		5   HS_GEAR5
+		==  ====================================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
+What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the UFS device power mode:
+		==  ====================================================
+		1   ACTIVE_PWR_MODE
+		2   SLEEP_PWR_MODE
+		3   POWERDOWN_PWR_MODE
+		4   DEEPSLEEP_PWR_MODE
+		==  ====================================================
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
+What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the state of UFS link:
+		==  ====================================================
+		0   UIC_LINK_OFF_STATE
+		1   UIC_LINK_ACTIVE_STATE
+		2   UIC_LINK_HIBERN8_STATE
+		3   UIC_LINK_BROKEN_STATE
+		==  ====================================================
+
+		The file is read only.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
 Date:		June 2020
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c959064..53af490 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -628,6 +628,76 @@ static const struct attribute_group ufs_sysfs_monitor_group = {
 	.attrs = ufs_sysfs_monitor_attrs,
 };
 
+static ssize_t gear_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", hba->pwr_info.gear_rx);
+}
+
+static ssize_t lane_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", hba->pwr_info.lane_rx);
+}
+
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", hba->pwr_info.pwr_rx);
+}
+
+static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", hba->pwr_info.hs_rate);
+}
+
+static ssize_t dev_pm_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->curr_dev_pwr_mode);
+}
+
+static ssize_t link_state_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->uic_link_state);
+}
+
+static DEVICE_ATTR_RO(gear);
+static DEVICE_ATTR_RO(lane);
+static DEVICE_ATTR_RO(mode);
+static DEVICE_ATTR_RO(rate);
+static DEVICE_ATTR_RO(dev_pm);
+static DEVICE_ATTR_RO(link_state);
+
+static struct attribute *ufs_power_info_attrs[] = {
+	&dev_attr_gear.attr,
+	&dev_attr_lane.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_dev_pm.attr,
+	&dev_attr_link_state.attr,
+	NULL
+};
+
+static const struct attribute_group ufs_sysfs_power_info_group = {
+	.name = "power_info",
+	.attrs = ufs_power_info_attrs,
+};
+
 static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
 				  enum desc_idn desc_id,
 				  u8 desc_index,
@@ -1233,6 +1303,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_capabilities_group,
 	&ufs_sysfs_monitor_group,
+	&ufs_sysfs_power_info_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
-- 
2.7.4

