Return-Path: <linux-kernel+bounces-66198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F57855872
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA3EB26DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7C0748D;
	Thu, 15 Feb 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdY468GL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576A611B;
	Thu, 15 Feb 2024 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958208; cv=none; b=MlIcA3xBWUWVYT+HygqZkSXoOeTUVeWbqM6TWJXD6Y1Ir3zYfP/V8LyNI/o2of2gUlfLK9SjA1l29tqTYGRZkugUSL932O9VEVMclXW57UgQOXRY+Lv+1lNenR1vECLuQEo06cheX0yF6oqjQKdWsDAQmEqjqhyzFxJbM/YBIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958208; c=relaxed/simple;
	bh=RwnPPmbshIPrHAhqt6nvIojZaFpX1mNKJof+jE1wWoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flUBZrbKQo9IUMwby5yvGVXv0AZvrV5aQpKM/MMN6+dSLBLLe8FwC0KInxlq9/9uDhZjy9KLdcg1Irj/C2eC7v5ngk/KXI7YOliNE0fAVxh6b91mxGllOkMkO9kHu1lD3KEX527eT8n1r1BjYsTkpzTVZxSZjxXBOrNuSsNV0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdY468GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE18C43390;
	Thu, 15 Feb 2024 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958208;
	bh=RwnPPmbshIPrHAhqt6nvIojZaFpX1mNKJof+jE1wWoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdY468GL32M/G+gwv+w8ZLQRt22cvdi4p+clmYR7lBpR8Hz6COfk4WHL1LBt7E4pm
	 rCoGXVDTvlEr0RmzBpPCzDXjLkU7MWi0a0FBD494UymBcfDtsylmYnXgy6pa+HhaOo
	 V0+5zDNIK+lNekTH0wRZ5oUasQf9nGNaIAviARu649+NmdxAck0HrDrZtN49YYFtSf
	 XdvvPIENaud4rOP+MiXn+TpoEobLUoG/FseG+mML8ErNSHc8qcUXpmoknhmTS+T9by
	 azP5czVyz3ekp1ybTf1gJBsffPFcxUaYjVqhxx/udbcNPmsjkvOC5yLjv0CQvhzt5z
	 SQ+VXFjLwmO/A==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 3/9] soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
Date: Thu, 15 Feb 2024 00:49:25 +0000
Message-Id: <20240215004931.3808-4-chunkuang.hu@kernel.org>
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

cmdq_pkt_eoc() append eoc command to CMDQ packet. eoc command
would ask GCE to generate IRQ. It's usually appended to the end
of packet to notify all command in the packet is done.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 10 ++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index ed4ef95adf5b..e982997117c2 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -359,6 +359,16 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 }
 EXPORT_SYMBOL(cmdq_pkt_jump);
 
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
index 6215191a328d..a67f719dec0b 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -245,6 +245,16 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
  */
 int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
 
+/**
+ * cmdq_pkt_eoc() - Append eoc command to the CMDQ packet, ask GCE
+ *		    to generate IRQ. It's usually appended to the end of
+ *		    packet to notify that all command in the packet is done.
+ * @pkt:	the CMDQ packet
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
+
 /**
  * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
  * @pkt:	the CMDQ packet
@@ -346,6 +356,11 @@ static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_
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


