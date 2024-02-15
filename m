Return-Path: <linux-kernel+bounces-66201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400A855878
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660631C23909
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC41DDD9;
	Thu, 15 Feb 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdh5+2zv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D96D536;
	Thu, 15 Feb 2024 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958215; cv=none; b=BRPvZKUlmS1G+eBQCBvm1DHfzoFodY+v7werLdV0Jqc7pPFMaszDdnV+XWHqZPXRxgWUhqfVSUrHoWH1Ywj2aAhHWt3REtPdLjFSyutmLW0CXDuQlAsmzerc4DHUsYxWMWCdKtiVA9y1omUj6BeJQryOm+EHWSXMFz7D5Q7hYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958215; c=relaxed/simple;
	bh=onMwpEpCvYyOOnD0Sp7hg/kBPts5AP1MXCVhCIOJE+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPZha2B49NQSlMpq/xRuY0p+VOhkxoqgXVffzs+oQAaDFOeZaXctK5XC8yKuQ3RbDSN3C+CmyIVTSEqez0Esz2qZ71FNUSZuG92892tWn2Wnr7hB0XsvbjhoD0YL6QXC0zMl6VtMsDpc/JNkYXh2wFT2HY4BcIZN+w8xqC6Yirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdh5+2zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD0C433F1;
	Thu, 15 Feb 2024 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958215;
	bh=onMwpEpCvYyOOnD0Sp7hg/kBPts5AP1MXCVhCIOJE+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rdh5+2zvRc2LrJ6l7s6QBojxeuh17PxDFF//fFMjlTKe4GlzMFXuYgDn4SS4CeTvG
	 Cg0jiURwzgUCaWtz4G7vDnpGmbFm7FidT01rTbFNq12U4NTJNVhi4651ZrPc48xHL1
	 tEz/vnnU9EIK5/w7svcP7QwcnZaP8deSPze1Zd6a1g7S2dWSPwSsAXbxX8b42+ROpJ
	 bizzenBgdgrkXSQDrUEK1H6yOr9pFLNEDjKhBxuHf0+vhbK4hB56nI3tEA0SbKC6UV
	 bniF2OQ4FkCupI0d7WX3Ax/2s9V3VGLUmRVzs78rz8LR3Qb0U/i37izMdpnfUb4d9X
	 8hp6oNK359O0A==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 6/9] media: platform: mtk-mdp3: drop calling cmdq_pkt_finalize()
Date: Thu, 15 Feb 2024 00:49:28 +0000
Message-Id: <20240215004931.3808-7-chunkuang.hu@kernel.org>
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

Because client driver has the information of struct cmdq_client, so
it's not necessary to store struct cmdq_client in struct cmdq_pkt.
cmdq_pkt_finalize() use struct cmdq_client in struct cmdq_pkt, so it's
going to be abandoned. Therefore, use cmdq_pkt_eoc() and cmdq_pkt_nop()
to replace cmdq_pkt_finalize().

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 3 ++-
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 2 ++
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 6adac857a477..a420d492d879 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -471,7 +471,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		dev_err(dev, "mdp_path_config error\n");
 		goto err_free_path;
 	}
-	cmdq_pkt_finalize(&cmd->pkt);
+	cmdq_pkt_eoc(&cmd->pkt);
+	cmdq_pkt_nop(&cmd->pkt, mdp->cmdq_shift_pa);
 
 	for (i = 0; i < num_comp; i++)
 		memcpy(&comps[i], path->comps[i].comp,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 94f4ed78523b..2214744c937c 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -231,6 +231,8 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_put_scp;
 	}
 
+	mdp->cmdq_shift_pa = cmdq_get_shift_pa(mdp->cmdq_clt->chan);
+
 	init_waitqueue_head(&mdp->callback_wq);
 	ida_init(&mdp->mdp_ida);
 	platform_set_drvdata(pdev, mdp);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 7e21d226ceb8..ed61e0bb69ee 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -83,6 +83,7 @@ struct mdp_dev {
 	u32					id_count;
 	struct ida				mdp_ida;
 	struct cmdq_client			*cmdq_clt;
+	u8					cmdq_shift_pa;
 	wait_queue_head_t			callback_wq;
 
 	struct v4l2_device			v4l2_dev;
-- 
2.34.1


