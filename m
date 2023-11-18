Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8967EFDF1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjKRFzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 00:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjKRFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 00:55:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16CA6;
        Fri, 17 Nov 2023 21:55:33 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI5pKdK009856;
        Sat, 18 Nov 2023 05:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FdcousxXEK2YX0DQ9FacyS/BELtwq6xvR7XtMp1Ohs4=;
 b=euyEDQIOBVFXAWu8DPP4iAmxgQRi8/pJF6PktzYTBlwPgkkJJvVvPN5TJLRU4ZcjAyYu
 YlOLzTflFtXQ0enrJxmREFiVABAQHnr5VDByVhRSPvcVYtc3XboUeweJhnPQ7wg6SjkM
 KR6aZutRf9WhfNRlfX1mvOPVi7ZJ6soGVMr4KzYFWXRi9+Cab1LhmybAHk/WoVfq95lY
 e2P3r086UAQIqnUX7KPR/pglD2fqSAcTk0J5iknueGuXWmT2TlWy1nwdOejQiBOdPypQ
 8Rl1gpZStQmlt3L345l2WcnGaI5C/aXNDIQDKeNLSjkVBeRKGqs77HnVjLaBjD73N1Qr Nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejymraqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 05:55:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI5tSE9016769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 05:55:28 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 21:55:25 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     <stable@vger.kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usbyy@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH 1/2] usb: dwc3: core: Add support for xhci-sg-trb-cache-size-quirk
Date:   Sat, 18 Nov 2023 11:24:54 +0530
Message-ID: <20231118055455.249088-2-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231118055455.249088-1-quic_prashk@quicinc.com>
References: <20231118055455.249088-1-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AVfXllujiIXt12qzfEIBvJy0WwogW_qx
X-Proofpoint-ORIG-GUID: AVfXllujiIXt12qzfEIBvJy0WwogW_qx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
which fixes XHC timeout while using SG buffers. Add a new quirk
in DWC3 layer to enable this XHCI quirk since this is needed
for DWC3 controller. Added xhci private data structure to pass
the quirk to XHCI.

In Synopsys DWC3 databook,
Table 9-3: xHCI Debug Capability Limitations
Chained TRBs greater than TRB cache size: The debug capability
driver must not create a multi-TRB TD that describes smaller
than a 1K packet that spreads across 8 or more TRBs on either
the IN TR or the OUT TR

Cc: <stable@vger.kernel.org> # 5.11
Fixes: bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/core.c | 2 ++
 drivers/usb/dwc3/core.h | 3 +++
 drivers/usb/dwc3/host.c | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0328c86..c6b0ae9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1633,6 +1633,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,parkmode-disable-hs-quirk");
 	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
 				"snps,gfladj-refclk-lpm-sel-quirk");
+	dwc->xhci_sg_trb_cache_size_quirk = device_property_read_bool(dev,
+				"xhci-sg-trb-cache-size-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index efe6caf..dde1447 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1119,6 +1119,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
  *                          running based on ref_clk
+ * @xhci_sg_trb_cache_size_quirk: set to prevent XHC timeout when scatter-gather
+ *			is enabled due to TRB_CACHE_SIZE.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
@@ -1342,6 +1344,7 @@ struct dwc3 {
 	unsigned		parkmode_disable_ss_quirk:1;
 	unsigned		parkmode_disable_hs_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
+	unsigned		xhci_sg_trb_cache_size_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe..09f049b 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -63,6 +63,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 {
 	struct property_entry	props[4];
 	struct platform_device	*xhci;
+	struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
 	int			ret, irq;
 	int			prop_idx = 0;
 
@@ -87,6 +88,14 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
+	if (dwc->xhci_sg_trb_cache_size_quirk)
+		dwc3_xhci_plat_priv.quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
+	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
+					sizeof(dwc3_xhci_plat_priv));
+	if (ret)
+		goto err;
+
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
 	if (dwc->usb3_lpm_capable)
-- 
2.7.4

