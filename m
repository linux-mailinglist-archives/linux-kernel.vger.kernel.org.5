Return-Path: <linux-kernel+bounces-113584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF288857D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A29E1C24DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4EF1C9EB1;
	Sun, 24 Mar 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI+J+dRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B274E3F;
	Sun, 24 Mar 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320388; cv=none; b=eAKYiqGUKVBd4at67XxDav00XbPraLlEf3fUwOneawkvnEagj0MJYKgcd6SS0GqAJeLqDUkTrdHsTKueAepx/NLj5p/9133Y4qwKZOCoxw86vD3Q9tQf4zvrhalYJ9Ry+BTsHptnzReIOkyOiVTa6h0ExdKgHz7urS2mwrGGSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320388; c=relaxed/simple;
	bh=vwZ5D5SxX73diJEFAtTAeHLjd4n9ybGa/CBUkh1hVtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt5par6kFy6bcNlgwEURzJ0xvbD5buujlUVwZEhqFvpZ0mHhg37smpjcHl8rJ1m6JbarPeVqy/irfWOp8t9nD0Uv2SFpoHR/K+NblL0xpGQCmnYAfYEHFpIpGUhezm0p7LbW8DxhoqaPR3ctWokTR/vHLXJWUrkDEzvDhHQfBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI+J+dRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC60C433F1;
	Sun, 24 Mar 2024 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320387;
	bh=vwZ5D5SxX73diJEFAtTAeHLjd4n9ybGa/CBUkh1hVtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZI+J+dRyfocEZoQPIHnPuz2rrNBEdd98x2lpA3bt6NFU81ZLLMIfl/f9YuIiNIhAq
	 xPG3clDpbtk/9N+XCAvNOWzTD/9vSodN1jKM7iGKUYKvwYjtdw4fs5ArMHGq6wsTj3
	 dXGVo7b4ZqCSk6HpvFqkjCUl6EqadNlcAwKlKP2xHq5YkHBDxxushYVS+6NtladZsd
	 gh+PRg5JzTm8TkD/zB0iqUrNTmJUfJPwX3InvCEUORqaLJ9qJYxE3dDZtLIU+ssg5o
	 2TwsrngJ4eJ20gK8MuM8UbjXB9ZiMShBS7jKuGNbIkRjXg1kqFoAGthat5lQ4akVQ8
	 VJuQOatcc6FTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 693/715] octeontx2-pf: Wait till detach_resources msg is complete
Date: Sun, 24 Mar 2024 18:34:32 -0400
Message-ID: <20240324223455.1342824-694-sashal@kernel.org>
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
index 02d0b707aea5b..a85ac039d779b 100644
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


