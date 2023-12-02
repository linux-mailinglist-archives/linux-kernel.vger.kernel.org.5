Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC22801B68
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjLBIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:12:01 -0500
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 00:12:05 PST
Received: from mail-m12821.netease.com (mail-m12821.netease.com [103.209.128.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B3134;
        Sat,  2 Dec 2023 00:12:05 -0800 (PST)
Received: from ubuntu.localdomain (unknown [111.222.250.119])
        by mail-m12750.qiye.163.com (Hmail) with ESMTPA id D46C3F20445;
        Sat,  2 Dec 2023 16:02:31 +0800 (CST)
From:   Shifeng Li <lishifeng@sangfor.com.cn>
To:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        eranbe@mellanox.com, moshe@mellanox.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinghui@sangfor.com.cn,
        lishifeng1992@126.com, Shifeng Li <lishifeng@sangfor.com.cn>,
        Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net v4] net/mlx5e: Fix a race in command alloc flow
Date:   Sat,  2 Dec 2023 00:01:26 -0800
Message-Id: <20231202080126.1167237-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0oYVkoZHkpMTB0fGh4eHlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVJSUlVSU5LVUpKQllXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
        Y+
X-HM-Tid: 0a8c298cf3a7b21dkuuud46c3f20445
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6Dxw*KTw8KAsCGCEZKgE3
        URMaCzhVSlVKTEtKTktPSk5IS01DVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
        C1lBWUpKSlVJSUlVSU5LVUpKQllXWQgBWUFNSEpCNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a cmd->ent use after free due to a race on command entry.
Such race occurs when one of the commands releases its last refcount and
frees its index and entry while another process running command flush
flow takes refcount to this command entry. The process which handles
commands flush may see this command as needed to be flushed if the other
process allocated a ent->idx but didn't set ent to cmd->ent_arr in
cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
the spin lock.

[70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
[70013.081968]
[70013.082028] Workqueue: events aer_isr
[70013.082053] Call Trace:
[70013.082067]  dump_stack+0x8b/0xbb
[70013.082086]  print_address_description+0x6a/0x270
[70013.082102]  kasan_report+0x179/0x2c0
[70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
[70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
[70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
[70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
[70013.082409]  pci_device_remove+0xf3/0x280
[70013.082439]  device_release_driver_internal+0x1c3/0x470
[70013.082453]  pci_stop_bus_device+0x109/0x160
[70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
[70013.082485]  pcie_do_fatal_recovery+0x167/0x550
[70013.082493]  aer_isr+0x7d2/0x960
[70013.082543]  process_one_work+0x65f/0x12d0
[70013.082556]  worker_thread+0x87/0xb50
[70013.082571]  kthread+0x2e9/0x3a0
[70013.082592]  ret_from_fork+0x1f/0x40

The logical relationship of this error is as follows:

             aer_recover_work              |          ent->work
-------------------------------------------+------------------------------
aer_recover_work_func                      |
|- pcie_do_recovery                        |
  |- report_error_detected                 |
    |- mlx5_pci_err_detected               |cmd_work_handler
      |- mlx5_enter_error_state            |  |- cmd_alloc_index
        |- enter_error_state               |    |- lock cmd->alloc_lock
          |- mlx5_cmd_flush                |    |- clear_bit
            |- mlx5_cmd_trigger_completions|    |- unlock cmd->alloc_lock
              |- lock cmd->alloc_lock      |
              |- vector = ~dev->cmd.vars.bitmask
              |- for_each_set_bit          |
                |- cmd_ent_get(cmd->ent_arr[i]) (UAF) 
              |- unlock cmd->alloc_lock    |  |- cmd->ent_arr[ent->idx]=ent

The cmd->ent_arr[ent->idx] assignment and the bit clearing are not 
protected by the cmd->alloc_lock in cmd_work_handler().

Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry while timeout comp handler")
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

---
v1->v2: fix code conflicts.
v2->v3: modify Fixes line and massage git log.
v3->v4: add target tree name in the subject and add the logical diagram.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index f8f0a712c943..a7b1f9686c09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -156,15 +156,18 @@ static u8 alloc_token(struct mlx5_cmd *cmd)
 	return token;
 }
 
-static int cmd_alloc_index(struct mlx5_cmd *cmd)
+static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
 	ret = find_first_bit(&cmd->vars.bitmask, cmd->vars.max_reg_cmds);
-	if (ret < cmd->vars.max_reg_cmds)
+	if (ret < cmd->vars.max_reg_cmds) {
 		clear_bit(ret, &cmd->vars.bitmask);
+		ent->idx = ret;
+		cmd->ent_arr[ent->idx] = ent;
+	}
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	return ret < cmd->vars.max_reg_cmds ? ret : -ENOMEM;
@@ -979,7 +982,7 @@ static void cmd_work_handler(struct work_struct *work)
 	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
 	down(sem);
 	if (!ent->page_queue) {
-		alloc_ret = cmd_alloc_index(cmd);
+		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
 			if (ent->callback) {
@@ -994,15 +997,14 @@ static void cmd_work_handler(struct work_struct *work)
 			up(sem);
 			return;
 		}
-		ent->idx = alloc_ret;
 	} else {
 		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->vars.bitmask);
+		cmd->ent_arr[ent->idx] = ent;
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
-	cmd->ent_arr[ent->idx] = ent;
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
-- 
2.25.1

