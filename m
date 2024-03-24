Return-Path: <linux-kernel+bounces-115959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F18894E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCFE1C2DF66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E1392806;
	Mon, 25 Mar 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW6WYAG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEF14AD32;
	Sun, 24 Mar 2024 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322220; cv=none; b=u34LNjKeKIN8aNIKOhcoU5CoDQl8eaIeofsuhF/UtiefIOAHtm0mVd3h7sCXM5MMZo6ehPAKbWld7J58a0CJlGez+sUugvTsklqzX1gTXhhaLl7HcxyudWY3qf9g8Mar23JNZifXz1imKV0zeRPtvAEqur1yrAlx0HkC2qIGYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322220; c=relaxed/simple;
	bh=n9RmBDkTknXlF+1oBI7LpD65+Xvb2cgfpRelD4wFYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJLwQU0DPdE+qpqvsfeAIUTKjsLvFYTuUseKBKN3+s0MSHsMrAsp50AwA9nWE7IcXfZjuI8McZLf4Yhykl5XIlrqrp9CBK+KG8SYU9Y1aHTPS/xJ1nYcI3EL+GlRJvP9F8tqJEBCFfO1QOkxlni31TRa6iiioROsWaT3W3hCx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW6WYAG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D30C433C7;
	Sun, 24 Mar 2024 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322219;
	bh=n9RmBDkTknXlF+1oBI7LpD65+Xvb2cgfpRelD4wFYjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BW6WYAG1+WDkpayrnxytR9sRSgabvlFrwJyW6cPjG5SPcwq7lnGCHKbmbjYnQ1l2q
	 f5e7KDliuO/E+rcl6JGYdm57pUvJ5rbIHWhtI4enLifaNgTGZ7od69TNasmAQ5qPaC
	 oiMudjeL0Qel7i2zpE5xGc6FAYZUeinRUsqFKJUH8uiXOVC0hqvJ5lgvnb/t+WamQ5
	 iYCQUmYTqjUx61i3xysJZC25hatwemj3a+Pbj7qYzvHjF4ZCnwA3JNAuQ0eP4NmpH2
	 4GAKbYbAmkG+i6IsYCg24mpV86134PUPbV+HyzaJPuimQaEolSdZWi3gqpJfqilhUO
	 dROQ98msNssPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 299/451] media: sun8i-di: Fix power on/off sequences
Date: Sun, 24 Mar 2024 19:09:35 -0400
Message-ID: <20240324231207.1351418-300-sashal@kernel.org>
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
index 3e58de58cd89d..01b44dd708bd3 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -931,11 +931,18 @@ static int deinterlace_runtime_resume(struct device *device)
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
@@ -952,23 +959,16 @@ static int deinterlace_runtime_resume(struct device *device)
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
 
@@ -979,11 +979,12 @@ static int deinterlace_runtime_suspend(struct device *device)
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


