Return-Path: <linux-kernel+bounces-115961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376038898E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6824C1C311CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851326803E;
	Mon, 25 Mar 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLVdTC9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017214AD3D;
	Sun, 24 Mar 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322227; cv=none; b=EpXhA7QSurjuxwJuzWmGGS4TCsDdMozMl0n0p2CJHnrpxCrIW3Untyfuis1ZHJDELsN3a0qSb7TDXbxFAaMKyJNx0b2wD6xrtiGJvJYNnWQjNJS/u6JoP6YFw5wBOZlykJ2TgRXUqFAZPPHbysUAafk1tKztuARgz/+Z7YWiz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322227; c=relaxed/simple;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btGkq3SUrxe4ORYDJ4sBVXTzevw2YzNM3SO+wVrZBQEsZMJ/HDgZxNe3IWvxiJBMjXtFB1clPG3/0M6VEo41avP134HwdG2exFshYDhOXtxcxiBFMrE4p3f7XERc3jcgp32V8PWbL7SOT5B9DetVqPhJSX8y7qL8l5xjroa6ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLVdTC9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB7EC433F1;
	Sun, 24 Mar 2024 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322227;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLVdTC9OAnaqRVWFqUk3JlIpd/sokhqZCsfC6/ZGf+RYwynfaPQUQaMWEqhRe8x5B
	 93zIUek4u6upH8loLTLj4EZySD3calVsFsA2ANOkO7kbuxtATsu+mkk8lRjQGOt34t
	 NziG85QN/6+nHfXJen09DrvdZbI6Da2SnzAGlevyN8JX19hAlQtV6mRl3+o+R34m/k
	 9gfu2dKQg0JLM6F/uewftKMGvMW4+F3Exmxbsumk6efwyW8HyCPv1TkRHUgtsLmLEF
	 fXIdCCDM2Zm3Gdy2FCrB7tsyZavqtCFsA+hlnwV04BjKYoy2BXOmfdbu4d7LhbWOWN
	 dvRxJ/EPWcsxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 308/451] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 19:09:44 -0400
Message-ID: <20240324231207.1351418-309-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


