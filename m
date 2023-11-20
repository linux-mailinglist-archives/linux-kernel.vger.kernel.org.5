Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDCF7F0BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjKTF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:58:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1659DE;
        Sun, 19 Nov 2023 21:58:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK3mTjS018683;
        Mon, 20 Nov 2023 05:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=12XFNR9I7qJcE+51vDot/mqJhDOeqI3VsWlt7HEydsg=;
 b=NqcQwMTRe/wfqEH67ys4ereBLZzzQujGHGWnn6Vf0tA/D0Bf6HnM4XBWsy4+NyzAyAcl
 zO8mbXAsq7JNJyo7DPZ8VrMbtHFrlmnJfVnSbasiE65TLc1GhHzf9v8G3lHEIaLomz+G
 /zHI9FwjdU1Eyv1r88SPXcZEWfSKih2Gr2cVLyqcLA2uw4OYnq8hhKIpHV11XVXidWY9
 WaO3GrXJiFq8u+v3cv3AQ6rPijYvZzZf+Td/8gppQ58EGvALHGPwGSYdtKXJZaXrsisU
 a84y8OTDwaFk5wHylep/H41D+NE+rFQmI69zg1wzK4PW7FJ/smmp2ArG8bBzMKpUL2QA gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uepjhjyd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 05:58:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK5wHTq011918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 05:58:17 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 19 Nov 2023 21:58:14 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     <stable@vger.kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usbyy@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v2 0/2] Add support for xhci-sg-trb-cache-size-quirk
Date:   Mon, 20 Nov 2023 11:28:01 +0530
Message-ID: <20231120055803.224634-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KWbNbXkdeeIg4qTu4z7D0wSdLezIv5vR
X-Proofpoint-GUID: KWbNbXkdeeIg4qTu4z7D0wSdLezIv5vR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_03,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=691 clxscore=1015 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XHCI_SG_TRB_CACHE_SIZE_QUIRK was introduced in XHCI to resolve
XHC timeout while using SG buffers, which was seen Synopsys XHCs.
The support for this isn't present in DWC3 layer, this series
enables XHCI_SG_TRB_CACHE_SIZE_QUIRK since this is needed for
DWC3 controller.

Changes in v2:
Included xhci-plat.c to pass the quirks via priv data.
Added Fixes tag in device tree binding patch.

Prashanth K (2):
  usb: dwc3: core: Add support for xhci-sg-trb-cache-size-quirk
  dt-bindings: usb: snps,dwc3: Add 'xhci-sg-trb-cache-size-quirk'

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml |  7 +++++++
 drivers/usb/dwc3/core.c                              |  2 ++
 drivers/usb/dwc3/core.h                              |  3 +++
 drivers/usb/dwc3/host.c                              | 10 ++++++++++
 4 files changed, 22 insertions(+)

-- 
2.25.1

