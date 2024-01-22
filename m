Return-Path: <linux-kernel+bounces-33518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB7836BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291F8B2572D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B132144609;
	Mon, 22 Jan 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFDvyQcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFD144603;
	Mon, 22 Jan 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936583; cv=none; b=rKyBb7otBw7WnMlOQA47udRLSDAVWDLwOUskQH/YItYwks0yskRJRgqItaAGSYIDMzzSqzjWcc8enrXOOavR3cE9H8Qjp5h9npBGQCoQ3HchXxuBYCjpmkjyc1EWZEn8D8A8LLI/2DBtWPpBBMzqM0NBri9tG4ui/bBfnbMfIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936583; c=relaxed/simple;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI5aH0yzZiDeTgRz6YQlZD5L+yPm4k5wb0DVPAIgOmeiKO7ZKUCd0+HmqKvGqAJYFTMCIpg5uzcBYOfNKQb4GA9mPEMNGlDUPonKhcgI9BA/2hNuWorhJacRgy/cRqPtnG96vW7iWNfAYXbJJEnCZn5A0r4g/gId8DhyHXljFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFDvyQcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6139CC43390;
	Mon, 22 Jan 2024 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936583;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFDvyQcV6bo7qE+LJfGQdJJREAkz+pdPX/a3N8QowUvDq7NXcIE/RjOH0IxmuStzt
	 eXCNSXomki7E0nCpPMEjDnN0czB/jHYdph8DkljQ5nQn52AKVx1FONXb8f8YGHLos3
	 SUN98bMMUHbq8V8v7aPWkp1LvxwLybhHWwsKg/MlZGBG3WvIe+tu8s3wiTHXs7oKif
	 e73QWLOqpKRQ8gPXr5zlZ6Es3XShKA1eJoYxreR3zY7XQmO7YVZO6ZFlXJ8MvWDcQ9
	 mv7orwcqPHcCzJZ80vE66eBy8zASK1kxOnHQGU+fu6BOqd69FdHvdU8ngpQ0U4cpwu
	 RpAuqUT3aMlVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	dinguyen@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 23/28] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:14:49 -0500
Message-ID: <20240122151521.996443-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit bfbea9e5667cfa9552c3d88f023386f017f6c308 ]

In cases where kcalloc() fails for the 'clk_data->clks' allocation, the
code path does not handle the failure gracefully, potentially leading
to a memory leak. This fix ensures proper cleanup by freeing the
allocated memory for 'clk_data' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20231210165040.3407545-1-visitorckw@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3620.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..eb9c139babc3 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -467,8 +467,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-- 
2.43.0


