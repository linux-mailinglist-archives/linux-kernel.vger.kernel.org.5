Return-Path: <linux-kernel+bounces-113937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F746888EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C032828FBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BC13AA5A;
	Sun, 24 Mar 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPHxdkL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470441EF7DE;
	Sun, 24 Mar 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321035; cv=none; b=VtXqFv8O2wu62uwNw4TB/fFtF2NMdWa/jfGYj8dp1pdFVShLzkUCwGb6QRaO9452t0FNtSDPygDXWU8V2uhbD4fBARJcahHrRmGtMcuRo4Nv5aCKAtcSljPthvwZKlfhHk4ezVLE9UZrAFr29qjqkzXxE0vZaLfilELqrHwrHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321035; c=relaxed/simple;
	bh=I8ZEAf3dinyvI/3ws4H3uGRlv1YlJNvEjPVFatNhj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+eMUASYKTZGpG/IdkjbginnVCAVIu739xg0ZFJsCZXx0P4zBKsk5BIwTZLQqSoEfVMWVCWhPT51GDifjz1S15PcAQy/gdL6EvBEfYJd4PRzzKR/OCmZ5rzu0p/V1wzVUn9mObGEUHigN4MKs3+0dMjEzJvYOuPxq9FwOPSRws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPHxdkL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87197C43390;
	Sun, 24 Mar 2024 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321034;
	bh=I8ZEAf3dinyvI/3ws4H3uGRlv1YlJNvEjPVFatNhj1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPHxdkL4JWd1+lUrZhAgzrqRZtyw0O9I/tgwv13838PGxWOHVeVKtAvxVINvNvltJ
	 poB/Nta6bEa4Mva4k9TQuzVYA+YaBUZJ2DabMyPooeBvjJdbW2VsPr+CtNAk2ZyuhG
	 62Qtu4kx5S41f3+OzFd/MHYH/Dim5Z/+BePaEA5tMFdSaiiJ+w/88egqQ82Dcd77Ls
	 5kGXm1qIMZ758mwigYHlSHAnXlNq3At23xvj4oO20z9RatyCMJBg0sTmUiTiNHBRoA
	 EYh1botJ+lMOpPr4fKr+oViDF8HBbbJ1XvKwxIyLCDYF+BhGvEseqU6D3gpGHbBSKB
	 P6xfjPuT4WNNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 597/713] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Sun, 24 Mar 2024 18:45:23 -0400
Message-ID: <20240324224720.1345309-598-sashal@kernel.org>
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
index 7be4c3adb4e2b..ab91009aea883 100644
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


