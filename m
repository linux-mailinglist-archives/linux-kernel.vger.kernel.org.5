Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D680EA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbjLLLZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346356AbjLLLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:25:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B4F3;
        Tue, 12 Dec 2023 03:25:39 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC7J7lc002473;
        Tue, 12 Dec 2023 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=m/1gc5/
        vET/rlUp4PJwtLowpOZzoNqriN3cdN+35i2Q=; b=IcvI+wYB5lfvM0GCJ7r0VsF
        LCb08Ac7gmqHpW9GRwCRmnKgsBYaYtGHeOOSoe5kwHGwt0OueIUMekqXGNoyno+v
        tHv4/TnvwNxhz1MHtP+rlTECv+Pve7CMnRL1n8eXoRh241OgfNg1L0qQjVDKTQJl
        adEWO/XzQtbRSt0t36fJ7X4Y0m33eLpaM6Ng/w0OrM+TwccIUTPqepUf5sDB//sR
        NJi6oiDGViF5Lg+Dkilco9zp1nuysvLCf+wqN8BgXVNoJ509yicYra9af2t0gik9
        X/9f5s9BDcOXzrzKCCNWJtrw8jMLYQFwY7Q8z10q0BBvOtzfxlrk0HNjCtpJOQg=
        =
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxctasb25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:25:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBPYPn016798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:25:34 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:25:32 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v2 0/2] Set XHCI_SG_TRB_CACHE_SIZE_QUIRK for DWC3 devices
Date:   Tue, 12 Dec 2023 16:55:19 +0530
Message-ID: <20231212112521.3774610-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O3AcRkztajW_Q5ckBo_uICCKZYBj5Q9T
X-Proofpoint-ORIG-GUID: O3AcRkztajW_Q5ckBo_uICCKZYBj5Q9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=649 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120091
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

In Synopsys DWC3 databook,
Table 9-3: xHCI Debug Capability Limitations
Chained TRBs greater than TRB cache size: The debug capability
driver must not create a multi-TRB TD that describes smaller
than a 1K packet that spreads across 8 or more TRBs on either
the IN TR or the OUT TR.

More information about this XHCI quirk is mentioned on the
following thread.
https://lore.kernel.org/all/20201208092912.1773650-3-mathias.nyman@linux.intel.com/

Changes in v2:
Changed implementation using device property instead of priv_data
Split the single patch into 2 patch series, v1 is mentioned below
https://lore.kernel.org/all/20231121135936.1669167-1-quic_prashk@quicinc.com/

Prashanth K (2):
  usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
  usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

 drivers/usb/dwc3/host.c      | 2 ++
 drivers/usb/host/xhci-plat.c | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.25.1

