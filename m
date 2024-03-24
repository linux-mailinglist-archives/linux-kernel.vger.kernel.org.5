Return-Path: <linux-kernel+bounces-115628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2A889455
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C751C2E813
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E034C56E;
	Mon, 25 Mar 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+RAbYNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC513341E;
	Sun, 24 Mar 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321452; cv=none; b=q48KCmwIZMhw7t8fXl2yOKDj7NtWcumvrQJ8md1SP5uuzqJZsL1mrm7W5saV9d2ZvlZvtGdJW8ABz8SMUsZjgOy0eBqv4yO4nIUeuZpxEKOzO7R4pDhKkUo/vCysiwjSPS7OSHZ8W7MwpDaaiPZ1WMvFoh2QqHr0Aqyd4sbODQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321452; c=relaxed/simple;
	bh=daAUKUWKXLE8XmGMuJAl8BDTZCAjNe9klaEnuvYRuLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T14gvnCHDETZUrLYRddKGqxEA4QZTMEc54yKIox+U0gnIR63CEa60l0lAk8ReHMXPASOyn4XE6MQGA4A89aqphOkEYuvG6ZPQLewYPrJx3r9njPURQga4CmCqzb1gttSWyTK4hQhLloycMPWvkHhHaFxGU5fcg7SUVoYiVcGRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+RAbYNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F76C43390;
	Sun, 24 Mar 2024 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321451;
	bh=daAUKUWKXLE8XmGMuJAl8BDTZCAjNe9klaEnuvYRuLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+RAbYNEpV9KkBZizGGBMaGNt6qP66VvSR8oi7nrF922Cp56SUiZtb99nht3aQfVt
	 M8wdfHjs6eAKmRM82BScBFbtwcHlfl8Au6kWBQtyVIbkYiQJgMW7hC2wVEKm8/VjsT
	 38R19KvIOiysGXZDvgkc0rwev8FrCsOCUAuomjPTXumw5vvpLOTEh3sqJhGJItS/b0
	 yx4KSIy8UZzeUReVds5eh2+3A9gtsnkLmiWQYwDoLzVVDaNsqxtjNjsI3ElxGpSXGV
	 +VAOotb9zWZLxlTuhh41hXw54AZUBknWcaNL9bg1/9TiTSwz+QCKvqDAndrfjeXkkC
	 11smKLaWJp1PQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 176/638] gpio: vf610: allow disabling the vf610 driver
Date: Sun, 24 Mar 2024 18:53:33 -0400
Message-ID: <20240324230116.1348576-177-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 673bafb8be588..d56b835359d3b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -691,7 +691,8 @@ config GPIO_UNIPHIER
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


