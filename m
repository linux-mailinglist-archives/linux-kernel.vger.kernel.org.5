Return-Path: <linux-kernel+bounces-140084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7828A0B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062F51F21637
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F3144D3B;
	Thu, 11 Apr 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hK+JyiwK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF2144307;
	Thu, 11 Apr 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824322; cv=none; b=L09irvy7cKmOiJn9slyzg6FrhlWnrNnW/y8u5YP91mZETgpt6WW1ajR1D1paw3og0lLPMHOFXGp3/XEnM4ZhXT9AkKctV1YjcbC7zilK9ipoIhca2sBvFOLTk9epaik7Pb82NtVQrvpWy4Z+GDlyiJuk7/QcwVe2SrWfcTZOqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824322; c=relaxed/simple;
	bh=LJ5xtskzI/p24BC4uZa8WFBkjICyouTGIeZYBD8ZDSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVl8QIzAPeelzWqN3Rm65w/EOYbLkvX0VzGVeNs8Rt9n+Xi9Ahb26ybTBspUoo5oSqd4+hXBJ54oZC98s09xE+HN1ufPBw31EIILfePaG+pMC8ECw3KTwoVNuSNYULn5a+a6DWfV2cLcG72KppyLXB6otW3eCh+8VgSjXWTybtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hK+JyiwK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712824319;
	bh=LJ5xtskzI/p24BC4uZa8WFBkjICyouTGIeZYBD8ZDSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK+JyiwKfJKb9pCyEgkGJ7NPPTcQnUJuwmaTdpHQgo76R6B0qs2LMlJ1a9qTPu/Gr
	 5sthmdNems1IuaXOSot3LPU7VR28X5gaoAZFzBa1y6BNfShKiL255nlNRc8uYNZDXb
	 3kvjJjLEkplsHqB8IZaePq9/vU7HwSsFvYSFChO9oGOMB997ZLQInoAmHUMJgp9VUM
	 2cUwYstgjK5uhapUl2PXL03+y2tqhwSvaAW/56bT6N/xIdI3pIXGaBRT0crzfBBOTa
	 ySuGxphryRjsbhx8NTq+oMA2f545gFYXRUL4jdcLyt9wRK4T1HVRdHhN1g8bL/OnRy
	 wCLLH8SzlDpSA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 57728378212D;
	Thu, 11 Apr 2024 08:31:58 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	chu.stanley@gmail.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 4/8] scsi: ufs: ufs-mediatek: Avoid underscores in crypt clock names
Date: Thu, 11 Apr 2024 10:31:45 +0200
Message-ID: <20240411083149.78537-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411083149.78537-1-angelogioacchino.delregno@collabora.com>
References: <20240411083149.78537-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change all of crypt_{mux,lp,perf} clock names to crypt-{mux,lp-perf}:
retaining compatibility with the old names is ignored as there is no
user of this driver declaring any of those clocks, and the binding
also doesn't allow these ones at all.

Fixes: 590b0d2372fe ("scsi: ufs-mediatek: Support performance mode for inline encryption engine")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 16a76b02c934..1c0c523ce1ee 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -573,15 +573,15 @@ static int ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
 		return -ENOMEM;
 
 	cfg = host->crypt;
-	ret = ufs_mtk_init_host_clk(hba, "crypt_mux", &cfg->clk_crypt_mux);
+	ret = ufs_mtk_init_host_clk(hba, "crypt-mux", &cfg->clk_crypt_mux);
 	if (ret)
 		goto out;
 
-	ret = ufs_mtk_init_host_clk(hba, "crypt_lp", &cfg->clk_crypt_lp);
+	ret = ufs_mtk_init_host_clk(hba, "crypt-lp", &cfg->clk_crypt_lp);
 	if (ret)
 		goto out;
 
-	ret = ufs_mtk_init_host_clk(hba, "crypt_perf", &cfg->clk_crypt_perf);
+	ret = ufs_mtk_init_host_clk(hba, "crypt-perf", &cfg->clk_crypt_perf);
 	if (ret)
 		goto out;
 
-- 
2.44.0


