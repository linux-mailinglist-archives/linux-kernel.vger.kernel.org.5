Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621117B12F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjI1GbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjI1GbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:31:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24391AA;
        Wed, 27 Sep 2023 23:30:56 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5MDkx024664;
        Thu, 28 Sep 2023 06:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YhKIpatrBvdIpmC7FIvGwKatW8WTxlPogyvQfWxRf40=;
 b=MUNz+pextQoN//uuU02UDq+Klr+KHhFQRZWhGpfTNmhvH6kbWkPIyfi63n1sW2FvpI+g
 7uPc7InHLqSctEzZJdjSstRrwbobmwVapAkwpPZSJ2uZXwl8zopnnCogCnAAosPdgd1D
 VIdZ7DGNyBBtTzs7xEKM1G+I18OUTRbW+oUO74onfmnUgf9COKlhZi5+0R0cjyJKNSTZ
 pr/KCrDv/XHE8EEpdPI4QMwenFIOjH5GV2eaRHMxYj9ZJKCje8B29fLhEZrK02nsTNny
 oGyV8ES064cXhV/LTLZrhZLkTJjjvrSHNqAHtMlZqtGm+TZf6IbTxRz9bgUBQ947fdso CQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td2vu04fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:30:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S6Uh6m000856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 06:30:43 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 27 Sep 2023 23:30:38 -0700
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
Subject: [PATCH v10 06/13] coresight-tpdm: Add reset node to TPDM node
Date:   Thu, 28 Sep 2023 14:29:39 +0800
Message-ID: <1695882586-10306-7-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
References: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLqKQvjqKUIpSunQ1OnTieLhgfbT1D04
X-Proofpoint-ORIG-GUID: hLqKQvjqKUIpSunQ1OnTieLhgfbT1D04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../testing/sysfs-bus-coresight-devices-tpdm  | 10 +++++++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 22 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index 4a58e649550d..ef8b5a6bd4ac 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -11,3 +11,13 @@ Description:
 		Accepts only one of the 2 values -  1 or 2.
 		1 : Generate 64 bits data
 		2 : Generate 32 bits data
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/reset_dataset
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Reset the dataset of the tpdm.
+
+		Accepts only one value -  1.
+		1 : Reset the dataset of the tpdm
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 951ad4d9b76f..9c65e4c01128 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -162,6 +162,27 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 	return 0;
 }
 
+static ssize_t reset_dataset_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
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
2.17.1

