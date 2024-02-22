Return-Path: <linux-kernel+bounces-76797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC385FCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183F328A155
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B443152E0B;
	Thu, 22 Feb 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJHhs7lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B0152DF4;
	Thu, 22 Feb 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616492; cv=none; b=MGXlmT4Fh3tsV+P5QxUCTZA+bPJQf8k7jx9lVkjdHM75xqYRMQduDXi+GPy1pVcao0w0YPcVhFfKveVpuZhU7Hy9Lvp3BP2f80A4zZk78pAxCUju7/OMubWisR8YYhd2BVyG5ABwMk1C8FEXzg+EMQicllaSL6oSj2yoKDSa1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616492; c=relaxed/simple;
	bh=xCIGBwYX6XIyecIkEgq00nSGxn+xtBAV0Xn4DI4lFRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwqW9tsMt9uvoYI09W53TAz0DJthhr38MQECVM+5J3FrI7tT1xFlpTpOyPEvxrFK3AOQ0TLGUPKQbXbs19BDm3xPuWyv0JVRLg2Ji86H6ciy+F11WlpnuqfgrHzXSq6UZ/j4zFHKCi/3zGEIeliRBvn6kBQTudhUZUWhTqfDX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJHhs7lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB80C43390;
	Thu, 22 Feb 2024 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616492;
	bh=xCIGBwYX6XIyecIkEgq00nSGxn+xtBAV0Xn4DI4lFRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJHhs7lbcCFk6UhjYW0wfrz8wcaLvrooR3gSmQxaayS7Sh4/AjqZeRw3hBjMXCEvL
	 1VzZxJIhdEXWO2U3HCUkWX4Eqq3Ao6MkESVptlhbSp1xaao6k6jbMQqq7x7q3YQAk/
	 T3JMH2d47sIiA/cjr4RcPUiw8u7MWM19rC/DqOet+LpAmb0443YJsoYOzpdSJl28aX
	 GmUV8fLYij3E8YVd76XEa0xITi/eND1F23dNO7hol5Cfy598RficTVlU5nx+Bf8/R7
	 MeVQqHDOZENPkIAr8Lh9DraCSOP6JtZPf6iKlel0mtsAyzMECXuV2UES7u4KcpqEDZ
	 p1EfRNUwaDA/g==
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
Subject: [PATCH v2 01/12] soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE
Date: Thu, 22 Feb 2024 15:41:09 +0000
Message-Id: <20240222154120.16959-2-chunkuang.hu@kernel.org>
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

For cmdq jump command, offset 0 means relative jump and offset 1
means absolute jump. cmdq_pkt_jump() is absolute jump, so fix the
typo of CMDQ_JUMP_RELATIVE in cmdq_pkt_jump().

Fixes: 946f1792d3d7 ("soc: mediatek: cmdq: add jump function")
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..0b2e5690dacf 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -14,7 +14,8 @@
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
-#define CMDQ_JUMP_RELATIVE	1
+#define CMDQ_JUMP_RELATIVE	0
+#define CMDQ_JUMP_ABSOLUTE	1
 
 struct cmdq_instruction {
 	union {
@@ -397,7 +398,7 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
-	inst.offset = CMDQ_JUMP_RELATIVE;
+	inst.offset = CMDQ_JUMP_ABSOLUTE;
 	inst.value = addr >>
 		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
 	return cmdq_pkt_append_command(pkt, inst);
-- 
2.34.1


