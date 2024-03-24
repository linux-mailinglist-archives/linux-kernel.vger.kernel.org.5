Return-Path: <linux-kernel+bounces-113981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097B8887BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616EE1C26A86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A7E22098D;
	Sun, 24 Mar 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a491kQv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1D12D75C;
	Sun, 24 Mar 2024 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321132; cv=none; b=T3FHAh+m4RrR+MT3NUdAZUrMlq6cSfxII8LLEwpIPJvjN2zafVBFVv8BHVSjSTLbQSlj00sURc+m6L0rH93O4n5rOdPyz9Rxi0+7AG0MlOloUZhD4FiI7C+xCjtT77pSx0l3yqrUvZuwUqRFnxk9203l426BoxcYzbGwrxS8meo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321132; c=relaxed/simple;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia5bRndWDSdbCbvuP0MaCjtgCREf4vcI+3fPLKLSSllNr27+EaMhVTVjycKkLF6n2ucSPp2UBP3sf1XvvaXr9aSrdZQIrPVvXvcQbY/urPV1LqwFAAZm7DIBweCIPVbP6hXE8nDKlbOoSfLmKzvA2usNCmTwqZ3cG6gDZGReU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a491kQv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D853C433C7;
	Sun, 24 Mar 2024 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321131;
	bh=8XXbG/EChvRgni9pSje66q6hAnBQVFirBzqxkCwPY/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a491kQv5P1vwCAlviMKrYUTviSvaOaD2fU42go+tzoJ4HQoQgHbhdIz8KK0Lz+VZB
	 Eo6N6uszZl/1x9Lfisd76WsDyMv5kHb2OIN/aQF2BcmF0d1i5dK3rdk1xtMBDIyrC7
	 8e+wrFMEBjB8y10/Hr6bu9/MFETOPeSjgF9VqfP18a5Yd/yU+qwHQYuhzQf/ZEFfVT
	 FHdrwFPyl8bT5pmupJq6UL8TkhohrKtWjACcPFkW9E5JKE+tl3DWU+6wE+VjCN1u6M
	 Kf8Z9E5zWK7zkX3O0K+PIDEsy+T+y+qd1BbXbGICFm9MoBatiDe1G3w+e0PhhH7gth
	 HWK2T2b7dNxvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 692/713] octeontx2-pf: Use default max_active works instead of one
Date: Sun, 24 Mar 2024 18:46:58 -0400
Message-ID: <20240324224720.1345309-693-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


