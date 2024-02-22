Return-Path: <linux-kernel+bounces-76802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69E85FCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81C81F2250D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E615530D;
	Thu, 22 Feb 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX0BMFOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9AF154C0A;
	Thu, 22 Feb 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616505; cv=none; b=qdsxDg4joc4Q3AeUALcomXOCZKjlHnXOyAoum0kzMmONnRHzLA3w6Pdmm2QFw6k8PUixXKIRnelneQCNZrezz1Lx6sOeciY98fW090f7x3C6UXoTnaletNXm1tO0/tMuutiBdcWi9NmMY6fx7h7kSP6Es47ErBTQDyHYsZtEvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616505; c=relaxed/simple;
	bh=nDJV3H5ien5JKkaRFl6YIw977BIcRyhSssibdZZbNS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdQBj+mRmFwktrhZ04vEhp+pupMXvDVfXYgIqUne53QtzmcmxtrUpizAxiaf3Rxot7NqULju6T1Uos2NoY2cG2dyyfZpIOBUrv77pSzjQzXKUv0s/kApRpPHUAJUrJl4ejwiEsbb8SHYTd2bj1t+aPQkDoCEDC6Kk7dyy+GqB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX0BMFOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB1C433C7;
	Thu, 22 Feb 2024 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616504;
	bh=nDJV3H5ien5JKkaRFl6YIw977BIcRyhSssibdZZbNS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SX0BMFOx6A7QuL23OjGPgrhtp4wl94MOyaFh5GXEeo2EooTQMADyzw49eslKGwAhN
	 3EB8LW7Bu0Nlwqew+qd2UPkhMWeJYO4Ty8PxJ51VhXGfyCrQ/11COqa0l0GTGZe8eE
	 XeAwwP4EVI/6I7hUjU/Dak0EBzOD5BNLevXL/Sd86iOhFzmmzKLKqUd0wxhpYCN2tF
	 7wzImDW7aud3DtY69Xs4Xd+e590SV7485TjKcQ148H5VK2LgencYiHnv4rE/XQxbQg
	 j3ps7o0ECniy5n2qHhn7SiKZK9Wuzpyau6Wjup4wsjqVa5LGLpbCgJEyf6VSBgrnZl
	 B8EmhyPJDJw2w==
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
Subject: [PATCH v2 05/12] soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
Date: Thu, 22 Feb 2024 15:41:13 +0000
Message-Id: <20240222154120.16959-6-chunkuang.hu@kernel.org>
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

cmdq_pkt_eoc() append eoc command to CMDQ packet. eoc command
would ask GCE to generate IRQ. It's usually appended to the end
of packet to notify all command in the packet is done.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 10 ++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 678db09983d4..766dbafaef62 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -414,6 +414,16 @@ int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
 }
 EXPORT_SYMBOL(cmdq_pkt_jump_rel);
 
+int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
+{
+	struct cmdq_instruction inst = { {0} };
+
+	inst.op = CMDQ_CODE_EOC;
+	inst.value = CMDQ_EOC_IRQ_EN;
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_eoc);
+
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index a935cd69d80f..45110494ee9d 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -275,6 +275,20 @@ int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
  */
 int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa);
 
+/**
+ * cmdq_pkt_eoc() - Append EOC and ask GCE to generate an IRQ at end of execution
+ * @pkt:	The CMDQ packet
+ *
+ * Appends an End Of Code (EOC) command to the CMDQ packet and asks the GCE
+ * to generate an interrupt at the end of the execution of all commands in
+ * the pipeline.
+ * The EOC command is usually appended to the end of the pipeline to notify
+ * that all commands are done.
+ *
+ * Return: 0 for success or negative error number
+ */
+int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
+
 /**
  * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
  * @pkt:	the CMDQ packet
@@ -401,6 +415,11 @@ static inline int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_p
 	return -EINVAL;
 }
 
+static inline int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
+{
+	return -EINVAL;
+}
+
 static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	return -EINVAL;
-- 
2.34.1


