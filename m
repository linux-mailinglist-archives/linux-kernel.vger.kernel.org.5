Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA680EA56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbjLLL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbjLLLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:25:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD2F5;
        Tue, 12 Dec 2023 03:25:44 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC8L6Zk003141;
        Tue, 12 Dec 2023 11:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=auJmLGf36BIEwAaCkoXd64xnACfFIbcd3T94XlIuBhQ=; b=U9
        bCGMjbkwGGIL+UsPuGTC+hwtjJ0tQ7s7nDU802EN6lfz7qqfgj7WPPVBChspjrIF
        hyIihSjtbMmr7rS12WMU4nxET3Mw/9KmjD4IFGPjRcALEeBE5Dd6uJYB5RyN6yTb
        bj7aCuLpjHkiAvkd9UG9s6ta/+SThx4rdvG2SIWB8Z+4lb9BxaW9XK2/jkzI9UDE
        4n/TGOBCviQqEwzilQkDF4Q8Diy/31jjQS51uckMsuxf2sbQEW+KhSFOyX5MqMdm
        HRs2gnUUmYo3vv6LR6dkdqltXAnzwA9yHpRTInAezlIJHMUskEjWK8ibU4UL1RpJ
        QjnjSWFxtbHEYJ5dE/KA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxkx58e8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:25:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBPev0017163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:25:40 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:25:37 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK
Date:   Tue, 12 Dec 2023 16:55:21 +0530
Message-ID: <20231212112521.3774610-3-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212112521.3774610-1-quic_prashk@quicinc.com>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -YEW9CJ-8GK5uoJNMNdNBhyOBMEfdHhX
X-Proofpoint-ORIG-GUID: -YEW9CJ-8GK5uoJNMNdNBhyOBMEfdHhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120091
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
which fixes XHC timeout, which was seen on synopsys XHCs while
using SG buffers. Currently this quirk can only be set using
xhci private data. But there are some drivers like dwc3/host.c
which adds adds quirks using software node for xhci device.
Hence set this xhci quirk by iterating over device properties.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 732cdeb73920..3c928cbf0558 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -250,6 +250,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
+			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
-- 
2.25.1

