Return-Path: <linux-kernel+bounces-91651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03DB8714AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76F5282B82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF22940D;
	Tue,  5 Mar 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oDMFf3Xb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C063C087;
	Tue,  5 Mar 2024 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612540; cv=none; b=Q1v1DjS/1dv+FHsEYhdgUBenupCG+YVTa+stV2GnlK5c37wTaG7zkblFo38u6ioynIJApKpH3/uN9ae6L4aw87Wma8dEHQ+R+vG/Hso5kpPkZKIxuQFq9hCkpmQoBLyXJdQlIS4o2M+5kNHeWZxIfOi8bme+c2cuDMO0aPDfauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612540; c=relaxed/simple;
	bh=0xM7NyL1pkdybHyg/1YdZzaZV2WQ7gK69y2nSqCZkKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HwZdXQ3SqKaOT5j+NJf7wmofdgdCpybdCOjGJ2MThRh5DjEJDy/LC8WOq1qoY6sji+se9euinZwsCDYcTzDDAhk8GT5/32xlSWMlrV+Qx0vhogz3Ck7L9pBJU6zaWvMDlXUbNhZQsKdaBWcGDsMgVC+XjWT/FB4+m+4GlCNhhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oDMFf3Xb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4253nSmx015123;
	Tue, 5 Mar 2024 04:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=n9v/xZ+
	yKjOqjVGGE3FNCkbRvvYOjln8Xvl7+jR9/uE=; b=oDMFf3XbGv+Eg1ZKayepFpj
	YE7rN2wAPsl7FLXDxZmrnz3DiwuBLHloyZNJmxSkCe8hfWOnJ+a02s2BuGRMJEsd
	IjYOQey+PJOAPo1m8XMiW5eb9mv7fyfUMk5DWRC6536xyaiuFy1q1CKIEdIoF4Ja
	Uc4tkLWlWPM6HC7ymDZTO5JlJA3pubLhWomLF9PyRDTUXvBsakX1xj3lGUol8eFP
	mse4i1Hb8grD+kh9voEtYt9XjvufGPLmqJA7Z7N6HS1BZyoCmAyNCqW+O6ScDXUe
	UuOHHUqvqeZ5MIGdvv2ljeVyUaYDSkiIJLv7hPJEHNwBkpLo85xmhHN3fTq9SEA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wndaj1xu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 04:22:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4254Lxk0014117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 04:21:59 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 20:21:55 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: qcom: Remove ACPI support from glue driver
Date: Tue, 5 Mar 2024 09:51:43 +0530
Message-ID: <20240305042143.3455101-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SjmvAjr0TfjVOwCri3R7ZTgQdRanphCJ
X-Proofpoint-GUID: SjmvAjr0TfjVOwCri3R7ZTgQdRanphCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_01,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=682 mlxscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050031

Minimal ACPI support was added to the Qualcomm DWC3 glue driver in order to
enable USB on SDM850 and SC8180X compute platforms. The support is still
functional, but unnoticed regressions in other drivers indicates that no
one actually booting any of platforms dependent on this implementation.

The functionality provides is the bare minimum and is not expected to aid
in the effort of bringing full ACPI support to the driver in the future.

Remove the ACPI code from the Qualcomm DWC3 glue driver to aid in the
implementation of improvements that are actually used like multiport and
flattening device tree.

Commit message by Bjorn Andersson.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 273 ++---------------------------------
 1 file changed, 11 insertions(+), 262 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index dbd6a5b2b289..a0879f224d96 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -4,7 +4,6 @@
  * Inspired by dwc3-of-simple.c
  */
 
-#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/clk.h>
@@ -53,22 +52,10 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
-struct dwc3_acpi_pdata {
-	u32			qscratch_base_offset;
-	u32			qscratch_base_size;
-	u32			dwc3_core_base_size;
-	int			qusb2_phy_irq_index;
-	int			dp_hs_phy_irq_index;
-	int			dm_hs_phy_irq_index;
-	int			ss_phy_irq_index;
-	bool			is_urs;
-};
-
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
 	struct platform_device	*dwc3;
-	struct platform_device	*urs_usb;
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
@@ -84,8 +71,6 @@ struct dwc3_qcom {
 	struct notifier_block	vbus_nb;
 	struct notifier_block	host_nb;
 
-	const struct dwc3_acpi_pdata *acpi_pdata;
-
 	enum usb_dr_mode	mode;
 	bool			is_suspended;
 	bool			pm_suspended;
@@ -248,9 +233,6 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 	struct device *dev = qcom->dev;
 	int ret;
 
-	if (has_acpi_companion(dev))
-		return 0;
-
 	qcom->icc_path_ddr = of_icc_get(dev, "usb-ddr");
 	if (IS_ERR(qcom->icc_path_ddr)) {
 		return dev_err_probe(dev, PTR_ERR(qcom->icc_path_ddr),
@@ -519,31 +501,13 @@ static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
 			  PIPE_UTMI_CLK_DIS);
 }
 
-static int dwc3_qcom_get_irq(struct platform_device *pdev,
-			     const char *name, int num)
-{
-	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	struct platform_device *pdev_irq = qcom->urs_usb ? qcom->urs_usb : pdev;
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	if (np)
-		ret = platform_get_irq_byname_optional(pdev_irq, name);
-	else
-		ret = platform_get_irq_optional(pdev_irq, num);
-
-	return ret;
-}
-
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
 	int irq;
 	int ret;
 
-	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
-				pdata ? pdata->qusb2_phy_irq_index : -1);
+	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
 	if (irq > 0) {
 		/* Keep wakeup interrupts disabled until suspend */
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
@@ -557,8 +521,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		qcom->qusb2_phy_irq = irq;
 	}
 
-	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
-				pdata ? pdata->dp_hs_phy_irq_index : -1);
+	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
@@ -571,8 +534,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		qcom->dp_hs_phy_irq = irq;
 	}
 
-	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
-				pdata ? pdata->dm_hs_phy_irq_index : -1);
+	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
@@ -585,8 +547,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		qcom->dm_hs_phy_irq = irq;
 	}
 
-	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
-				pdata ? pdata->ss_phy_irq_index : -1);
+	irq = platform_get_irq_byname_optional(pdev, "ss_phy_irq");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
@@ -649,88 +610,6 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	return 0;
 }
 
-static const struct property_entry dwc3_qcom_acpi_properties[] = {
-	PROPERTY_ENTRY_STRING("dr_mode", "host"),
-	{}
-};
-
-static const struct software_node dwc3_qcom_swnode = {
-	.properties = dwc3_qcom_acpi_properties,
-};
-
-static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
-{
-	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
-	struct device		*dev = &pdev->dev;
-	struct resource		*res, *child_res = NULL;
-	struct platform_device	*pdev_irq = qcom->urs_usb ? qcom->urs_usb :
-							    pdev;
-	int			irq;
-	int			ret;
-
-	qcom->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
-	if (!qcom->dwc3)
-		return -ENOMEM;
-
-	qcom->dwc3->dev.parent = dev;
-	qcom->dwc3->dev.type = dev->type;
-	qcom->dwc3->dev.dma_mask = dev->dma_mask;
-	qcom->dwc3->dev.dma_parms = dev->dma_parms;
-	qcom->dwc3->dev.coherent_dma_mask = dev->coherent_dma_mask;
-
-	child_res = kcalloc(2, sizeof(*child_res), GFP_KERNEL);
-	if (!child_res) {
-		platform_device_put(qcom->dwc3);
-		return -ENOMEM;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	child_res[0].flags = res->flags;
-	child_res[0].start = res->start;
-	child_res[0].end = child_res[0].start +
-		qcom->acpi_pdata->dwc3_core_base_size;
-
-	irq = platform_get_irq(pdev_irq, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out;
-	}
-	child_res[1].flags = IORESOURCE_IRQ;
-	child_res[1].start = child_res[1].end = irq;
-
-	ret = platform_device_add_resources(qcom->dwc3, child_res, 2);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add resources\n");
-		goto out;
-	}
-
-	ret = device_add_software_node(&qcom->dwc3->dev, &dwc3_qcom_swnode);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add properties\n");
-		goto out;
-	}
-
-	ret = platform_device_add(qcom->dwc3);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add device\n");
-		device_remove_software_node(&qcom->dwc3->dev);
-		goto out;
-	}
-	kfree(child_res);
-	return 0;
-
-out:
-	platform_device_put(qcom->dwc3);
-	kfree(child_res);
-	return ret;
-}
-
 static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 {
 	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
@@ -763,57 +642,12 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_device *dwc3_qcom_create_urs_usb_platdev(struct device *dev)
-{
-	struct platform_device *urs_usb = NULL;
-	struct fwnode_handle *fwh;
-	struct acpi_device *adev;
-	char name[8];
-	int ret;
-	int id;
-
-	/* Figure out device id */
-	ret = sscanf(fwnode_get_name(dev->fwnode), "URS%d", &id);
-	if (!ret)
-		return NULL;
-
-	/* Find the child using name */
-	snprintf(name, sizeof(name), "USB%d", id);
-	fwh = fwnode_get_named_child_node(dev->fwnode, name);
-	if (!fwh)
-		return NULL;
-
-	adev = to_acpi_device_node(fwh);
-	if (!adev)
-		goto err_put_handle;
-
-	urs_usb = acpi_create_platform_device(adev, NULL);
-	if (IS_ERR_OR_NULL(urs_usb))
-		goto err_put_handle;
-
-	return urs_usb;
-
-err_put_handle:
-	fwnode_handle_put(fwh);
-
-	return urs_usb;
-}
-
-static void dwc3_qcom_destroy_urs_usb_platdev(struct platform_device *urs_usb)
-{
-	struct fwnode_handle *fwh = urs_usb->dev.fwnode;
-
-	platform_device_unregister(urs_usb);
-	fwnode_handle_put(fwh);
-}
-
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
-	struct resource		local_res;
 	int			ret, i;
 	bool			ignore_pipe_clk;
 	bool			wakeup_source;
@@ -825,14 +659,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
-	if (has_acpi_companion(dev)) {
-		qcom->acpi_pdata = acpi_device_get_match_data(dev);
-		if (!qcom->acpi_pdata) {
-			dev_err(&pdev->dev, "no supporting ACPI device data\n");
-			return -EINVAL;
-		}
-	}
-
 	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
 	if (IS_ERR(qcom->resets)) {
 		return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
@@ -860,41 +686,18 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (np) {
-		parent_res = res;
-	} else {
-		memcpy(&local_res, res, sizeof(struct resource));
-		parent_res = &local_res;
-
-		parent_res->start = res->start +
-			qcom->acpi_pdata->qscratch_base_offset;
-		parent_res->end = parent_res->start +
-			qcom->acpi_pdata->qscratch_base_size;
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
-	}
+	parent_res = res;
 
 	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
 	if (IS_ERR(qcom->qscratch_base)) {
 		ret = PTR_ERR(qcom->qscratch_base);
-		goto free_urs;
+		goto clk_disable;
 	}
 
 	ret = dwc3_qcom_setup_irq(pdev);
 	if (ret) {
 		dev_err(dev, "failed to setup IRQs, err=%d\n", ret);
-		goto free_urs;
+		goto clk_disable;
 	}
 
 	/*
@@ -906,14 +709,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ignore_pipe_clk)
 		dwc3_qcom_select_utmi_clk(qcom);
 
-	if (np)
-		ret = dwc3_qcom_of_register_core(pdev);
-	else
-		ret = dwc3_qcom_acpi_register_core(pdev);
-
+	ret = dwc3_qcom_of_register_core(pdev);
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
-		goto free_urs;
+		goto clk_disable;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -945,16 +744,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 interconnect_exit:
 	dwc3_qcom_interconnect_exit(qcom);
 depopulate:
-	if (np) {
-		of_platform_depopulate(&pdev->dev);
-	} else {
-		device_remove_software_node(&qcom->dwc3->dev);
-		platform_device_del(qcom->dwc3);
-	}
+	of_platform_depopulate(&pdev->dev);
 	platform_device_put(qcom->dwc3);
-free_urs:
-	if (qcom->urs_usb)
-		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -969,21 +760,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 static void dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
-	if (np) {
-		of_platform_depopulate(&pdev->dev);
-	} else {
-		device_remove_software_node(&qcom->dwc3->dev);
-		platform_device_del(qcom->dwc3);
-	}
+	of_platform_depopulate(&pdev->dev);
 	platform_device_put(qcom->dwc3);
 
-	if (qcom->urs_usb)
-		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
-
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
@@ -1053,38 +835,6 @@ static const struct of_device_id dwc3_qcom_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
 
-#ifdef CONFIG_ACPI
-static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
-	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
-	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
-	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.qusb2_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2
-};
-
-static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
-	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
-	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
-	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.qusb2_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2,
-	.is_urs = true,
-};
-
-static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
-	{ "QCOM2430", (unsigned long)&sdm845_acpi_pdata },
-	{ "QCOM0304", (unsigned long)&sdm845_acpi_urs_pdata },
-	{ "QCOM0497", (unsigned long)&sdm845_acpi_urs_pdata },
-	{ "QCOM04A6", (unsigned long)&sdm845_acpi_pdata },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
-#endif
-
 static struct platform_driver dwc3_qcom_driver = {
 	.probe		= dwc3_qcom_probe,
 	.remove_new	= dwc3_qcom_remove,
@@ -1092,7 +842,6 @@ static struct platform_driver dwc3_qcom_driver = {
 		.name	= "dwc3-qcom",
 		.pm	= &dwc3_qcom_dev_pm_ops,
 		.of_match_table	= dwc3_qcom_of_match,
-		.acpi_match_table = ACPI_PTR(dwc3_qcom_acpi_match),
 	},
 };
 
-- 
2.34.1


