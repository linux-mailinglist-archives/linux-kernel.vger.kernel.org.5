Return-Path: <linux-kernel+bounces-113958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960D888795
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7771C26929
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C07155751;
	Sun, 24 Mar 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxhbvGdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87412CD92;
	Sun, 24 Mar 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321068; cv=none; b=A7z0tWifnTd+nnHXjpqo/BR2C8h6sgKhgGHOzIJoZVDbJ5nDMvsMUbc0ZaF/XflxOq2VJa16tKw8fiyp9DPv1e8hz5s/4aHnKP0kayK2M4CbBVqkPX/FKtYRtE3rgyguTeiaLGzmOmeXKOlpgdTtGQ8EDcrW11OvCTfmpJKwj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321068; c=relaxed/simple;
	bh=6p00qWPD8q3Jl6wgFEBHQbhgscMIjhKq5hnO5ZFYyh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUs+4Fv0iZOuF+ERZ+00+ClYP/3egBpHccP/wdcoWmAq37/onj96TLsYsdaeA5S+ojbR245SOXjScGOAdyaK8/8wgZ5JhIX8+4iTfljs4dv4J/yXttw3iRnPkcQhvh1aRGKzJeNUyXCJrPYevJueW/zjbPiKtgpBeJsVy2TUOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxhbvGdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6400AC43394;
	Sun, 24 Mar 2024 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321067;
	bh=6p00qWPD8q3Jl6wgFEBHQbhgscMIjhKq5hnO5ZFYyh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxhbvGdYkLDB6UBaWhyGyL/qF6N7aYI6VYInBU5nUt9h7vAC4L6Szlx1b4l5mCQhn
	 RKqIoWfKPcsG3yJJDRKnK+pVYpSgycIyND9jS037BP0+3Z/qJS74GpBzZ6Lc2oiZ+U
	 cmmlD52LxwAbZ29gLHmrAs60MLnvdBe3k1O0MJmjxmgCNR/2eVEJ6UwlHhpZMRQ60x
	 9/hkjmmaJ8EFaCKpuD/0BfoKhlvCnNdLiAXudUWwS+CWVwfx1pf9GTmNh01M+CxYqT
	 sRWvgTiWZAfniTTM5wBTJvcxMLzqG+heSa0ZwUMti0R4ED6w7Hb4Mbrw3DC4fDG6Yz
	 rOi1uhiJhuNXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 631/713] bus: mhi: ep: check the correct variable in mhi_ep_register_controller()
Date: Sun, 24 Mar 2024 18:45:57 -0400
Message-ID: <20240324224720.1345309-632-sashal@kernel.org>
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
index 582d5c166a75e..934cdbca08e44 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1427,7 +1427,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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


