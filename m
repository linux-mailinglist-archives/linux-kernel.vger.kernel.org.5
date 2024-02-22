Return-Path: <linux-kernel+bounces-76798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45A85FCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE528A5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836D153513;
	Thu, 22 Feb 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiBlVyOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C871534F8;
	Thu, 22 Feb 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616495; cv=none; b=dnbE0XTukdQMKwQ2SSKuZQvlXuCM1HHgJxjd7URlII+HfikkXXouBeGYlaWybazL4TI79QGRLjPocW72Su337xQi6FlTh5NBmzABiDB+TvExAZ5a02IBlU97Y+RZyyzQmisSXBvz24MSIs6kymsHiFwqw6q/uqqiDTIEPvdTakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616495; c=relaxed/simple;
	bh=RuWY1cv8Dhz18Wxup/ZL/5dm4lWX9+YTDfCxalcnNUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Elcb0XDhVdJKPCtyf8OH2MWHrGJnPgnKbF8cW/UpWWtwwwNl03R9ieCqRVzhzLYkAE5I7DLHTVffCc/PHfh9KYqA6sDZTZQu+ZDvwGFtzysATsUkPK8MRbV+hWNpkVVUNo6uTWV/Zv7XDHQvSlz2VnuYKN+qTVWg1TycCU34sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiBlVyOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5700C43394;
	Thu, 22 Feb 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616495;
	bh=RuWY1cv8Dhz18Wxup/ZL/5dm4lWX9+YTDfCxalcnNUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiBlVyOCYtJPgJOPH/yQz3yHhsu5izAVu0rXFmi6w6IQTdn8PtsC8zim0x2V6KkLn
	 gFG1gOFuwAKXl+Rp3793LnwLN268Tqmd38WhnUKQL0CrQN59BgC49LbtWhMxfYs87B
	 TAYruJfJ/809V40bGe6y4NHi/Cf8AwxlYazgBLacAuyNQDdUjXyRF22XftDqeekqjV
	 e02JE4zBp0nyDnjUCLKau6xDlPHsswTho8YevEGNB5ABJy/T7UO8Fib5hKNBMidEha
	 SWDtS3AHAMQfcThlt1R1u6kw9JwECb30RwkQkRwT0EfAFBVTOR1yv3cOoKHKRX5kdU
	 pmzIdAqmVsXiw==
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
Subject: [PATCH v2 02/12] soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
Date: Thu, 22 Feb 2024 15:41:10 +0000
Message-Id: <20240222154120.16959-3-chunkuang.hu@kernel.org>
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
index 0b2e5690dacf..3380e56dd69b 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -393,14 +393,13 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 }
 EXPORT_SYMBOL(cmdq_pkt_assign);
 
-int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
+int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 {
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
 	inst.offset = CMDQ_JUMP_ABSOLUTE;
-	inst.value = addr >>
-		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
+	inst.value = addr >> shift_pa;
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_jump);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 649955d2cf5c..72adfd867cd9 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -253,10 +253,12 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
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
@@ -374,7 +376,7 @@ static inline int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 	return -EINVAL;
 }
 
-static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
+static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 {
 	return -EINVAL;
 }
-- 
2.34.1


