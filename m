Return-Path: <linux-kernel+bounces-114468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA258888A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9E1F25DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340228453E;
	Sun, 24 Mar 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJWBAGZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393322097E;
	Sun, 24 Mar 2024 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321892; cv=none; b=Nb3SvNNEnt9NDW24LXiFWzoH6nI9JlJTrMVZYbVijIOpfZakER3E0ZzhMRyU8PhJIwSn13P6DyMedx6ddUv4ov0mYcn2tSaoao2YROqKHREZxmATLMZxRXG5ze+vG/PZGc2omUzkovcNNczBUPe4+K2Qa1NZQpscAV6DX+psPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321892; c=relaxed/simple;
	bh=mCSJQlreFHbZTIy1RASVODLNrap2xaBQzBI2jNkX8xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMdCoao3gdjTU88IEd1ZsZlFkrZs+qnX9XpCgi6N2f2urnWQk+wHza1eSHDzsg31vSYFPLrXIIetlbSSFaSFk2Ve2kwHkAGz8QXYcVxHXOwt/5j907bfj91MyPrrr72DG+CeBpNB4H8SypmMQixztH3Y6THflYkkwQrR+5SwEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJWBAGZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B13C433C7;
	Sun, 24 Mar 2024 23:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321891;
	bh=mCSJQlreFHbZTIy1RASVODLNrap2xaBQzBI2jNkX8xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJWBAGZrk8lhX7uGBVEQGJ3b5tMkA1qq0zD2qVS9cbFNpStzpEiRnfQLIbYKKxZaI
	 JFRUoPFPeL6lbLBAYmwNvowVPtKKAT+Ltk3D7R7i0vdbE4myd6pISyC5kQyxtrT1WT
	 1tJvdxC8SFx68a8oj6vumWKjXh61cfUHgUfWRClf0zT5GghIAcmzmMOAAZMvamYZEB
	 gw8tHiaFOSeL4xhkP5JNHScwvxNFb5W/z+uxPeEhLar3Q8IYNICv35h6XMVhCPwwY1
	 EgLeclqQ5dQ8NLE0nw2XL8XQsp3GwAMiUHgle4fpyyEEOtonBm9c9Y3GRGzLhQrCG9
	 yJQ/JZmUqZ0+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 619/638] octeontx2-pf: Wait till detach_resources msg is complete
Date: Sun, 24 Mar 2024 19:00:56 -0400
Message-ID: <20240324230116.1348576-620-sashal@kernel.org>
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

[ Upstream commit cbf2f24939a5dafce6de4dd4422e543ce8f610cf ]

During VF driver remove, a message is sent to detach VF
resources to PF but VF is not waiting until message is
complete. Also mailbox interrupts need to be turned off
after the detach resource message is complete. This patch
fixes that problem.

Fixes: 05fcc9e08955 ("octeontx2-pf: Attach NIX and NPA block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index e6df4e6a78ab7..af62d66470d5e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1592,7 +1592,7 @@ int otx2_detach_resources(struct mbox *mbox)
 	detach->partial = false;
 
 	/* Send detach request to AF */
-	otx2_mbox_msg_send(&mbox->mbox, 0);
+	otx2_sync_mbox_msg(mbox);
 	mutex_unlock(&mbox->lock);
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index ced456cec8baf..cf0aa16d75407 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -775,8 +775,8 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	otx2_mcam_flow_del(vf);
 	otx2_shutdown_tc(vf);
 	otx2_shutdown_qos(vf);
-	otx2vf_disable_mbox_intr(vf);
 	otx2_detach_resources(&vf->mbox);
+	otx2vf_disable_mbox_intr(vf);
 	free_percpu(vf->hw.lmt_info);
 	if (test_bit(CN10K_LMTST, &vf->hw.cap_flag))
 		qmem_free(vf->dev, vf->dync_lmt);
-- 
2.43.0


