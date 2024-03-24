Return-Path: <linux-kernel+bounces-113500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF638884CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC691F2234F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952341B9DCE;
	Sun, 24 Mar 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V30u9KjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9731B9DB1;
	Sun, 24 Mar 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320301; cv=none; b=gj29PWey3xIrM/WR7Lj3ceADqXWcKk3qjSBn4rDwqD8gsdz8xEcMWcqqTgCT2FnlMJrU8OhOhPiwcEiKWTYuYPigbUOl7FMMlqLTKs6mGr0Nccati7zkWYLI+kMkkKalnuZjslRAyV+xzkmtK6YCJN6JpqO8v/W3gZGyL/7CZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320301; c=relaxed/simple;
	bh=XJu2PDosWvo6ftdrnpc97k6E/frxFjZouHIAs4sPWt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuic1Hif3MjjMsLBylNvK/GEc2D9lT3rqIV/rC6KqCfyQ+ZVPWw/MuOCBg1l0gYPYD9vSmRjoMoYaLnmFVpvYitT7LAiuKgbI0RX8a/pm4SO3BmbjXhNaGx5nGAmr6krjc0g1rFM1vP8ffQOCwUxnS7LbIhptADW503LFVxCt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V30u9KjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17480C433F1;
	Sun, 24 Mar 2024 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320301;
	bh=XJu2PDosWvo6ftdrnpc97k6E/frxFjZouHIAs4sPWt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V30u9KjR2RV/SsKq8GlbJJIX3r5xamf6KhxTEHndHOUC+0UIr35G7Rom8lsdKcgg8
	 kXH/84qVdOheh6DbIW8WrkaRq+1rfguouyNbkvHvN4l92TC0+i5xav6RlkH2mslj/g
	 aKRRwLbR1RzXkcFWRgRPJqyKWT8vpESuYPRoV8vBc6f+czFqqOhu4S3MtMcGc7jaeS
	 oGIbbTpEMaR5G/+vIgVBTFlTo0nO/IpgyPBQN0IyK+K5Ojt9QPT6OnTf5XwkldTtU6
	 GRjMe3QvlwmEkKkd0uTuWWEU4HBhvE2WYZ0Fyo2+4CYuYk5hVEAdmV2GnKWfMiTk3Z
	 C8GeFrxbamXyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 609/715] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 18:33:08 -0400
Message-ID: <20240324223455.1342824-610-sashal@kernel.org>
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

From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

[ Upstream commit c77b35ce66af25bdd6fde60b62e35b9b316ea5c2 ]

The sparse tool complains about the remove of the _iomem attribute.

stm32_rproc.c:660:17: warning: cast removes address space '__iomem' of expression

Add '__force' to explicitly specify that the cast is intentional.
This conversion is necessary to cast to addresses pointer,
which are then managed by the remoteproc core as a pointer to a
resource_table structure.

Fixes: 8a471396d21c ("remoteproc: stm32: Move resource table setup to rproc_ops")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20240117135312.3381936-3-arnaud.pouliquen@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2c28635219ebf..10b442c6f6323 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -657,7 +657,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.43.0


