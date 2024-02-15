Return-Path: <linux-kernel+bounces-66197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21B855870
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36251C295F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C24C69;
	Thu, 15 Feb 2024 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4SrMWPn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0584A01;
	Thu, 15 Feb 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958206; cv=none; b=ptDmSlE/nUcJSI2U4sQiN+Z6ubusHZdirGvODMKSyYuPr/VEE9bVM/H9ZqMSXtkvwIbcqhrW5U24HTURCV7RTDD04cc1Me9Z2Nu12LP8ZgxNTvO7VcFeq3tjRACNXm+aoU+V6mudm8WHtvjAv8fkqALF1INR9lMTEdWL6U6pUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958206; c=relaxed/simple;
	bh=BIeHFKJRxR/tz+Sb8qGs+H0wGg4wyyBVsQF9o4cfHQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpprnHaHWaepZSw+do+SrrIkiohkLclsHbGkCibQtOSjPjMcWOgfNxYeMQ//PIpYx2r6QfZqgiDpCUseSBTi6pSqOiWZzSWk8JE9FeGLcPulLlgsy4GpSP23EwXTdYVHfH8yg2R6JnTcN9u9P5zqevPt0gQLvla6eZ23tGdjhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4SrMWPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4F4C43399;
	Thu, 15 Feb 2024 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958206;
	bh=BIeHFKJRxR/tz+Sb8qGs+H0wGg4wyyBVsQF9o4cfHQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4SrMWPnJV/p3bkb6Gqik+U8yVgMiHSaXZ2VoWYqDv4tEPx1IplKfi+xQ9JU6c7aN
	 IhoGPmnD1tv6m4jNlkwm3zx4N+H5phQSJ2R29PMi58bklwg+DxKDGF2MlkIuYaXmCy
	 e+O3y4IRXhgCCXxQMnK98rVo+JuRmvV8SVK8d7evJaQoLGBPFBdjobgmJnMpQqYsqD
	 3Ecyx2IoAIROaYYLuYf0eiClE6h0LkrM8jyEZuHGj/vLxfKU/0KcyXxpkYmMBwvMfq
	 P8i+QjTcFM2JPbVup8YBrwDJF4Lzmg0v3iXw5IYb1LtfATbe8EZCSMqlX89QN70CY/
	 Or9UNM/yIQifA==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 2/9] soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
Date: Thu, 15 Feb 2024 00:49:24 +0000
Message-Id: <20240215004931.3808-3-chunkuang.hu@kernel.org>
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

In original design, cmdq_pkt_jump() call cmdq_get_shift_pa() every
time to get shift_pa. But the shift_pa is constant value for each
SoC, so client driver just need to call cmdq_get_shift_pa() once
and pass shift_pa to cmdq_pkt_jump() to prevent frequent function
call.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 5 ++---
 include/linux/soc/mediatek/mtk-cmdq.h  | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 67e17974d1e6..ed4ef95adf5b 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -348,14 +348,13 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 }
 EXPORT_SYMBOL(cmdq_pkt_assign);
 
-int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
+int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 {
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
 	inst.offset = CMDQ_JUMP_RELATIVE;
-	inst.value = addr >>
-		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
+	inst.value = addr >> shift_pa;
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_jump);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 6c42d817d368..6215191a328d 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -238,10 +238,12 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
  *		     a physical address which should contains more instruction.
  * @pkt:        the CMDQ packet
  * @addr:       physical address of target instruction buffer
+ * @shift_pa:	shift bits of physical address in CMDQ instruction. This value
+ *		is got by cmdq_get_shift_pa().
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
+int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
 
 /**
  * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
@@ -339,7 +341,7 @@ static inline int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 	return -EINVAL;
 }
 
-static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
+static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 {
 	return -EINVAL;
 }
-- 
2.34.1


