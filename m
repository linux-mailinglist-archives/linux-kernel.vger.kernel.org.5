Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E317CB8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjJQDLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjJQDLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757EBAB;
        Mon, 16 Oct 2023 20:11:38 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2b1Ca025606;
        Tue, 17 Oct 2023 03:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=3LhIQf0nCCyiRc+p/FRk8dvj6MIrvckooaW0UUNNfNM=;
 b=ULNN6Lis/KO7+K1+Wgb55W+2YI5MhU/U0+9GGBu+usLtbWXzHjEs29oOHrpPe0+nntPs
 pFHoFqjAxHvAziyQV8eZ7JYUwN2zBpDQesOz2Xh2zuEAhx6VYGQDHSpwarFhK8+tanca
 JmSFOM7PiaLJMZlDtx/SYN/gj9Q2iuhvOfLmKSy0N7ZELEgeqdnaAKpGJrjN3OJzgEny
 ClE+1qBuUq6UI+q/ZoT5rQv8fn7bXipZpZiCpmtxG0aTgBShGRGh/yv1BF9PoZeFAnrW
 Xj+/aDN25+IGpL+HWXS5a8wL7kw6EGaLMhy52qFShnRef/WaHU43nhPMtW5JEN8wkpqe zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsd1rrgxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BR69012888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:27 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:11 -0700
Subject: [PATCH 03/12] usb: dwc3: qcom: Merge resources from urs_usb device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-3-ab4a84165470@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=6022;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=7+5bDX8ppSUoZ0S/ZT53CM2YVEu9VcrjVto/s4tG2p0=;
 b=ORbE4smD4XA0s0gQLmi5Y8DG4sw33oV4jAseHAcxSb8NPe86tAO6m/Im1i6XZ92z61d96ydLYeNd
 BIYdUWKYBSZ7yqlm4cby0B4DDzsFfmrWTeLkC8GG34lWgzQT/WmI
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yo_-Zdmpsk83LnhGs2jsZBrNi3gnlQyH
X-Proofpoint-ORIG-GUID: Yo_-Zdmpsk83LnhGs2jsZBrNi3gnlQyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some ACPI DSDT tables, such as the one found in SC8180X devices,
the USB resources are split between the URSn and it's child USBn device
nodes, in particular the interrupts are placed in the child nodes.

The solution that was chosen for handling this is to allocate a
platform_device from the child node and selectively pick interrupts
from the main platform_device, or from this created child device, when
creating the platform_device for the DWC3 core.

This does however not work with the upcoming change where the DWC3 core
is instantiated from the same platform_device as the glue, as the DRD
and host code will attempt to resolve their interrupts from the shared
device, and not the child device.

Work around this by merging the resources of the child device into the
glue device node, to present a single platform_device with all the
resources necessary.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 82 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a31c3bc1f56e..7c810712d246 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -68,7 +68,6 @@ struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
 	struct platform_device	*dwc_dev;
-	struct platform_device	*urs_usb;
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
@@ -522,15 +521,13 @@ static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
 static int dwc3_qcom_get_irq(struct platform_device *pdev,
 			     const char *name, int num)
 {
-	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	struct platform_device *pdev_irq = qcom->urs_usb ? qcom->urs_usb : pdev;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	if (np)
-		ret = platform_get_irq_byname_optional(pdev_irq, name);
+		ret = platform_get_irq_byname_optional(pdev, name);
 	else
-		ret = platform_get_irq_optional(pdev_irq, num);
+		ret = platform_get_irq_optional(pdev, num);
 
 	return ret;
 }
@@ -667,8 +664,6 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, *child_res = NULL;
-	struct platform_device	*pdev_irq = qcom->urs_usb ? qcom->urs_usb :
-							    pdev;
 	int			irq;
 	int			ret;
 
@@ -700,7 +695,7 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	child_res[0].end = child_res[0].start +
 		qcom->acpi_pdata->dwc3_core_base_size;
 
-	irq = platform_get_irq(pdev_irq, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
 		goto out;
@@ -766,31 +761,72 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_device *
-dwc3_qcom_create_urs_usb_platdev(struct device *dev)
+static int dwc3_qcom_acpi_merge_urs_resources(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	struct resource *resources;
 	struct fwnode_handle *fwh;
 	struct acpi_device *adev;
 	char name[8];
+	int count;
 	int ret;
 	int id;
+	int i;
 
 	/* Figure out device id */
 	ret = sscanf(fwnode_get_name(dev->fwnode), "URS%d", &id);
 	if (!ret)
-		return NULL;
+		return -EINVAL;
 
 	/* Find the child using name */
 	snprintf(name, sizeof(name), "USB%d", id);
 	fwh = fwnode_get_named_child_node(dev->fwnode, name);
 	if (!fwh)
-		return NULL;
+		return 0;
 
 	adev = to_acpi_device_node(fwh);
 	if (!adev)
-		return NULL;
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (count <= 0)
+		return count;
+
+	count += pdev->num_resources;
+
+	resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources) {
+		acpi_dev_free_resource_list(&resource_list);
+		return -ENOMEM;
+	}
+
+	memcpy(resources, pdev->resource, sizeof(struct resource) * pdev->num_resources);
+	count = pdev->num_resources;
+	list_for_each_entry(rentry, &resource_list, node) {
+		/* Avoid inserting duplicate entries, in case this is called more than once */
+		for (i = 0; i < count; i++) {
+			if (resource_type(&resources[i]) == resource_type(rentry->res) &&
+			    resources[i].start == rentry->res->start &&
+			    resources[i].end == rentry->res->end)
+				break;
+		}
+
+		if (i == count)
+			resources[count++] = *rentry->res;
+	}
 
-	return acpi_create_platform_device(adev, NULL);
+	ret = platform_device_add_resources(pdev, resources, count);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add resources\n");
+
+	acpi_dev_free_resource_list(&resource_list);
+	kfree(resources);
+
+	return ret;
 }
 
 static int dwc3_qcom_probe(struct platform_device *pdev)
@@ -817,6 +853,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "no supporting ACPI device data\n");
 			return -EINVAL;
 		}
+
+		if (qcom->acpi_pdata->is_urs) {
+			ret = dwc3_qcom_acpi_merge_urs_resources(pdev);
+			if (ret < 0)
+				goto clk_disable;
+		}
 	}
 
 	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
@@ -857,18 +899,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			qcom->acpi_pdata->qscratch_base_offset;
 		parent_res->end = parent_res->start +
 			qcom->acpi_pdata->qscratch_base_size;
-
-		if (qcom->acpi_pdata->is_urs) {
-			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
-			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
-				dev_err(dev, "failed to create URS USB platdev\n");
-				if (!qcom->urs_usb)
-					ret = -ENODEV;
-				else
-					ret = PTR_ERR(qcom->urs_usb);
-				goto clk_disable;
-			}
-		}
 	}
 
 	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);

-- 
2.25.1

