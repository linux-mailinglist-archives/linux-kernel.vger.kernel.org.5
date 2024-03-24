Return-Path: <linux-kernel+bounces-114469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84247888AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB961F25B90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10828455D;
	Sun, 24 Mar 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igAxICBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16307221905;
	Sun, 24 Mar 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321893; cv=none; b=HzG6QtMueuxjDUtT/Bg1kGSkOj5dBtvpKEgvAvv5u/W0pLjX+m/ZTeYdXnfMQ9Kg4iaJtpIDzRT17mhuOs/IVw7JqLpLUA4ACaB2lUIZ1v8289qPAPNjzgNLM2G5XIlEN6ToyceHBmdT7/TSpSnXrWFtpu/rllNWn3O3kVMEk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321893; c=relaxed/simple;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orfWNQFeEdvx4kJcEujYYBPI/H+IT4T6s96QUwvZ5B5PEAoxWdjKNksNFqUrfar6sHSnFFjkdtIjmRmRtoUO63Db0U7qoO3scDYqB1vhmrGtVdYA+qEQVQwcyBHjAXsRva5YjMxCIAjEwV9xE8TEkAzt/FYP2lIWHWtaOniylSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igAxICBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59779C43394;
	Sun, 24 Mar 2024 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321892;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igAxICBTyLz8NAYOWHmL58mVK8S8JWuOYV/a0bV9UKPrUy2KUt68SsUCmT5OJExgf
	 p1cGDF1ksqT/YvGb5IedO+k7RxlObj5CWcOLhW452GO1uIyodDa9/hyWZVFIi7JUCY
	 YIBY9IZ0vLKzBDwQnFgPOztv664L/HtQnAtnSiBRDSXH3eX/SCzAA+c6mj6Me+vW2w
	 Ppx/X+zn7f8BkoG3B4/VBpWSP18v5TO8mA9x/zwhY8oXvpMhHD4sVPiJ4Ha+miG/v6
	 AZGdS1Md7iQh+YdeciCTfSipswnS9tduwBiMd9XyX89FW+iP6k6cKAYJ+GgHZvcH16
	 9jlTjOt14YcKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 620/638] octeontx2-pf: Use default max_active works instead of one
Date: Sun, 24 Mar 2024 19:00:57 -0400
Message-ID: <20240324230116.1348576-621-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 7558ce0d974ced1dc07edc1197f750fe28c52e57 ]

Only one execution context for the workqueue used for PF and
VFs mailbox communication is incorrect since multiple works are
queued simultaneously by all the VFs and PF link UP messages.
Hence use default number of execution contexts by passing zero
as max_active to alloc_workqueue function. With this fix in place,
modify UP messages also to wait until completion.

Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 3c8841b35d0f7..f85d38fab3211 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -584,8 +584,9 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf)
 		return -ENOMEM;
 
-	pf->mbox_pfvf_wq = alloc_ordered_workqueue("otx2_pfvf_mailbox",
-						   WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
+					   WQ_UNBOUND | WQ_HIGHPRI |
+					   WQ_MEM_RECLAIM, 0);
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
@@ -3146,7 +3147,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 
 	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
 
-	otx2_mbox_msg_send_up(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
 
 	mutex_unlock(&pf->mbox.lock);
 }
-- 
2.43.0


