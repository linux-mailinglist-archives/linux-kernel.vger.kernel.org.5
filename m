Return-Path: <linux-kernel+bounces-76801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B985FCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DD11F2758B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B615099C;
	Thu, 22 Feb 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZVVBKw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE29154C0A;
	Thu, 22 Feb 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616501; cv=none; b=FSml6r/fVLShpkOcmtNIG4MOTx+ogBvk5gkTvrl7cEB3TGtrSlDdBGSEPjNUyktMupXdSE6GD2EPOrDhGOV1GOQC7T3mKsBS4wH2mxcKeKGm/EBkEtndI3Og1tkLUNVeBXTrpJ07Q9jv8fkWh3slQYco2VP6kV8U+mkWcp7PgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616501; c=relaxed/simple;
	bh=rK1krWLb7shm5l17Ae3PYsFAPIxWE0/hDUOnRbU8Hms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncHqStFTUeNELlJ19FmuQ4DnagdT54+ZUJ/I5tW37bqIkmUyR5wLx5W8dM8oNXBCVy6ZNYGIE4Q5sXP0wiZLDx+7hy0PSC+gVSUtyrwlXhgG1oVqVCDxkGbcw5zTZtdQfn5pyuhvS7i48QB5WDRlyimqawGjYSarDfr8MqZPlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZVVBKw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D0C43390;
	Thu, 22 Feb 2024 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616501;
	bh=rK1krWLb7shm5l17Ae3PYsFAPIxWE0/hDUOnRbU8Hms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZVVBKw2J1qlidIBDZKh0L7B2jAWgRX+55M0yA4RfXh4LLvWlCqc5FBcwKdjKNO8g
	 tYR5GfRnfvTuGqV4g03wJmYteJn09cG8IkNyGyawEMGf3EeLapDhpNp4lrik9xS3eH
	 5tpzH2woRsubrZ7fHY9HR+o4wamHPJXB3VIFDeHSd12N54XTsrmvh/5AymtyhwKWUe
	 mEs7qqZmxk1jDQWIwhCw6wvCTYZzzxjho5a83m3uLpfpkhXDQZv6bzy+9Jc/GscTOF
	 f+mvwe6MbfC614OuDsa4+eAKBZnwM5fTP0opxQaj/vu9bAFFu7+HT0v2+2bJ9jq748
	 GXS1chuI2eyIQ==
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
Subject: [PATCH v2 04/12] soc: mediatek: cmdq: Add cmdq_pkt_jump_rel() helper function
Date: Thu, 22 Feb 2024 15:41:12 +0000
Message-Id: <20240222154120.16959-5-chunkuang.hu@kernel.org>
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

cmdq_pkt_jump_rel() append relative jump command to the packet.
Relative jump change PC to the target address with offset from
current PC.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 10 ++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 38d9077725d2..678db09983d4 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -404,6 +404,16 @@ int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 }
 EXPORT_SYMBOL(cmdq_pkt_jump_abs);
 
+int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
+{
+	struct cmdq_instruction inst = { {0} };
+
+	inst.op = CMDQ_CODE_JUMP;
+	inst.value = (u32)offset >> shift_pa;
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_jump_rel);
+
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index f9b8608cb5d9..a935cd69d80f 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -261,6 +261,20 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
  */
 int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
 
+/**
+ * cmdq_pkt_jump_rel() - Append jump command to the CMDQ packet, ask GCE
+ *			 to execute an instruction that change current thread
+ *			 PC to a physical address with relative offset. The
+ *			 target address should contains more instruction.
+ * @pkt:	the CMDQ packet
+ * @offset:	relative offset of target instruction buffer from current PC.
+ * @shift_pa:	shift bits of physical address in CMDQ instruction. This value
+ *		is got by cmdq_get_shift_pa().
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa);
+
 /**
  * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
  * @pkt:	the CMDQ packet
@@ -382,6 +396,11 @@ static inline int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr, u8 sh
 	return -EINVAL;
 }
 
+static inline int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
+{
+	return -EINVAL;
+}
+
 static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	return -EINVAL;
-- 
2.34.1


