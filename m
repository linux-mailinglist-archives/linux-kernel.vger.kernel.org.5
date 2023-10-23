Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B237D2E02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJWJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJWJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A16D7B;
        Mon, 23 Oct 2023 02:21:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7Ru3f027059;
        Mon, 23 Oct 2023 09:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FAsGC2GCdTt739888DFQKe/Ps6P7so29IhyE17GBLnY=;
 b=SamacrxQLu3KOVYp0pR+8hzQsB/HU+53rz74EmcdSMU3LETJcm0krXh7h5d4sKrooFws
 D3nCJvBzu3cw9p76ThJq+P7mEIzCZyw7RNIfo1moP88GGlCw6I68XCLTspFtuhSSFD1o
 gQ4hsaqep1J/YHkFusWEv9HoggyIPEqZceOasA0VijiOCLy3jC/8I/1sdjKv34IZholu
 T+P1K36x20maI9QhonMM5Zs03xWq4S44yT1pZWYyw7GtGJyc3lvEqgAzW6hI27tDpv98
 4Jxp3hH27S0nW/7vfBDJBt4oRCQYJ3SiRWaLIV1bZ3ER1avso27BB/bDavVeHUGkI54s DQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv71d3k53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9LGjT015469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:16 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:21:11 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v1 0/5] soc/arm64: qcom: add initial version of memory dump
Date:   Mon, 23 Oct 2023 17:20:52 +0800
Message-ID: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SUg97CiL91Q73T6CwbAsLCIowSgXIcl0
X-Proofpoint-GUID: SUg97CiL91Q73T6CwbAsLCIowSgXIcl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=421
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm memory dump driver is to cooperate with firmware, providing the
hints(id and size) of storing useful debugging information into pre-allocated
memory. Firmware then does the real data capture. The debugging information
includes cache contents, internal memory, registers. 

The driver dynamically reserves memory and provides the hints(dump id and size)
following specified protocols with firmware. After crash and warm reboot,
firmware scans these information and stores contents into reserved memory
accordingly. Firmware then enters into full dump mode which dumps whole DDR
to host through USB.

User then get full dump using PCAT and can parse out these informations.

Dump id and size are provided by bootconfig. The expected format of a
bootconfig file is as follows:-
memory_dump_config {
	<node name> {
		id = <id of HW component>
		size = <dump size of HW component>
	}
}

for example:
memory_dump_config {
        c0_context_dump {
		id = 0
		size = 0x800
        }
}

Test based on 6.6-rc1.

Zhenhua Huang (5):
  dt-bindings: soc: qcom: Add memory_dump driver bindings
  dt-bindings: sram: qcom,imem: document sm8250
  soc: qcom: memory_dump: Add memory dump driver
  arm64: defconfig: enable Qcom Memory Dump driver
  arm64: dts: qcom: sm8250: Add memory dump node

 .../bindings/soc/qcom/qcom,mem-dump.yaml           |  42 ++
 .../devicetree/bindings/sram/qcom,imem.yaml        |  45 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  31 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/memory_dump.c                     | 540 +++++++++++++++++++++
 8 files changed, 678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
 create mode 100644 drivers/soc/qcom/memory_dump.c

-- 
2.7.4

