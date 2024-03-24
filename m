Return-Path: <linux-kernel+bounces-114872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D68891E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB791F2E0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA82CA441;
	Mon, 25 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDgmKIul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF7177A92;
	Sun, 24 Mar 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323515; cv=none; b=TXj0SmdglolPlU098B/PHMEGnaImJCyCBafF7E/5QrZOb6YoAjhq7hCk1OqIOEF0j1AO8In0cUEVIo3rbX7PQJJ7hO01o88/XRjTb92mT7FHhETcN+3D2fObznwWFDRfuNVvX6edbbS/rN93fe0l3qhmG+s88N5CSGV8toy4o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323515; c=relaxed/simple;
	bh=TYK28TeZGa/OFOO34UMom8LLO0Z98SnbL7GGLyYtOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF6zRpaamUDag+D/4d43xozM36OH7R+XS7r4hTU2AhqCGQd8EK0KchYRayIIagfw0swSqJURU3Bfg5fvT/Dr7tsYt4vXxBPffggNMl7FENUlBfuO5W1hc5AFyfgELgg7rII/YBIIlQmzXujW3AbvdIstZvzslTfMquNt/nSfhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDgmKIul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F569C433F1;
	Sun, 24 Mar 2024 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323514;
	bh=TYK28TeZGa/OFOO34UMom8LLO0Z98SnbL7GGLyYtOWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDgmKIultAl6dQzE95GpaQPaz8Am2oK+j5W++wfRnieCjg0Mfsndz4iLH6Ro63pUc
	 UwRYfoxN6vit44P1LDhiEBByK/8HMtE0i57Ru4EOmOMYws1oXw/nWN+LkeHZb5UtV/
	 KAGpO3ZstKAxlBPqSmnqz3dR6ssGkrwBk2QBQne8izoZRsktAxeGWxPTE0BPl2DLhR
	 hR1+uJLE4kKo8N+zVDh9J4g/hJZtXAq+djNIHMxZN3aaImJ6YXvfNsxNx4/GoSkfWc
	 e+76GmOQImch6+Im5asNPfdUwifh0HLr/zCVRax1Fs9JHb+xxUGC8kHudHYsJEmuGF
	 ilqSQwhQXUgPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 221/317] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:33:21 -0400
Message-ID: <20240324233458.1352854-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit e28c28a34ee9fa2ea671a20e5e7064e6220d55e7 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-4-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28e..dbe1009943718 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -110,7 +110,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.43.0


