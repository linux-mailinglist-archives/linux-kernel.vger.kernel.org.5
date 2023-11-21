Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9697F23E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjKUC0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjKUCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:25:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964BE3;
        Mon, 20 Nov 2023 18:25:51 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL20hQY009143;
        Tue, 21 Nov 2023 02:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ITiWIWUJVK9pQ5j666+u/QaSZET+SUFePDEmSBHWBcw=;
 b=FKZe4abjORuJDNN8ybyjy7xnPYV9IZPmcYJFww4TVPwI3rN7bsTtz3tDW/glJM/4MXmK
 er2fBSBUMmWp/iPG+Rt4nZLzIrt9o9ftvpMtIOmyVfLOT1+di5Zqlm6jEqzef8KhqV9I
 euFyPE2k14WV3wDeITKV/rUzAR5tOdCjG4QumWjaff7iz7fRiB/vfWVwOZcLdNfXVwJ3
 OEqdaMO+p3H1MRp7mvyDC9XQ7R229SBfH8D8MmRCrpOfbzrPL4punmgsSDxEmqS+gNYY
 +J3Ka7hMCBNNeMAO+cv9MFmF5DELzQMfEFKJZkIhb/Us60dCkbRhe9vVQEiN7vO13dAK ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugdxmgmsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2PdWf000760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:39 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:34 -0800
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
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v3 4/8] coresight-tpdm: Add support to configure CMB
Date:   Tue, 21 Nov 2023 10:24:50 +0800
Message-ID: <1700533494-19276-5-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MHKi6R4r6q5mZMjqti9yy4ojNNVyhoA_
X-Proofpoint-ORIG-GUID: MHKi6R4r6q5mZMjqti9yy4ojNNVyhoA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=814 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPDM CMB subunits support two forms of CMB data set element creation:
continuous and trace-on-change collection mode. Continuous change
creates CMB data set elements on every CMBCLK edge. Trace-on-change
creates CMB data set elements only when a new data set element differs
in value from the previous element in a CMB data set. Set CMB_CR.MODE
to 0 for continuous CMB collection mode. Set CMB_CR.MODE to 1 for
trace-on-change CMB collection mode

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  | 14 ++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 71 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  | 12 ++++
 3 files changed, 97 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index f07218e78843..246c77c109d7 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -170,3 +170,17 @@ Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_t
 Description:
 		(RW) Set/Get the MSR(mux select register) for the DSB subunit
 		TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_mode
+Date:		March 2023
+KernelVersion	6.7
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:	(Write) Set the data collection mode of CMB tpdm. Continuous
+		change creates CMB data set elements on every CMBCLK edge.
+		Trace-on-change creates CMB data set elements only when a new
+		data set element differs in value from the previous element
+		in a CMB data set.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Continuous CMB collection mode.
+		1 : Trace-on-change CMB collection mode.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index c8bb38822e08..efb376e069a1 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -148,6 +148,18 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t tpdm_cmb_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata && tpdm_has_cmb_dataset(drvdata))
+		return attr->mode;
+
+	return 0;
+}
+
 static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int n)
 {
@@ -172,6 +184,9 @@ static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 		drvdata->dsb->trig_ts = true;
 		drvdata->dsb->trig_type = false;
 	}
+
+	if (tpdm_has_cmb_dataset(drvdata))
+		memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
 }
 
 static void set_dsb_mode(struct tpdm_drvdata *drvdata, u32 *val)
@@ -277,6 +292,16 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 	u32 val;
 
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
+	/*
+	 * Set to 0 for continuous CMB collection mode,
+	 * 1 for trace-on-change CMB collection mode.
+	 */
+	if (drvdata->cmb->trace_mode)
+		val |= TPDM_CMB_CR_MODE;
+	else
+		val &= ~TPDM_CMB_CR_MODE;
+
+	/* Set the enable bit of CMB control register to 1 */
 	val |= TPDM_CMB_CR_ENA;
 
 	/* Set the enable bit of CMB control register to 1 */
@@ -397,6 +422,12 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
 		if (!drvdata->dsb)
 			return -ENOMEM;
 	}
+	if (tpdm_has_cmb_dataset(drvdata) && (!drvdata->cmb)) {
+		drvdata->cmb = devm_kzalloc(drvdata->dev,
+						sizeof(*drvdata->cmb), GFP_KERNEL);
+		if (!drvdata->cmb)
+			return -ENOMEM;
+	}
 	tpdm_reset_datasets(drvdata);
 
 	return 0;
@@ -735,6 +766,35 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_trig_ts);
 
+static ssize_t cmb_mode_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%x\n",
+			  drvdata->cmb->trace_mode);
+
+}
+
+static ssize_t cmb_mode_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long trace_mode;
+
+	if ((kstrtoul(buf, 0, &trace_mode)) || (trace_mode & ~1UL))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cmb->trace_mode = trace_mode;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_mode);
+
 static struct attribute *tpdm_dsb_edge_attrs[] = {
 	&dev_attr_ctrl_idx.attr,
 	&dev_attr_ctrl_val.attr,
@@ -851,6 +911,11 @@ static struct attribute *tpdm_dsb_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_cmb_attrs[] = {
+	&dev_attr_cmb_mode.attr,
+	NULL,
+};
+
 static struct attribute_group tpdm_dsb_attr_grp = {
 	.attrs = tpdm_dsb_attrs,
 	.is_visible = tpdm_dsb_is_visible,
@@ -880,6 +945,11 @@ static struct attribute_group tpdm_dsb_msr_grp = {
 	.name = "dsb_msr",
 };
 
+static struct attribute_group tpdm_cmb_attr_grp = {
+	.attrs = tpdm_cmb_attrs,
+	.is_visible = tpdm_cmb_is_visible,
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
@@ -887,6 +957,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_dsb_trig_patt_grp,
 	&tpdm_dsb_patt_grp,
 	&tpdm_dsb_msr_grp,
+	&tpdm_cmb_attr_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 0098c58dfdd6..c6b36d2fe45a 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -14,6 +14,8 @@
 
 /* Enable bit for CMB subunit */
 #define TPDM_CMB_CR_ENA		BIT(0)
+/* Trace collection mode for CMB subunit */
+#define TPDM_CMB_CR_MODE	BIT(1)
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
@@ -181,6 +183,14 @@ struct dsb_dataset {
 	bool			trig_type;
 };
 
+/**
+ * struct cmb_dataset
+ * @trace_mode:       Dataset collection mode
+ */
+struct cmb_dataset {
+	u32			trace_mode;
+};
+
 /**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
@@ -190,6 +200,7 @@ struct dsb_dataset {
  * @enable:     enable status of the component.
  * @datasets:   The datasets types present of the TPDM.
  * @dsb         Specifics associated to TPDM DSB.
+ * @cmb         Specifics associated to TPDM CMB.
  * @dsb_msr_num Number of MSR supported by DSB TPDM
  */
 
@@ -201,6 +212,7 @@ struct tpdm_drvdata {
 	bool			enable;
 	unsigned long		datasets;
 	struct dsb_dataset	*dsb;
+	struct cmb_dataset	*cmb;
 	u32			dsb_msr_num;
 };
 
-- 
2.17.1

