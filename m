Return-Path: <linux-kernel+bounces-57175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBF84D4BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431B81C21FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479FF15DF17;
	Wed,  7 Feb 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBwVzhTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9915DF03;
	Wed,  7 Feb 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341158; cv=none; b=Oh+rEdOwJIdzpAlIIWY09d7jwA+6NmCPP21Gz6QmI3S5SesJaoVzPapi6dQCFKD5pIB46Mz8nR//9Pja/aJGXJYVzkIhxBbRizHVJpTMpBXffzvon6BQo3fYY68idXoiYuauvnPvXxJiKv7AT7bdvTiXviFXe6YIOO/ttO3xSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341158; c=relaxed/simple;
	bh=h79hO05xp7Yb1JfaQ+0MRJL26ORufyCzdOf24bZvOpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah6xLy2ayxwfpNGyLe4v8+Z3NwRkNgC1r6tv8KUOu0NeCaHVsMAu+4t24sJOJVUaYHErZeXVV/Zj+pIviBDXMIWwWbOAyu0DEp4Qkhr3QFgPrIahnPcYmnZOa/FDwnbhRaxG7QKMSTLAarqH+Ml+ctZXNzRx35rBBsRVvm5eKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBwVzhTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EFEC43394;
	Wed,  7 Feb 2024 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341158;
	bh=h79hO05xp7Yb1JfaQ+0MRJL26ORufyCzdOf24bZvOpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBwVzhTQFeCKgYCLH+yyrT7gVxkSiV9WoFtEzBE0InPNj+ygUmDsOiSFxnRH24frW
	 mdg+VnVtTOj6n/uxsXk0vwfLTycXEpjz7fPjkOiBQD2Av6U9MrBIzGd2FgjuFwU3V1
	 4CvQKz+PX/zV+tDm1oSDWwn87HVQzpq11XEf/eeNZ9MBF+RnlwTIgGPnWrxWwQdpoK
	 5jv9dYBRsMpuzfVkksnw3MQ+hoqihbLXeR6B3REUw3S/LT9jRy/9hmwT9yvkPeeuSO
	 Ga4VExLFunP2Y6o3e/nPIolzmrh34qkNnIceXK4LS7P14p5g11aYBzPN8Vt8gIkP64
	 TG88vRFh8wacw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 26/29] nvmet-fc: take ref count on tgtport before delete assoc
Date: Wed,  7 Feb 2024 16:24:51 -0500
Message-ID: <20240207212505.3169-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit fe506a74589326183297d5abdda02d0c76ae5a8b ]

We have to ensure that the tgtport is not going away
before be have remove all the associations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 36cae038eb04..8a02ed63b156 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1092,13 +1092,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 }
 
 static void
-nvmet_fc_delete_assoc(struct work_struct *work)
+nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
+}
+
+static void
+nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
 	struct nvmet_fc_tgt_assoc *assoc =
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
+	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
+	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_tgtport_put(tgtport);
+}
+
+static void
+nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_tgtport_get(assoc->tgtport);
+	queue_work(nvmet_wq, &assoc->del_work);
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1132,7 +1147,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
-	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
+	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
@@ -1491,7 +1506,7 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	rcu_read_unlock();
@@ -1545,7 +1560,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1590,7 +1605,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			queue_work(nvmet_wq, &assoc->del_work);
+			nvmet_fc_schedule_delete_assoc(assoc);
 			nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
@@ -1897,7 +1912,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	}
 
-	queue_work(nvmet_wq, &assoc->del_work);
+	nvmet_fc_schedule_delete_assoc(assoc);
 	nvmet_fc_tgt_a_put(assoc);
 
 	return false;
-- 
2.43.0


