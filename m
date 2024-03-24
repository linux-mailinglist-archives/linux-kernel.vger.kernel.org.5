Return-Path: <linux-kernel+bounces-113409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F0888418
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE67D1C23AED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645B1A62F7;
	Sun, 24 Mar 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k73EOYYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800671A62DE;
	Sun, 24 Mar 2024 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320211; cv=none; b=uhsS2CDVB6Lr+facpNZrTRBBd2P42C7ib9+c4QnNVjsUedcAb523Lu1XO2cRP1wEc8YwvXHwJWB9IEFK5LJQOdeOJ2L+kyq5gUuLlWYOtg8SMOsCeBfiJ/xAmmrq+Rk+qckZD4pSBrB8Aibe/eaJ0sO9iT9YlIdS41+NM4RCWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320211; c=relaxed/simple;
	bh=Wml8Fpma/jCRajX7n0E7UooUQHgAIcEy1zlBA0LnHYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwL0oYLmc29HwAQsq5BSCp46C1jrZhWJmPaBSNxyeCKp0u4K5Ib/vkUnsDchWDpxXR2vXYMvUH1SYKY0BlBQzhtNP5HwqN99bmEEUaMUjXLXuUb0tGpE3FB7wMinhdAbVsAHweSgVVyP7qUsGSMHGJMWUot/GX/dGINCKu7XxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k73EOYYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B03C43390;
	Sun, 24 Mar 2024 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320211;
	bh=Wml8Fpma/jCRajX7n0E7UooUQHgAIcEy1zlBA0LnHYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k73EOYYgaqIBesTWw2fwd8esjgBykpXlg9iP5pE43L3s9XmAztl/0c5gjw8usLAnN
	 KSQaagTobwcz7P7tZ6rHmzaU7/7MUzfNlrXTfdwaOLRm+D6G68/Tj4WuypCCtUXJ1K
	 1wFTkOrqA0aVnhbbw/Pd0PwaTlnjvugdmBZRnstS9k4H2XbUHE8+qjCQ4x/AM2s42Z
	 2yj9YFHRMS2WsuFt4HI99mZk0CeoGixflk+CL2GBFmNtZ231QDNtRuQWlAGvnIYQcw
	 wUivjfDNL3W3vfDd20NUH3Ap8xGMJ0X6QlfmQevoaZJkloExEmRCuNbqsPROqbYgHE
	 R+cenGleEQe8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 518/715] powerpc/4xx: Fix warp_gpio_leds build failure
Date: Sun, 24 Mar 2024 18:31:37 -0400
Message-ID: <20240324223455.1342824-519-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 5b9e00a6004cf837c43fdb8d5290df619de78024 ]

The 44x/warp_defconfig build fails with:

  arch/powerpc/platforms/44x/warp.c:109:15: error: variable ‘warp_gpio_leds’ has initializer but incomplete type
    109 | static struct platform_device warp_gpio_leds = {
        |               ^~~~~~~~~~~~~~~

Fix it by including platform_device.h.

Fixes: ef175b29a242 ("of: Stop circularly including of_device.h and of_platform.h")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240305123410.3306253-3-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/44x/warp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index bf0188dcb9184..a5001d32f978d 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/kthread.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-- 
2.43.0


