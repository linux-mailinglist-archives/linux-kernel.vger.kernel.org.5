Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E877A74D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHMPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHMPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:13:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266AE6A;
        Sun, 13 Aug 2023 08:13:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DEaLkQ028394;
        Sun, 13 Aug 2023 15:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=mYvpXGhs/tn8Tw4cpt8ycDzZ2epbzb3Kv/ScWNicpQ4=;
 b=AWFQy680ZdlFt2e/xY4slcZ+nozybUbhnbsr6JdYmw/UHVnJtHIIj60BLR2r1x2wb77C
 yTZxtjOukfKQTZEseK9OLZ/uDVXWSYIzI8e+p3WV+ozPXGOrgUiQD7IGdxR+FlOUZlpw
 LKO2OOj98cZkXZiAVqAQDtyf4cSaGmu3QwqHuh2Jm3Vso6xSua6G7mG0xCNX2EfZ73qD
 JA1Ei/o6hARCOqRh0TwIqX0kMeUlMdePrn0DuORPCKjkfWe2I4t1x210xdnhLp3ZJibK
 A7EF5Cydkl0wDutZveTUJN5A7KzVjC+mtnqjUt+PQXvjLgy8q7MYodNMLEv34yOZ3C2Q sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3hssuqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37DFDEZi029232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:13:14 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 13 Aug 2023 08:13:09 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v2 0/3] Add support for a streaming interface for TMC ETR
Date:   Sun, 13 Aug 2023 23:12:50 +0800
Message-ID: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HlN3xipJ3le7D2DUJWSXdIMg_bidI7cV
X-Proofpoint-ORIG-GUID: HlN3xipJ3le7D2DUJWSXdIMg_bidI7cV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=596 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to add support for a streaming interface for
TMC ETR to allow for continuous log collection to secondary storage.
An interrupt based mechanism is used to stream out the data from the device.

QDSS_CS_QDSSCSR_ETRIRQCTRL register is used to set the IRQ byte counter
value. The value of this registers defines the number of bytes that when moved by
the ETR AXI interface. It will casues an interrupt which can be used by an
userspace program to know how much data is present in memory requiring copy to some
other location. A zero setting disables the interrupt.A one setting
means 8 bytes, two 16 bytes, etc. In other words, the value in this
register is the interrupt threshold times 8 bytes. ETR must be enabled
when use this interrupt function.

Sample:
echo 4096 > /sys/bus/coresight/devices/csr0/etr_byte_cntr_val
echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/stm0/enabl_source

cat /dev/byte-cntr > /data/qdss.bin &

The log collection will stop after disabling the ETR.

codelinaro link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/coresight-byte-cntr-v2?ref_type=heads

Change in V2:
Make CSR device as a helper device of ETR device. When enable ETR, it
will enable CSR byte-cntr function.

Mao Jinlong (3):
  Coresight: Add driver to support for CSR
  dt-bindings: arm: Adds CoreSight CSR hardware definitions
  coresight-csr: Add support for streaming interface for ETR

 .../testing/sysfs-bus-coresight-devices-csr   |   6 +
 .../bindings/arm/qcom,coresight-csr.yaml      | 130 ++++++
 MAINTAINERS                                   |   2 +-
 drivers/hwtracing/coresight/Kconfig           |  12 +
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/coresight-core.c  |  31 +-
 .../coresight/coresight-csr-bytecntr.c        | 275 ++++++++++++
 .../hwtracing/coresight/coresight-csr-core.c  | 393 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-csr.h   | 112 +++++
 drivers/hwtracing/coresight/coresight-priv.h  |   8 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |   3 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 include/dt-bindings/arm/coresight-csr-dt.h    |  12 +
 include/linux/coresight.h                     |   3 +-
 14 files changed, 984 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-csr
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-csr-bytecntr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-csr-core.c
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.h
 create mode 100644 include/dt-bindings/arm/coresight-csr-dt.h

-- 
2.17.1

