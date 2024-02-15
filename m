Return-Path: <linux-kernel+bounces-66199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAE855874
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B8B289865
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17AAD5E;
	Thu, 15 Feb 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG8swuC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3918F6F;
	Thu, 15 Feb 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958211; cv=none; b=GPnJ/VWDUjegsU+Pg9ybFjMjUc0GDKrYURZ+cu8vdNklK7z7AeA1Y+zP85YTdTXyUTYJBxKnwgcfLBA+ud79//YvNDffoEfOITtf+l31ILQbF1argWmAYPf9bYyvg3hVbFvu5nij5Z9NUV2j4c4zhqaRtxVxIxeO2f3axfdo48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958211; c=relaxed/simple;
	bh=7Y5HUcTOOASw7q/i66H/i3KoMA/Mx0KFs62yKsM7Q3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1kprDMUG6VBEB2mnB88ezjyfhoPaerVBpHTXujCiz1diI9SEbvQj8pGunsgUJFZagaqK1cugRmw/GdLMQdj7xYzXPAOOHJTvIsieEZ+s8bEwzfbBzg3uj4Wu2/Oz2z3L48wMSOelK4qMpvt1fr2bJElaBzU7YVHFGdkF0CNeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG8swuC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E13C433F1;
	Thu, 15 Feb 2024 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958210;
	bh=7Y5HUcTOOASw7q/i66H/i3KoMA/Mx0KFs62yKsM7Q3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BG8swuC7G7o0rc6PZD+BP6DnZFqHhFPMSq6dQMm688+1cJOISJSAFtHpXi2YZs7Ol
	 WeM5Fd70Is5xAllHt8MST0VoNH9/LjZeSNVZrZsaMs/kgdrFr9/8iIkpehRk2W+Ne3
	 aJyHnj0GkzPRAbiJdEgODAgTUqlsO12INSZffnQsk1XIV+W8jI2vYWyvUYgddYR8Fl
	 BOHn13x+9jah2yOtFMQAJIB8uo9dfOc1Z9GYHhvFdWyLACPuFqdbel/LDDss5AGfc4
	 A3+Qn1MAxuyNIig+Xz/u5MAzjDAUoHUbC44eYRyOfN2e1QnoaavfLaCGt/CNTO7wOn
	 ZNF7737Oj0biw==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 4/9] soc: mediatek: cmdq: Add cmdq_pkt_nop() helper function
Date: Thu, 15 Feb 2024 00:49:26 +0000
Message-Id: <20240215004931.3808-5-chunkuang.hu@kernel.org>
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

cmdq_pkt_nop() append nop command to the packet. nop command ask
GCE to do no operation.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 11 +++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index e982997117c2..1be950b4ec7f 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -369,6 +369,17 @@ int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_eoc);
 
+int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa)
+{
+	struct cmdq_instruction inst = { {0} };
+
+	/* Jumping to next instruction is equal to no operation */
+	inst.op = CMDQ_CODE_JUMP;
+	inst.value = CMDQ_INST_SIZE >> shift_pa;
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_nop);
+
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index a67f719dec0b..8179ba5238f9 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -255,6 +255,17 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
  */
 int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
 
+/**
+ * cmdq_pkt_nop() - Append nop command to the CMDQ packet, ask GCE
+ *		    to do no operation.
+ * @pkt:	the CMDQ packet
+ * @shift_pa:	shift bits of physical address in CMDQ instruction. This value
+ *		is got by cmdq_get_shift_pa().
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa);
+
 /**
  * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
  * @pkt:	the CMDQ packet
@@ -361,6 +372,11 @@ static inline int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
 	return -EINVAL;
 }
 
+static inline int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa)
+{
+	return -EINVAL;
+}
+
 static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	return -EINVAL;
-- 
2.34.1


