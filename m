Return-Path: <linux-kernel+bounces-113343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A768888391
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF60A1F22398
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E33198B92;
	Sun, 24 Mar 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thLRky9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3E198B75;
	Sun, 24 Mar 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320144; cv=none; b=M+MxoxoZllW46gWWvtCVvko9GbZxTwRmwHUAbq5aYe77aKIYGmg9Ad50CGWVpKsZIjLadTtli44FU+1k0dpnEVM6W4wsg/ebDUyklmGd83jnODjO1fEesUIvXY5NPiUn6xZBspudtZTExnnRygLtuzFcW8/t6JZdGwqj0mIihfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320144; c=relaxed/simple;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5dKhmxuBh3jsNO2LuKpmJhQU04b7chG5dilqbymDRCaGIg5ETcnW3oAbs0+YlfbzKRgZk5UYChvaUmv8E8sBasePb5573GqiusqZld4CZ2UERHwvdaAgINA48CefD2o5QYqn2Tz3+XZDSaVxIzx2fOmVetxWwOD5Y8FjDuC3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thLRky9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E71C43390;
	Sun, 24 Mar 2024 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320144;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thLRky9JzvkJSUZYGAygg+rkXxubfIxgl0xcFRc38BH39uyvk/DKH2/p6sMCZYOMK
	 6ghVwdraFcozjeEgxyzb1W2otG73cizNfBjxPxc44Q7M+zypHECjP2daHZvPn45qJQ
	 A78eoSZ2b2o4IbXVJWxc6LiaxwP85WpB5Q7YVw9AlaW1oHbpIlnUWS+jbCOYRjmRn0
	 XyGcYzf+ekaj/sR4UZa2Ls46m4YNdxuRFABCDQNvgr78jtFzhMBjtTlKXi+ap2xl2R
	 JRXW3d3uCjdaWDeF0vcD8qs2ELjBuqHTejvlbkeEzlSERcVkYHRLkANjVFwrChLPPA
	 2yS0xQHzmlivA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 452/715] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 18:30:31 -0400
Message-ID: <20240324223455.1342824-453-sashal@kernel.org>
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


