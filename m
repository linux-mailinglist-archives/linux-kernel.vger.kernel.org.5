Return-Path: <linux-kernel+bounces-113929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1F888765
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB72B24FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFE2215952;
	Sun, 24 Mar 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8WxqF7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BC12BF19;
	Sun, 24 Mar 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321019; cv=none; b=c3Rr4s+8iajwUdeqkkuVxbcGGm3LIOr6Wx3PAKjDMONdMnzxb2h9DoGSprIh61URyco9upjFS9wCT2jKOG7rNXDCtmcYw3BCEhcj5H/zJqAHP5qD6nXwhAueHX6tOevVKUMxbuIcSg7NbLmPLIumnGQiarmZJk+Q+Ef24b4qhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321019; c=relaxed/simple;
	bh=4C25oCwPgly30uqHrAYSqQTvBxyzpXbGxKpIMOxu0jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUiTzX/kWLfnecSpZq6nS00HGsKC2WpaabsqPkzxi+CFGRK/3aqxonVn1J52hJpuVX1Lydy1cGmTRziAqRvhDKmRmGBYZQ70nh1bL52v7b4PlxIIf+GT5SZRzaIhF9Bh8fdp+V5NK9xsJeFtPRkNe4anjwL9VDmVCB+FbwmqUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8WxqF7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D3C43394;
	Sun, 24 Mar 2024 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321018;
	bh=4C25oCwPgly30uqHrAYSqQTvBxyzpXbGxKpIMOxu0jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8WxqF7Eum3qutCRWdj635eQrRCm9Ums+HeZsXMKt9RfJ0GY/lPpWvOn06iIu8LfD
	 pdZBTmyw0tv33zrGJ3W4qegWCce9IoD7aIl4K3AnxHP79uwvh+KPwNGs82lAcVmtfm
	 vC0m11WS1F3V27rf9M9/x/TeFuzDQZ9echTEiYfQiHBFuRkGCUn15vnMt5+MaVKgpZ
	 VP7HwF/uQwn3YTvYdpDHytMpcRchB5LryPmwUjaqCHsYdTe7bbEq5rcKWanpUr4W+E
	 8XIpaCmgylT8huV6EWzHLltY986+JOv/5ox+r60miZ6/QxiLU+C2Z6ZgpoPyFDaIau
	 fOLbvZ8RBAUAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dylan Hung <dylan_hung@aspeedtech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 581/713] i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling
Date: Sun, 24 Mar 2024 18:45:07 -0400
Message-ID: <20240324224720.1345309-582-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dylan Hung <dylan_hung@aspeedtech.com>

[ Upstream commit 10201396ef6455a68ac671fa0163205d327ebb70 ]

Disable IBI IRQ signal and status only when hot-join and SIR enabling of
all target devices attached to the bus are disabled.

Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Link: https://lore.kernel.org/r/20240119054547.983693-1-dylan_hung@aspeedtech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index ef5751e91cc9e..276153e10f5a4 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1163,8 +1163,10 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 		global = reg == 0xffffffff;
 		reg &= ~BIT(idx);
 	} else {
-		global = reg == 0;
+		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);
+
 		reg |= BIT(idx);
+		global = (reg == 0xffffffff) && hj_rejected;
 	}
 	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
 
-- 
2.43.0


