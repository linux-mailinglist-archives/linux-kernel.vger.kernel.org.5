Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A47DEA7A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348225AbjKBB75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:59:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7B110;
        Wed,  1 Nov 2023 18:59:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21cR3H007156;
        Thu, 2 Nov 2023 01:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=pCg/c7I2/RUaFnksCU8WecferE/EwY8K5eTYjPO1yBQ=;
 b=B4dD6phMJlc6/Nn6iw7/NDRYVAoGaWuUizs6CVHn2cBVEugg8XVLdEWpNNin7Lm2IsW0
 wC+aq2h6pVN0EWEXHTJjss62shoa9UpaU/Fr74nFY+3awFmHgA00lRwc8J3AxGyRW5sh
 FvazJcWQ1Na6TXTrbaqtPiA4Can0Ik0GOY/ZFgHBVWwStO6iuX+4wd/PCZBoXvH/1Xfb
 Bvel5zAb656sovNedR0pYodSzvTluKfUZD3xwDLRXI0SL0hF6XEtIi2pLClCqgyUCQc/
 cUORGsC3aYOv2xr3FUBr93ua9y39rYlrPPiKMR0A8IGG856RT84wYGTsPOqGDF41yetM hA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3kactau4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 01:59:31 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A21xUna030861;
        Thu, 2 Nov 2023 01:59:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3u4227r7y2-1;
        Thu, 02 Nov 2023 01:59:30 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A21x3xo030542;
        Thu, 2 Nov 2023 01:59:30 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3A21xU3Z030854;
        Thu, 02 Nov 2023 01:59:30 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id C2AA120A51; Wed,  1 Nov 2023 18:59:29 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] scsi: ufs: ufs-sysfs: Expose UFS power info
Date:   Wed,  1 Nov 2023 18:58:36 -0700
Message-Id: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 79ZGSCbq2P19iSDK8ETWIgPJy0OjkSnc
X-Proofpoint-GUID: 79ZGSCbq2P19iSDK8ETWIgPJy0OjkSnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020013
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having UFS power info available in sysfs makes it easier to tell the state
of the link during runtime considering we have a bunch of power saving
features and various combinations for backward compatibility.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---

v3 -> v4:
Incorporated comments from Bart and Mani

v2 -> v3:
1. For mode/gear/rate/dev_pm/link_status, print texts instead of numbers
2. Removed number<->text explanations for mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs

v1 -> v2:
1. Incorporated comments from Bart, Nitin and Mani.
2. Added explanations for lane/mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs

---

 Documentation/ABI/testing/sysfs-driver-ufs |  49 ++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 120 +++++++++++++++++++++++++++++
 include/ufs/unipro.h                       |   4 +-
 3 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf..b73067b 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1223,6 +1223,55 @@ Description:	This file shows the total latency (in micro seconds) of write
 
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
+Description:	This file shows the PA power mode of UFS.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
+What:		/sys/bus/platform/devices/*.ufs/power_info/rate
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the speed rate of UFS link.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
+What:		/sys/bus/platform/devices/*.ufs/power_info/gear
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the gear of UFS link.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
+What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the UFS device power mode.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
+What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
+Date:		September 2023
+Contact:	Can Guo <quic_cang@quicinc.com>
+Description:	This file shows the state of UFS link.
+
+		The file is read only.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
 Date:		June 2020
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c959064..05b10ca 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -7,9 +7,56 @@
 #include <asm/unaligned.h>
 
 #include <ufs/ufs.h>
+#include <ufs/unipro.h>
 #include "ufs-sysfs.h"
 #include "ufshcd-priv.h"
 
+static const char *ufs_pa_pwr_mode_to_string(enum ufs_pa_pwr_mode mode)
+{
+	switch (mode) {
+	case FAST_MODE:		return "FAST_MODE";
+	case SLOW_MODE:		return "SLOW_MODE";
+	case FASTAUTO_MODE:	return "FASTAUTO_MODE";
+	case SLOWAUTO_MODE:	return "SLOWAUTO_MODE";
+	default:		return "UNKNOWN";
+	}
+}
+
+static const char *ufs_hs_gear_rate_to_string(enum ufs_hs_gear_rate rate)
+{
+	switch (rate) {
+	case PA_HS_MODE_A:	return "HS_RATE_A";
+	case PA_HS_MODE_B:	return "HS_RATE_B";
+	default:		return "UNKNOWN";
+	}
+}
+
+static const char *ufs_pwm_gear_to_string(enum ufs_pwm_gear_tag gear)
+{
+	switch (gear) {
+	case UFS_PWM_G1:	return "PWM_GEAR1";
+	case UFS_PWM_G2:	return "PWM_GEAR2";
+	case UFS_PWM_G3:	return "PWM_GEAR3";
+	case UFS_PWM_G4:	return "PWM_GEAR4";
+	case UFS_PWM_G5:	return "PWM_GEAR5";
+	case UFS_PWM_G6:	return "PWM_GEAR6";
+	case UFS_PWM_G7:	return "PWM_GEAR7";
+	default:		return "UNKNOWN";
+	}
+}
+
+static const char *ufs_hs_gear_to_string(enum ufs_hs_gear_tag gear)
+{
+	switch (gear) {
+	case UFS_HS_G1:	return "HS_GEAR1";
+	case UFS_HS_G2:	return "HS_GEAR2";
+	case UFS_HS_G3:	return "HS_GEAR3";
+	case UFS_HS_G4:	return "HS_GEAR4";
+	case UFS_HS_G5:	return "HS_GEAR5";
+	default:	return "UNKNOWN";
+	}
+}
+
 static const char *ufshcd_uic_link_state_to_string(
 			enum uic_link_state state)
 {
@@ -628,6 +675,78 @@ static const struct attribute_group ufs_sysfs_monitor_group = {
 	.attrs = ufs_sysfs_monitor_attrs,
 };
 
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
+	return sysfs_emit(buf, "%s\n", ufs_pa_pwr_mode_to_string(hba->pwr_info.pwr_rx));
+}
+
+static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ufs_hs_gear_rate_to_string(hba->pwr_info.hs_rate));
+}
+
+static ssize_t gear_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", hba->pwr_info.hs_rate ?
+			  ufs_hs_gear_to_string(hba->pwr_info.gear_rx) :
+			  ufs_pwm_gear_to_string(hba->pwr_info.gear_rx));
+}
+
+static ssize_t dev_pm_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ufshcd_ufs_dev_pwr_mode_to_string(hba->curr_dev_pwr_mode));
+}
+
+static ssize_t link_state_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ufshcd_uic_link_state_to_string(hba->uic_link_state));
+}
+
+static DEVICE_ATTR_RO(lane);
+static DEVICE_ATTR_RO(mode);
+static DEVICE_ATTR_RO(rate);
+static DEVICE_ATTR_RO(gear);
+static DEVICE_ATTR_RO(dev_pm);
+static DEVICE_ATTR_RO(link_state);
+
+static struct attribute *ufs_power_info_attrs[] = {
+	&dev_attr_lane.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_gear.attr,
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
@@ -1233,6 +1352,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_capabilities_group,
 	&ufs_sysfs_monitor_group,
+	&ufs_sysfs_power_info_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index 256eb3a..360e124 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -193,7 +193,7 @@
 #define DME_LocalAFC0ReqTimeOutVal		0xD043
 
 /* PA power modes */
-enum {
+enum ufs_pa_pwr_mode {
 	FAST_MODE	= 1,
 	SLOW_MODE	= 2,
 	FASTAUTO_MODE	= 4,
@@ -205,7 +205,7 @@ enum {
 #define PWRMODE_RX_OFFSET	4
 
 /* PA TX/RX Frequency Series */
-enum {
+enum ufs_hs_gear_rate {
 	PA_HS_MODE_A	= 1,
 	PA_HS_MODE_B	= 2,
 };
-- 
2.7.4

