Return-Path: <linux-kernel+bounces-113859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF65888700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ED31C261C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA91514FE;
	Sun, 24 Mar 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQvy2sZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908131E9F8A;
	Sun, 24 Mar 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320905; cv=none; b=uViemdIt091WD3XNIsd5zR119oxSP/Q8C49nZMvX/BtSjOb1L+pUkpQYbV0N4MBo0gy4E3Jz9UFlFpq5T8NhLknnq0ctM8ADMwJyoBw2CIcMvWk/mFMsiVveUZi3jRr/tZSy8IkoTWQ9RcXvY1OA/YVaeY7DDnL/vW4Pdw4zxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320905; c=relaxed/simple;
	bh=fHnzwmobOYNha3Um/3eYLDkuCg4PAOwPxx5h/dlW7Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsy4wPvASPyIqV0q4nOy0oXd4DuNpS3RFjKKLkq92yN0HuVK7gNOY27cK8kwDq5AwZSSWbpWfSCUUU37FGucmTYoQAkGRSI9hwF49lObntBvgM4QIpp/+kGFTpZdBoZBwsvBXRJ76vdsYCB0jvxeQgv3/xOl+IGeq2kQ4iijBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQvy2sZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8D3C433F1;
	Sun, 24 Mar 2024 22:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320904;
	bh=fHnzwmobOYNha3Um/3eYLDkuCg4PAOwPxx5h/dlW7Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQvy2sZ0b9CERF6kuNKJWZZyK0yvnU5y1umOU4/VzzmtJflKGStf0hcwWcT7L50wH
	 UoiFbgWRPB9DnvC0X8+9syBxEWuN3qniEgP/J2ZJSwTuQQljfNCtlF2nIVRaCrPZrr
	 vumITqVRa9PHSYFzrBBpLny4Z4H3FRIwxY0FSrBA2kxOGQmYMKKuKdFv7uollxE5PC
	 zU/pjNj8M9VNqAeBRmorQf02QQh5dlBjvi6igWg4nBENs9AP6lr/76J5GqTavMwvyg
	 mjs9caKQJBEO+KPLRRPkZhrnwkrvNbV7hyjPu679ZDW0qCrecY3jGCmusXJ34SQBjN
	 uCaIwh9hlNbhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 467/713] media: sun8i-di: Fix power on/off sequences
Date: Sun, 24 Mar 2024 18:43:13 -0400
Message-ID: <20240324224720.1345309-468-sashal@kernel.org>
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
index 34e0999392842..f253a40cc04f8 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -929,11 +929,18 @@ static int deinterlace_runtime_resume(struct device *device)
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
@@ -950,23 +957,16 @@ static int deinterlace_runtime_resume(struct device *device)
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
 
@@ -977,11 +977,12 @@ static int deinterlace_runtime_suspend(struct device *device)
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


