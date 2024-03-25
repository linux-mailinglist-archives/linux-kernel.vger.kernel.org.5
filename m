Return-Path: <linux-kernel+bounces-117252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B502B88A919
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A98E380878
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2850248;
	Mon, 25 Mar 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fUgtR5ap"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F645D461
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376770; cv=none; b=oNbUI297CVTX3G847PvlCIf2IYNtViUpxQLqh/0ogBRHphSgjhx7DP0IfmyPm5UpIChNCV3Ww3HWkmPx9PQW7O+IKbG7eXwvKA19kS77oTFQRywAwp3TL+vcPkEYr1q6YrTQhh+WZZ4vzi+Vjj0S6u5cf9odul5SEtog7aXwYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376770; c=relaxed/simple;
	bh=kSsDUFc4xMpkJAiRXUXJMti50HYAxPhKfrDtqOEs+90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dTEhArCEpssPCHc4WTQreFG6c4Q5zxTLSoGzVz9GUrNY1YXFmZI/gQNa7kVOWIZY3g4OUfcFaMS3iF5pk63rMvZpP2jQBqNYg3KlJBuUeXhBqz2PPLr9gQNBIkJG2bQgaouBWJIYQg051QjmQ6inoC5xDC34i2vZZpwJ8xjRlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fUgtR5ap; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBUTBs021565;
	Mon, 25 Mar 2024 14:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=H8GadMAswCcqkzJqWtejRQESsFWaKvFT0Zyr1p8nSdY=;
 b=fUgtR5ap1zPyMIj6daRDH9j/OkghuNTJUoCOGO9mTg9/7Mph9tiigybdrclcuBm0Dkhc
 uEWc/gVoMM4zN7wcZ5amBu+nUNPOguxFlrPluI0gzpcGgILvA76Y+f3Pd8U//Gf4/VW9
 9KtFlTVYu2xZvCcaKlYmEN9jXfUqPLjfebwijF46/EfRd7rqPV+Bg//Rg9nMUDNQAMKx
 ShYNOfwi/r9eN6IWbiuavOj0xnuuZY23c2PbebXdDH6sByF/x/kVBC4+3H7WhWjUrolg
 SJSyDzgkkd7Tc+iuW9/ox0jKQh1eZ6PpRu3N/pFPHbtpiZqiU7ESxv2dPQhtdfT0t+b7 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x38eu8c32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:35 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PEOZ3j005355;
	Mon, 25 Mar 2024 14:24:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x38eu8c2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBaEww025481;
	Mon, 25 Mar 2024 14:24:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awmhh4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 14:24:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PEOUH244695848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 14:24:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14FAB20040;
	Mon, 25 Mar 2024 14:24:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D08252004B;
	Mon, 25 Mar 2024 14:24:26 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 14:24:26 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v4 0/2] Allow migrate on protnone reference with MPOL_PREFERRED_MANY policy
Date: Mon, 25 Mar 2024 09:24:12 -0500
Message-Id: <cover.1711373653.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BV3XDWLCnGj00J2wBrC88t1VhTezyxbe
X-Proofpoint-GUID: _8qFibs6pPHYfbpZZolyG_N0gqxqgl0s
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403250079

This patchset is to optimize the cross-socket memory access with
MPOL_PREFERRED_MANY policy.

To test this patch we ran the following test on a 3 node system.
 Node 0 - 2GB   - Tier 1
 Node 1 - 11GB  - Tier 1
 Node 6 - 10GB  - Tier 2

Below changes are made to memcached to set the memory policy,
It select Node0 and Node1 as preferred nodes.

   #include <numaif.h>
   #include <numa.h>

    unsigned long nodemask;
    int ret;

    nodemask = 0x03;
    ret = set_mempolicy(MPOL_PREFERRED_MANY | MPOL_F_NUMA_BALANCING,
                                               &nodemask, 10);
    /* If MPOL_F_NUMA_BALANCING isn't supported,
     * fall back to MPOL_PREFERRED_MANY */
    if (ret < 0 && errno == EINVAL){
       printf("set mem policy normal\n");
        ret = set_mempolicy(MPOL_PREFERRED_MANY, &nodemask, 10);
    }
    if (ret < 0) {
       perror("Failed to call set_mempolicy");
       exit(-1);
    }

Test Procedure:
===============
1. Make sure memory tiering and demotion are enabled.
2. Start memcached.

   # ./memcached -b 100000 -m 204800 -u root -c 1000000 -t 7
       -d -s "/tmp/memcached.sock"

3. Run memtier_benchmark to store 3200000 keys.

  #./memtier_benchmark -S "/tmp/memcached.sock" --protocol=memcache_binary
    --threads=1 --pipeline=1 --ratio=1:0 --key-pattern=S:S --key-minimum=1
    --key-maximum=3200000 -n allkeys -c 1 -R -x 1 -d 1024

4. Start a memory eater on node 0 and 1. This will demote all memcached
   pages to node 6.
5. Make sure all the memcached pages got demoted to lower tier by reading
   /proc/<memcaced PID>/numa_maps.

    # cat /proc/2771/numa_maps
     ---
    default anon=1009 dirty=1009 active=0 N6=1009 kernelpagesize_kB=64
    default anon=1009 dirty=1009 active=0 N6=1009 kernelpagesize_kB=64
     ---

6. Kill memory eater.
7. Read the pgpromote_success counter.
8. Start reading the keys by running memtier_benchmark.

  #./memtier_benchmark -S "/tmp/memcached.sock" --protocol=memcache_binary
   --pipeline=1 --distinct-client-seed --ratio=0:3 --key-pattern=R:R
   --key-minimum=1 --key-maximum=3200000 -n allkeys
   --threads=64 -c 1 -R -x 6

9. Read the pgpromote_success counter.

Test Results:
=============
Without Patch
------------------
1. pgpromote_success  before test
Node 0:  pgpromote_success 11
Node 1:  pgpromote_success 140974

pgpromote_success  after test
Node 0:  pgpromote_success 11
Node 1:  pgpromote_success 140974

2. Memtier-benchmark result.
AGGREGATED AVERAGE RESULTS (6 runs)
==================================================================
Type    Ops/sec   Hits/sec   Misses/sec  Avg. Latency  p50 Latency
------------------------------------------------------------------
Sets     0.00       ---         ---        ---          ---
Gets    305792.03  305791.93   0.10       0.18949       0.16700
Waits    0.00       ---         ---        ---          ---
Totals  305792.03  305791.93   0.10       0.18949       0.16700

======================================
p99 Latency  p99.9 Latency  KB/sec
-------------------------------------
---          ---            0.00
0.44700     1.71100        11542.69
---           ---            ---
0.44700     1.71100        11542.69

With Patch
---------------
1. pgpromote_success  before test
Node 0:  pgpromote_success 5
Node 1:  pgpromote_success 89386

pgpromote_success  after test
Node 0:  pgpromote_success 57895
Node 1:  pgpromote_success 141463

2. Memtier-benchmark result.
AGGREGATED AVERAGE RESULTS (6 runs)
====================================================================
Type    Ops/sec    Hits/sec  Misses/sec  Avg. Latency  p50 Latency
--------------------------------------------------------------------
Sets     0.00        ---       ---        ---           ---
Gets    521942.24  521942.07  0.17       0.11459        0.10300
Waits    0.00        ---       ---         ---          ---
Totals  521942.24  521942.07  0.17       0.11459        0.10300

=======================================
p99 Latency  p99.9 Latency  KB/sec
---------------------------------------
 ---          ---            0.00
0.23100      0.31900        19701.68
---          ---             ---
0.23100      0.31900        19701.68


Test Result Analysis:
=====================
1. With patch we could observe pages are getting promoted.
2. Memtier-benchmark results shows that, with the patch,
   performance has increased more than 50%.

 Ops/sec without fix -  305792.03
 Ops/sec with fix    -  521942.24

Changes:
V4
- Added an example in the "PATCH 2/2" commit message as per the discussion
  from V3.
V3:
- Added "* @vmf: structure describing the fault" comment for
  mpol_misplaced() to fix the warning.
https://lore.kernel.org/oe-kbuild-all/202403202229.WZeAnUuO-lkp@intel.com/
-https://lore.kernel.org/lkml/cover.1711002865.git.donettom@linux.ibm.com/
v2:
- Rebased on latest upstream (v6.8-rc7)
- Used 'numa_node_id()' to get the current execution node ID, Added
  'lockdep_assert_held' to make sure that the 'mpol_misplaced()' is
  called with ptl held.
- The migration condition has been updated; now, migration will only
  occur if the execution node is present in the policy nodemask.
-https://lore.kernel.org/lkml/cover.1709909210.git.donettom@linux.ibm.com/

-v1: https://lore.kernel.org/linux-mm/9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com/#t


Donet Tom (2):
  mm/mempolicy: Use numa_node_id() instead of cpu_to_node()
  mm/numa_balancing:Allow migrate on protnone reference with
    MPOL_PREFERRED_MANY policy

 include/linux/mempolicy.h |  5 +++--
 mm/huge_memory.c          |  2 +-
 mm/internal.h             |  2 +-
 mm/memory.c               |  8 +++++---
 mm/mempolicy.c            | 36 +++++++++++++++++++++++++++---------
 5 files changed, 37 insertions(+), 16 deletions(-)

-- 
2.39.3


