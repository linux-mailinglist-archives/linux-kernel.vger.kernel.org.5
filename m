Return-Path: <linux-kernel+bounces-66202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B385587A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E131C208BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957010958;
	Thu, 15 Feb 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxx40D/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9EE566;
	Thu, 15 Feb 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958218; cv=none; b=Bnx740eJMBOokPSvkt1pbHrKRclDkZdfCB5aBX97/sx/M/Gf+PVpqSdRmnJSBk8p9yUhNwnFiWUK8y8xiU8nTbk6Qasy7dqQ8uiZNfb9IJdKlgc/sXt/fMC0mtLTtIvZrjsdvzBYXi8jDo4z537xiOFoRoC+QKWC/udSEKRJuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958218; c=relaxed/simple;
	bh=dPziziTO31/IgvG01QjFF6q9F9Ksbkg3Q8cm4HNP0Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkDMwIIzAmqJK+kmp1GGqk3z/WKzcTAV8R93zNMYI/wWtUcCA0l+rK6KGghgPzxbCqDmx68ZSQsvPzr/t2ZalOCduY9ec/se11zuN79fq2iztGer/TFUwV66hy4sMRf60vOOvE40bekMmMh2bsNz1Aq7gsNEFqBW9ZlBaSA+YUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxx40D/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25994C433B2;
	Thu, 15 Feb 2024 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958218;
	bh=dPziziTO31/IgvG01QjFF6q9F9Ksbkg3Q8cm4HNP0Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oxx40D/89a6FlorbWuMzZEYV6v9l4FbG9HoWoWtIQbtV0NtDuB5wgcHL//ag4s+4q
	 TCgrMKpr9bn4NrblZK2iJsOfLDeRcdTEYJRC2DUXD8GbOcf9BOM19ThwxHzCpbFfuE
	 65xCCK7+1IzuOQtm+JmczPhYQDYwqoX1zUs9rjTRff+hT2qWQA5wIp5raLibyOslrK
	 W66bvZknkAFeqPjeIwe4oM+WfWh0ej8sF8ipaeoZvmhEBD6BVuF5yPoRV4+LpVIp0N
	 ZQB560i4SHwe2FD+b6LfJMoLQJA+i8Yv892a1KyZs/9f+7+/vZcM01+jdy6vCwR892
	 y1Y4ICvyDigvw==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 7/9] soc: mediatek: cmdq: Remove cmdq_pkt_finalize() helper function
Date: Thu, 15 Feb 2024 00:49:29 +0000
Message-Id: <20240215004931.3808-8-chunkuang.hu@kernel.org>
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
cmdq_pkt_finalize() use struct cmdq_client in struct cmdq_pkt, so
client driver use cmdq_pkt_eoc() and cmdq_pkt_nop() to replace
cmdq_pkt_finalize() and this function could be removed.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 22 ----------------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 13 -------------
 2 files changed, 35 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 1be950b4ec7f..9b937db7398c 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -380,26 +380,4 @@ int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa)
 }
 EXPORT_SYMBOL(cmdq_pkt_nop);
 
-int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
-{
-	struct cmdq_instruction inst = { {0} };
-	int err;
-
-	/* insert EOC and generate IRQ for each command iteration */
-	inst.op = CMDQ_CODE_EOC;
-	inst.value = CMDQ_EOC_IRQ_EN;
-	err = cmdq_pkt_append_command(pkt, inst);
-	if (err < 0)
-		return err;
-
-	/* JUMP to end */
-	inst.op = CMDQ_CODE_JUMP;
-	inst.value = CMDQ_JUMP_PASS >>
-		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
-	err = cmdq_pkt_append_command(pkt, inst);
-
-	return err;
-}
-EXPORT_SYMBOL(cmdq_pkt_finalize);
-
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 8179ba5238f9..f1d571475b52 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -266,14 +266,6 @@ int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
  */
 int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa);
 
-/**
- * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
- * @pkt:	the CMDQ packet
- *
- * Return: 0 for success; else the error code is returned
- */
-int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
-
 #else /* IS_ENABLED(CONFIG_MTK_CMDQ) */
 
 static inline int cmdq_dev_get_client_reg(struct device *dev,
@@ -377,11 +369,6 @@ static inline int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa)
 	return -EINVAL;
 }
 
-static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
-{
-	return -EINVAL;
-}
-
 #endif /* IS_ENABLED(CONFIG_MTK_CMDQ) */
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.34.1


