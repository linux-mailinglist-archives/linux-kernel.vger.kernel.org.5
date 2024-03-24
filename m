Return-Path: <linux-kernel+bounces-113516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A978884F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058FD1C243A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0F1BD04E;
	Sun, 24 Mar 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEeMDeAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD651BD030;
	Sun, 24 Mar 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320317; cv=none; b=G8S0dTAmMwXqRMuRWAXufXXy79Xcy8NxxtwOdvyj8SGtK2HneJD/ajKLGG98BOY/DH3FnitFFV0pEb5w3yNtmWcbuKOyTp6gDq9/abEpAeRheyv9QZZHxiGPh3kL+lzwv6+SsbDHOL4JlIZlajioBmlMWumF1+heS3nvM5iAj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320317; c=relaxed/simple;
	bh=bi5hRMZZ6dmQWF3G3tWajxwBJIbdfbU1VvFygoXUibo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0UtpnstiFyBDKdtaXs2+jcYBzhK900nxJRUJ1VYTGFHaHGTHPNw9ixy9u+KN+zesx2Ay8BwGoAko36772i2cpQJdE98/q+x1cfMKZM70x87nbRPRS2ZgaQCfw4CkEEquJHt2kanPpuNtRWIWBYjk1S9Qty+F0dGtR6XDjIi9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEeMDeAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627AEC433B1;
	Sun, 24 Mar 2024 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320317;
	bh=bi5hRMZZ6dmQWF3G3tWajxwBJIbdfbU1VvFygoXUibo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEeMDeASbUFHoEqXbg9KqKVxPb/V4UQTeNCL9P7kkTwDqbiZMZap6jcTnv0//tND4
	 g7ku2w6ZpCVRk5daBI4JCVwIibWeDEQdih3LOXUH5Z5w1yiwvJAj2pBLdRj4nXGNq5
	 zbw5Nhi3nK88xKyCKvZB0MAeQHuPPsH1JoPZVU8+wPAFpK9DQDvIcPpRDUUAk7XmPx
	 uAAkkAJ5yt87CCyX67plTEavZyozTH914wmMnBKI/OodXrE4fAv4D5q+Uhn+VcR5RF
	 MnuUaXWT+YzRh4fw3MFYdcEU11Ko3dg1w+A/9cObHAAIDK5Oeb3Ic4zzX4M59XZ0w7
	 GlUQVyH8WWZww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 625/715] bus: mhi: ep: check the correct variable in mhi_ep_register_controller()
Date: Sun, 24 Mar 2024 18:33:24 -0400
Message-ID: <20240324223455.1342824-626-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 27711860c54ccb5e80719df684f49f0bf3f8fb51 ]

There is a copy and paste bug here so it checks "ev_ring_el_cache" instead
of "ring_item_cache".

Fixes: 62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/bebcd822-d465-45da-adae-5435ec93e6d4@moroto.mountain
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/ep/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec2..65f1f6b9b5df3 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1496,7 +1496,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
 							sizeof(struct mhi_ep_ring_item), 0,
 							0, NULL);
-	if (!mhi_cntrl->ev_ring_el_cache) {
+	if (!mhi_cntrl->ring_item_cache) {
 		ret = -ENOMEM;
 		goto err_destroy_tre_buf_cache;
 	}
-- 
2.43.0


