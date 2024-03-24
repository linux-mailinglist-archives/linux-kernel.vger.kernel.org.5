Return-Path: <linux-kernel+bounces-114319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD6888FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C762B3293C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B616EC13;
	Sun, 24 Mar 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmjyN00k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CB13AA49;
	Sun, 24 Mar 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321705; cv=none; b=Mp7EJcKUC9DMDP2eaKdbr6umehxrfe0gX1O7LaqakOZGrZgTusK49POe9hHwRPOLqztaCAdbsFx9iPcMgVv7QbaSGdH1bMdzikPXgcYbzOhjp1rqdFzBxy6ffqDRcToUxNz0gbgizV8+6K7d6JRuAVxnp1xXiWDatzlnbi8rUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321705; c=relaxed/simple;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLSYBqMJ6bTD54VbK4iP01UJW+ZwNF8sSJfpDnrWMi61PME3dkORBCd+7voU3CeFkizunQxjwpV0bxs2CWoOowweF2uGeYPT+Bl429werukEgnhDj8D6HI552Xj5ibeQEevhB19RN+rrpG/w54OvLT15Jk8j6kjhm+6QFYRAazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmjyN00k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF6C43390;
	Sun, 24 Mar 2024 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321703;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmjyN00k/LBQnrNYXIYnGCXmgv0VRYDNRWlLS8OYKmF9UehcEWriBClXWrDaV19S6
	 dJ+9bF6jYVznstPrwryl24aot0IDtx/Z8Ve/vOR/r2AnorXeDKTryYvwrPZy5aXUfN
	 QUwUNA5jvbKKZNSa9U/TmQHo91TbranixyX8MrIQJsoNM2rO6wv0wCw1asCMvGpOfp
	 BvPpeRkKejV+y5ua0OIMcHAfBCc7m4I/pV98IEsXn3MbmtBoLZg/IWHP6vDqU7Sac4
	 R1si/35pFBrjygNzRRoZl7+Aa2rntTumv6mewigcEar62K85ie1Bz8iMOXzv63eQAT
	 d2LhF48glTYqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 432/638] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 18:57:49 -0400
Message-ID: <20240324230116.1348576-433-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index b871872d9960d..141b727ff60d6 100644
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


