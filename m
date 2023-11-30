Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E97FEC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjK3J5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjK3J47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:56:59 -0500
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 01:57:03 PST
Received: from mail-m25476.xmail.ntesmail.com (mail-m25476.xmail.ntesmail.com [103.129.254.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E859A;
        Thu, 30 Nov 2023 01:57:03 -0800 (PST)
Received: from ubuntu.localdomain (unknown [111.222.250.119])
        by mail-m12750.qiye.163.com (Hmail) with ESMTPA id 5D1DAF20542;
        Thu, 30 Nov 2023 17:46:59 +0800 (CST)
From:   Shifeng Li <lishifeng@sangfor.com.cn>
To:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ogerlitz@mellanox.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinghui@sangfor.com.cn,
        lishifeng1992@126.com, Shifeng Li <lishifeng@sangfor.com.cn>
Subject: [PATCH] net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
Date:   Thu, 30 Nov 2023 01:46:56 -0800
Message-Id: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBhOVkkdQ0pPTEhNTRlISlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVJSUlVSU5LVUpKQllXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
        Y+
X-HM-Tid: 0a8c1f9fddd3b21dkuuu5d1daf20542
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Sjo4Sjw#HhA3HgsVIS5L
        OTowCzFVSlVKTEtKSEhMTUlLT0NMVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
        C1lBWUpKSlVJSUlVSU5LVUpKQllXWQgBWUFISEpNNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out_sz that the size of out buffer is calculated using query_nic_vport
_context_in structure when driver query the MAC list. However query_nic
_vport_context_in structure is smaller than query_nic_vport_context_out.
When allowed_list_size is greater than 96, calling ether_addr_copy() will
trigger an slab-out-of-bounds.

[ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
[ 1170.055870]
[ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
[ 1170.055936] Call Trace:
[ 1170.055949]  dump_stack+0x8b/0xbb
[ 1170.055958]  print_address_description+0x6a/0x270
[ 1170.055961]  kasan_report+0x179/0x2c0
[ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
[ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
[ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
[ 1170.056381]  process_one_work+0x65f/0x12d0
[ 1170.056383]  worker_thread+0x87/0xb50
[ 1170.056390]  kthread+0x2e9/0x3a0
[ 1170.056394]  ret_from_fork+0x1f/0x40

Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
Cc: Ding Hui <dinghui@sangfor.com.cn>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 5a31fb47ffa5..21753f327868 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -277,7 +277,7 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 		req_list_size = max_list_size;
 	}
 
-	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) +
+	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
 			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kvzalloc(out_sz, GFP_KERNEL);
-- 
2.25.1

