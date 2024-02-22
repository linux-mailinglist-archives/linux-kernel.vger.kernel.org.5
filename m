Return-Path: <linux-kernel+bounces-76806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B014785FCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC75B26F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74231157E74;
	Thu, 22 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcu2M+N4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE715699D;
	Thu, 22 Feb 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616514; cv=none; b=XGE2wKggdA+VZycSqGyUG8E57kEahit7mvq8UykqXSKxXASWdrTGxmB+XNgG7MbVTvU2PqOOV+HIjlt2SeQLDZyF1Gpv2+6Fk455ROUO1f1jFo7cTaqlHnM35pIVcXkAQNC3uUHwlvHlP0+QbkQR8QTwjS4uUs985o0D3zSNFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616514; c=relaxed/simple;
	bh=TyYfmOPE/p3NSd8TeId10uLJdlRXk+ZcnArj63ZnB78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDE/s7P2chuw6HbAq6l1VWiSD6EXfkjCFkrj3Nak0zNR02eGl3GMhTAVEKqw5+XKJTIXQzUxPG6gVgup/ceHLeVLrbvxddqzt022Xh6keW85T+XSGp4664AHzAUmbkQhExrkARcuDbw9l1/+ANowX7gLoRCMQ3iClA05fjW+gsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcu2M+N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B457CC433C7;
	Thu, 22 Feb 2024 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616514;
	bh=TyYfmOPE/p3NSd8TeId10uLJdlRXk+ZcnArj63ZnB78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcu2M+N40lnWO0VRIjirr4tmgHxDycIihP1hNLX/vwGiRrExvp4aZrtKxMjGVbO/W
	 CBLfCfyrPZH7R+m/3nGdAvmq/SDiPRQg0oGXxG8peloIbT/vIJMbsk4YROvB16QtZg
	 7chEHJhemcr7VY6Cda3yNzVUcCbZdmdbvEgbBBu2mnARRfTGrmNgSUOHm0mH7Fp/DN
	 mfSKHNVYx0WbaDJ7SaRIWbPGejb4IbGX/0YX69D8G9lhcLvLDIkZqvFnGfPnXfRN5E
	 oT/eQXFrH2F0Fq47VyZuN8iiG7CgBgBDdqLxgpXg6znePkxnGLTDcfbrRthubA1kdn
	 xp2RIuy2lFMXg==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 08/12] drm/mediatek: Use cmdq_pkt_eoc() instead of cmdq_pkt_finalize()
Date: Thu, 22 Feb 2024 15:41:16 +0000
Message-Id: <20240222154120.16959-9-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154120.16959-1-chunkuang.hu@kernel.org>
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
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


