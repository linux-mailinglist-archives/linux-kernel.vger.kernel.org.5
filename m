Return-Path: <linux-kernel+bounces-66200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E7855876
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD880B2895B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE9CA4E;
	Thu, 15 Feb 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqp3Z+5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4ABA4B;
	Thu, 15 Feb 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958213; cv=none; b=G1gi+CJZAZd8+MmEo9Gi+I19eP2RByxVNMGHsXM3NHZqTdWwUnl/PX4sh26WXB2K0Dfn2e5X+OsYwRldWy/c16Vi/IY3Uyx0C0+kag150Pa/RVvmZh8yXwfe4Emqea7UIXBtcJ9W53dKobTuXQidzg2cmN74XyW09aoe2F+tz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958213; c=relaxed/simple;
	bh=TyYfmOPE/p3NSd8TeId10uLJdlRXk+ZcnArj63ZnB78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0F30FFHcIqLr9ZzfCzG4qqtvWA04D2YLDVDOGSeguG5VOKYQ3sZnoJRP/wlTl+Rg4ESaOk1cklblT1hEPPABaSg5JJfjEUTL5T3yAHchcg/fcBOJD2tCmAOTXpsK8L+woFoAtLn82Wt7w/WcMN/kDETm44cOD36WFLt9GKSis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqp3Z+5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FCAC433F1;
	Thu, 15 Feb 2024 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958213;
	bh=TyYfmOPE/p3NSd8TeId10uLJdlRXk+ZcnArj63ZnB78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqp3Z+5F53mWZq048afnxrfe7nQprPLQu+KBQWmQOH2mkqI5soXwZfsv99yhXWWta
	 tb3QXoONODumGhTKQw1KTG+7Wo4q0nB/ywNPFI3f63X1ZzP7JW51J4MMGlt6HsNq4P
	 6nz7CMPGf4tG/tB119Sg0av2sKA7Opvr6vVclFqutXXz5KPsfgLGl4qigdh1LdIhJH
	 NIq1RPhRv7OQZNNhTHK76OSiOSaLdQ8MOMKhV4Xyv7Ya4K65hDpLW3IxgpXfDIXCAp
	 BDJjBTB9O9x0iwIlkX8tQlYVApISqlTPIAnmKKwY/1Eyz91MyxaCFXc/XTp3XbpsW9
	 kXm/K4qhZZD4g==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 5/9] drm/mediatek: Drop calling cmdq_pkt_finalize()
Date: Thu, 15 Feb 2024 00:49:27 +0000
Message-Id: <20240215004931.3808-6-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215004931.3808-1-chunkuang.hu@kernel.org>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some client driver, it want to reduce latency between excuting
previous packet command and next packet command, so append jump
command to the end of previous packet and the jump destination
address is the start address of next packet command buffer. Before
next packet exist, the previous packet has no information of where
to jump to, so append nop command first. When next packet exist,
change nop command to jump command. For mediatek drm driver, it
never has next packet, so appending nop command is redundant.
Because cmdq_pkt_finalize() would append nop command, so change
calling cmdq_pkt_finalize() to cmdq_pkt_eoc() to prevent append
redundant nop command.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c729af3b9822..df693fa268ce 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -593,7 +593,7 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
-		cmdq_pkt_finalize(cmdq_handle);
+		cmdq_pkt_eoc(cmdq_handle);
 		dma_sync_single_for_device(mtk_crtc->cmdq_client.chan->mbox->dev,
 					   cmdq_handle->pa_base,
 					   cmdq_handle->cmd_buf_size,
-- 
2.34.1


