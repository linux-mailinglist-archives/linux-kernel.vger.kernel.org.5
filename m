Return-Path: <linux-kernel+bounces-113021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EC8880D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6967B1C212C9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A3138483;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxxEU3J9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5B137C44;
	Sun, 24 Mar 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319832; cv=none; b=bKsacYD05vZcTFmd5M0i2z+eCj3ob/ioqTZl/7v0apaboRUhZVL76RJaxnoe4EeqCW/YENMMUGzHa5tTr/iBOcqGrHxYB8da79Nc6JnrAIfVoXQKHEpDamdzaSliKvPy8jEcFaN/Fol32fEsBFZZxrSY0VNggd41dBnQ+CEwCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319832; c=relaxed/simple;
	bh=UU3RW3VG76C1ppMjisYC2nlueT7fVuWvWnBOyvqAUqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvvP4QxXorLSQ+wy7F9F1a5gwSTauDc13ySVYpkABiI5QogLC9ISYVxwwi9fmMNYvlCeifHZN7MMm5UC157QdvOauOJgPB3WcMfUqej9K+v5Nn1gkV69isx/qXSZnp9Dgy3h0vHTLcn22YtdQYYUCgssuqizcmcQHn4PpAyil6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxxEU3J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F89C433F1;
	Sun, 24 Mar 2024 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319831;
	bh=UU3RW3VG76C1ppMjisYC2nlueT7fVuWvWnBOyvqAUqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxxEU3J9gBAmd6C75zq/WrVU/1ghR+LX/64A1rPcgNiAYI9xHIflarm7QW5K1EyoP
	 8oNzSX0N86+g791JS0xdAL4ca1eqslu4CbsQ4a1glUP2BuGQvOVDH5egg9cWfcnkV8
	 hMWzWcH/KSY818d5RA4Q1/L5R/I1a5/sdxsCnrlYl4Z+AJMUxZc7kd3THjz05Zvc0s
	 EYQLpWOSYx2e9INwt/ty31mnZlyrTYIAhMXhypryWoPk+YxoAKqmyiG8s4P10KfKAN
	 iAVn85nZamEgBgN+Skqu8nTD0YfbK4IgkbdUD9NaMmkNScQB8frd3OzCrW86MMbqHz
	 NRb4yMWHTDYHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 134/715] gpio: vf610: allow disabling the vf610 driver
Date: Sun, 24 Mar 2024 18:25:13 -0400
Message-ID: <20240324223455.1342824-135-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 1301cec94f128..353af1a4d0ace 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -711,7 +711,8 @@ config GPIO_UNIPHIER
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


