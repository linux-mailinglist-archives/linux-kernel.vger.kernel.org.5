Return-Path: <linux-kernel+bounces-113346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7AC888397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4F01C235FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A251989E7;
	Sun, 24 Mar 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIuaA/km"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF3199252;
	Sun, 24 Mar 2024 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320147; cv=none; b=SXGzUOUZYYnOzYMsiWzWW5I0s39o5rBn1vrlXO8ex2b3PQh8X2ilLYA0ynt30fjZYgX724REmapFcgzZ2uh++CfLg4Bc2/4xFLHspi8bliTrsjkBXfg/uTylmSO8CbMsnUul5pFnosfQDQnQWte6Mje1M+utin8TuyP908ny2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320147; c=relaxed/simple;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaGOU/f3BPsu/ed+Ob6xicUsYFy1AvGfHwnCUPBE5qvz+j94TghM5mdezSjAjVqDEzHtj0oNzsaZz16+bE/eL/wUSpY6s0RvZTuh9dIZ5SWEgXNiq6YfIxpIMgTJey98md2CjyNh1wDtx95aOkA1DQ0fvxGOeh0Wec8z5A7U0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIuaA/km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435D2C43399;
	Sun, 24 Mar 2024 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320147;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIuaA/kmlcOh7hEe+VVkC5neqFesWPZjUEaiWy3Vvzl5Y1ZIRyBoibMsTG0cWOptk
	 tligBageWKnTQPdw1kfdCPHI/stnMLgoctFc1bbJQE3ZFgfm9bJPlwyoBLDJWCp610
	 NtAFspIAOeptzkvWiuPAUMWToTgZafXf4ajeDCVMA/bGgR0bfQfcg5/zUcbtsMu0Pq
	 pVtqA+aKMCt8CQ9P8Nm14/ifCU+6BQ+79GnWkDUBCKGerJUMfw+Mm8dKlfVKD74XsK
	 twwaK86DiO+AZULeI026jVeLQhrZ3avQBo8KKfuubvkVvsp4nynNo7g0Z+gmTq5752
	 ZrBXMnjGf0TQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 455/715] clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:30:34 -0400
Message-ID: <20240324223455.1342824-456-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


