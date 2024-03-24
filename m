Return-Path: <linux-kernel+bounces-115026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D9888C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C811F29359
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B21C17E0;
	Mon, 25 Mar 2024 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0K3wmlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67B2853F8;
	Sun, 24 Mar 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323831; cv=none; b=WOvcW5yIXsazKJlN7UHuUj8Y+nlPWu950xeP8jFvLHQQtpky6hzhqtMFJCSaXUV3+K98q6MwQW/sk0u3rmA/r220hDSrSbkCOOP3mbf7mGIxZSuzVLz/VAPkt+Yv9tILt02wD4g7AG2BMxGQTd47LcUyMoQJAdokidbxzfhqynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323831; c=relaxed/simple;
	bh=Z2KX9mTTI28dMsecRddWr5ign6Feol3zpL27DLWJepI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TImbv3NDW7753Nsnl9HEpBUhvJFMKW2tvxouZgyeAfpuRSB3Zde13WmuSdNrbUpf13cTjJZlFqO3o9DIyokd3rjs2FqL6t0WB1MSCEmXP6JpKIEWAI73nTr9dQBJiotcTWMgQpd/1Dr7NC4eMKGNKhGCF55tQsmaM+7qu0wuTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0K3wmlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A217C43394;
	Sun, 24 Mar 2024 23:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323830;
	bh=Z2KX9mTTI28dMsecRddWr5ign6Feol3zpL27DLWJepI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0K3wmlwLlA3aiK3VgG4vrhb+0S+wEHir/5bQ7jC8w6r09CN9NZCXzfVdp6AdWpZm
	 cm4Ee047XsJ9MAte7JCDvKfs5DvAPJl607roxndgHY+L2jDoOMo3TV8yjoB4bWWUst
	 kaMWjlQctna2f56DX9cQHs8oy0mJFoIBk4eT5hPAcXiXofXoGKs8iu5Kpl1u4c4PgF
	 jl2eO1uDjWKTbSKxp5ldNr+spSCZkKLNZIVes63v+sLkIIPs9vniNtRTa/UQwRENAk
	 RQhwoiRF+py3Avq3R2K74/g3r4/kf+ZOkJhBvgoHHj7dyJS3d7TWSW3/PRmVJJgcIj
	 +mHO6Na5JZW3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/238] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 19:39:57 -0400
Message-ID: <20240324234027.1354210-210-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index d11949ae3ba0d..6e529ea05d3a8 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -617,7 +617,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 done:
 	/* Assuming the resource table fits in 1kB is fair */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.43.0


