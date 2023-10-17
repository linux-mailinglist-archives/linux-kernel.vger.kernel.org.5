Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537077CCD28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjJQUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjJQUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:01:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174CD110;
        Tue, 17 Oct 2023 13:01:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJXXxa010251;
        Tue, 17 Oct 2023 20:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Xk8ISyjTzgsfSY0vX24SAQNx8CM2OMLl0VLNRxny4/A=;
 b=lX9O3Sc6GlhHixxzhfT45IeNl1qXIRzTrtPOaD1Y+3PRDNFjLzhKeaFiX0QzsUVpgzY5
 N6YvcSdudX35KgK/swjGVVd6qgT+oHmtQW1PDow+XrsZgWg94Mk/rhJYd/T93y1cBcQ0
 SM2MU/+itwHeV+H/RBUi0JxCmNKVgx5qcTFZeabzSUjSTXfaVUbBR3cGIG4UfrlZ+SPj
 lfxxrN2MlFyURx3Omym22Rr3HmvKZw73u0uVm35eUX0eScnCkRQvnuAGN3Ff9zmKWRAN
 VPyZFcBZhVlwuvvLDH5RZL0H+4IexZSyEC0zTa7eAo9spFruCiv/gHgqQ4HhQ+byOUwG Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxwrpus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HK1Kcl018659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:21 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 13:01:20 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v9 06/34] usb: host: xhci-mem: Allow for interrupter clients to choose specific index
Date:   Tue, 17 Oct 2023 13:00:41 -0700
Message-ID: <20231017200109.11407-7-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017200109.11407-1-quic_wcheng@quicinc.com>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wECXEfHTKH0PZ6boTf_apRgbaR0hwVss
X-Proofpoint-ORIG-GUID: wECXEfHTKH0PZ6boTf_apRgbaR0hwVss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=571 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clients may operate only on a specific XHCI interrupter instance.
Allow for the associated class driver to request for the interrupter that
it requires.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-mem.c       | 30 ++++++++++++++++--------------
 drivers/usb/host/xhci-sideband.c  |  5 +++--
 drivers/usb/host/xhci.h           |  3 ++-
 include/linux/usb/xhci-sideband.h |  3 ++-
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b8936daf6cf5..3d6ee70bd6f7 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2343,7 +2343,7 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 }
 
 struct xhci_interrupter *
-xhci_create_secondary_interrupter(struct usb_hcd *hcd)
+xhci_create_secondary_interrupter(struct usb_hcd *hcd, int intr_num)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_interrupter *ir;
@@ -2358,28 +2358,30 @@ xhci_create_secondary_interrupter(struct usb_hcd *hcd)
 		return NULL;
 
 	spin_lock_irq(&xhci->lock);
-
-	/* Find available secondary interrupter, interrupter 0 is reserved for primary */
+	/* Find available secondary interrupter, interrupter 0 is reserverd for primary */
 	for (i = 1; i < xhci->max_interrupters; i++) {
-		if (xhci->interrupters[i] == NULL) {
-			err = xhci_add_interrupter(xhci, ir, i);
-			break;
+		if ((intr_num > 0 && i == intr_num) || intr_num <= 0) {
+			if (xhci->interrupters[i] == NULL) {
+				err = xhci_add_interrupter(xhci, ir, i);
+				if (err) {
+					spin_unlock_irq(&xhci->lock);
+					goto free_ir;
+				}
+				break;
+			}
 		}
 	}
-
 	spin_unlock_irq(&xhci->lock);
 
-	if (err) {
-		xhci_warn(xhci, "Failed to add secondary interrupter, max interrupters %d\n",
-			  xhci->max_interrupters);
-		xhci_free_interrupter(xhci, ir);
-		return NULL;
-	}
-
 	xhci_dbg(xhci, "Add secondary interrupter %d, max interrupters %d\n",
 		 i, xhci->max_interrupters);
 
 	return ir;
+
+free_ir:
+	xhci_free_interrupter(xhci, ir);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(xhci_create_secondary_interrupter);
 
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index cc4f90375e00..13a8a260b024 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -242,12 +242,13 @@ EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
  * Returns 0 on success, negative error otherwise
  */
 int
-xhci_sideband_create_interrupter(struct xhci_sideband *sb)
+xhci_sideband_create_interrupter(struct xhci_sideband *sb, int intr_num)
 {
 	if (sb->ir)
 		return -EBUSY;
 
-	sb->ir = xhci_create_secondary_interrupter(xhci_to_hcd(sb->xhci));
+	sb->ir = xhci_create_secondary_interrupter(xhci_to_hcd(sb->xhci),
+			intr_num);
 	if (!sb->ir)
 		return -ENOMEM;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7161b0841368..23d26f44e9b5 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2092,7 +2092,8 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 		int type, gfp_t flags);
 void xhci_free_container_ctx(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *ctx);
-struct xhci_interrupter *xhci_create_secondary_interrupter(struct usb_hcd *hcd);
+struct xhci_interrupter *xhci_create_secondary_interrupter(struct usb_hcd *hcd,
+		int intr_num);
 void xhci_remove_secondary_interrupter(struct usb_hcd
 				       *hcd, struct xhci_interrupter *ir);
 void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
index c1457d1800f4..7f4080f530d3 100644
--- a/include/linux/usb/xhci-sideband.h
+++ b/include/linux/usb/xhci-sideband.h
@@ -54,7 +54,8 @@ struct sg_table *
 xhci_sideband_get_event_buffer(struct xhci_sideband *sb);
 
 int
-xhci_sideband_create_interrupter(struct xhci_sideband *sb);
+xhci_sideband_create_interrupter(struct xhci_sideband *sb,
+				 int intr_num);
 
 void
 xhci_sideband_remove_interrupter(struct xhci_sideband *sb);
