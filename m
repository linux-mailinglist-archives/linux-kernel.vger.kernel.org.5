Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4B770F29
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjHEKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:01:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723A4495
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 03:01:52 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHyhH2G94zGpns;
        Sat,  5 Aug 2023 17:58:23 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 18:01:50 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <tariqt@nvidia.com>, <yury.norov@gmail.com>,
        <kuba@kernel.org>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] sched/topology: Fix sched_numa_find_nth_cpu() when there's CPU-less node
Date:   Sat, 5 Aug 2023 17:59:27 +0800
Message-ID: <20230805095927.6907-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

When booting with maxcpus=1 we met below panic:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000002098202000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc1 #3
Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA BIOS 2280-A CS V2.B220.01 03/19/2020
pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __bitmap_weight_and+0x40/0xb0
lr : cpumask_weight_and+0x18/0x24
sp : ffff80000841bab0
x29: ffff80000841bab0 x28: 0000000000000000 x27: ffffb0d897ca6068
x26: 0000000000000000 x25: ffff80000841bbb8 x24: 0000000000000080
x23: ffffb0d8983c9a48 x22: 0000000000000000 x21: 0000000000000002
x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
x17: ffff4f5337dd9000 x16: ffff800008000000 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000bc91ca x12: ffff202bffffe928
x11: ffff202bffffe938 x10: ffff202bffffe908 x9 : 0000000000000001
x8 : 0000000000000380 x7 : 0000000000000014 x6 : ffff2020040b0d00
x5 : 0000000000332000 x4 : ffffb0d8962d9794 x3 : 0000000000000008
x2 : 0000000000000080 x1 : 0000000000000003 x0 : ffffb0d8983c9a48
Call trace:
 __bitmap_weight_and+0x40/0xb0
 cpumask_weight_and+0x18/0x24
 hop_cmp+0x2c/0xa4
 bsearch+0x50/0xc0
 sched_numa_find_nth_cpu+0x80/0x130
 cpumask_local_spread+0x38/0xa8
 hns3_nic_init_vector_data+0x58/0x394
 hns3_client_init+0x2c8/0x6d8
 hclge_init_client_instance+0x128/0x39c
 hnae3_init_client_instance.part.5+0x20/0x54
 hnae3_register_ae_algo+0xf0/0x19c
 hclge_init+0x58/0x84
 do_one_initcall+0x60/0x1d0
 kernel_init_freeable+0x1d8/0x2ac
 kernel_init+0x24/0x12c
 ret_from_fork+0x10/0x20
Code: 52800014 d2800013 d503201f f8737ae1 (f8737ac0)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
SMP: stopping secondary CPUs
Kernel Offset: 0x30d88e200000 from 0xffff800008000000
PHYS_OFFSET: 0x0
CPU features: 0x000000,01100506,22006203
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

The driver use cpumask_local_spread() and inner sched_numa_find_nth_cpu()
access the node mask which is not initialized. In sched_init_numa(),
we don't care about node without CPUs since they won't participate in scheduling.

This patch fix this by using a closet CPU node when the target node is
CPU-less. Furthermore, sched_numa_hop_mask() also suffers so fix it as
well by returning an error when information of target node is not
initialized.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Fixes: 9feae65845f7 ("sched/topology: Introduce sched_numa_hop_mask()")
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/topology.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..78d95ebf5072 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2119,6 +2119,25 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 
 	rcu_read_lock();
 
+	/*
+	 * When the target node is CPU-less, we cannot use it directly since
+	 * we didn't initialise sched_domains_numa_masks[level][node]. Use the
+	 * closet online node instead.
+	 */
+	if (!node_state(node, N_CPU)) {
+		int tmp, closet_node, closet_distance = INT_MAX;
+
+		for_each_node_state(tmp, N_CPU) {
+			if (node_distance(tmp, node) < closet_distance) {
+				closet_node = tmp;
+				closet_distance = node_distance(tmp, node);
+			}
+		}
+
+		k.node = closet_node;
+		node = closet_node;
+	}
+
 	k.masks = rcu_dereference(sched_domains_numa_masks);
 	if (!k.masks)
 		goto unlock;
@@ -2160,7 +2179,7 @@ const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops)
 		return ERR_PTR(-EINVAL);
 
 	masks = rcu_dereference(sched_domains_numa_masks);
-	if (!masks)
+	if (!masks || !masks[hops] || !masks[hops][node])
 		return ERR_PTR(-EBUSY);
 
 	return masks[hops][node];
-- 
2.24.0

