Return-Path: <linux-kernel+bounces-115732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D188A01F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2A9B41A36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F44364708;
	Mon, 25 Mar 2024 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1/4eMPH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A52197D7;
	Sun, 24 Mar 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321812; cv=none; b=JUgaSdzaTFRKv2jcDG7R3BK0TSmDvSs9bAOFmLxmNCBV4GFZsaxHUnTsGk8AcXegW44jcIgpphoHqUDman4smYHcERTwA4aN2bRg/sgB0fPcWy5yT4t0gWkJIypyMgHuBuT7STFybKBzwf7USVvytpcyLaMdczulx77cT82p8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321812; c=relaxed/simple;
	bh=I8ZEAf3dinyvI/3ws4H3uGRlv1YlJNvEjPVFatNhj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldEKGLHxsHD1X7ttjkVvncZtG9c8JOGN5nqAp6p/1d0n4JU/XHd6S9J6IaSTXbMipfsQzzmUVTq2dCoY+BUBT9C9Vihj3wjCNiSf/KC8HMrVv0OMI5isE3S1VT+aEbUoL6xQpe1g5t9YfQZitMNP6SxxxoP93sFU2LV+cc7SEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1/4eMPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAD1C43394;
	Sun, 24 Mar 2024 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321811;
	bh=I8ZEAf3dinyvI/3ws4H3uGRlv1YlJNvEjPVFatNhj1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1/4eMPHygSh0E7k7CKr7DDyPVDY6r3juAPPwfLA1XYYmEKX2WnRcM9BtZVS5NyYy
	 UG0LQrmdiiIMVS7INBP3e2UkmkSAhP2D8FBQy5ltH6rmkk8VHWCW12HNkv/Anrez04
	 xfEl0lEHs6ZW69QY3fawb5tvm3b61adwZoUCaMGIHQ/KehPr4gciHsTByodwwUk7Uf
	 yo73Fdps/UyLEUn5mqcVaMmxJo5mad4XP6zQ6jZjWLINmdU/tSpjt+QyGLD/ZDCNkQ
	 R0Tnzkj4zdm9U4q+thHIu8OsDJdLErlXdXyCAoWlJyololilhFziPUoJ3fy7Wwe14v
	 ShZi7fv6EjjyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 539/638] RDMA/mana_ib: Fix bug in creation of dma regions
Date: Sun, 24 Mar 2024 18:59:36 -0400
Message-ID: <20240324230116.1348576-540-sashal@kernel.org>
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


