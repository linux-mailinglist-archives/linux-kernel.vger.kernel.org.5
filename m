Return-Path: <linux-kernel+bounces-76810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260885FCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50DB1C20B08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBE158D6B;
	Thu, 22 Feb 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULvRevFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F75158D75;
	Thu, 22 Feb 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616528; cv=none; b=LcCdg7vCAhoDTtVTOrrGXeOmfrKb5mW9NxkPduOpM77lQ2SAhZkPULqrftYGtdFT/IyOEFvtk++5okIvvp9wWPky4+A0i4TCxMqQNO85u6ZN+w/vBg0QQ5cvBcqSvK0rKT/npR2P8Ii19W5BJJMMJSOY9iiH1PWryyXfgLYGFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616528; c=relaxed/simple;
	bh=KO0UKLqm+OddAhcTdqHcm9JrDeUZKFWO1dn/YTdiCjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4aMGogdeu0NBcPIWZQNXN0H8O8nrOVhi3f50urY8ctefsar20vuJt8V5joPJNGdRiVayVq37YIJzSA80gljYrC3/kXePrzNZjifLAwSimyh2uB8OE0U9uJZr6Hcj65Xs+IH6PMSrtz0NG/2eyWV5jaACfvfnM9csfhpdILzUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULvRevFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CBC433F1;
	Thu, 22 Feb 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616528;
	bh=KO0UKLqm+OddAhcTdqHcm9JrDeUZKFWO1dn/YTdiCjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULvRevFmAJDU77CXRU8vM7MQqLlnOOa+4MS6HSmJUK1Dv3q5StBZqUarVmP1cNx/s
	 NPOPZz6LnWNa5c4SE/6hHkp7Ph+8W10fK7lSZoAad6b6MsKKFoWxNxxunTGmNHN7MJ
	 1e15LcfeelpJqpw5z6ME5jy9sUOsDeNj/r2x+YuH3bL7pehvhKcB/s6Ct8J7L+AQ7h
	 7REHqiFQB5M/nnabCq1Ef5H733QyWF27OeHuZE3GuudfYe2NVK1JW1GOVjArfOQRBs
	 tRY0ceNI+8LI/Bsg3op9OFroEYzKfSiwGTvtVBhG1nd/XN6D4Bou9doj+WPlj+XK3z
	 jD+HeaPMqs6CQ==
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
Subject: [PATCH v2 12/12] soc: mediatek: cmdq: Remove cmdq_pkt_finalize() helper function
Date: Thu, 22 Feb 2024 15:41:20 +0000
Message-Id: <20240222154120.16959-13-chunkuang.hu@kernel.org>
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

In order to have fine-grained control, use cmdq_pkt_eoc() and
cmdq_pkt_jump_rel() to replace cmdq_pkt_finalize().

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 22 ----------------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 13 -------------
 2 files changed, 35 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 1a1f1b260a06..d8fe98338bf2 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -414,26 +414,4 @@ int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_eoc);
 
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
index d9d0ee5ecb7a..6bdb9c0d6a29 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -291,14 +291,6 @@ int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa);
  */
 int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
 
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
@@ -409,11 +401,6 @@ static inline int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
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


