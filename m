Return-Path: <linux-kernel+bounces-114860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18468891CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3131C2D432
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF81BBCF5;
	Mon, 25 Mar 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E93yB//g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A27B104;
	Sun, 24 Mar 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323504; cv=none; b=mpZeCrLOMlcF02QFyOCpr7/2dfcnxXbnv7Qd69RRDBnSM1j/iKvPA05JoQxaNdoVc3VIFWm4NixiXxcwUHOUlLNxC+d6ZpiG5Z74NOZ4mac2KFmjz41wR0mlYFi/w1Gd95MnpUzTPkxoe8pxQsBf5JBbRzLn++sqddxVeH3NAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323504; c=relaxed/simple;
	bh=0Eg9GoRURLgZukSzhlo77FcQHJEdGPmW8mmGZ5+MOeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9MiZRByj0MTght9g+eLroB3pTAogGtsT9f/G6DHAMypQTzhzc5cpolK4HnGcBQbnf6SztWYKaQT+VVf0xjGcgimYCSkOq77+VuhsogU3A4dR2faBbjvX1KBZkcQJ2263KySQ7KbUvcPGzBoUoR7Nxpo+R9VTVvki6gxrznKBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E93yB//g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330C0C43399;
	Sun, 24 Mar 2024 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323502;
	bh=0Eg9GoRURLgZukSzhlo77FcQHJEdGPmW8mmGZ5+MOeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E93yB//ge0VM5CKhf1NIDuf4DH2FP/wzKzAxRd2rjxDQjqv37D+k+ZpFl0mPmCrGO
	 5lamaniHpqt0fsUM+Ii5Y8sJYxxNrW9OFXBDnWJsSUhJWFaFEZD8kCuLAwnBItsIr0
	 t18UaPvS3/0g3PUi7nJFgM21QeD417ozgnpXC7pOyoj+DGo3aOqqW+aOdHiSCg7gmV
	 +aRxo03im2JTfyDHZ77IZkzprRen6NGtHtEXPuQhCx/EPgaj6UqPUFmtyrUm/mOjhG
	 tUrFMlT5kjo+mOmQJVnMtMUrHI1z1vEMOq4XTsVMSzLlV2GgKw+vtidb7ACQxwAsom
	 CBIAQCRhoGFrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 208/317] media: sun8i-di: Fix power on/off sequences
Date: Sun, 24 Mar 2024 19:33:08 -0400
Message-ID: <20240324233458.1352854-209-sashal@kernel.org>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit cff104e33bad38f4b2c8d58816a7accfaa2879f9 ]

According to user manual, reset line should be deasserted before clocks
are enabled. Also fix power down sequence to be reverse of that.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 073a61c094183..8faf93c418ed5 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -933,11 +933,18 @@ static int deinterlace_runtime_resume(struct device *device)
 		return ret;
 	}
 
+	ret = reset_control_deassert(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		goto err_exclusive_rate;
+	}
+
 	ret = clk_prepare_enable(dev->bus_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable bus clock\n");
 
-		goto err_exclusive_rate;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -954,23 +961,16 @@ static int deinterlace_runtime_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_deassert(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	deinterlace_init(dev);
 
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_bus_clk:
 	clk_disable_unprepare(dev->bus_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 err_exclusive_rate:
 	clk_rate_exclusive_put(dev->mod_clk);
 
@@ -981,11 +981,12 @@ static int deinterlace_runtime_suspend(struct device *device)
 {
 	struct deinterlace_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->bus_clk);
+
+	reset_control_assert(dev->rstc);
+
 	clk_rate_exclusive_put(dev->mod_clk);
 
 	return 0;
-- 
2.43.0


