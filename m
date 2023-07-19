Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289967591AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGSJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGSJbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:31:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F014269A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:30:47 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5Vpf1zdmztRTj;
        Wed, 19 Jul 2023 17:27:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:30:44 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>
Subject: [PATCH v9 0/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed, 19 Jul 2023 17:28:36 +0800
Message-ID: <20230719092838.2302-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

This is the follow-up work to support cluster scheduler. Previously
we have added cluster level in the scheduler for both ARM64[1] and
X86[2] to support load balance between clusters to bring more memory
bandwidth and decrease cache contention. This patchset, on the other
hand, takes care of wake-up path by giving CPUs within the same cluster
a try before scanning the whole LLC to benefit those tasks communicating
with each other.

[1] 778c558f49a2 ("sched: Add cluster scheduler level in core and related Kconfig for ARM64")
[2] 66558b730f25 ("sched: Add cluster scheduler level for x86")

Since we're using sd->groups->flags to determine a cluster, core should ensure
the flags set correctly on domain generation. This is done by [*].

[*] https://lore.kernel.org/all/20230713013133.2314153-1-yu.c.chen@intel.com/

Change since v8:
- Peter find cpus_share_lowest_cache() is weired so fallback to cpus_share_resources()
  suggested in v4
- Use sd->groups->flags to find the cluster when scanning, save one per-cpu pointer
- Fix sched_cluster_active enabled incorrectly on domain degeneration
- Use sched_cluster_active to avoid repeated check on non-cluster machines, per Gautham
Link: https://lore.kernel.org/all/20230530070253.33306-1-yangyicong@huawei.com/

Change since v7:
- Optimize by choosing prev_cpu/recent_used_cpu when possible after failed to
  scanning for an idle CPU in cluster/LLC. Thanks Chen Yu for testing on Jacobsville
Link: https://lore.kernel.org/all/20220915073423.25535-1-yangyicong@huawei.com/

Change for RESEND:
- Collect tag from Chen Yu and rebase on the latest tip/sched/core. Thanks.
Link: https://lore.kernel.org/lkml/20220822073610.27205-1-yangyicong@huawei.com/

Change since v6:
- rebase on 6.0-rc1
Link: https://lore.kernel.org/lkml/20220726074758.46686-1-yangyicong@huawei.com/

Change since v5:
- Improve patch 2 according to Peter's suggestion:
  - use sched_cluster_active to indicate whether cluster is active
  - consider SMT case and use wrap iteration when scanning cluster
- Add Vincent's tag
Thanks.
Link: https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/

Change since v4:
- rename cpus_share_resources to cpus_share_lowest_cache to be more informative, per Tim
- return -1 when nr==0 in scan_cluster(), per Abel
Thanks!
Link: https://lore.kernel.org/lkml/20220609120622.47724-1-yangyicong@hisilicon.com/

Change since v3:
- fix compile error when !CONFIG_SCHED_CLUSTER, reported by lkp test.
Link: https://lore.kernel.org/lkml/20220608095758.60504-1-yangyicong@hisilicon.com/

Change since v2:
- leverage SIS_PROP to suspend redundant scanning when LLC is overloaded
- remove the ping-pong suppression
- address the comment from Tim, thanks.
Link: https://lore.kernel.org/lkml/20220126080947.4529-1-yangyicong@hisilicon.com/

Change since v1:
- regain the performance data based on v5.17-rc1
- rename cpus_share_cluster to cpus_share_resources per Vincent and Gautham, thanks!
Link: https://lore.kernel.org/lkml/20211215041149.73171-1-yangyicong@hisilicon.com/

Barry Song (2):
  sched: Add cpus_share_resources API
  sched/fair: Scan cluster before scanning LLC in wake-up path

 include/linux/sched/sd_flags.h |  7 ++++
 include/linux/sched/topology.h |  8 ++++-
 kernel/sched/core.c            | 12 +++++++
 kernel/sched/fair.c            | 59 +++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 25 ++++++++++++++
 6 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.24.0

