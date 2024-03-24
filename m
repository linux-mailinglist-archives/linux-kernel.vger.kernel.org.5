Return-Path: <linux-kernel+bounces-114424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F3888FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933ED1C2C177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98A27B10A;
	Sun, 24 Mar 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUISDbIx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5021C195;
	Sun, 24 Mar 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321839; cv=none; b=AAyga0f6EeW9snQAwi8oa4lgMAnMWebYSzCo5dOYQpQcZak/0XIaPMl/IeHFxUwM01cNzSXw3XrlFkovOe/SuJoXUaGn1aADTPzmjspcJdSu1/vVlZoo6w8SHr8Iy+z/rxSVz9KvzU6Lf/Vpr6+DGdWg+JOI/+/26ZOCZH5px1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321839; c=relaxed/simple;
	bh=6p00qWPD8q3Jl6wgFEBHQbhgscMIjhKq5hnO5ZFYyh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajBX+ZBW0/NamnOF3Am0NcabPLsQ06LQX3NwBw+rwHCffq8bCQD2ubAVK/9t5Foct3WxxPn7ipLzOL4EnWo1dgrV/2qoVo6FsqenNXIBf9oYFMrehZdW/Umgw2zwdKVvqEefyAJtV7+TUeuEfCKIfe8V83luQcYsuaQOPE08zKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUISDbIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD6C433C7;
	Sun, 24 Mar 2024 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321838;
	bh=6p00qWPD8q3Jl6wgFEBHQbhgscMIjhKq5hnO5ZFYyh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUISDbIxfZ2iBHvfpGeuhk0pHfOBqBlhoLEKtKUtctyWQTlMQkknN3uLc9m1s1v0+
	 wFE4KxC1tLLVd7qBwI74n3DZ/+kblDCg3Quj5mx1UQ9qo7KmqTyT/0RndbErn4xQz3
	 8vQhAbSXsIkls1i8gSNgT3xRVjX8eJYMN5JDF68dQxkOg9ytMn+jwQL2UZXMaWTNiE
	 qa+wyan279kcW5Mp2QSq2IRh5Nmra02il/W3WQdmGRGDDRLhZwf989s3IyRhHLVbGl
	 WsBgWTg2e34F3MNglfbh28L7Xl+95me+Xr5+3tk1b9ZPY7QpGuWoMKB67rQRjrL0mA
	 PY8WXLKYsiG2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 567/638] bus: mhi: ep: check the correct variable in mhi_ep_register_controller()
Date: Sun, 24 Mar 2024 19:00:04 -0400
Message-ID: <20240324230116.1348576-568-sashal@kernel.org>
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


