Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE279C186
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjILBPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjILBPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:15:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81217A9F3;
        Mon, 11 Sep 2023 18:02:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BNPkoX026380;
        Mon, 11 Sep 2023 23:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OAKZowELMuTGKnR3vCC2jgfxXUTvEmcpCXqGHpnuwxw=;
 b=QiNeGZnnFkgUr5bLatGDZ3L/hLj7ocODy7sHRKTKt+0oTGA26Y+W7IILD92lWUCeueOO
 fPpayg3hf7CMho7ziO1+zowQr+K8qzt9dwghgR+nu/nRUv/VEnu4dpwiS2ne+ZkRWkOV
 AT/Wxb87oajjUA9uMCCnSRYwvjXzlpQSxOiByknadCt29bun17ha2YhtLEjXWv+QKbv4
 e8h8BZ8moSyVgEI4Q50HfcSedr/Nw57X4d/0hN7hnHnLvfqfckQ5VHvLOhW8Py18Pl7K
 J3ustVdeeClc5l5zX82c1+o9Pira2RtgrLacu5HuXf+8FDo1z0SNjKt7VW2bNShiKfss lA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xkjt2s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:41:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BNfXww030391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:41:33 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 16:41:32 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer
Date:   Mon, 11 Sep 2023 16:41:22 -0700
Message-ID: <20230911234122.1408-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zZnjhJT5fv20qI2n5qC9w05YDJj8v4Ag
X-Proofpoint-ORIG-GUID: zZnjhJT5fv20qI2n5qC9w05YDJj8v4Ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=742 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in:
  commit 474ed23a6257 ("xhci: align the last trb before link if it is
easily splittable.")

A bounce buffer is utilized for ensuring that transfers that span across
ring segments are aligned to the EP's max packet size.  However, the device
that is used to map the DMA buffer to is currently using the XHCI HCD,
which does not carry any DMA operations in certain configrations.
Migration to using the sysdev entry was introduced for DWC3 based
implementations where the IOMMU operations are present.

Replace the reference to the controller device to sysdev instead.  This
allows the bounce buffer to be properly mapped to any implementations that
have an IOMMU involved.

cc: <stable@vger.kernel.org>
Fixes: 4c39d4b949d3 ("usb: xhci: use bus->sysdev for DMA configuration")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..98389b568633 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -798,7 +798,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -3469,7 +3469,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;
