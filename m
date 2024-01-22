Return-Path: <linux-kernel+bounces-33485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E75836A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792CF1C247A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E152F99;
	Mon, 22 Jan 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZlq/fcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B06135A63;
	Mon, 22 Jan 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936471; cv=none; b=kv5A3E9oumuv2iRT0YocP7cboxtsAHoXzy82/iSOGtbag72PwrfaVN/Cqk4mM74MPxI42SixfgLh/u8V0w+CERn9/RldcpknoWBdjQq/GzdjBxK10a3vdgoxQCv9PyxbOZ4lc+d5IxcXbU1OhZ0DY3uPmUab/T4VDTi8p6Ui50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936471; c=relaxed/simple;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWIKHkhF5jEoCU3TgmkXgud6Gu5OtkW6Eq4MnmrDBa7BLayXMNVyzhZ72KC/rvOOOdR9951tzKDkRcwL+FcrqrZcO8atZsSeyf+c2kNUrUz8SeGGhsbXrxMef+Xb+0FB/SvU/CVE3mLVyNOf8WUO0b5I9287ZbFCu6Wbd1UVxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZlq/fcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802E1C433C7;
	Mon, 22 Jan 2024 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936470;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZlq/fcD2xca6I0nrWdZqvvU88Jsdg0TuxxKPqYhZ1aAVkydZxeaDfER1ytlxdeWF
	 ubyndsn4gQvOtFr2/PhevbaCd43VKTiEV60Gr7pn4tFP2TmThwFUhdkIOV6qIv91IZ
	 +mLzEUHbGbkwYPOMbZtwAywDpvBwolgqAuTiBvNsdgNFMXTMtIR7XJsZ9wwVE6Qg8b
	 bz1IzAr7QG1/mcHrxMk/A+2hCekarIdLV+pqpiqjbR4tkx/VFHwHDQmx3PxzWSg9wp
	 gl7wGKYcFsXs1WdtzFXtCHbpGOs4W5v2lFiI4/OdnLNDRAgiPRI6flf/HA4LPWAYWS
	 45EBGwdYfoFAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	abel.vesa@linaro.org,
	heiko@sntech.de,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/35] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:12:24 -0500
Message-ID: <20240122151302.995456-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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


