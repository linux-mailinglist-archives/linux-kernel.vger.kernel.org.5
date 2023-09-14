Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1A79FAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjINFo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjINFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:44:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8684BB;
        Wed, 13 Sep 2023 22:44:22 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E4TKnY028895;
        Thu, 14 Sep 2023 05:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=B6E/cHMJlwO2nIX+v4kNCEs6vSsvDZ1W7C+JgRkrVEM=;
 b=jGlPTJ8YQcEbl1lr2V2YGsunYMPWrK0sYIaegZw6xIeTUmPhORn/W7m/oRgivkdiCCIw
 rxJ/rKxi4xSl3LvDDIbC3UOIeTsDNUx0sNGji+mlstG+28esblxjma54Ig9w02+uHd+T
 xeFQT+fzRyvtzKHssEz4WZ5JKIHCjuEIAsczCD9yGXhbnUu/psU/wzHRVxrZOq7T7FxT
 GeiI4yZX1r6V3fCf85mKsR4fdN/T7b8kHtVq1DCI9tO+Xko0wQpG54+4Zvksv+G/BQL6
 9ZbBmWHOOwfkB75wWqTF0Wc3w8cHC/VJ4oAz6WNvozF/f9meBmWFC4qiAumtUnE7Dxiy 9Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3003kja0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:43:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E5hpoM029427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 05:43:51 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 22:43:46 -0700
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
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v9 00/13] Add support to configure TPDM DSB subunit
Date:   Thu, 14 Sep 2023 13:43:11 +0800
Message-ID: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DHQ5WT8pW6VRf7IrI2lFWBKnUuRZe1xF
X-Proofpoint-GUID: DHQ5WT8pW6VRf7IrI2lFWBKnUuRZe1xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of TPDM DSB subunit
DSB subunit is responsible for creating a dataset element, and is also
optionally responsible for packing it to fit multiple elements on a
single ATB transfer if possible in the configuration. The TPDM Core
Datapath requests timestamps be stored by the TPDA and then delivering
ATB sized data (depending on ATB width and element size, this could
be smaller or larger than a dataset element) to the ATB Mast FSM.

The DSB subunit must be configured prior to enablement. This series
adds support for TPDM to configure the configure DSB subunit.

Once this series patches are applied properly, the new tpdm nodes for
should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
which supports DSB subunit.
e.g.
root@qemuarm64:/sys/devices/platform/soc@0/6c08000.tpdm/tpdm1# ls -l
drwxr-xr-x    2 root     root             0 Jan  1 00:00 connections
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_edge
-rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_mode
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_msr
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_ts
-rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_type
drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_trig_patt
-rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_ts
-rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_type
-rw-r--r--    1 root     root          4096 Jan  1 00:02 enable_source
--w-------    1 root     root          4096 Jan  1 00:00 integration_test
drwxr-xr-x    2 root     root             0 Jan  1 00:00 power
--w-------    1 root     root          4096 Jan  1 00:02 reset_dataset
lrwxrwxrwx    1 root     root             0 Apr  5  2021 subsystem -> ../../../../../bus/coresight
-rw-r--r--    1 root     root          4096 Apr  5  2021 uevent
-r--r--r--    1 root     root          4096 Jan  1 00:00 waiting_for_supplier

We can use the commands are similar to the below to configure the
TPDMs which support DSB subunit. Enable coresight sink first.
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm1/reset_dataset
echo 0x3 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_idx
echo 0x1 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_mask
echo 0x0 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_val
echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/enable_ts
echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/set_type
echo 0 > /sys/bus/coresight/devices/tpdm1/dsb_trig_ts
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_patt/tpmr5
echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_trig_patt/xpr2
echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source

TPDM_DSB commit tree:
https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/tpdm-dsb-v9
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-dsb-v9

Changes in V9:
1. Adjust the alignment for all the patches in this series.
-- Suzuki K Poulose
2. Initialize the variable "ret" to 0 in the patch#4.
-- Suzuki K Poulose
3. Change the kernel version to 6.7 for all the sysfs files
in the documents for this patch series.
-- Suzuki K Poulose
4. Remove the parameter "max" from the general read/write
functions in the patch#9 and patch#10.
-- Suzuki K Poulose
5. Avoid releasing the lock in two different places in the
patch#10.
-- Suzuki K Poulose
6. Rename "dsb_patt_ts" to "enable_ts", and rename "dsb_patt_type"
to "set_type" in the patch#11. Move these two sysfs files to the
folder "dsb_patt".
-- Suzuki K Poulose
7. Clear the relevant fields first in the function "set_dsb_tier".
-- Suzuki K Poulose
8. Reading/writing the TIER register in the function "set_dsb_tier".
-- Suzuki K Poulose
9. Read the property "qcom,dsb_msr_num" during probe.
-- Suzuki K Poulose
10. Move the variable "dsb_msr_num" to "drvdata".
-- Suzuki K Poulose
11. Move the msr number check to simple tpdm sysfs API.
-- Suzuki K Poulose
12. Remove the needless "msr number" check in the function
"tpdm_reset_datasets"
-- Suzuki K Poulose

Changes in V8:
1. Refine the function "tpda_set_element_size" and rename it
to "tpda_get_element_size" in the patch#4.
-- Suzuki K Poulose
2. Refine the functioin "tpda_enable_port" in the patch#4.
-- Suzuki K Poulose
3. Write a helper to check if the TPDM has DSB dataset in the
patch#5.
-- Suzuki K Poulose
4. Move the function "tpdm_reset_datasets" to "datasets_setup"
to call in the patch#5.
-- Suzuki K Poulose
5. Refine the comment of DSB in "tpdm_drvdata" in the patch#5.
-- Suzuki K Poulose
6. Refine the comments in the documents for this patch series.
-- Suzuki K Poulose
7. Adjust the code alignment in this patch series.
-- Suzuki K Poulose
8. Combine the mode related functions to one in the patch#8.
-- Suzuki K Poulose
9. Refine the R/W functions of "dsb_mode" in the patch#8.
-- Suzuki K Poulose
10. Adjust the macros of mode in the TPDM header file in the
patch#8.
-- Suzuki K Poulose
11. Remove the unused code and fix the warnings in compiling
for the patch#9.
-- kernel test robot
12. Use the following sysfs nodes to read/set edge control
related value in the patch#9.
dsb_edge/
	\- ctrl_idx		-> Set the index number
	\- ctrl_val		-> Set the edge control value
	\- ctrl_mask	-> Set the edge control mask
	\- edcr0 ... edcr15		-> Read the edge control value
	\- edcmr0 ... edcmr7	-> Read the edge control mask
-- Suzuki K Poulose
13. Use the following sysfs nodes to read/set DSB trigger
pattern value and mask in the patch#10.
dsb_trig_patt/
	\- xpr0 ... xpr15		-> (RW) Set/Get the value
	\- xpmr0 ... xpmr7		-> (RW) Set/Get the mask
-- Suzuki K Poulose
14. Use the following sysfs nodes to read/set DSB pattern
value and mask in the patch#11.
dsb_patt/
	\- tpr0 ... tpr15		-> (RW) Set/Get the value
	\- tpmr0 ... tpmr7		-> (RW) Set/Get the mask
-- Suzuki K Poulose
15. Add "Acked-by" tag to the patch#12.
-- Rob Herring
16. Use the following sysfs nodes to read/set DSB MSR in
the patch#13.
dsb_msr/
	\- msr0 ... msr31		-> (RW) Set/Get the value
-- Suzuki K Poulose
17. Create the maximal number of DSB MSR sysfs nodes if the
TPDM supports DSB MSR. Write the values set by user space to
the DSB MSR according to the number of MSR supported by the
TPDM.
-- Suzuki K Poulose

Changes in V7:
1. Since the "One value" limitation on SysFs file usage, add
the nodes to read/write the index number for configuring the
DSB TPDM. The following index number nodes are added.
"dsb_edge_ctrl_idx" in the patch #9
"dsb_trig_patt_idx" in the patch #10
"dsb_patt_idx" in the patch #11
"dsb_msr_idx" in the patch #13
-- Suzuki K Poulose

Changes in V6:
1. Align the code to fix the styling issue.
-- Suzuki K Poulose

Changes in V5:
1. Correct data type for DSB element size in dt-bindings patch.
2. Refine the recursive function "tpda_set_element_size".
-- Suzuki K Poulose
3. Get return value of the function "__tpda_enable" in
"tpda_enable".
-- Suzuki K Poulose
4. Refine the comments on "dsb_esize".
-- Suzuki K Poulose
5. Split the chage that introduce the subtype
"SUBTYPE_SOURCE_TPDM" to Coresight driver.
-- Suzuki K Poulose
6. Inline the trigger type setting to "tpdm_enable_dsb" simply.
-- Suzuki K Poulose
7. Split the change that remove the needless CS_{UN,}LOCK in
the function "tpdm_datasets_setup".
-- Suzuki K Poulose
8. Remove the disablement step in the reset node.
-- Suzuki K Poulose
9. Update the kernel version to 6.5 in the sysfs document.
-- Suzuki K Poulose
10. Remove the needless check in "tpdm_dsb_is_visible".
-- Suzuki K Poulose
11. Change the macro to mask the mode of DSB TPDM.
-- Suzuki K Poulose
12. Add a check to make sure "sysfs_emit_at" calling will not
cause overflow.
-- Suzuki K Poulose
13. Change the macro to get "edge_ctrl" value.
-- Suzuki K Poulose
14. Remove the needless comments in the sysfs document.
-- Suzuki K Poulose
15. Replace "TPDM_DSB_MAX_PATT" with "drvdata->dsb->msr_num" in
"dsb_msr_show".
-- Suzuki K Poulose
16. Update the check of MSR number in "dsb_msr_store".
-- Suzuki K Poulose
17. Write data to the MSR registers in the DSB TPDM enablement
function.
-- Suzuki K Poulose

Changes in V4:
1. Change the range of the property "qcom,dsb-element-size", and
change the type to enumeration.
-- Suzuki K Poulose, Krzysztof Kozlowski
2. Change dsb_esize from 32 bits to 8 bits.
-- Suzuki K Poulose
3. Update the function tpda_set_element_size since James has
updated the dependency series. Meanwhile, it will send out a
warning if it detects more than one TPDM from the same TPDA
input port.
-- Suzuki K Poulose
4. Add a source_sub_type for TPDM to distinguish TPDM from
the other coresight source.
-- Suzuki K Poulose
5. Return error if the element size is not configured on
devicetree in TPDA enablement.
-- Suzuki K Poulose
6. Move memory allocation from "tpdm_init_datasets" to
"tpdm_datasets_setup". Rename "tpdm_init_datasets" as
"tpdm_reset_datasets".
-- Suzuki K Poulose
7. Replace "coresight_disable" with "coresight_disable_source"
to disable the TPDM in resetting.
-- Suzuki K Poulose
8. Make sure "drvdata" is not NULL pointer before using it.
-- Suzuki K Poulose
9. Change "set_dsb_cycacc_mode" to "set_dsb_test_mode" since
cycle accurate mode is not supported on the current targets.
It is replaced by test mode.
10. Document the value of "dsb_mode".
-- Suzuki K Poulose
11. Macros are used to replace the formulas on dsb edge control
nodes.
-- Suzuki K Poulose
12. Document the values of "dsb_trig_patt_val" and
"dsb_trig_patt_mask".
-- Suzuki K Poulose
13. Combine two pattern related loops to one. And move DSB TIER
register configurations to the new function "set_dsb_tier".
-- Suzuki K Poulose
14. Rename the property "qcom,dsb_msr_num" to "qcom,dsb-msrs-num".
-- Suzuki K Poulose, Krzysztof Kozlowski

Changes in V3:
1. Move the property "qcom,dsb-element-size" to TPDM
devicetree and update the TPDM yaml file for this item.
-- Suzuki K Poulose
2. Add the error message when the DSB element size is not set to
32-bit or 64-bit. -- Suzuki K Poulose
3. Add more information to the comments of patch #3
-- Suzuki K Poulose
4. Combine the value updates to the TPDM_DSB_CR for TPDM.
-- Suzuki K Poulose
5. Remove the function "tpdm_datasets_alloc", and fold its code
to a new function "tpdm_init_datasets". It will complete the
initialization of TPDM.  -- Suzuki K Poulose
6. Change the method of qualifying input values.
-- Suzuki K Poulose
7. Add the documentation of the new sysfs handles.
-- Suzuki K Poulose
8. Provide the separate handles for the "mode bits".
-- Suzuki K Poulose

Changes in V2:
1. Change the name of the property "qcom,dsb-elem-size" to
"qcom,dsb-element-size" -- Suzuki K Poulose
2. Update the TPDA yaml file for the item "qcom,dsb-elem-size".
-- Krzysztof Kozlowski
3. Add the full name of DSB in the description of the item
"qcom,dsb-elem-size". -- Rob Herring

Changes in V1:
1. Change the definition of the property "qcom,dsb-elem-size" from
"uint32-array" to "uint32-matrix". -- Krzysztof Kozlowski
2. Add the full name of DSB. -- Rob Herring
3. Deal with 2 entries in an iteration in TPDA driver. -- Suzuki K Poulose
4. Divide the function "tpdm_datasets_alloc" into two functions,
"tpdm_datasets_setup" and "tpdm_datasets_alloc".
5. Detecte the input string with the conventional semantics automatically,
and constrain the size of the input value. -- Suzuki K Poulose
6. Use the hook function "is_visible()" to hide the DSB related knobs if
the data sets are missing. -- Suzuki K Poulose
7. Use the macros "FIELD_GET" and "FIELD_PREP" to set the values.
-- Suzuki K Poulose
8. Update the definition of the macros in TPDM driver.
9. Update the comments of the values for the nodes which are for DSB
element creation and onfigure pattern match output. -- Suzuki K Poulose
10. Use API "sysfs_emit" to "replace scnprintf". -- Suzuki K Poulose

Tao Zhang (13):
  coresight-tpdm: Remove the unnecessary lock
  dt-bindings: arm: Add support for DSB element size
  coresight-tpdm: Introduce TPDM subtype to TPDM driver
  coresight-tpda: Add DSB dataset support
  coresight-tpdm: Initialize DSB subunit configuration
  coresight-tpdm: Add reset node to TPDM node
  coresight-tpdm: Add nodes to set trigger timestamp and type
  coresight-tpdm: Add node to set dsb programming mode
  coresight-tpdm: Add nodes for dsb edge control
  coresight-tpdm: Add nodes to configure pattern match output
  coresight-tpdm: Add nodes for timestamp request
  dt-bindings: arm: Add support for DSB MSR register
  coresight-tpdm: Add nodes for dsb msr support

 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 159 +++++
 .../bindings/arm/qcom,coresight-tpdm.yaml          |  20 +
 drivers/hwtracing/coresight/coresight-core.c       |   3 +
 drivers/hwtracing/coresight/coresight-tpda.c       | 126 +++-
 drivers/hwtracing/coresight/coresight-tpda.h       |   2 +
 drivers/hwtracing/coresight/coresight-tpdm.c       | 714 ++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       | 161 +++++
 include/linux/coresight.h                          |   1 +
 8 files changed, 1164 insertions(+), 22 deletions(-)

-- 
2.7.4

