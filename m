Return-Path: <linux-kernel+bounces-114868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8398892D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57FEB30147
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4B2CA433;
	Mon, 25 Mar 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2/8bGBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D213C694;
	Sun, 24 Mar 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323512; cv=none; b=fte7TAf+uWJrwbgS9GJcB4aFpie2hlva4jjIbQdlJ3RkMjcaAmi8ws1TQf2y/3R9+CQj5yzjrvnGt1WSdRQB2o60IhmlEAgeYHJCFg8jXwg9c/HufgHX9B22yQ2uGzeM+Z+ALVpTDj/fA+4Z/U59YueNHG8FV5xW/se3t2t/1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323512; c=relaxed/simple;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0Wdvl+L1nnclBOzk8okg3hli5I2A+3Rj1XwDhSdJlbaxN9iaHylsgWtmM6AMM9IQP9OPC0pmWJBAfmVX5DNF9+RrW502FBjAzkVi3ccNUVCP+8VnP9UFGSkPTUaj5lErVj4RQrXDxfnKNoG4yBcbHkMA/mPKvcS8/g+WKJzD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2/8bGBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE38C43390;
	Sun, 24 Mar 2024 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323511;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2/8bGBOcBhadc1Rf9GhYwVjwGERrNuDAO825BrsHMsRjfhctBm7/NrWhvvxhRhvt
	 qxx830+wQWLDh90cD42x6WAN12/opUnVF7p78jQ2Iv65Tr9n0vNyMhHWM3k2YRac6U
	 jXqH9IQgRZ+tWuXRDlFq0tHlgptVA20uPMRYwe9aM1OXx2K0yczNUtwWF0WSxKWqLg
	 ceJZcrO1a3Y19h+IFgAYQbvTZ/xhTSRhUOmY35SSKarCpfWpY/kDDtJE03U/dwoQwq
	 q5hFt4OaIFupOC4K24lf8xu3+qkhYCeMcr6mB8LRd3T6l8jfvaU/FrwQjvFgTWlLuj
	 EfV5tJFxRzy/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 217/317] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 19:33:17 -0400
Message-ID: <20240324233458.1352854-218-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


