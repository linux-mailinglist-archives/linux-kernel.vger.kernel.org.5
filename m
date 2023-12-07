Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0E808897
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjLGM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLGM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:57:25 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B1D5E;
        Thu,  7 Dec 2023 04:57:30 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7Cr1qs027097;
        Thu, 7 Dec 2023 12:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HjIMDBErvcFf1wv9hqQUMOA9EbkqzxRH/JoQ6aYpg14=;
 b=bEh6pzQrIfTkOLO0V9/d1Qq0VEh+D4VuHsCnadzoxUbtv8OV+YHzw6fz5wuAxFAGjLH1
 b3dwl7XWgnfO2HkuNwV+3ebx6LW3QA46FnS2Iy5xHrVCNvj6ytmyc1NSVgAv4aCTuZ6T
 j6FIGeh5Yum9vGwb8+MdPa2VDaRpvX/i4tjkhgWgOF84AdbiwJHjt83PBrAvlPU+5HFn
 EFDSONVwWfvV1yWoX7dE4y68GdhCF9pa+YcKI8dOPbanEDNxxnoXXDK4Bq4znXqw0ZBD
 xKICO5zw9PQ7Ou592wsa6Evm0yxrc+x6FqvDVzm3g28e0S7NBYiHNFgZM3xVGTM2lCqd uw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uueep84ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 12:57:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7B5ied015401;
        Thu, 7 Dec 2023 12:57:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkk5yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 12:57:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B7CvLRG28574272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 12:57:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7614120043;
        Thu,  7 Dec 2023 12:57:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DEA520040;
        Thu,  7 Dec 2023 12:57:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Dec 2023 12:57:21 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix fails of perf stat --bpf-counters --for-each-cgroup on s390
Date:   Thu,  7 Dec 2023 13:57:16 +0100
Message-Id: <20231207125716.1947860-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ct-Akwe7L1CJCRtQHzLZKpa85UhOFwas
X-Proofpoint-ORIG-GUID: ct-Akwe7L1CJCRtQHzLZKpa85UhOFwas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 this test fails very often, as can be observed in the output
below. This is caused by the second test function
check_cpu_list_counted(). The perf stat is triggered for 2 CPUs
0 and 1.  On s390, which usually has a lot more CPUs, most often
this ends up in no counter increments on these 2 CPUs 0 and 1.

Fix this and trigger explicit workload on CPU 0 and 1 for
systemd. This is a better approach than calculating a long
list of CPUs (which is basicly the same as option -a), or
wait a longer period of time.

Output before:
 # for i in $(seq 10)
 > do ./perf test 100
 > done
 100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
 100: perf stat --bpf-counters --for-each-cgroup test : Ok
 #

Output after:
 # for i in $(seq 10);
 do ./perf test 100;
 done
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 100: perf stat --bpf-counters --for-each-cgroup test  : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index e75d0780dc78..f67602321403 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -60,6 +60,7 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
+	taskset -c 0,1 systemctl daemon-reexec &
 	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
 	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
-- 
2.43.0

