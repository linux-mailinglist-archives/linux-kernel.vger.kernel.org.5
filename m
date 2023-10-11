Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5E7C4613
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjJKAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbjJKAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:23:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099C9E;
        Tue, 10 Oct 2023 17:23:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ANDW4n019165;
        Wed, 11 Oct 2023 00:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1o9AgF+HsBUM8GdL2XQ2LUtTvou/SDC6UHkFrWrK4+s=;
 b=nRGQ38+SkYaL8IhwxG+cI4YJs6u8KWEcYuYUTptlgi61kxdCow0QvPFXywCvZ5eqUFcH
 QIp7CqxArq8Y9BBMW08f2lUQxM9Eg63A16piDRxLH5BnIQlVhgJeCUxY3sEFuGTu+8Jz
 gykbgfLS54suVXtP+LvnhPvf0GYqTXogftFdpH/RsulJhCsNHhegZGKv4DWxdsUeDdNG
 4HAgE8MXRjeM2erGX7GkFIzzQDIMXpGjIjLKXyNnMmfU0bP5CiUib6Lsw2w+pOQEIOsR
 bDMS+9199BWELoD+xMUvcShbGIWA8jZ40dvOXNw7DQzKOs+e0wfbLoC2Af0EiaRWLeeJ zg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn492stc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 00:22:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B0MUXi002137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 00:22:30 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 17:22:30 -0700
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
Subject: [PATCH v8 06/34] usb: host: xhci-mem: Allow for interrupter clients to choose specific index
Date:   Tue, 10 Oct 2023 17:21:18 -0700
Message-ID: <20231011002146.1821-7-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011002146.1821-1-quic_wcheng@quicinc.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K9zjymFteWgJ6WateLevapEwQhbnYdMq
X-Proofpoint-ORIG-GUID: K9zjymFteWgJ6WateLevapEwQhbnYdMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=576
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index e6df1cb15e5b..cdfa70275dec 100644
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
index 9ef375e5c27e..298bcef81918 100644
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
