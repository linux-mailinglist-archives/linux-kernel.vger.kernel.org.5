Return-Path: <linux-kernel+bounces-113585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B024888580
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB3C284A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB131CADB4;
	Sun, 24 Mar 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBTPzhtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C41C9856;
	Sun, 24 Mar 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320388; cv=none; b=onJV9HFP+Vr7qxgRzNzTFXpkty9NXcfC87HMIBtsjOSyzwTKukl6JC3UNB/9h7D2GBh1MkRGM7uBTvkZVTorVL2fn7WDZDNIaVoo9k1Rm9zkBPGWuGTHaDLesfVqqJOSYRku8ImQe7lWjvEqtC1XVuD453ec2ghAfxDg+Ls35zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320388; c=relaxed/simple;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL3mlBkfT7msyb8tuxnZxGYKE/0+bxm50QHfaF7xU4ZeSghQ+lTVd0rbp25Bv0TFVSkQPkqOyVII6GIORkooDES98kcjN76l9GSskFeWsHRfRxxiv/Lop26N8kmOrSCQ0xCUPT5jWiuVJBp8IwyGyPHDpp202OpCJQv4ANv1Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBTPzhtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7680C433B1;
	Sun, 24 Mar 2024 22:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320388;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBTPzhtMmlVSJVYKapvMYjkRe5ip62x+gm8dNqB9WL9AAsg9+VGKolaVis28h6KT3
	 op7+tsq/i6KXDsCN+D+K+JBsXThl++EW/c41gVcQwpHRAKF2DoRgiL10Qw6Q/xJlGY
	 M+tJcQAoygTNgMXW32+GwshU5dOwHfe9LBTxYPCCKTLXXF6CHBHVkKVLgweb70p7zC
	 aZndLSFlLx0AvyLpZfj5vRyBpH4zfReyG/v3PkbEcnWPcdOG+K8NJBctQcyhO3XZOc
	 WUfPW3eWEkG+/DBLXSNQZ6KNZuDi1oal7GgL2xFDnVKh3ySGQxe4eZHJLe8PqB7LL9
	 A5qNceoD0azRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 694/715] octeontx2-pf: Use default max_active works instead of one
Date: Sun, 24 Mar 2024 18:34:33 -0400
Message-ID: <20240324223455.1342824-695-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


