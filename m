Return-Path: <linux-kernel+bounces-115129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140C6888D51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B504F1F2A152
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78F2FF8E8;
	Mon, 25 Mar 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQMfnODo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFE181CEB;
	Sun, 24 Mar 2024 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324128; cv=none; b=HIhKuZUqJzYtldrjkUld+CpBlQut45L+Kr3AqS8SHcDxsT0QgXarZ6EH6oP4eOX3UYfmwnj2e+z7BYCb+V0WEGM71++Wt7vug8ALOTwP/QMXnUYTVud5DPNAxCMIQZpiKmOeZJruScQe8Cyg5ILywdKaOQUVdNlktssH2zWI+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324128; c=relaxed/simple;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPl3Gtvnv/PbLz9a8CwUQ2Yj3Vw6cnnfzM+k96SxuxEnW2KL4rnE7us57aDbpAQcKwHV09f5kcOYD6Kygmm8KtSJVJ+ffpMiw+HmIB04Rca3zyNjfZWz9MV5xRCCu7QHg9yRDZp/6b60y6GIitkzPVccUvRiJWt61S2BSsr5p9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQMfnODo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF3EC433A6;
	Sun, 24 Mar 2024 23:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324126;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQMfnODouKKGm3PoNNdfMoj6WpwesBz3J7cgRvosAa00naiyqdzGZibXPnVwZc5XL
	 md6egDitQ3DHyXQqVGzqNMmXjmZ+btvdGITPQiiw7IvQxw4QCy7aBjBKZBj2G6PHiM
	 YznR8g1lSiIy77EyAhgxBZ74BZmpudwLPx0QbfFFsAZzBusqnbSRskx5o5fAlEpd9h
	 PvtQZ9QTw1twPHlP1F4ChFmD68t2/WveHFJM1fXo4PrqzNXK1mHAXDC18FoKXp728v
	 w0qflEPwY3wLHZQk7MKjDNgNqY9BH1XJIeJ7aC+pSpUKM1xjPXPkY/Dnhe/J5VYuPU
	 EmC18hbCi9osQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 124/183] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 19:45:37 -0400
Message-ID: <20240324234638.1355609-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 74e39f526d95c0c119ada1874871ee328c59fbee ]

The gates are stored in 'hi3519_gate_clks', not 'hi3519_mux_clks'.
This is also in line with how hisi_clk_register_gate() is called in the
probe.

Fixes: 224b3b262c52 ("clk: hisilicon: hi3519: add driver remove path and fix some issues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/c3f1877c9a0886fa35c949c8f0ef25547f284f18.1704912510.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3519.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350cf03..60d8a27a90824 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -130,7 +130,7 @@ static void hi3519_clk_unregister(struct platform_device *pdev)
 	of_clk_del_provider(pdev->dev.of_node);
 
 	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
+				ARRAY_SIZE(hi3519_gate_clks),
 				crg->clk_data);
 	hisi_clk_unregister_mux(hi3519_mux_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
-- 
2.43.0


