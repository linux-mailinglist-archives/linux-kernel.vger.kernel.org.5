Return-Path: <linux-kernel+bounces-115377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F50B889CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB9DB36176
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D641F30D2;
	Mon, 25 Mar 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACpBC8hQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75C83CD2;
	Sun, 24 Mar 2024 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320636; cv=none; b=LngyMbpz3Hulb8fAE1zMLVvCuuutPjQsv+6iWgnbXJMrQNuNQuAhB+GjmUcqcdPL1s0Hdukw73dSAnvRXaFyidW0RTkSGax1nAIBwldO7GQ8SR9A3NJpZ0Xkl7NjpXjTSvNZNyHnPrxs40lFYbU9lWjAdZ93tXw7xr1XRAJi1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320636; c=relaxed/simple;
	bh=aJJzQQrpiTfZBv6U5QGeic3fSx+uw2bw3ZShTZrhi5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4ZdIFK/y7R6TFL1VlX9TcAB3W74zNNfcMUTn9xrdTcqnLGwHOcddqHgNS+lfGGq9VTMm01QOajEsT8c3szkT2oQhp1YH7Ck6aJ+/VA4gs1+KA2q8EnEf5/z8flSmGZj/ZqhKRBu1sfZQUQgOhQi2vEvLsVK7vt9vWooJ2xukOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACpBC8hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B30EC433C7;
	Sun, 24 Mar 2024 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320635;
	bh=aJJzQQrpiTfZBv6U5QGeic3fSx+uw2bw3ZShTZrhi5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACpBC8hQK1A43BXKzl1VFun/TB1XTaozESFsLxB6EV49hRf8rKOiS3r/U/rL1GCWT
	 6XRCRbAC98PlYRNr7EpcHyT2QnNZnOkfVFRvRVcywe5V+XmuLmCDG7CG5RTozx0hpl
	 /UX+3XwlKDusfMQbunKKyN/m0GOwod0kKDavJu2ZS6bG4HJG8FC/R50D8LixVzQw+Y
	 BZ4rNOpMdMpe+XWGtcTkxZ9NSqoyzsVPqIAQP5VWeUrxoCao1ogM8LWGmsCtYKMNTJ
	 Urr8YIlyaB1St0zssd06YeksgMrLtw3FvSTT6W9mPckdcSBIH7qL9AvhI5RO8KrW5z
	 z6e49GTsJQPBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 197/713] gpio: vf610: allow disabling the vf610 driver
Date: Sun, 24 Mar 2024 18:38:43 -0400
Message-ID: <20240324224720.1345309-198-sashal@kernel.org>
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
index b3a133ed31ee5..41b51536bd867 100644
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


