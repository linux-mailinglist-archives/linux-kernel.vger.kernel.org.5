Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC140783949
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHVF1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHVF12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:27:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC12B1B0;
        Mon, 21 Aug 2023 22:27:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M4afqc006763;
        Tue, 22 Aug 2023 05:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+B4mUiN6XL4eVEyOS8jySg45NVz3jJggk8hJ/rLS2Lk=;
 b=ZsGX4YkH876oIh6TW1oVKM64OIR17aHptOvsyOh3GK+UrL/i4AbD76NzYZQAns3mVcxO
 U4f1QtHXVWfyE0F9psLMEJRO2HrM96nz2V2yFFMGVgkBcEms++HU00jox7wIjxThQNip
 3TkBfkbaVVkkWM+HXl+FDYzyPHctQ1eXx2ukqYsIY3teKg85pck5eniH1Oin3Koyw82u
 Iqvejn2RRbnh+inLhvB9pVulK8MZeyS/KOliXugTuDkrwDIwc23VYmFz/aM3T70h1mb1
 UKfdRjyXmiZoUEofzwAMtX0RWOqm0p4FndOr+d/xkw84DDKih3ooWhJOA95YWvzUOKXi hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm3xvak2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 05:27:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M5R7kt007076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 05:27:07 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 22:27:03 -0700
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
Subject: [PATCH v8 06/13] coresight-tpdm: Add reset node to TPDM node
Date:   Tue, 22 Aug 2023 13:26:06 +0800
Message-ID: <1692681973-20764-7-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
References: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZVs1szl-hqvGo8Oha5Jga5bugPu8YkDz
X-Proofpoint-ORIG-GUID: ZVs1szl-hqvGo8Oha5Jga5bugPu8YkDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_03,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPDM device need a node to reset the configurations and status of
it. This change provides a node to reset the configurations and
disable the TPDM if it has been enabled.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 4a58e64..2936226 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -11,3 +11,13 @@ Description:
 		Accepts only one of the 2 values -  1 or 2.
 		1 : Generate 64 bits data
 		2 : Generate 32 bits data
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/reset_dataset
+Date:		March 2023
+KernelVersion	6.5
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Reset the dataset of the tpdm.
+
+		Accepts only one value -  1.
+		1 : Reset the dataset of the tpdm
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 951ad4d..d6e7c8c 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -162,6 +162,27 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 	return 0;
 }
 
+static ssize_t reset_dataset_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret || val != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	tpdm_reset_datasets(drvdata);
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(reset_dataset);
+
 /*
  * value 1: 64 bits test data
  * value 2: 32 bits test data
@@ -202,6 +223,7 @@ static ssize_t integration_test_store(struct device *dev,
 static DEVICE_ATTR_WO(integration_test);
 
 static struct attribute *tpdm_attrs[] = {
+	&dev_attr_reset_dataset.attr,
 	&dev_attr_integration_test.attr,
 	NULL,
 };
-- 
2.7.4

