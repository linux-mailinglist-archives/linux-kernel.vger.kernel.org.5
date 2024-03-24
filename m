Return-Path: <linux-kernel+bounces-114699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAF888BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C607297943
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5286313CC55;
	Mon, 25 Mar 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtTaqhJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0B15FA7A;
	Sun, 24 Mar 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322354; cv=none; b=lrYJyNkpvUVb4XEIyHSJKE18803wCkQbzLPAB5nNBjehkDvRoPBNooSwhAeiz87FPACf1P2r43vUug8eGpR8z8olO20r3hNgkddvXFXSTJx7e+DWgwCfbTg9d6uBPtOwox+4Mstu/2jr9BGSx8dwogK6w05/R1nuYCaM9XuHy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322354; c=relaxed/simple;
	bh=ZImDsyZT8sY0bml6pXAWTDFF5at1/jbbazN+gtwFXbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po9VRO8TJXttHzVt/dYlXW/NNxCH0ZoG5OMrHfs9k5YHu4P3AGq9PiMVTgXMrXPykjA+x+2k2ZUvF/FbT1g7g55JrqMLY7JzJjVNCZDxu5pCb8/PR8eld0lOzT/A9oUSXKgyfuqBWb2rn4+cvEHYX3WoD24Z6y1PAqiGIBe77Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtTaqhJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FBCC433B1;
	Sun, 24 Mar 2024 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322352;
	bh=ZImDsyZT8sY0bml6pXAWTDFF5at1/jbbazN+gtwFXbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtTaqhJgaEXODzVboYkLNoJg4ejGVxue3RwdwFJakTdAtMTJivFGX7aVvg7M9JANF
	 ARuN6nlWYiew4fZ+F6kjoclYIEanGwhUr1Wx5Gz31NR/4V8GNGULqGcopoLC+iVeaQ
	 ssegeoI/6UZXLV8h3xkPqu0IamnCJOGNf3qP2btgsKwSUt9epspVkPT6j0xvNLjyC6
	 45Tlj7jMstiiOg8JP2nsTAPI5mqmL0vVU+mSpQOUQYKKD1tgTiAwvzIktLqQZ2aiyy
	 mMAykZtxsKHxW/hbhh0Y8/sw3nNa5bHV8CPjcA14aa5kXEPFcwrPQBaiO4AkcBvybN
	 ZY17oxGHdzm7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 434/451] octeontx2-pf: Use default max_active works instead of one
Date: Sun, 24 Mar 2024 19:11:50 -0400
Message-ID: <20240324231207.1351418-435-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 3f044b161e8bf..a6c5f6a2dab07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -583,8 +583,9 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf)
 		return -ENOMEM;
 
-	pf->mbox_pfvf_wq = alloc_ordered_workqueue("otx2_pfvf_mailbox",
-						   WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
+					   WQ_UNBOUND | WQ_HIGHPRI |
+					   WQ_MEM_RECLAIM, 0);
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
@@ -3086,7 +3087,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 
 	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
 
-	otx2_mbox_msg_send_up(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
 
 	mutex_unlock(&pf->mbox.lock);
 }
-- 
2.43.0


