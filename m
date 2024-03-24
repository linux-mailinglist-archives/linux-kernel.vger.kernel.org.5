Return-Path: <linux-kernel+bounces-113867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BB888EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95F01C21E74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E3209E2D;
	Sun, 24 Mar 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCsUeMhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579012A172;
	Sun, 24 Mar 2024 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320922; cv=none; b=qwx8qoynIxbGTqNgSyb1cunvMr8SQEhJP6Vd8cVDoMOPcrdH59UjDU9R+Kqpbbsu2eTnHgwb/+JudcWm5/NVAv1dywVN/+i1bsH09kpj/KOkiOqRwKxv0G21VLR15SViJNRqBkZ8MVpC81PURz8fFrV6G3XeVcyd4X7sH2WKGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320922; c=relaxed/simple;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua2FvVyVcCvMxNNLZLYlf2zFAkUcwhOaFdudvCsAior/XeRLHiffIZSNKsvRJJhZg059Ds1Uu/AtKVa0TUe+bfdUZgyBdcfiPsdFRD5p7i5UnX5D1o0SbtY3mVifdsZ7wNAP8WPbhFDAYsZa/FJdK9YpvMv7nkXp7I9Qykn95Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCsUeMhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AF1C43390;
	Sun, 24 Mar 2024 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320920;
	bh=0jeLzV7xh9um03QKzMZKQCMNMFblAXkgO2KjG9Ao6Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCsUeMhSIzQKUi5Qk0l6FySWSAm8ZFptItqVK82mTGzDepAwutN7wikHten35zc3j
	 H7cK6y+Nqvadcj4VU4ec4SbvxmsWbfPy9M7r7grsr406HoBzOiuI0lvGXGYKe5aJp7
	 Ua1bnLulqcmsn9Br/vZ5nu3YZn3YwwmJ25rxpBHdCoBPWZRs8LOmrH2/j/h6Z8GVs1
	 eR2tzjxrMUjQdLd4OOZ2TTJwfzWcKMPmQD4DPLJg9F4juAXK2i+Q+B+ACRSyd8/3Jg
	 9apRHwhTk2Yznt/Ts6A83pYuisntYWlLGD4HnDOuxSZ+dRVkLX8713OySWAjqZz5bt
	 tyf6ZQ7UZDClw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 484/713] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 18:43:30 -0400
Message-ID: <20240324224720.1345309-485-sashal@kernel.org>
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


