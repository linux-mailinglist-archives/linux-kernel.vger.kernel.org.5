Return-Path: <linux-kernel+bounces-57138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D284D464
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD811C2246D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED0152DE4;
	Wed,  7 Feb 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeFrvjiT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D9152C13;
	Wed,  7 Feb 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341076; cv=none; b=mNcJIIY5h2+xSZMpfEfBqlkauqBupVDUg+XQ8qlOKuY49PyuA/dInbDm8sjEzFJsOOfwJjonJHxXVr/8vBlq8N/Mra01Y7CKjK4+/xwaOev+HR4PtPD1l8dp7VsSb/+iiKLy7n7oK4nXMAVmGXGD0knKu5T8fkBIzNO6wTcLQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341076; c=relaxed/simple;
	bh=8Zk0CzA0tVU4lBXyhl7hjsNEW2keRPbiMZnj5O9LUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqgYRRYGwHU8er6jthriFqHr1Kh/qU98xelAtUpeP+aawdo4++UaKN2XbG6h7GpVQr7ieqZiEMn6/ocUBnG94NpcS9oOeCyaJxMPtQyrUcWI4gXXjFoi25uRuqCUAe+VkbREQLVOGuzjFDwQrjZHHcyPXslvSrUr69rbMf5C1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeFrvjiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68396C43390;
	Wed,  7 Feb 2024 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341075;
	bh=8Zk0CzA0tVU4lBXyhl7hjsNEW2keRPbiMZnj5O9LUXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeFrvjiTH/a8KBu+XjW9OmjUx0jBT29tRpp6Q+9nvhD/gnNmsvJttzB9Nh1G79Mnm
	 g15JkhVZtCTeUNn95z8oXtFLbqkp1UhYoscr5NIgAeAcR7KVyO66Y8AoIo2ljkkQk/
	 XEV3A6rXx7fw713j6UbO/cQSW+495ifarMauFpqedyaMh42IBLKhiNO9dvhRgmsm8T
	 GkRqPqelFfrFGlwbCyYyRkU45LG2kf+fE7xGqxfqxRM1HgjSDVw2PN2CR6oKSCBeB+
	 ERU0xDY0RUuS/CHHd3S0RoNdXnj7/+Va6BmRTXMruV4MIdzkxtj9Q4RQE8S/KydfRX
	 B5UXU2XStpFBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 28/38] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed,  7 Feb 2024 16:23:14 -0500
Message-ID: <20240207212337.2351-28-sashal@kernel.org>
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

[ Upstream commit dcfad4ab4d6733f2861cd241d8532a0004fc835a ]

The first argument of list_add_tail function is the new element which
should be added to the list which is the second argument. Swap the
arguments to allow processing more than one element at a time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c65a73433c05..e6d4226827b5 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
-- 
2.43.0


