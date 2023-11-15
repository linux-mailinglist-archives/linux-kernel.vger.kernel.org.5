Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F67EC225
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjKOMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:23:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA99C7;
        Wed, 15 Nov 2023 04:23:11 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF9N1pL002619;
        Wed, 15 Nov 2023 12:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=lwJo36FxXJ4olmKQ64Cg9Xz4VwhSuoUcQGoRfsXDE9w=;
 b=Mgp+LLly7Xixb1a6+qIRZDCh8UALocCQM9IGCUeNZ4rXHEWoUExNcxMcvUlYfxerTHTI
 XK76ExWfjVuKylc/6alk8LM2WjUiZq0rLLdkYGxwnvXpniwPJ3apmf/z9/ps04HqIFOG
 yxPpzlnO6UVNH8QuNuY5ljO/LPHZd9CnkXNYo6aTo0ZtD/6yRx+CUHjXD8bcZxsKw5Gq
 T1tbOSbZcQKW4nXQsv9tzeS6kRjlUNjGofPSjP/abq8+0kN40V+HJm3lNJO0XY8dl1qi
 bwdT8fNg6ZVkg3jdiUDb7bNAv4pJRKgST1yffg+8AEn5oNA3hdiT9qH4UE0OhoPz4cW2 NQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac0f9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:22:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFCMoar031221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:22:50 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 04:22:45 -0800
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: [PATCH RESEND v2 0/4] PM: hibernate: LZ4 compression support
Date:   Wed, 15 Nov 2023 17:52:06 +0530
Message-ID: <cover.1700048610.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eFVMwHeGwvUzHjWNMCDVoD16NeGX7UQk
X-Proofpoint-GUID: eFVMwHeGwvUzHjWNMCDVoD16NeGX7UQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series covers the following:
1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
used in the next patch where we move to crypto based APIs for
compression. There are no functional changes introduced by this
approach.


2. Replace LZO library calls with crypto generic APIs

Currently for hibernation, LZO is the only compression algorithm
available and uses the existing LZO library calls. However, there
is no flexibility to switch to other algorithms which provides better
results. The main idea is that different compression algorithms have
different characteristics and hibernation may benefit when it uses
alternate algorithms.

By moving to crypto based APIs, it lays a foundation to use other
compression algorithms for hibernation.


3. LZ4 compression

Extend the support for LZ4 compression to be used with hibernation.
The main idea is that different compression algorithms have different
characteristics and hibernation may benefit when it uses any of these
algorithms: a default algorithm, having higher compression rate but is
slower(compression/decompression) and a secondary algorithm, that is
faster(compression/decompression) but has lower compression rate.

LZ4 algorithm has better decompression speeds over LZO. This reduces
the hibernation image restore time.
As per test results:
                                    LZO             LZ4
Size before Compression(bytes)   682696704       682393600
Size after Compression(bytes)    146502402       155993547
Decompression Rate               335.02 MB/s     501.05 MB/s
Restore time                       4.4s             3.8s

LZO is the default compression algorithm used for hibernation. Enable
CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.

Compression Benchmarks: https://github.com/lz4/lz4


4. Support to select compression algorithm

Currently the default compression algorithm is selected based on
Kconfig. Introduce a kernel command line parameter "hib_compression" to
override this behaviour.

Users can set "hib_compression" command line parameter to specify
the algorithm.
Usage:
    LZO: hib_compression=lzo
    LZ4: hib_compression=lz4
LZO is the default compression algorithm used with hibernation.


Changes in v2:
 - Fixed build issues reported by kernel test robot for ARCH=sh, [1].
[1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/

Nikhil V (4):
  PM: hibernate: Rename lzo* to make it generic
  PM: hibernate: Move to crypto APIs for LZO compression
  PM: hibernate: Add support for LZ4 compression for hibernation
  PM: hibernate: Support to select compression algorithm

 .../admin-guide/kernel-parameters.txt         |   6 +
 kernel/power/Kconfig                          |  26 ++-
 kernel/power/hibernate.c                      |  85 +++++++-
 kernel/power/power.h                          |  19 ++
 kernel/power/swap.c                           | 189 +++++++++++-------
 5 files changed, 251 insertions(+), 74 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.17.1

