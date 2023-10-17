Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15EB7CCCFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjJQUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjJQUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:01:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF037F1;
        Tue, 17 Oct 2023 13:01:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJRv3G031259;
        Tue, 17 Oct 2023 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2u2Hw4cQxnaiuMAYd+x/zUYluVwUQV8zR7nL/DLubdM=;
 b=LMVpNN5Lzmc1d12scQ7zxYxmwiZTXQhR9nTBgBHb7/Y1xhDKM+ZUjmtV9iVjGlPUDjqd
 6epT2i6vv54wRQrkOAoaVvIRIRyDnavYrakWY+P4I7CuVtEUOfjTw5ARtftvi/mxrwUe
 mxl0Gyyn8lyv/R21r16CTFsmAa4Jh4MSYxwIrJfby2/bFWF7OVo9MHh2tLTnTAwBCmb1
 oJ1UP5aoXgvuxatQcOEvFsNNLZ7bFmGKjauj9mMTvloA3tQ2QtXDfXVHMKCAEzf58CUM
 ajJcDU0dXtXELz2XMgKUMGqE3SIRVdGihMQZwL+8klf8orGF6EOD9LyS4UX5wfQ03X8b iQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnej9qhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HK1J0d010264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:19 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 13:01:19 -0700
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
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v9 01/34] xhci: split free interrupter into separate remove and free parts
Date:   Tue, 17 Oct 2023 13:00:36 -0700
Message-ID: <20231017200109.11407-2-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: zutR5yPPknOWcT9Gq93-GGlpYtwcJ1pN
X-Proofpoint-ORIG-GUID: zutR5yPPknOWcT9Gq93-GGlpYtwcJ1pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

The current function that both removes and frees an interrupter isn't
optimal when using several interrupters. The array of interrupters need
to be protected with a lock while removing interrupters, but the default
xhci spin lock can't be used while freeing the interrupters event ring
segment table as dma_free_coherent() should be called with IRQs enabled.

There is no need to free the interrupter under the lock, so split this
code into separate unlocked free part, and a lock protected remove part.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-mem.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 0a37f0d511cf..0994ca9fba44 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1797,23 +1797,14 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
 }
 
 static void
-xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
+xhci_remove_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
-	size_t erst_size;
 	u64 tmp64;
 	u32 tmp;
 
 	if (!ir)
 		return;
 
-	erst_size = sizeof(struct xhci_erst_entry) * ir->erst.num_entries;
-	if (ir->erst.entries)
-		dma_free_coherent(dev, erst_size,
-				  ir->erst.entries,
-				  ir->erst.erst_dma_addr);
-	ir->erst.entries = NULL;
-
 	/*
 	 * Clean out interrupter registers except ERSTBA. Clearing either the
 	 * low or high 32 bits of ERSTBA immediately causes the controller to
@@ -1828,10 +1819,28 @@ xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 		tmp64 &= (u64) ERST_PTR_MASK;
 		xhci_write_64(xhci, tmp64, &ir->ir_set->erst_dequeue);
 	}
+}
+
+static void
+xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
+{
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	size_t erst_size;
+
+	if (!ir)
+		return;
+
+	erst_size = sizeof(struct xhci_erst_entry) * ir->erst.num_entries;
+	if (ir->erst.entries)
+		dma_free_coherent(dev, erst_size,
+				  ir->erst.entries,
+				  ir->erst.erst_dma_addr);
+	ir->erst.entries = NULL;
 
-	/* free interrrupter event ring */
+	/* free interrupter event ring */
 	if (ir->event_ring)
 		xhci_ring_free(xhci, ir->event_ring);
+
 	ir->event_ring = NULL;
 
 	kfree(ir);
@@ -1844,6 +1853,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
 
+	xhci_remove_interrupter(xhci, xhci->interrupter);
 	xhci_free_interrupter(xhci, xhci->interrupter);
 	xhci->interrupter = NULL;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed primary event ring");
