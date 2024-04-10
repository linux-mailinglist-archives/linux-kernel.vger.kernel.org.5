Return-Path: <linux-kernel+bounces-138925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320C89FC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453231C211D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D726174EEE;
	Wed, 10 Apr 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmdksDvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9217554B;
	Wed, 10 Apr 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764453; cv=none; b=Agw5GcMtzVL8/jw8WOi1kL93woEFE9VHO/aigFLxfnrktLBpHtjz+bHM1sh4zBNqdjiiRSDp2QwxeTwYU5O8aFd/T0NRTwPandrFmqhnH1QhBZ0OKL7WF9xemJxGGNsFbG/NLs01qvB9Jn3fXAJ2r0iNd7VdJ0wGAgsJ+8rox/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764453; c=relaxed/simple;
	bh=bb46vZ/qYJOGEUqqoTrn1SAKdnMs641lNoDDmlmSBP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFZdkj/zc3R8OmKsoznDtTQOgXjWZeFCKho8jiBcgsTXmvW0CMFRjQ2IhJXRc/IqOUVl0fxfgse8VJUZIQeUuA2NmpHWSB8IWmOoQERl/6JCN9NoO8cSodtb8Cu37eEhHGgShFq2RBNXJuZ6PaWd7FCn2i15YWw2fuhRGfLtQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmdksDvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F42C433C7;
	Wed, 10 Apr 2024 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764453;
	bh=bb46vZ/qYJOGEUqqoTrn1SAKdnMs641lNoDDmlmSBP4=;
	h=From:To:Cc:Subject:Date:From;
	b=PmdksDvZxg0DP0QWJHIis2PiQoTUR4cgtizWYpZ/k2OiPuzWvMgndJlbmlQaDp4aP
	 yORgpECpNY3O/9dzpflHaPalZopZlIJ37vwFL3ft4ugAjws4S8HKuwCY+56MTsw4+N
	 OlGIH4DUBSoIBzSDoR9UE4nEzgbH6teJqiSNtRX7GBBF15zUIEPPwi4oliYOz3BTsl
	 93JKL9ektnoMb+BvJ9ZnC1YAdYP0DN1siBUbLAEXO7f/Jv6F1UwMS9cbU++ZR2VCtG
	 +52W8LGfjNwqtTWBDe5GxYZlvdFedIW5I1yrr1qVmqLRmJgLYRnbtCqCTDfCUCzkzL
	 BzizaCcSBLPZA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] clk: meson: s4: fix module autoloading
Date: Wed, 10 Apr 2024 17:54:06 +0200
Message-Id: <20240410155406.224128-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.  Clocks are considered core
components, so usually they are built-in, however these can be built and
used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/meson/s4-peripherals.c | 1 +
 drivers/clk/meson/s4-pll.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 6c35de3d536f..22ff030bd6a8 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -3799,6 +3799,7 @@ static const struct of_device_id clkc_match_table[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, clkc_match_table);
 
 static struct platform_driver s4_driver = {
 	.probe		= meson_s4_periphs_probe,
diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index 8dfaeccaadc2..8a917b9703bf 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -853,6 +853,7 @@ static const struct of_device_id clkc_match_table[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, clkc_match_table);
 
 static struct platform_driver s4_driver = {
 	.probe		= meson_s4_pll_probe,
-- 
2.34.1


