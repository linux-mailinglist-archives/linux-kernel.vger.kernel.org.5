Return-Path: <linux-kernel+bounces-54345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E6484ADF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335A7285D16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CB7F48C;
	Tue,  6 Feb 2024 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2D5XXav"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571780029;
	Tue,  6 Feb 2024 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196754; cv=none; b=gUK8MJKc5HYKj0Umj5xY+AAficeLbP7A5XWJzl2PUMRX/fe2FtZn54qSSXRSuX+JAy8sRgOgSwV1l+zw/zvhkgCiSIrRzBA5NOCIdxmGrMyde+S4GyrDVFeiJl88t/35dHM2b4735HOswqjx2zZpQ+KvGm6XdoN2C+mvYYfk59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196754; c=relaxed/simple;
	bh=j8iuvu7BppvpaCpiz8YTbF3FB1//iK8fz3i7rhvXSdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNmYJu1gDUyiqjY1KWy1afgMXhC4gCXeL3YkeasWWwpt8BXOW7J8cwgQNR2rluPr02RIcdupDRP2uB9gDaOqJE1R86tRA61FjvOCseG8xR2LoBV5zwyAyBguk2qFja4Gtplc8cB/Et0nrv2+34B25VNTr6LvfxB5u60IX1C0w0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2D5XXav; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164pXVa023084;
	Tue, 6 Feb 2024 05:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pYfflv6DE7m6RXZElDk+z3aDlyfLl3NWYNPAo4kwf+o=; b=R2
	D5XXavb+xDnKHSGfyxWPJXEl8cHNs1oOioiDuK1hVPERe+xcj0u2cCmQtowqBh3M
	owqYKAVZDbhseWB5o/QLMsL+g7zV5v0ySKyghdVWTqeh0ckzOKfsNyt913dWciPo
	txc5E0VFDH1GVABEssj/vpa7keE6dUAiMrWT90D7/6kj+6akVxFE9srs8qj4Zw1F
	owJ46+T4vB61Ted5iYTu8E//ojdKs3b5N4ir9YV+HqDDiMp5+4k91Y8nM9NbJazn
	keWnG+yMYGglL7ymPbigjo1JgBjjlKq3V8TfLHLRwS8o79xyL2WAKLVCDygtiksA
	3EJnBOXd7wXb3n/P8m+g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399erjp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:19:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4165J4cA026171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 05:19:04 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 21:18:59 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Harsh Agarwal
	<quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v14 4/9] usb: dwc3: core: Refactor PHY logic to support Multiport Controller
Date: Tue, 6 Feb 2024 10:48:20 +0530
Message-ID: <20240206051825.1038685-5-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: gIO8oKSMLEFa_Y30XrX7kSkUxvJ6LaBs
X-Proofpoint-ORIG-GUID: gIO8oKSMLEFa_Y30XrX7kSkUxvJ6LaBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=832
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060035

From: Harsh Agarwal <quic_harshq@quicinc.com>

Currently the DWC3 driver supports only single port controller
which requires at least one HS PHY and at most one SS PHY.

But the DWC3 USB controller can be connected to multiple ports and
each port can have their own PHYs. Each port of the multiport
controller can either be HS+SS capable or HS only capable
Proper quantification of them is required to modify GUSB2PHYCFG
and GUSB3PIPECTL registers appropriately.

Add support for detecting, obtaining and configuring PHYs supported
by a multiport controller. Limit support to multiport controllers
with up to four ports for now (e.g. as needed for SC8280XP).

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 251 ++++++++++++++++++++++++++++------------
 drivers/usb/dwc3/core.h |  14 ++-
 drivers/usb/dwc3/drd.c  |  15 ++-
 3 files changed, 193 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c47fec10b231..53cd5279e456 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -124,6 +124,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	int ret;
 	u32 reg;
 	u32 desired_dr_role;
+	int i;
 
 	mutex_lock(&dwc->mutex);
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -201,8 +202,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+			}
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
@@ -217,8 +220,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -589,22 +592,14 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 	return ret;
 }
 
-/**
- * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
- * @dwc: Pointer to our controller context structure
- *
- * Returns 0 on success. The USB PHY interfaces are configured but not
- * initialized. The PHY interfaces and the PHYs get initialized together with
- * the core in dwc3_core_init.
- */
-static int dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 {
 	unsigned int hw_mode;
 	u32 reg;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
 
 	/*
 	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
@@ -659,9 +654,19 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	return 0;
+}
+
+static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
+{
+	unsigned int hw_mode;
+	u32 reg;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
 	/* Select the HS PHY interface */
 	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
@@ -673,7 +678,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		} else if (dwc->hsphy_interface &&
 				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
 		} else {
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
@@ -740,7 +745,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->ulpi_ext_vbus_drv)
 		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+
+	return 0;
+}
+
+/**
+ * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
+ */
+static int dwc3_phy_setup(struct dwc3 *dwc)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		ret = dwc3_ss_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = dwc3_hs_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -748,23 +781,32 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 static int dwc3_phy_init(struct dwc3 *dwc)
 {
 	int ret;
+	int i;
+	int j;
 
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
 
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_shutdown_usb3_phy;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_exit_phy;
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_exit_usb2_phy;
+		ret = phy_init(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			phy_exit(dwc->usb2_generic_phy[i]);
+			goto err_exit_phy;
+		}
+	}
 
 	return 0;
 
-err_exit_usb2_phy:
-	phy_exit(dwc->usb2_generic_phy);
-err_shutdown_usb3_phy:
+err_exit_phy:
+	for (j = i - 1; j >= 0; j--) {
+		phy_exit(dwc->usb3_generic_phy[j]);
+		phy_exit(dwc->usb2_generic_phy[j]);
+	}
+
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
 
@@ -773,8 +815,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 
 static void dwc3_phy_exit(struct dwc3 *dwc)
 {
-	phy_exit(dwc->usb3_generic_phy);
-	phy_exit(dwc->usb2_generic_phy);
+	int i;
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_exit(dwc->usb3_generic_phy[i]);
+		phy_exit(dwc->usb2_generic_phy[i]);
+	}
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -783,23 +829,32 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 static int dwc3_phy_power_on(struct dwc3 *dwc)
 {
 	int ret;
+	int i;
+	int j;
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_suspend_usb3_phy;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err_power_off_phy;
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_power_off_usb2_phy;
+		ret = phy_power_on(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			phy_power_off(dwc->usb2_generic_phy[i]);
+			goto err_power_off_phy;
+		}
+	}
 
 	return 0;
 
-err_power_off_usb2_phy:
-	phy_power_off(dwc->usb2_generic_phy);
-err_suspend_usb3_phy:
+err_power_off_phy:
+	for (j = i - 1; j >= 0; j--) {
+		phy_power_off(dwc->usb3_generic_phy[j]);
+		phy_power_off(dwc->usb2_generic_phy[j]);
+	}
+
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 
@@ -808,8 +863,12 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
 static void dwc3_phy_power_off(struct dwc3 *dwc)
 {
-	phy_power_off(dwc->usb3_generic_phy);
-	phy_power_off(dwc->usb2_generic_phy);
+	int i;
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_power_off(dwc->usb3_generic_phy[i]);
+		phy_power_off(dwc->usb2_generic_phy[i]);
+	}
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -1201,6 +1260,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	unsigned int		hw_mode;
 	u32			reg;
 	int			ret;
+	int			i;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
@@ -1244,15 +1304,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
 		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+			for (i = 0; i < dwc->num_usb3_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+			}
 		}
 
 		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 		}
 	}
 
@@ -1372,7 +1436,9 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
 	struct device_node	*node = dev->of_node;
+	char phy_name[9];
 	int ret;
+	int i;
 
 	if (node) {
 		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
@@ -1398,22 +1464,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb2_generic_phy = NULL;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		if (dwc->num_usb2_ports == 1)
+			sprintf(phy_name, "usb2-phy");
 		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-	}
+			sprintf(phy_name, "usb2-%d", i);
+
+		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb2_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb2_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret,
+						"failed to lookup phy %s\n", phy_name);
+		}
 
-	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
-	if (IS_ERR(dwc->usb3_generic_phy)) {
-		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb3_generic_phy = NULL;
+		if (dwc->num_usb2_ports == 1)
+			sprintf(phy_name, "usb3-phy");
 		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+			sprintf(phy_name, "usb3-%d", i);
+
+		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb3_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb3_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret,
+						"failed to lookup phy %s\n", phy_name);
+		}
 	}
 
 	return 0;
@@ -1423,6 +1503,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
 	int ret;
+	int i;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
@@ -1430,8 +1511,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -1442,8 +1523,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+		}
 
 		ret = dwc3_host_init(dwc);
 		if (ret)
@@ -1939,6 +2022,10 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
 
 	iounmap(base);
 
+	if (dwc->num_usb2_ports > DWC3_MAX_PORTS ||
+	    dwc->num_usb3_ports > DWC3_MAX_PORTS)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -2176,6 +2263,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	u32 reg;
+	int i;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2194,17 +2282,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
 		    dwc->dis_enblslpm_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-				DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+					DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 
 			/* Give some time for USB2 PHY to suspend */
 			usleep_range(5000, 6000);
 		}
 
-		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -2234,6 +2326,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 	unsigned long	flags;
 	int		ret;
 	u32		reg;
+	int		i;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2253,17 +2346,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (dwc->dis_u2_susphy_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+			if (dwc->dis_u2_susphy_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-		if (dwc->dis_enblslpm_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+			if (dwc->dis_enblslpm_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+		}
 
-		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c52fef99838..38f88a341a69 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -33,6 +33,12 @@
 
 #include <linux/power_supply.h>
 
+/*
+ * Maximum number of ports currently supported for multiport
+ * controllers.
+ */
+#define DWC3_MAX_PORTS 4
+
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
@@ -1037,8 +1043,8 @@ struct dwc3_scratchpad_array {
  * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
- * @usb2_generic_phy: pointer to USB2 PHY
- * @usb3_generic_phy: pointer to USB3 PHY
+ * @usb2_generic_phy: pointer to array of USB2 PHYs
+ * @usb3_generic_phy: pointer to array of USB3 PHYs
  * @num_usb2_ports: number of USB2 ports
  * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
@@ -1186,8 +1192,8 @@ struct dwc3 {
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-	struct phy		*usb2_generic_phy;
-	struct phy		*usb3_generic_phy;
+	struct phy		*usb2_generic_phy[DWC3_MAX_PORTS];
+	struct phy		*usb3_generic_phy[DWC3_MAX_PORTS];
 
 	u8			num_usb2_ports;
 	u8			num_usb3_ports;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 57ddd2e43022..d76ae676783c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -331,6 +331,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 	u32 reg;
 	int id;
 	unsigned long flags;
+	int i;
 
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
@@ -386,9 +387,12 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy,
-					     PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				if (dwc->usb2_generic_phy[i]) {
+					phy_set_mode(dwc->usb2_generic_phy[i],
+						     PHY_MODE_USB_HOST);
+				}
+			}
 		}
 		break;
 	case DWC3_OTG_ROLE_DEVICE:
@@ -400,9 +404,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy,
-				     PHY_MODE_USB_DEVICE);
+		if (dwc->usb2_generic_phy[0])
+			phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
 			dev_err(dwc->dev, "failed to initialize peripheral\n");
-- 
2.34.1


