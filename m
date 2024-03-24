Return-Path: <linux-kernel+bounces-113873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0F888710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA1B1F25905
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9B20AF68;
	Sun, 24 Mar 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOAd6+Qr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C514883D;
	Sun, 24 Mar 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320924; cv=none; b=Y6Ydxwn03dfrpwCyn3TIPwuRzbLjvzYjCUNn3A+DChYib5EsSL4jY94vq+d8Hjh9xA9bJ82iUz3DF4X5jITLXxBOFJe/uh82hbzJ8vXV5mki0tEi7lPFxBHpiqBwsklxK9a5ahjFol9jjd7+6CtfKuub2JuY/MJHQVPJHP0DkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320924; c=relaxed/simple;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Af1RgO7MRIYB2ydpmEk3e+2yZ6MQKro2xaKN3TsfMIkOb+P4EJyunoCB4FuPB8kT/lvwdYF0YpHS4z4ryVeB60wunkj15mFaKq7r7mrfkgn2peQLS2yrLcE7ml3GuwXB5ug5svqKY0dO2JOcM9nwghFpezxDlY5O3KcHOxtJJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOAd6+Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A3C43399;
	Sun, 24 Mar 2024 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320923;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOAd6+QrSb4u3H+H/7qdgYhtpHImCdoWD4K9/luPBb8xgnqptIQ0pHu7QibKNk3Ne
	 jrLfvnk5y8hqgkSrNwMvbmf9ruo65qlrklnJhQvqkCjfIy9FKirNS9gvfb7tVv9QuB
	 6zVOuTAKpcuRYA39ZkaiStDvJWwivH5r3c8IylIKb2b+I9FQQsYAxW4naWaNv8ejEf
	 PCD/9c2eEZ8QffHVmNDMLUdukAWYz57ajd063gkqxU2zrFwljdcIj38DJUiwT90iQi
	 OB69XK9EPi97awSDpTGlBil6xqHgCQrvNhyMwN91yh+UaNrcR9mJ99fsFwm3TosroC
	 MTOAfs7Vy3liw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 487/713] clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:43:33 -0400
Message-ID: <20240324224720.1345309-488-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a32e88f2b20259f5fe4f8eed598bbc85dc4879ed ]

'clk_data' is allocated with mtk_devm_alloc_clk_data(). So calling
mtk_free_clk_data() explicitly in the remove function would lead to a
double-free.

Remove the redundant call.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 9cffd278e9a43..1b8f859b6b6cc 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -127,7 +127,6 @@ static void clk_mt7622_apmixed_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-	mtk_free_clk_data(clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
-- 
2.43.0


