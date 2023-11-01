Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD37DDCFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjKAHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKAHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:12:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D771C2;
        Wed,  1 Nov 2023 00:12:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A15ajHL030431;
        Wed, 1 Nov 2023 07:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GmF2UW/uh2FonkvFNEGvXHnhUgmtV8BI/HPj8Y9TIAY=;
 b=UwXzte1iIpW+I+00nDrpJKpq5vkPIEvnEZxsmic0vAad1SpA4mNfgAAjQoIsflMT+wu2
 a3gP63ejka09DRDWSwrv0hXBoi9ifCvg0XONMf8/DyzEr22up7tzanEdPWzIRmzCuJrL
 uHiah2sGSaT1QTfDTKhrxNXRcw19vIievsSWnMmtQAHRMp85PDRxXZzpvn908oHnT6F5
 0niyIivdsoWx6IbQWLixwzXew7027nEzqNmjAWrDcopOor/h/D/wn658yg3GWzbDU3HQ
 mY9b7+y7D26COtZtidgsYj5jCUDjSOvywhY1OQzYvc9eZwiX0plwrsuz2To8+1N/w79U +Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3382jfry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 07:12:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A17BxQP013210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 07:11:59 GMT
Received: from hu-gkohli-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 00:11:56 -0700
From:   Gaurav Kohli <quic_gkohli@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>,
        <quic_bjorande@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <iommu@lists.linux.dev>,
        <steven.price@arm.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gaurav Kohli" <quic_gkohli@quicinc.com>
Subject: [RFC 0/1] Add custom alloc and free pgtable callback
Date:   Wed, 1 Nov 2023 12:41:43 +0530
Message-ID: <20231101071144.16309-1-quic_gkohli@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-j-vbT05H8hjLiMv0Hju3EaONetCO95
X-Proofpoint-ORIG-GUID: Z-j-vbT05H8hjLiMv0Hju3EaONetCO95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_04,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 mlxlogscore=409 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel does not support customizable page table support,
Below series from Boris is helping to solve this problem by
introducing custome alloc and free ops:

https://lore.kernel.org/all/20230809121744.2341454-1-boris.brezillon@collabora.com/

For cases, where HLOS has to setup s1 pgtable and request firmware
to share the same to different entity(VMID), there is no easy way 
to achieve the same.

This patchset over Boris patches is an attempt to solve the same problem
where HLOS can do below things with help of custom alloc and free
pgtable ops:

-> Parse VMID from vendor implementation driver.
-> Provide custom and free pg table ops, which help to
   create pages for page table from custom ops.
-> And HLOS can also create S1 page table from custom ops and
   request firmware to share the same to headless VM or different
   entity(VMID).

Gaurav Kohli (1):
  arm-smmu: Add iommu support to share pgtable

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 81 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  8 +++
 2 files changed, 89 insertions(+)

-- 
2.17.1

