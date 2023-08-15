Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BA77CF18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbjHOP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjHOP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:06 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35990172A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:04 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAXQ1E003906;
        Tue, 15 Aug 2023 08:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2ex+D3u9FzxFtbdhX5RyDEHnyv3P6whTJzV5woJQOkc=;
 b=BheyIJq24zEHdxB+7hBEguBZo0R+E8MOh0N39oF1FMxWdJSaM9rutoRKqnzSYwY8I6eX
 vYr5Ynr6T+xLsp9Xb9mEn2wkwbM+NJDICKYTuz6rQr++O/pWLW82s69FgheOiFshzOCA
 7OCVsAHsu5pqmWR1NPDZuJz3q5mvAbDOJHIVkWIco+6DiNyi2Y0k8y4oe0hzK428zKYp
 y8vtFkE0Oku+u7/EZmpNWloJjGk/ztH8Vs8XmJwtwKW0v2SOX3kH5TZtueWyLDnVf2+1
 I5zpFmXe7PbWfsf7CGAtyjVQv3k7Ns4uU835G0J/TFo6xUFL05U4FABAH0mw3YOOuQiq GQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjaju7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:39 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 54C593F703F;
        Tue, 15 Aug 2023 08:27:36 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 00/12] ARM: MPAM: add support for priority partitioning control
Date:   Tue, 15 Aug 2023 20:57:00 +0530
Message-ID: <20230815152712.1760046-1-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JUDH_Ch8j7qwNSBegcezTal6p9F4YefF
X-Proofpoint-ORIG-GUID: JUDH_Ch8j7qwNSBegcezTal6p9F4YefF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Memory System Resource Partitioning and Monitoring (MPAM) supports
different controls that can be applied to different resources in the system
For instance, an optional priority partitioning control where priority
value is generated from one MSC, propagates over interconnect to other MSC
(known as downstream priority), or can be applied within an MSC for internal
operations.

Marvell implementation of ARM MPAM supports priority partitioning control
that allows LLC MSC to generate priority values that gets propagated (along with
read/write request from upstream) to DDR Block. Within the DDR block the
priority values is mapped to different traffic class under DDR QoS strategy.
The link[1] gives some idea about DDR QoS strategy, and terms like LPR, VPR
and HPR.

Setup priority partitioning control under Resource control
----------------------------------------------------------
At present, resource control (resctrl) provides basic interface to configure/set-up
CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation) capabilities.
ARM MPAM uses it to support controls like Cache portion partition (CPOR), and 
MPAM bandwidth partitioning.

As an example, "schemata" file under resource control group contains information about
cache portion bitmaps, and memory bandwidth allocation, and these are used to configure
Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.

MB:0=0100
L3:0=ffff

But resctrl doesn't provide a way to set-up other control that ARM MPAM provides
(For instance, Priority partitioning control as mentioned above). To support this,
James has suggested to use already existing schemata to be compatible with 
portable software, and this is the main idea behind this RFC is to have some kind
of discussion on how resctrl can be extended to support priority partitioning control.

To support Priority partitioning control, "schemata" file is updated to accommodate
priority field (upon priority partitioning capability detection), separated from CPBM
using delimiter ",".

L3:0=ffff,f where f indicates downstream priority max value.

These dspri value gets programmed per partition, that can be used to override 
QoS value coming from upstream (CPU).

RFC patch-set[2] is based on James Morse's MPAM snapshot[3] for 6.2, and ACPI
table is based on DEN0065A_MPAM_ACPI_2.0.

Test set-up and results:
------------------------

The downstream priority value feeds into DRAM controller, and one of the important
thing that it does with this value is to service the requests sooner (based on the 
traffic class), hence reducing latency without affecting performance.

Within the DDR QoS traffic class.

0--5 ----> Low priority value
6-10 ----> Medium priority value
11-15 ----> High priority value

Benchmark[4] used is multichase.

Two partition P1 and P2:

Partition P1:
-------------
Assigned core 0
100% BW assignment

Partition P2:
-------------
Assigned cores 1-79
100% BW assignment

Test Script:
-----------
mkdir p1
cd p1
echo 1 > cpus
echo L3:1=8000,5 > schemata   ##### DSPRI set as 5 (lpr)
echo "MB:0=100" > schemata

mkdir p2
cd p2
echo ffff,ffffffff,fffffffe > cpus
echo L3:1=8000,0 > schemata
echo "MB:0=100" > schemata

### Loaded latency run, core 0 does chaseload (pointer chase) with low priority value 5, and cores 1-79 does memory bandwidth run ###
./multiload -v -n 10 -t 80 -m 1G -c chaseload  

cd /sys/fs/resctrl/p1

echo L3:1=8000,a > schemata  ##### DSPRI set as 0xa (vpr)

### Loaded latency run, core 0 does chaseload (pointer chase) with medium priority value a, and cores 1-79 does memory bandwidth run ###
./multiload -v -n 10 -t 80 -m 1G -c chaseload

cd /sys/fs/resctrl/p1

echo L3:1=8000,f > schemata  ##### DSPRI set as 0xf (hpr)

### Loaded latency run where core 0 does chaseload (pointer chase) with high priority value f, and cores 1-79 does memory bandwidth run ###
./multiload -v -n 10 -t 80 -m 1G -c chaseload

Results[5]:

LPR average latency is 204.862(ns) vs VPR average latency is 161.018(ns) vs HPR average latency is 134.210(ns).

[1]: https://drops.dagstuhl.de/opus/volltexte/2021/13934/pdf/LIPIcs-ECRTS-2021-3.pdf
[2]: https://github.com/Amit-Radur/linux/commits/mpam_downstream_priority_work
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.2
[4]: https://github.com/google/multichase
[5]:

root@localhost:# ./dspri_test.sh
Info: Loaded Latency chase selected. A -l memload can be used to select a specific memory load
nr_threads = 80
page_size = 4096 bytes
total_memory = 1073741824 (1024.0 MiB)
stride = 256
tlb_locality = 262144
chase = chaseload
memload = stream-sum
run_test_type = RUN_CHASE_LOADED
main: sample_no=0 
main: sample_no=1  avg=204.9(ns)
 main: threads=79, Total(MiB/s)=343018.0, PerThread=4342
main: sample_no=2  avg=206.0(ns)
 main: threads=79, Total(MiB/s)=343038.0, PerThread=4342
main: sample_no=3  avg=206.4(ns)
 main: threads=79, Total(MiB/s)=342443.0, PerThread=4335
main: sample_no=4  avg=206.3(ns)
 main: threads=79, Total(MiB/s)=345156.0, PerThread=4369
main: sample_no=5  avg=205.6(ns)
 main: threads=79, Total(MiB/s)=343807.0, PerThread=4352
main: sample_no=6  avg=205.9(ns)
 main: threads=79, Total(MiB/s)=343593.0, PerThread=4349
main: sample_no=7  avg=206.3(ns)
 main: threads=79, Total(MiB/s)=344770.0, PerThread=4364
main: sample_no=8  avg=205.7(ns)
 main: threads=79, Total(MiB/s)=344935.0, PerThread=4366
main: sample_no=9  avg=205.3(ns)
 main: threads=79, Total(MiB/s)=343189.0, PerThread=4344
main: sample_no=10  avg=206.1(ns)
 main: threads=79, Total(MiB/s)=344455.0, PerThread=4360
ChasAVG=205.848485, ChasGEO=205.847944, ChasBEST=204.861518, ChasWORST=206.443386, ChasDEV=0.008   
LdAvgMibs=343840.400000, LdMaxMibs=345156.000000, LdMinMibs=342443.000000, LdDevMibs=0.008   
Samples	, Byte/thd	, ChaseThds	, ChaseNS	, ChaseMibs	, ChDeviate	, LoadThds	, LdMaxMibs	, LdAvgMibs	, LdDeviate	, ChaseArg	, MemLdArg
10    	, 1073741824 	, 1       	, 204.862 	, 37      	, 0.008   	, 79      	, 345156  	, 343840  	, 0.008   	, chaseload	, stream-sum
Info: Loaded Latency chase selected. A -l memload can be used to select a specific memory load
nr_threads = 80
page_size = 4096 bytes
total_memory = 1073741824 (1024.0 MiB)
stride = 256
tlb_locality = 262144
chase = chaseload
memload = stream-sum
run_test_type = RUN_CHASE_LOADED
main: sample_no=0 
main: sample_no=1  avg=161.4(ns)
 main: threads=79, Total(MiB/s)=342023.0, PerThread=4329
main: sample_no=2  avg=161.3(ns)
 main: threads=79, Total(MiB/s)=341773.0, PerThread=4326
main: sample_no=3  avg=161.4(ns)
 main: threads=79, Total(MiB/s)=342780.0, PerThread=4339
main: sample_no=4  avg=161.6(ns)
 main: threads=79, Total(MiB/s)=341275.0, PerThread=4320
main: sample_no=5  avg=161.0(ns)
 main: threads=79, Total(MiB/s)=342680.0, PerThread=4338
main: sample_no=6  avg=161.9(ns)
 main: threads=79, Total(MiB/s)=341538.0, PerThread=4323
main: sample_no=7  avg=161.5(ns)
 main: threads=79, Total(MiB/s)=345302.0, PerThread=4371
main: sample_no=8  avg=161.5(ns)
 main: threads=79, Total(MiB/s)=341352.0, PerThread=4321
main: sample_no=9  avg=161.5(ns)
 main: threads=79, Total(MiB/s)=341200.0, PerThread=4319
main: sample_no=10  avg=161.5(ns)
 main: threads=79, Total(MiB/s)=341874.0, PerThread=4328
ChasAVG=161.458012, ChasGEO=161.457856, ChasBEST=161.017587, ChasWORST=161.935907, ChasDEV=0.006   
LdAvgMibs=342179.700000, LdMaxMibs=345302.000000, LdMinMibs=341200.000000, LdDevMibs=0.012   
Samples	, Byte/thd	, ChaseThds	, ChaseNS	, ChaseMibs	, ChDeviate	, LoadThds	, LdMaxMibs	, LdAvgMibs	, LdDeviate	, ChaseArg	, MemLdArg
10    	, 1073741824 	, 1       	, 161.018 	, 47      	, 0.006   	, 79      	, 345302  	, 342180  	, 0.012   	, chaseload	, stream-sum
Info: Loaded Latency chase selected. A -l memload can be used to select a specific memory load
nr_threads = 80
page_size = 4096 bytes
total_memory = 1073741824 (1024.0 MiB)
stride = 256
tlb_locality = 262144
chase = chaseload
memload = stream-sum
run_test_type = RUN_CHASE_LOADED
main: sample_no=0 
main: sample_no=1  avg=134.3(ns)
 main: threads=79, Total(MiB/s)=345284.0, PerThread=4371
main: sample_no=2  avg=134.7(ns)
 main: threads=79, Total(MiB/s)=345295.0, PerThread=4371
main: sample_no=3  avg=134.4(ns)
 main: threads=79, Total(MiB/s)=344421.0, PerThread=4360
main: sample_no=4  avg=134.9(ns)
 main: threads=79, Total(MiB/s)=343273.0, PerThread=4345
main: sample_no=5  avg=134.5(ns)
 main: threads=79, Total(MiB/s)=345518.0, PerThread=4374
main: sample_no=6  avg=134.5(ns)
 main: threads=79, Total(MiB/s)=346052.0, PerThread=4380
main: sample_no=7  avg=134.5(ns)
 main: threads=79, Total(MiB/s)=342852.0, PerThread=4340
main: sample_no=8  avg=134.7(ns)
 main: threads=79, Total(MiB/s)=345818.0, PerThread=4377
main: sample_no=9  avg=134.2(ns)
 main: threads=79, Total(MiB/s)=344045.0, PerThread=4355
main: sample_no=10  avg=134.7(ns)
 main: threads=79, Total(MiB/s)=344345.0, PerThread=4359
ChasAVG=134.547983, ChasGEO=134.547841, ChasBEST=134.210254, ChasWORST=134.863073, ChasDEV=0.005   
LdAvgMibs=344690.300000, LdMaxMibs=346052.000000, LdMinMibs=342852.000000, LdDevMibs=0.009   
Samples	, Byte/thd	, ChaseThds	, ChaseNS	, ChaseMibs	, ChDeviate	, LoadThds	, LdMaxMibs	, LdAvgMibs	, LdDeviate	, ChaseArg	, MemLdArg
10    	, 1073741824 	, 1       	, 134.210 	, 57      	, 0.005   	, 79      	, 346052  	, 344690  	, 0.009   	, chaseload	, stream-sum

Amit Singh Tomar (12):
  arm_mpam: Handle resource instances mapped to different controls
  arm_mpam: resctrl: Detect priority partitioning capability
  arm_mpam: resctrl: Define new schemata format for priority partition
  fs/resctrl: Obtain CPBM upon priority partition presence
  fs/resctrl: Set-up downstream priority partition resources
  fs/resctrl: Extend schemata read for priority partition control
  arm_mpam: resctrl: Retrieve priority values from arch code
  fs/resctrl: Schemata write only for intended resource
  fs/resctrl: Extend schemata write for priority partition control
  arm_mpam: resctrl: Facilitate writing downstream priority value
  arm_mpam: Fix Downstream priority mask
  arm_mpam: Program Downstream priority value

 drivers/platform/mpam/mpam_devices.c  |  38 +++++++--
 drivers/platform/mpam/mpam_internal.h |   1 +
 drivers/platform/mpam/mpam_resctrl.c  |  64 +++++++++++---
 fs/resctrl/ctrlmondata.c              | 118 ++++++++++++++++++++++++--
 fs/resctrl/rdtgroup.c                 |  30 +++++++
 include/linux/resctrl.h               |  12 +++
 6 files changed, 235 insertions(+), 28 deletions(-)

-- 
2.25.1

