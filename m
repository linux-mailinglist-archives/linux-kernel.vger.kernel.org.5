Return-Path: <linux-kernel+bounces-113476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803C8884DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21713B2227A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3321B4BF2;
	Sun, 24 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4dm6KrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141661B453F;
	Sun, 24 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320277; cv=none; b=LgI79e2dvEceQZTP91q+11RCx2afriNgDRXrm/Hzv9r8n1j3o8ZJTaey9HWevOMxYMLnwJcSPqeIOWXkEcm75o0wptbDVQ/xnfjYyEabgQrd+0L2QaQbKUPBnYGIqH57izQxPwSfnrQdy3+qxOEvmZ+vakGowIHy9J05iKLuP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320277; c=relaxed/simple;
	bh=FyG+KOA3zwss0ROMKakELc5JW09kwZFpeal06o/3OWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXSdWkVohB887mCogMDgdGuiTgbf5FFuL75GSWaqKvpBPpE6GhgexwiNM7Ppt2gAKKFL3XGpelYjeLmi8WI8s5Of3Nzt+G164joNUPaUKJrrLSnsTEVOOTLnvCt+6gHv1OlVPiauBH+2b66hBjgSj1fl38gcfDqrhTLW0Z/79YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4dm6KrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481D1C433B1;
	Sun, 24 Mar 2024 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320276;
	bh=FyG+KOA3zwss0ROMKakELc5JW09kwZFpeal06o/3OWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4dm6KrM3QM3CAR6lkJ5M9mZM5cfOi1tO1bCCA/qE/St0Qam5WoMNrx/K1TuDJxbf
	 4VoAV6RgCx1Fr4YH7zJY0h5lj/yCXNCghYbX+LqIk64YAsywq5O41Fw9wiBsY5gM/c
	 ReprdTbxRMo0BEAGzFysBPkTxSMJElo8lOE9tIen/RkN8Ylb4+areSMC/oF7FGO6v6
	 wr+3hiWFW2mNVuQ9PG69JaAmGjN7mXvY6KplpDDfqYGq4BRicSwRwqclpvW/bzPMrI
	 O7VPlYrNmu/Cj1C6Xk7TeItAWwxAj6nYmfv0tt9c17QWMn7Pw5G9AUT/3b7kQnbN5e
	 7CrIp5aGNZFqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 585/715] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Sun, 24 Mar 2024 18:32:44 -0400
Message-ID: <20240324223455.1342824-586-sashal@kernel.org>
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

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit e02497fb654689049ba8b46f098f17d5f19e0b3c ]

Use ib_umem_dma_offset() helper to calculate correct dma offset.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://lore.kernel.org/r/1709560361-26393-2-git-send-email-kotaranov@linux.microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index faca092456fa3..7840c9e2631cc 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -358,7 +358,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 			     sizeof(struct gdma_create_dma_region_resp));
 
 	create_req->length = umem->length;
-	create_req->offset_in_page = umem->address & (page_sz - 1);
+	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
 	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
-- 
2.43.0


