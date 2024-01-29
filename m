Return-Path: <linux-kernel+bounces-43343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C973E841264
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA52B21441
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADE15EA8B;
	Mon, 29 Jan 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGX5OkfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB615DBD4;
	Mon, 29 Jan 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553364; cv=none; b=jrI6pFfqLpmErZjxZ/6Gef3ysln9v428tpP3rRCraInuIH5uajInd7l9N6PK2b3L+l3Td/Zb/6YnMD7ppSfoY6ZLLQF9Z2SbDbWGbYkb+f3K0l3sH0A9CC+A13ymNZZAauFcc4+0aZlMx9k3dDYKfuDqleBWTkiYr5z76A2DFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553364; c=relaxed/simple;
	bh=f2qon/MEecaTc/kJlFlzqN/Onn1g2OJPkj7GSwe3yuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtyzUZeEN9f31Ib8fWfEGxVqgOOERGjXN+2rKzW4PxKZdK7kfFPqMVoOL1uRnyzfeFT8ju+XPoQtK5GE58+69CjbwpGnEasAyDaw8hItTPh5zZHm4fyh0x4dktO6O0s0Ja0w+tX/sAjdMqXmtxdYKbdcHv2yUjgvMDKyrP0CepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGX5OkfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4B5C433F1;
	Mon, 29 Jan 2024 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553363;
	bh=f2qon/MEecaTc/kJlFlzqN/Onn1g2OJPkj7GSwe3yuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGX5OkfFA7AB0SpYSRutDsNGbrwpKoCE2+vSsXP9FH4nBMVz32K3ifIF/91PwZ4Wd
	 /oG49lnEvLZx8g0ueHb4rdVV/LF6tnmQW8/3idTFsUXHkOe9AfoE9B39WzkS1W6CGE
	 Mkpcf4uIPwh/iuspffgmXRY5AFBfC7c5Geb2e8km9j3vKHjrOycQC+MHPhrTsZ/qZA
	 dCVIAvvMdU/BDeERhkHTglg6s4b8haxvc9JYKHbsCCF3Dai38I5yRGXXCz/4YnEh1o
	 GKOouXrCryiVbrlV42GDpwUybJeI5wrXsm4ZfBRRNqFOoaVyXht65InpfrX5DCn41W
	 XIMjkU5qEHiBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/5] scsi: target: core: Add TMF to tmr_list handling
Date: Mon, 29 Jan 2024 13:35:54 -0500
Message-ID: <20240129183559.464502-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183559.464502-1-sashal@kernel.org>
References: <20240129183559.464502-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 301fe376a120..13558cbd9b82 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -147,7 +147,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
@@ -178,10 +177,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
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
index 0686882bcbda..fb93d74c5d0b 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3627,6 +3627,10 @@ int transport_generic_handle_tmr(
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


