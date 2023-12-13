Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E396810F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjLMK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbjLMK5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:57:41 -0500
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 02:57:45 PST
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com [45.254.49.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88E9C;
        Wed, 13 Dec 2023 02:57:44 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3270:b440:d83b:6c2e:b6f:d27e])
        by mail-m12741.qiye.163.com (Hmail) with ESMTPA id 66C609E05CD;
        Wed, 13 Dec 2023 18:49:29 +0800 (CST)
From:   Ke Xiao <xiaoke@sangfor.com.cn>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     dinghui@sangfor.com.cn, zhudi2@huawei.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ke Xiao <xiaoke@sangfor.com.cn>
Subject: [net PATCH] i40e: fix use-after-free in i40e_aqc_add_filters()
Date:   Wed, 13 Dec 2023 18:49:11 +0800
Message-Id: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh4ZVklOQhlMGE5JGhlCSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEtBGU9PS0EfQ0gZQU0YSR5BGU0dQR9JTB5ZV1kWGg8SFR0UWU
        FZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8c62cbc175b214kuuu66c609e05cd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N006ERw5GDw3Sj1DDgwjDR9N
        EzowCyNVSlVKTEtJT01PTkxLT0lLVTMWGhIXVQMSGhQQHjsIGhUcHRQJVRgUFlUYFUVZV1kSC1lB
        WUlPSx5BSBlMQUhJTEtBGU9PS0EfQ0gZQU0YSR5BGU0dQR9JTB5ZV1kIAVlBT05PTjcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3116f59c12bd ("i40e: fix use-after-free in
i40e_sync_filters_subtask()") avoided use-after-free issues,
by increasing refcount during update the VSI filter list to
the HW. However, it missed the unicast situation.

When deleting an unicast FDB entry, the i40e driver will release
the mac_filter, and i40e_service_task will concurrently request
firmware to add the mac_filter, which will lead to the following
use-after-free issue.

Fix again for both netdev->uc and netdev->mc.

BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379

CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
Workqueue: i40e i40e_service_task [i40e]
Call Trace:
 dump_stack+0x71/0xab
 print_address_description+0x6b/0x290
 kasan_report+0x14a/0x2b0
 i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
 i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
 i40e_service_task+0x1397/0x2bb0 [i40e]
 process_one_work+0x56a/0x11f0
 worker_thread+0x8f/0xf40
 kthread+0x2a0/0x390
 ret_from_fork+0x1f/0x40

Allocated by task 21948:
 kasan_kmalloc+0xa6/0xd0
 kmem_cache_alloc_trace+0xdb/0x1c0
 i40e_add_filter+0x11e/0x520 [i40e]
 i40e_addr_sync+0x37/0x60 [i40e]
 __hw_addr_sync_dev+0x1f5/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_add_excl+0x137/0x190
 i40e_ndo_fdb_add+0x161/0x260 [i40e]
 rtnl_fdb_add+0x567/0x950
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Freed by task 21948:
 __kasan_slab_free+0x137/0x190
 kfree+0x8b/0x1b0
 __i40e_del_filter+0x116/0x1e0 [i40e]
 i40e_del_mac_filter+0x16c/0x300 [i40e]
 i40e_addr_unsync+0x134/0x1b0 [i40e]
 __hw_addr_sync_dev+0xff/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_del+0x77/0x90
 rtnl_fdb_del+0x6a5/0x860
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Di Zhu <zhudi2@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ab8dbe2d880..16b574d69843 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -108,11 +108,17 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 				  struct net_device *netdev, int delta)
 {
 	struct netdev_hw_addr *ha;
+	struct netdev_hw_addr_list *ha_list;
 
 	if (!f || !netdev)
 		return;
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
+		ha_list = &netdev->uc;
+	else
+		ha_list = &netdev->mc;
+
+	netdev_hw_addr_list_for_each(ha, ha_list) {
 		if (ether_addr_equal(ha->addr, f->macaddr)) {
 			ha->refcount += delta;
 			if (ha->refcount <= 0)
-- 
2.17.1

