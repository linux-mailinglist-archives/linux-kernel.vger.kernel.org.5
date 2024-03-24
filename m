Return-Path: <linux-kernel+bounces-115796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DC8894B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B7D1C2F461
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F61703DF;
	Mon, 25 Mar 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddTHGMDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C092145B3B;
	Sun, 24 Mar 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322047; cv=none; b=aPSrTh8Sehz8Glfz8O1eolQO65EWHBSaFrSbfD6V/P/nxkKLbjBpFwLa3EX+LiZMUBncjATgGESok1m/2znmHqbjTbfpwIh5YjwCknQmGKrmztmpJEKJkF4H1J4y3OLhUA2UjhiIAy2rmOy33vFnMxlZVe6Pjs1XGN4i2bXrKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322047; c=relaxed/simple;
	bh=9Jwo5MuWcAgGBmzbxKCppdwX4vW5rbfFnUdR44EgPL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nu6UxVL7SOqKO+05aiPtjdRR4DM1HcQISFQznC5Wkn5DSnOT3Puf4JLp0tGLjaYuwgfy0N0UTbelJdBZXuJIF6wSHjNX3Lprdk0f5fwJWO1BW8g98TFcnbjkeAPc18qadhx2VaUkD4B0GWLx0WrPM91WgucGfv73rqlFAAzAQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddTHGMDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7DBC433F1;
	Sun, 24 Mar 2024 23:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322046;
	bh=9Jwo5MuWcAgGBmzbxKCppdwX4vW5rbfFnUdR44EgPL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddTHGMDek7fUzHxvFm/xE9Y4SgJ1eMeJRRaI8Mu/gBLDISBrztYDoVvhiCFHQSmIG
	 HxPUzWf0jS4gWp++v0W0jeKqYgTT3NxF7VXgRHYGheMDzH20fL4pvvH/OLJYFhBUSk
	 z+XfAHmUJeIbQMiOuFkevP+PiOUlZsoVNbvZaiswJ1Z3oLTosfZ5IpVrofPjCj4491
	 y2ctdtEuuPIfHF0FMwhc9Ljnbhf7l4/8bfHmNjDThe6OtttODF6ltme34gDulMafFP
	 VFe2H+Ag9iAY0+n40s5vblLJK5EqgyLbM4dFmxkGv29u6W4IwZRvOrnvCEEAozO6QX
	 YR/S1Cpl6KOwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/451] gpio: vf610: allow disabling the vf610 driver
Date: Sun, 24 Mar 2024 19:06:35 -0400
Message-ID: <20240324231207.1351418-120-sashal@kernel.org>
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

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit f57595788244a838deec2d3be375291327cbc035 ]

The vf610 gpio driver is enabled by default for all i.MX machines,
without any option to disable it in a board-specific config file.

Most i.MX chipsets have no hardware for this driver. Change the default
to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

Add a text description after the bool type, this makes the driver
selectable by make config etc.

Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3e8e5f4ffa59f..700f71c954956 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -679,7 +679,8 @@ config GPIO_UNIPHIER
 	  Say yes here to support UniPhier GPIOs.
 
 config GPIO_VF610
-	def_bool y
+	bool "VF610 GPIO support"
+	default y if SOC_VF610
 	depends on ARCH_MXC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.43.0


