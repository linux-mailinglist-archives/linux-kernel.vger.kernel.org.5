Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F6784084
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjHVMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjHVMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:15:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8D6199;
        Tue, 22 Aug 2023 05:15:52 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MABNrE018413;
        Tue, 22 Aug 2023 12:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5fy9r+OihAp7IxpCaXvtSARKZ9Gq58Rvo24OX1Y8VWw=;
 b=B4JYBwDnE1fKefAeKPyxz0dACb74blgbxYf+ekMQ3Xk3Aq8KkYJNLB0sOPtw+mNJojPq
 ztzbY7104EcEsjv3IzbBX87DblCNN32xel4ZZ8yCfPNCKAFCdk0ulOoFtQ021cwUkRKa
 lbfZrMuGoTzp8K6gRGnDiylHAQnPNcPyNCaP0gwLjYu9gQdkfuvAFqIq1A0IptN4PCPo
 nwBya63Z+sOcPElvVAfnYZfjBv9B0cgKNTfta5Fgt1fdgKztbSR11u1hn0qWBNBObFXJ
 8M1zKyNFROSHthfK+Mm3WuiKZXj8WgnxYlDNCL0KXJ/BufS9fQk+HEQPGHycm3BDg0e9 Dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smdhwhhk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 12:15:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MCFlLL002440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 12:15:47 GMT
Received: from hu-ninanaik-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 05:15:42 -0700
From:   Ninad Naik <quic_ninanaik@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>
Subject: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
Date:   Tue, 22 Aug 2023 17:45:11 +0530
Message-ID: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LkJPrnnGDQF9hkgy2tkdj-CfE1ZhQm0c
X-Proofpoint-GUID: LkJPrnnGDQF9hkgy2tkdj-CfE1ZhQm0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_11,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=935 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot time logs for Qualcomm secondary boot-loader or XBL can help to
identify different set of information regarding firmware configuration,
SoC boot KPIs. A dedicated region is carved out in the memory map in order
to store this log in the memory.

The objective of this driver is to read the XBL boot log stored in
this memory region post boot-up, and provide an entry in debugfs, which
can be used to read back the logs and print them on to the console.

Further, this log can be parsed to extract different set of information
as required.

For example, one use case can be parsing boot time KPIs to calculate,
 - PBL End time
 - SBL End time
 - UEFI Start/Stop time

Corresponding log contents as captured in /sys/kernel/debug/xbl_log entry
which prints the above counters,

        S -     59378 - PBL, End
        B -     68198 - SBL1, Start
        B -   1308877 - SBL1, End
        UEFI Start     [ 3370]
         - 0x0AF001000 [ 3375] Sec.efi
        UEFI Total : 466 m
        POST Time      [ 3836] OS Loader
         - 0x0ABE10000 [ 3838] LinuxLoader.efi
        Exit EBS        [ 4878] UEFI End

        /* Note - these are few excerpts picked from the complete XBL log
         *        as tested on SA8775p
         */

Ninad Naik (1):
  soc: qcom: Add driver to read secondary bootloader (XBL) log

 drivers/soc/qcom/Kconfig        |  13 +++
 drivers/soc/qcom/Makefile       |   1 +
 drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/soc/qcom/dump_xbl_log.c

-- 
2.41.0

