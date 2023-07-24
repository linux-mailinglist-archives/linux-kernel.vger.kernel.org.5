Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B2760250
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGXWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjGXWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:31:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335BD10E3;
        Mon, 24 Jul 2023 15:31:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OMIQEw029962;
        Mon, 24 Jul 2023 22:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=tgztBj0/mJz03MJdJCZ9JHhqYfeG+XgYMvyAdd3/QYQ=;
 b=Jolm/4Pto6H89NYXkiAY7sBP8McF6X5D9RAED5RaPWKCwo+tYb5IKqLr+XFMNtMTImxU
 v3qJM0Wh54TbYkdZE8XdI0IFNy7zGmbi2xxz0Fkih90YqWfSTBD66xncYYTU/9W88nWU
 3EjL7oCmuaX9XvuP2ie1MBnWiKm75Z38e+jerYhu4f9+1COlGo6bVR9x+HpZheZVX8yb
 Pp9ERQ2abZHJ99Vg6l3lXEt2k/tcekPjt//TXmDv/t72w1TcXj2pRGlT6V7O3tCMqDVG
 IhMecU7/iAWvixQcBzOgqDMjom+vBHQXPtE7JAnQuaj1IrU+ZnUsJnfWTuyYS0yzgCaq mQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1v6u8w4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OMVE3b005283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 15:31:14 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Prasad Sodagudi" <quic_psodagud@quicinc.com>
Subject: [RFC PATCH 0/4] Implement a PSCI SYSTEM_RESET2 reboot-mode driver
Date:   Mon, 24 Jul 2023 15:30:50 -0700
Message-ID: <20230724223057.1208122-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AJZTyLSqDAycFmRx5BX6rUgsWlnPQb9X
X-Proofpoint-GUID: AJZTyLSqDAycFmRx5BX6rUgsWlnPQb9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_16,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=844 lowpriorityscore=0 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI implements a restart notifier for architectural defined resets.
The SYSTEM_RESET2 call allows vendor firmware to define additional reset
types which could be mapped to the reboot reason.

Implement a driver to wire the reboot-mode framework to make vendor
SYSTEM_RESET2 calls on reboot.

This is a continuation from https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Elliot Berman (4):
  power: reset: reboot-mode: Allow magic to be 0
  power: reset: reboot-mode: Wire reboot_mode enum to magic
  dt-bindings: power: reset: Document arm,psci-vendor-reset
  power: reset: Implement a PSCI SYSTEM_RESET2 reboot-mode driver

 .../power/reset/arm,psci-vendor-reset.yaml    | 35 +++++++++++++
 MAINTAINERS                                   |  2 +
 drivers/firmware/psci/psci.c                  |  9 ++++
 drivers/power/reset/Kconfig                   |  9 ++++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/psci-vendor-reset.c       | 49 +++++++++++++++++++
 drivers/power/reset/reboot-mode.c             | 44 ++++++++++++-----
 include/linux/psci.h                          |  2 +
 8 files changed, 139 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
 create mode 100644 drivers/power/reset/psci-vendor-reset.c


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0

