Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3079FB08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjINFpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjINFow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:44:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B7CC;
        Wed, 13 Sep 2023 22:44:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E4rTcN020631;
        Thu, 14 Sep 2023 05:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fl+inL8c72brwGk2t45tjkjYRrAIRR3mOX8ok/DzDNQ=;
 b=Iw9ArRrRmzClrhYOjueHw+UHifArj9N6esEFHtqbGifu1J6fxefA1pNs33YAifTq0aa2
 bfP4vKxmXLj5ozHyv9WtPM7Zj1pItAEL7JG2m4sxIX9eJQ36Mhs+tjWBSTA+vXLC5xgo
 DrFPn+RjbjHreWU3sRpaASMXyaMPH9CWL1+n4KYKRQuIkF4sjEOVywsN/erM1QG5+G+B
 il6QU/FAZkmIWGG8IZlSmtU5hRJ5kRG47z518kiMZAWXzwz+F/SkGrjUg1tIQwSHRW0e
 ibnUXt7PEEIiky7QG7TmoF7dVfX0VYI93SR8y62LnmS66qi+XSczFk0GuqfsmBuVnpcp pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3r15rgyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E5iQfL018305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:44:26 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 22:44:22 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v9 07/13] coresight-tpdm: Add nodes to set trigger timestamp and type
Date:   Thu, 14 Sep 2023 13:43:18 +0800
Message-ID: <1694670204-11515-8-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jZLcyO7ooD7dqUvcquf9tAFc4861GqXo
X-Proofpoint-ORIG-GUID: jZLcyO7ooD7dqUvcquf9tAFc4861GqXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nodes are needed to set or show the trigger timestamp and
trigger type. This change is to add these nodes to achieve these
function.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 22 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 95 ++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index ef8b5a6..b15bf01 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -21,3 +21,25 @@ Description:
 
 		Accepts only one value -  1.
 		1 : Reset the dataset of the tpdm
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the trigger type of the DSB for tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the DSB trigger type to false
+		1 : Set the DSB trigger type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the trigger timestamp of the DSB for tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the DSB trigger type to false
+		1 : Set the DSB trigger type to true
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 9c65e4c..e9fc348 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -25,6 +25,18 @@ static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
 	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
 }
 
+static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata && tpdm_has_dsb_dataset(drvdata))
+		return attr->mode;
+
+	return 0;
+}
+
 static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (tpdm_has_dsb_dataset(drvdata)) {
@@ -232,8 +244,91 @@ static struct attribute_group tpdm_attr_grp = {
 	.attrs = tpdm_attrs,
 };
 
+static ssize_t dsb_trig_type_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_type);
+}
+
+/*
+ * Trigger type (boolean):
+ * false - Disable trigger type.
+ * true  - Enable trigger type.
+ */
+static ssize_t dsb_trig_type_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->trig_type = true;
+	else
+		drvdata->dsb->trig_type = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_type);
+
+static ssize_t dsb_trig_ts_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_ts);
+}
+
+/*
+ * Trigger timestamp (boolean):
+ * false - Disable trigger timestamp.
+ * true  - Enable trigger timestamp.
+ */
+static ssize_t dsb_trig_ts_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->dsb->trig_ts = true;
+	else
+		drvdata->dsb->trig_ts = false;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_ts);
+
+static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_trig_ts.attr,
+	&dev_attr_dsb_trig_type.attr,
+	NULL,
+};
+
+static struct attribute_group tpdm_dsb_attr_grp = {
+	.attrs = tpdm_dsb_attrs,
+	.is_visible = tpdm_dsb_is_visible,
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
+	&tpdm_dsb_attr_grp,
 	NULL,
 };
 
-- 
2.7.4

