Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A77E350A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjKGGKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:10:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCD10F;
        Mon,  6 Nov 2023 22:10:06 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A75QHOg009740;
        Tue, 7 Nov 2023 06:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TJ6K7QS0tX20YF3a9J4LB3meI6Sg6zcVszwc0Lz3C3k=;
 b=TfQsnYm6xQIOf683WMo98Rc6eYJaiXQQ72dULwCT3jMaa/OZeYIXPemTm1F4OkXXVcpc
 qck4aGt1gNUSC2DbZI3QyvYfIMll+J89TSLahSq9SaiBSWUtpF1QTZ8ePG6UQ4lodXcf
 Zm26Zwc1Xn+JVZc2MyS9M+BtQe/fkQZjvKydUgpWm6YzduAVwRVH9W81eC2vu1N7VjS2
 snrEqqlo8CRWgfxikxvDLpwBIBocaeXREQFfwdmuCTNabJuBnMm1zcSoxB15LooXjKTW
 ZWGO2jXsTgr5cW9OMpzgHTQYiOvag1K8a0T44AAlHdYN09C8tXtPTV/Q4keZPOvZuhSL kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72avssu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 06:09:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A769p6J019474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 06:09:51 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 22:09:51 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Subject: [PATCH v1 0/2] coresight: Add remote etm support
Date:   Mon, 6 Nov 2023 22:09:33 -0800
Message-ID: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: llF_Nw759j3z7MjuQrLA2kX7XyWzG2UG
X-Proofpoint-GUID: llF_Nw759j3z7MjuQrLA2kX7XyWzG2UG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=690 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system on chip (SoC) consists of main APSS(Applications processor
subsytem) and additional processors like modem, lpass. There is
coresight-etm driver for etm trace of APSS. Coresight remote etm driver
is for enabling and disabling the etm trace of remote processors.
It uses QMI interface to communicate with remote processors' software
and uses coresight framework to configure the connection from remote
etm source to TMC sinks.

Example to capture the remote etm trace:

Enable source:
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/remote_etm0/enable_source

Capture the trace:
cat /dev/tmc_etf0 > /data/remote_etm.bin

Disable source:
echo 0 > /sys/bus/coresight/devices/remote_etm0/enable_source

Mao Jinlong (2):
  coresight: Add remote etm support
  dt-bindings: arm: Add remote etm driver

 .../arm/qcom,coresight-remote-etm.yaml        |  59 ++++
 drivers/hwtracing/coresight/Kconfig           |   9 +
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-core.c  |   3 +
 drivers/hwtracing/coresight/coresight-qmi.h   | 109 ++++++
 .../coresight/coresight-remote-etm.c          | 325 ++++++++++++++++++
 include/linux/coresight.h                     |   1 +
 7 files changed, 507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-qmi.h
 create mode 100644 drivers/hwtracing/coresight/coresight-remote-etm.c

-- 
2.41.0

