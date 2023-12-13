Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB0811C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379112AbjLMSNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjLMSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:13:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C5F2;
        Wed, 13 Dec 2023 10:13:37 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDEdBZJ001943;
        Wed, 13 Dec 2023 18:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=iXUSdzl
        Whi9I84iGPxMHNa5qw5UEecWxK8/qXwJLZSc=; b=UScuhTB2JCMTA2RwUI2hBYM
        k9vjjcXjQjK8ccwmhv5LfoyRSiIYTVHLjsCBIbKxivc/d49AKvZBNvQ6fR+XZXVJ
        2k5OCM66uvJS+Ce4V0XSmRc5X3HmLbvKVo2raB3hazYdiSyLEzHW7YcTNjStpa8H
        tvaitdnaN7ppB2FtPGRnMUBj+Uor0iJjLmMKelXGyYWzbnvBNgl3RWSEtWg4BDy6
        vu9aTCcf04LdvMYGs01s2+812W6ZVlBSvfHMtmX9Zl0e8X5YSGZIUlE16HBPuivk
        6OX8zwIqWW8Sa/elImi3XUuleR/BbodNQh19bU4L2kpXZHWsgGahKnHT2FDIabQ=
        =
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy7j7skm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:13:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDIDWL1025998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:13:32 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 10:13:28 -0800
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        "Vignesh Viswanathan" <quic_viswanat@quicinc.com>
Subject: [PATCH] remoteproc: qcom: q6v5_mpd: Add custom coredump segments
Date:   Wed, 13 Dec 2023 23:43:14 +0530
Message-ID: <20231213181314.271484-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kHQ0fPJlbkhyp9k2wsUktSa-KRB2btFJ
X-Proofpoint-ORIG-GUID: kHQ0fPJlbkhyp9k2wsUktSa-KRB2btFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 mlxlogscore=799 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 and IPQ5332 can have multiple reserved memory regions that needs
to be collected as part of the coredump.

Loop through all the regions defined under reserved-memory node in the
devicetree for the remoteproc and add each as a custom segment for
coredump.

Also, update the ELF info for coredump collection for multipd
remoteprocs.

This patch depends on [1] which adds support for IPQ9574 and IPQ5332
remoteproc q5v5_mpd driver.

[1]: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/

Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_mpd.c | 71 +++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
index 839f6a15b88d..901b0b0da8f2 100644
--- a/drivers/remoteproc/qcom_q6v5_mpd.c
+++ b/drivers/remoteproc/qcom_q6v5_mpd.c
@@ -443,11 +443,77 @@ static unsigned long q6_wcss_panic(struct rproc *rproc)
 	return qcom_q6v5_panic(&wcss->q6);
 }
 
+static void q6_wcss_copy_segment(struct rproc *rproc,
+				 struct rproc_dump_segment *segment,
+				 void *dest, size_t offset, size_t size)
+{
+	struct q6_wcss *wcss = rproc->priv;
+	struct device *dev = wcss->dev;
+	int base;
+	void *ptr;
+
+	base = segment->da + offset - wcss->mem_reloc;
+
+	if (base < 0 || base + size > wcss->mem_size) {
+		ptr = devm_ioremap_wc(dev, segment->da, segment->size);
+		memcpy(dest, ptr + offset, size);
+		devm_iounmap(dev, ptr);
+	} else {
+		memcpy(dest, wcss->mem_region + offset, size);
+	}
+}
+
+static int q6_wcss_dump_segments(struct rproc *rproc,
+				 const struct firmware *fw)
+{
+	struct device *dev = rproc->dev.parent;
+	struct reserved_mem *rmem = NULL;
+	struct device_node *node;
+	int num_segs, index = 0;
+	int ret;
+
+	/* Parse through additional reserved memory regions for the rproc
+	 * and add them to the coredump segments
+	 */
+	num_segs = of_count_phandle_with_args(dev->of_node,
+					      "memory-region", NULL);
+	while (index < num_segs) {
+		node = of_parse_phandle(dev->of_node,
+					"memory-region", index);
+		if (!node)
+			return -EINVAL;
+
+		rmem = of_reserved_mem_lookup(node);
+		if (!rmem) {
+			dev_err(dev, "unable to acquire memory-region index %d num_segs %d\n",
+				index, num_segs);
+			return -EINVAL;
+		}
+
+		of_node_put(node);
+
+		dev_dbg(dev, "Adding segment 0x%pa size 0x%pa",
+			&rmem->base, &rmem->size);
+		ret = rproc_coredump_add_custom_segment(rproc,
+							rmem->base,
+							rmem->size,
+							q6_wcss_copy_segment,
+							NULL);
+		if (ret)
+			return ret;
+
+		index++;
+	}
+
+	return 0;
+}
+
 static const struct rproc_ops wcss_ops = {
 	.start = wcss_pd_start,
 	.stop = wcss_pd_stop,
 	.load = wcss_pd_load,
 	.get_boot_addr = rproc_elf_get_boot_addr,
+	.parse_fw = q6_wcss_dump_segments,
 };
 
 static const struct rproc_ops q6_wcss_ops = {
@@ -457,6 +523,7 @@ static const struct rproc_ops q6_wcss_ops = {
 	.load = q6_wcss_load,
 	.get_boot_addr = rproc_elf_get_boot_addr,
 	.panic = q6_wcss_panic,
+	.parse_fw = q6_wcss_dump_segments,
 };
 
 static int q6_alloc_memory_region(struct q6_wcss *wcss)
@@ -672,6 +739,7 @@ static int q6_register_userpd(struct platform_device *pdev,
 		goto free_rproc;
 
 	rproc->auto_boot = false;
+	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 	ret = rproc_add(rproc);
 	if (ret)
 		goto free_rproc;
@@ -731,9 +799,10 @@ static int q6_wcss_probe(struct platform_device *pdev)
 		goto free_rproc;
 
 	qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
-	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
+	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, pdev->name);
 
 	rproc->auto_boot = false;
+	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 	ret = rproc_add(rproc);
 	if (ret)
 		goto free_rproc;
-- 
2.41.0

