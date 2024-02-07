Return-Path: <linux-kernel+bounces-57106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36984D413
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7811C23C19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4213D501;
	Wed,  7 Feb 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiFgaUJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06313D4E2;
	Wed,  7 Feb 2024 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340997; cv=none; b=Kba3MF0eacdePrAnXHKXX7dN9aDD3yrFVv5utr20RY2s8SxHjWphz70RVSydJi+vPhmLsBdn+tjzsabKVQQOUnYAAtpJaB7XRl4WVAIYpxUHJgQ6CRNZsuqlmDIJEMGoQaQXNqoZGZXaS1Sq8tDNOPWOBQY7lbse5/S+c4wKjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340997; c=relaxed/simple;
	bh=LxtbjQURu71KUXIa1Q1DH91EK5gWHmSOthyEQLP+4tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8ooUJqzVFg0IuKZO+AX1AGIfH8QBKHDjwUjZ5dXPFWdD5cB3n674SshzCDGhlIrMlwsh7elWFpPu4sOz8EZ2Jht8Z3T26CMPtomIlATLRRYL8VjP/n1xX1rm2QtFtTSSB0T5jBm7W2xp99l2BcrXqhUGA9c54W/y7CDubDxxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiFgaUJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F82C433C7;
	Wed,  7 Feb 2024 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340996;
	bh=LxtbjQURu71KUXIa1Q1DH91EK5gWHmSOthyEQLP+4tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiFgaUJqNHz1ebK2KUuA2Jqd3GIx6fAqM+QkHjX3OUgJE5WDKr7VO/t1SEXlG6CCS
	 46FZI7TmZRpOos/i1PM0sKGkUVVQs5X4uC/o3HGUB424mK5JIyXkTpK+xEm5rP8W9C
	 yf20FAvfO6p2SqsXdViOfJlJJzYcjT1DyfEggLMi2aKl7P0zZpHpr9IIunfrlULN4i
	 FJmY0oKqKEG21cGE7UkYVH9C1LFk7k8TCH+VByFm55UW1DMn7KJfq1vsWsEYMF3Mws
	 Z9do2YHGLGIgU/mSj1Lyt5fMEXc6GMn0IPz3qEwcPgt7ou8piCsVyMMCt+mSqalx5B
	 TMWIMFgMF8rnA==
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
Subject: [PATCH AUTOSEL 6.7 40/44] nvmet-fc: take ref count on tgtport before delete assoc
Date: Wed,  7 Feb 2024 16:21:07 -0500
Message-ID: <20240207212142.1399-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 4793d1c64401..6b47279f9924 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1091,13 +1091,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1128,7 +1143,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
-	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
+	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
@@ -1484,7 +1499,7 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	rcu_read_unlock();
@@ -1538,7 +1553,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1583,7 +1598,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			queue_work(nvmet_wq, &assoc->del_work);
+			nvmet_fc_schedule_delete_assoc(assoc);
 			nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
@@ -1890,7 +1905,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	}
 
-	queue_work(nvmet_wq, &assoc->del_work);
+	nvmet_fc_schedule_delete_assoc(assoc);
 	nvmet_fc_tgt_a_put(assoc);
 
 	return false;
-- 
2.43.0


