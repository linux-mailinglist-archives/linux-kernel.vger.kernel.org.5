Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D87AE86C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjIZI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjIZI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:58:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D9FDE;
        Tue, 26 Sep 2023 01:58:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q7LYfV031306;
        Tue, 26 Sep 2023 08:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=7wYr2f7GR/gnOln58QFT1dBmpK5rOQQPXNbgSsX6x7A=;
 b=VJYG7SqeMLFi0Wl6wJX7kQKkiiFFPHF7eibcUoSQUfLsd3o5EvWqe8VIh4Jp2YQlvT3h
 95Ny7kF5Ol4p5VN1468qV6Y5EkSJ4UjcnX2cHke5Kup21AxnF7vpWn+0VD8nrwZDi4Gn
 Wv9Dwi+pMB6He1ibDxqvEVJmF+QqljEJcFX1epZaaot2r+E+RBkH8Vv3MHiQsFlZVyvo
 TVhauB4Kycb2RMNNUNPb2qMbGEB2AvP6nBWiMsunLaDQkxn3Oy5bcO/VxfaaO7gtugMD
 XVBmw/olIDBfnqG+qZyx/JkVo3ATFEfJ9gybqUfvTRjVisje0OkBu/fl5YVbSWdXKSTE EQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72sjs4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 08:58:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q8wIM4021387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 08:58:18 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 01:58:11 -0700
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: [RFC PATCH 0/4] PM: hibernate: LZ4 compression support
Date:   Tue, 26 Sep 2023 14:27:10 +0530
Message-ID: <cover.1695711299.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8WVn62nEL_LK_j0_t81CxRwApjZC6T-B
X-Proofpoint-ORIG-GUID: 8WVn62nEL_LK_j0_t81CxRwApjZC6T-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
The main idea is that different compression algorithms
have different characteristics and hibernation may benefit when it uses
any of these algorithms: a default algorithm, having higher
compression rate but is slower(compression/decompression) and a
secondary algorithm, that is faster(compression/decompression) but has
lower compression rate.

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

Currently the default compression algorithm is selected based on Kconfig.
Introduce a kernel command line parameter "hib_compression" to
override this behaviour.

Users can set "hib_compression" command line parameter to specify
the algorithm.
Usage:
    LZO: hib_compression=lzo
    LZ4: hib_compression=lz4
LZO is the default compression algorithm used with hibernation.

Nikhil V (4):
  PM: hibernate: Rename lzo* to make it generic
  PM: hibernate: Move to crypto APIs for LZO compression
  PM: hibernate: Add support for LZ4 compression for hibernation
  PM: hibernate: Support to select compression algorithm

 .../admin-guide/kernel-parameters.txt         |   6 +
 kernel/power/Kconfig                          |  25 ++-
 kernel/power/hibernate.c                      |  83 +++++++-
 kernel/power/power.h                          |  19 ++
 kernel/power/swap.c                           | 189 +++++++++++-------
 5 files changed, 248 insertions(+), 74 deletions(-)

-- 
2.17.1

