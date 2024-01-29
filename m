Return-Path: <linux-kernel+bounces-43350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592B384127C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBAFB239BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26D160888;
	Mon, 29 Jan 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="theisKUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1C160883;
	Mon, 29 Jan 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553379; cv=none; b=XkFwJ/fg7PrLGUGY9z2NsPf8hnt9YnSGoRkaNbhIdwXNEGJZAtFTG+JRCetmmpofYI/fT1vxYC/MFSihZQSs4FR0SbBfdp7RMMpD6ocYeB6tG0zpGef9hnFYFvfw9nCaRcUwnfjJIL33fM5QTw+wE7Jl9JFn2MLcZyxBT3hps24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553379; c=relaxed/simple;
	bh=wXSYGzy1EoFfW3m4rIwhqSSqO7rpIiguW21X+XARLIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLNK+0q8Lzd1c9Aj772LTZZ6jkOkXVert4ySy8XEkmWR27MGCyzHfOgerKf6D4pU+JHGcDX60GMbseBg1iDBKoZ82hQqrbZ9rRyP5+4fPYx+jPzLnMnANEPL+qXSOj9NNOB8wIqsAKCO2voQgICnmN8m/7nZXiSM3C15Yw42FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=theisKUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9896AC433F1;
	Mon, 29 Jan 2024 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553379;
	bh=wXSYGzy1EoFfW3m4rIwhqSSqO7rpIiguW21X+XARLIU=;
	h=From:To:Cc:Subject:Date:From;
	b=theisKUnVSb+JiRSjhIBCx4Uc2xs+0MwOdRk1Ju5n2LigAPIalX3l+XI1ApCuR5Qj
	 Sf0qcUVqZSqCNH6Lr8CoUv1OpVQ+GgyWcB2jp3n1R2FmDn4zkdOLvIuADmwsA4giY0
	 UkNvzrhMSTjxTecp5KV8XgFpRI1+LKWlyrIvPsZvMWtoIW0QjY4OM0LVLRvmyoATDd
	 Lp5U0idEVwOzSzw+epu4wmfJBXwlHQFtpNbWv4Ktp5KKJ4Rv6S6Hh8FA57hHNNprTB
	 6lxF1Z/+GJCvWik8Nk6Cx6Q7JsZG6RTxkfKf6UUhlSQfScJaw17DYvTxSgGBRbqUL/
	 CStWQhI4wWslA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/3] scsi: target: core: Add TMF to tmr_list handling
Date: Mon, 29 Jan 2024 13:36:14 -0500
Message-ID: <20240129183617.464694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit 83ab68168a3d990d5ff39ab030ad5754cbbccb25 ]

An abort that is responded to by iSCSI itself is added to tmr_list but does
not go to target core. A LUN_RESET that goes through tmr_list takes a
refcounter on the abort and waits for completion. However, the abort will
be never complete because it was not started in target core.

 Unable to locate ITT: 0x05000000 on CID: 0
 Unable to locate RefTaskTag: 0x05000000 on CID: 0.
 wait_for_tasks: Stopping tmf LUN_RESET with tag 0x0 ref_task_tag 0x0 i_state 34 t_state ISTATE_PROCESSING refcnt 2 transport_state active,stop,fabric_stop
 wait for tasks: tmf LUN_RESET with tag 0x0 ref_task_tag 0x0 i_state 34 t_state ISTATE_PROCESSING refcnt 2 transport_state active,stop,fabric_stop
..
 INFO: task kworker/0:2:49 blocked for more than 491 seconds.
 task:kworker/0:2     state:D stack:    0 pid:   49 ppid:     2 flags:0x00000800
 Workqueue: events target_tmr_work [target_core_mod]
Call Trace:
 __switch_to+0x2c4/0x470
 _schedule+0x314/0x1730
 schedule+0x64/0x130
 schedule_timeout+0x168/0x430
 wait_for_completion+0x140/0x270
 target_put_cmd_and_wait+0x64/0xb0 [target_core_mod]
 core_tmr_lun_reset+0x30/0xa0 [target_core_mod]
 target_tmr_work+0xc8/0x1b0 [target_core_mod]
 process_one_work+0x2d4/0x5d0
 worker_thread+0x78/0x6c0

To fix this, only add abort to tmr_list if it will be handled by target
core.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Link: https://lore.kernel.org/r/20240111125941.8688-1-d.bogdanov@yadro.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c    | 5 -----
 drivers/target/target_core_transport.c | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 9aeedcff7d02..daa4d06ce233 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -150,7 +150,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
@@ -181,10 +180,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 	se_tmr->tmr_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 
-	spin_lock_irqsave(&se_tmr->tmr_dev->se_tmr_lock, flags);
-	list_add_tail(&se_tmr->tmr_list, &se_tmr->tmr_dev->dev_tmr_list);
-	spin_unlock_irqrestore(&se_tmr->tmr_dev->se_tmr_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(transport_lookup_tmr_lun);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 2e97937f005f..8d294b658592 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3436,6 +3436,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
-- 
2.43.0


