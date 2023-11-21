Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53B7F23D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKUCZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUCZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:25:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25775AA;
        Mon, 20 Nov 2023 18:25:36 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0OY5c028552;
        Tue, 21 Nov 2023 02:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=kU6bepyHJLPXRb3yHjWtij7AyNrmvADA0jgdZ3VliRw=;
 b=fSbqzSAJJRlAPbpzNNlJgElQ1BVpxWm625IMaV/wASqTCKeFqOJuOtTcSBqPRfhRiXok
 N/szzfh7UuVQhgUSeggvALMFiF9qKtyEVAH5UV2FOJ6n+1985C3rvlC3A0TYRspIIMv3
 +8cgFBnyOSjWkFED+fFpA1RY0fl0f0H27FlaTuieluiL6VLAYubrEd1wDpFp7hWViC+F
 +uh1Jh5XUIf8p9yM/Q4vVbsqkB5xhciX/ooapvz5IA/CK2XoH/qvdZy+4XxyVE8AuRQZ
 8tY1SF8cwJmqRBiosM+WW7zyul8eCTLsv8RKvaTtp4Mofs+Yr3BBOqrzsmKnmexUIHSu Cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uge000mg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2PJnf010513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:25:19 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:25:14 -0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v3 0/8] Add support to configure TPDM CMB subunit
Date:   Tue, 21 Nov 2023 10:24:46 +0800
Message-ID: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EYnhZk_CW4ybUR8zOvCgVi3rPLIX2fa7
X-Proofpoint-ORIG-GUID: EYnhZk_CW4ybUR8zOvCgVi3rPLIX2fa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of TPDM CMB(Continuous Multi Bit) subunit
CMB subunit is responsible for creating a dataset element, and is also
optionally responsible for packing it to fit multiple elements on a
single ATB transfer if possible in the configuration. The TPDM Core
Datapath requests timestamps be stored by the TPDA and then delivering
ATB sized data (depending on ATB width and element size, this could
be smaller or larger than a dataset element) to the ATB Mast FSM.
The CMB makes trace elements in two modes. In ‘continuous’ mode, every
valid data cycle creates an element. In ‘trace on change’ mode, when
valid data changes on the bus, a trace element is created. In
continuous mode, all cycles where this condition is true create trace
elements. In trace on change mode, a data element is only when the
previously sampled input is different from the current sampled input.

The CMB subunit must be configured prior to enablement. This series
adds support for TPDM to configure the configure CMB subunit.

Once this series patches are applied properly, the new tpdm nodes for
should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
which supports CMB subunit.
e.g.
root@qemuarm64:/sys/devices/platform/soc@0/684c000.tpdm/tpdm0# ls -l
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_mode
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_msr
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_patt
drwxr-xr-x    2 root     root             0 Jan  1 00:00 cmb_trig_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_trig_ts
-rw-r--r--    1 root     root          4096 Jan  1 00:00 cmb_ts_all
drwxr-xr-x    2 root     root             0 Jan  1 00:00 connections
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_edge
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_msr
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_patt
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_trig_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 enable_source
--w-------    1 root     root          4096 Jan  1 00:00 integration_test
drwxr-xr-x    2 root     root             0 Ja?  1 00:00 power
--w-------    1 root     root          4096 Jan  1 00:00 reset_dataset
lrwxrwxrwx    1 root     root             0 Apr  5  2021 subsystem -> ../../../../../bus/coresight
-rw-r--r--    1 root     root          4096 Apr  5  2021 uevent
-r--r--r--    1 root     root          4096 Jan  1 00:00 waiting_for_supplier

We can use the commands are similar to the below to configure the
TPDMs which support CMB subunit. Enable coresight sink first.
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/reset_dataset
echo 1 > /sys/bus/coresight/devices/tpdm0/cmb_mode
echo 1 > /sys/bus/coresight/devices/tpdm0/cmb_patt/enable_ts
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/cmb_patt/tpmr0
echo 0 > /sys/bus/coresight/devices/tpdm0/cmb_trig_ts
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/cmb_trig_patt/xpr1
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source

codelinaro link:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-cmb-v3

Changes in V3:
1. Add 8-bit support to the description in the TPDM devicetree document.
-- Rob Herring
2. Change how the result is produced in "tpdm_read_element_size".
-- James Clark
3. Calling "tpdm_clear_element_size" at the beginning of
"tpda_enable_port".
-- James Clark
4. Use "dsb_esize" and "cmb_esize" to determine whether multiple TPDMs
are detected on a TPDA input port in "tpda_get_element_size".
-- James Clark
5. Modify the judgment logic in "tpda_enable_port".
-- James Clark
6. Add more description of "cmb_mode" to TPDM SysFS document.
-- James Clark

Changes in V2:
1. Optimizate and modify this patch series based on the patch series
"Add support to configure TPDM CMB subunit".
2. Modify the functions that read the element size of DSB/CMB in TPDA driver.

Tao Zhang (8):
  dt-bindings: arm: Add support for CMB element size
  coresight-tpda: Add support to configure CMB element
  coresight-tpdm: Add CMB dataset support
  coresight-tpdm: Add support to configure CMB
  coresight-tpdm: Add pattern registers support for CMB
  coresight-tpdm: Add timestamp control register support for the CMB
  dt-bindings: arm: Add support for TPDM CMB MSR register
  coresight-tpdm: Add msr register support for CMB

 .../testing/sysfs-bus-coresight-devices-tpdm  |  87 ++++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  38 ++
 drivers/hwtracing/coresight/coresight-tpda.c  | 117 +++---
 drivers/hwtracing/coresight/coresight-tpda.h  |   6 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 390 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  |  87 ++++
 6 files changed, 673 insertions(+), 52 deletions(-)

-- 
2.17.1

