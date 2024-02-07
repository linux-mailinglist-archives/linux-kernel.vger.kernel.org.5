Return-Path: <linux-kernel+bounces-57144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF584D470
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0297328440D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE90153BEF;
	Wed,  7 Feb 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oexO6ciS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15984153BE0;
	Wed,  7 Feb 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341087; cv=none; b=qZ3EHxuWo6oqzLiSQt+4ek6J/nx2NFTjD2D4ldcGOsohK34qIcnhJOUT0oVQzwxthTGxUH0z5dXzm7oig5RpRgy6kQ+1gZS4IPTH7NBFPsxLTNHnOCPkO9ZD28EkU+Y/iUNN/f+PvRUMDnCcstM/B70VofGqRRkbYbK8LboYXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341087; c=relaxed/simple;
	bh=h79hO05xp7Yb1JfaQ+0MRJL26ORufyCzdOf24bZvOpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgLHwk+QNVbv+L+3WOMlRev6PT5RTc3dPj3edFPgai/ycT5rebMl2U2gPPVkeidSWeJ4yOTAdbjq1/f/Ud76NoiQuVqnV6FItSZCJF5l2A04i02ic99THmDMCJaQsa7mNG63OdWLYyB1xaHe2nYvOoxWm7HY0FFtpkdT+ljZ8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oexO6ciS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5CC433F1;
	Wed,  7 Feb 2024 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341086;
	bh=h79hO05xp7Yb1JfaQ+0MRJL26ORufyCzdOf24bZvOpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oexO6ciSc8TWOm2XEq2zVrjAgD1gsi6Sf0CzwLXzJRcQzzcMFyJWRhuaN0jR1Sbq/
	 I5cubjIxbMhwaSBcqhWviFtxYeElUzOWyT/kfAUYpfhlgjEz0CBiL9exsAK51FxtHA
	 25sq67GTM3F8fcyvpL7VO+6lsYVREJI3qDWBO0weC/+WcZ8XVeiSHjHJwOLs8GfY2T
	 4GT5mPpk0jBpKHl/cY+6ztD7yMLtG3WOP40TRB7ACiZg3SiGSnH1+ORkoVHs6tChb6
	 iXLOq5XAu3LLcpVc5UX5GQU6AVEVBhqECrxewIiJ5PFWjqYBetT8bxMMK4CpHL8f23
	 YWMhqERwA8OJA==
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
Subject: [PATCH AUTOSEL 6.6 34/38] nvmet-fc: take ref count on tgtport before delete assoc
Date: Wed,  7 Feb 2024 16:23:20 -0500
Message-ID: <20240207212337.2351-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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


