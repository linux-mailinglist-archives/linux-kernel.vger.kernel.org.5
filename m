Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968627BD8E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbjJIKkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbjJIKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:40:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B59D;
        Mon,  9 Oct 2023 03:40:38 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3999xgLV014632;
        Mon, 9 Oct 2023 10:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fo29B5ogljByjTFWeRxan604GVuHCTLUJe/zKny8lv0=;
 b=Yk22zjGtkhxi8HZkKcfio+S1f0gWfZxNEFVmQ5pym/uU6CIf7t80q3W09g2kqcGf5GQl
 w5yZ8cUMXjNn3EDaMBKXaEa21trdg5wYjIN+CIbhBVviUxNWsue0cO1froWFWpllP5aN
 4FKitfSkEPir+PCoJlEsk35FqnlFspIv/cPBx6DWcXICwtwkkYqkSR8xbm+CTf1C02pV
 pKsE32GL4iJQJJhLe8qbnIKepagNm+vYW84vJuFplXM4/Igk4eeOBlyhGnONWFcRu6nK
 xwnnN3cK79m4A+h6UywtNzhmmirCfvQs94kZgMNXxaazRPGm0AhnGbQ34BT/ESS7bFZn fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh5e26vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 10:39:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399AdxLn017209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 10:39:59 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 9 Oct 2023 03:39:55 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, <stable@kernel.org>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH RESEND] xhci: Keep interrupt disabled in initialization until host is running.
Date:   Mon, 9 Oct 2023 16:09:26 +0530
Message-ID: <1696847966-27555-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q7GwYVxX0Jx2Uv4vBvPNZYM70rmdULVv
X-Proofpoint-ORIG-GUID: Q7GwYVxX0Jx2Uv4vBvPNZYM70rmdULVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_09,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=743 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Xie <xy521521@gmail.com>

[ Upstream commit a808925075fb750804a60ff0710614466c396db4 ]

irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
It's possible that you will receive thousands of interrupt requests
after initialization for 2.0 roothub. And you will get a lot of
warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
disabled?". This amount of interrupt requests will cause the entire
system to freeze.
This problem was first found on a device with ASM2142 host controller
on it.

[tidy up old code while moving it, reword header -Mathias]

Cc: stable@kernel.org
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20220623111945.1557702-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/host/xhci.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 541fe4d..7ee747e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -607,8 +607,27 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	unsigned long	flags;
+	u32		temp;
+
+	/*
+	 * Enable interrupts before starting the host (xhci 4.2 and 5.5.2).
+	 * Protect the short window before host is running with a lock
+	 */
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable interrupts");
+	temp = readl(&xhci->op_regs->command);
+	temp |= (CMD_EIE);
+	writel(temp, &xhci->op_regs->command);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable primary interrupter");
+	temp = readl(&xhci->ir_set->irq_pending);
+	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
+
 	if (xhci_start(xhci)) {
 		xhci_halt(xhci);
+		spin_unlock_irqrestore(&xhci->lock, flags);
 		return -ENODEV;
 	}
 	xhci->shared_hcd->state = HC_STATE_RUNNING;
@@ -619,6 +638,8 @@ static int xhci_run_finished(struct xhci_hcd *xhci)
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Finished xhci_run for USB3 roothub");
+
+	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
 }
 
@@ -667,19 +688,6 @@ int xhci_run(struct usb_hcd *hcd)
 	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
 	writel(temp, &xhci->ir_set->irq_control);
 
-	/* Set the HCD state before we enable the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= (CMD_EIE);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enable interrupts, cmd = 0x%x.", temp);
-	writel(temp, &xhci->op_regs->command);
-
-	temp = readl(&xhci->ir_set->irq_pending);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
-			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
-	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
-
 	if (xhci->quirks & XHCI_NEC_HOST) {
 		struct xhci_command *command;
 
-- 
2.7.4

