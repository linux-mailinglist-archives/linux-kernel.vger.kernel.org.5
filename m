Return-Path: <linux-kernel+bounces-33542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0A836B06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB51F25B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49514AD38;
	Mon, 22 Jan 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSn3EHc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F714AD16;
	Mon, 22 Jan 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936669; cv=none; b=lR6EF0L0mfZApv+joM7KzkBixcnxOD13nrFYemwNOvNrOLi924I9K0u5pT2teL9LXbtNn8i4NgBXoaq6nm+zCgwIslZcreOznxHqDvlC1TDQBFNRixw3cgAYY8cf22VXutUtd1Vx6J2IlmRiwUZER9no3muvgla6X/jlCZceNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936669; c=relaxed/simple;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu6Ts3TIxT1yKcGRE2PI96eDfIVuFHl6DY8Rx5OBZyq7D5JIlxRwvLLGtWWdYe/9k9KfVaT5ktG4hS7DUu5eHq4Du5W2fpjhDd31rFwAYP+K60WtQWcSBuL4n6R6M5di+ODdwlqMqR2RDggwqwhVZdswQRYggnLVRYcMj9a2R5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSn3EHc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C84C433A6;
	Mon, 22 Jan 2024 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936669;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSn3EHc06hZY4MuIOcaxySDn/01c55iP/NhG6hGdnqsiSfTimP/WiSlnfxwlTt2FT
	 xvgzVnek2841koCMnJds/osbKMEfv6pLVtSMWywUqLrkFlZLiN++2q9lVZXUQrgsI6
	 quMSrH9JQUlatFRLJC1uZ72EhlA5GI0PnfDkskhd6Sm1fk2KFTS+A/0NnLIxjMXrlk
	 eWEjnZ5RpeDjwUeZ2RknUuD6SE+VvAEa7Vzql9kJvaR/3BWqCdaOIrFR8T3pW/+ofa
	 DhVatMeyn/nrPeBNsIWOXLH+qsSrP05a1SNEDyARVEJk8fB3MdnmbMT5J/X0EmDqLf
	 X2mGyvIuNYXYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	dinguyen@kernel.org,
	cw00.choi@samsung.com,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 19/24] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:16:33 -0500
Message-ID: <20240122151659.997085-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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


