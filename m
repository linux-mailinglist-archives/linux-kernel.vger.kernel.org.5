Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795D79A331
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjIKGCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIKGCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:02:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB11B9;
        Sun, 10 Sep 2023 23:01:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5rWiL009039;
        Mon, 11 Sep 2023 06:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=mffWOqAhx7Dx4280AURFM1berny9POS9TD45FqGA8Sk=;
 b=OwC9qjMhw0cBVtqfHqU1bHwVvxA3No2YQMvgSOQjPgpCrI/w4cVubcm5cHVdIU9n0dvy
 1VkCIbOmuUZ4o0/HJGUC4RVYgW61tOpL9OzJPOBDG+UmX8NH2glthmZ3KrJglFDijq2P
 fBYe7/BU4Zc7zuJ8BdWY/LjsBNDrsmvl51LwezPPlCzMlRYsqDr8OGzGkgMljOXToA4u
 ZqWOTtX4srQLpjt7Vn5gQz5+dRepZed7iJe9PAY4fHxlCTFDoWOW8VXwAQaHiMSh/i0X
 Z/PBloE8V2G7GqeR1Dv9MYUGQxmCxMOlP7+bMTTKywlSpJOsRZO0IVQqLWcqM6ftYGIc vw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hvyjr9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:00:48 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38B5PkUq017311;
        Mon, 11 Sep 2023 06:00:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3t0hskq2hj-1;
        Mon, 11 Sep 2023 06:00:47 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B60l4B008075;
        Mon, 11 Sep 2023 06:00:47 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 38B60l49008074;
        Mon, 11 Sep 2023 06:00:47 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 4524C20DEF; Sun, 10 Sep 2023 23:00:47 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, mani@kernel.org, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] scsi: ufs: ufs-sysfs: Expose UFS power info
Date:   Sun, 10 Sep 2023 22:59:26 -0700
Message-Id: <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jm4GTeQg0VXce-vO5QrhyFrZauU8Eshw
X-Proofpoint-GUID: Jm4GTeQg0VXce-vO5QrhyFrZauU8Eshw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=836 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110054
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having UFS power info available in sysfs makes it easier to tell the state
of the link during runtime considering we have a bounch of power saving
features and various combinations for backward compatiblity.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/core/ufs-sysfs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

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

