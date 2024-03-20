Return-Path: <linux-kernel+bounces-109373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9975B881833
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B24A2853CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2D85922;
	Wed, 20 Mar 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKqY+NAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDD69DF4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964831; cv=none; b=TxGFZZVN2h1yCzxT4hZEN7slauklEsRLv2sHBZyX4kr6EDFx/JGtm/CMvXqgEnE0+ctLS5u0gjdqdpN+23SWxapgmmLzN0J95cIV4rF0ywTqOJHiiZGcQmHhueE11VzOEmjcr1K+QfR7fFYWUkeu47S+zbXEc7PV8mNJhs0eHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964831; c=relaxed/simple;
	bh=FzH8MeD4QMwtOcQz+3Fn/tqz3VRjWcU/cmxW6r3l/8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j2KnGtI6E/ljBLRJXaiT4yfTzCFJIUN2Kt3eqJGOCWoKYzD6RE3IEsDSIF7rPAriUjhErkoslIZa0tSsAhqEvRbZiaEATMr/NjIlkO0B7Hh39ACeurUsg22NXgSN5WuJ7qX0UN5OxvXFf2sY93M7ImYnOmc1JNjHFKACnXrAY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKqY+NAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A06CC433C7;
	Wed, 20 Mar 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710964830;
	bh=FzH8MeD4QMwtOcQz+3Fn/tqz3VRjWcU/cmxW6r3l/8U=;
	h=From:Date:Subject:To:Cc:From;
	b=MKqY+NAi4c5+0MYcQedHDw+gPGfiB79uvkSyEamFcJHfjsRIe+QHPBkzz1crZh0Uj
	 +OsbIamgDm/xefaK1Yjvv5LYM/LQc5ZwcfVlgrVwcj9A1cJvy0Gx3SmWBUhF75/3Ey
	 +OrDIyBmHZnjB6mUlAQXenGzMAc3CMzyuM0xs4wAecgUiYNMe+hx6rmmE1UUp740+H
	 qNsfEicdgqwaWsCcPDElGEbUtpfB64zMndojX/tWw5TaBoNfepDLngPHehUY/JXdu+
	 JUp3y+yfWTIkH+x4UjtffYU/+rU+qcHRYOXhq6smV+SV4rX1XX+gcjVsqJeZzZrobr
	 EUCN7hNiCYPEw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Mar 2024 19:59:57 +0000
Subject: [PATCH] reset: gpio: Fix missing gpiolib dependency for GPIO reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-reset-gpiolib-deps-v1-1-eaf5d30fa647@kernel.org>
X-B4-Tracking: v=1; b=H4sIADxA+2UC/x3MQQqAIBBA0avIrBtQi6KuEi0qxxqIEiciEO+et
 HyL/xMIRSaBQSWI9LDwdRaYSsG6z+dGyK4YrLaNrq3GSEI3boGvgxd0FAR919q2N33nVw0lDJE
 8v/90nHL+AAtaBmBkAAAA
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FzH8MeD4QMwtOcQz+3Fn/tqz3VRjWcU/cmxW6r3l/8U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl+0Bc6AEWms0OtVOQf3YpsvG6yyxC7G/v2DVqEHbF
 U2GKGSuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZftAXAAKCRAk1otyXVSH0OItB/
 9MtefPV85vw2QkQtlHQyPJn8NeT+tIxsB11d8vPJ5R7LhHYGve3X44ifom1ZlbmbGUuek1dDBvJWRa
 f9XBtRLEM5JHiZ6HzjGoMI8lNrpD0GuxG+77b8lFpJyJuh3YcrF+TmiZ9QQtFDcubFteL+PCWk+8ri
 Ypx4oPCnRADxQA9Y1MQLivYekRE3r2LUdRlRUb9FyI58AeA3pnYnDJp9w0t2XtxqGTOSumdtZvRZgN
 nfQ0cx9hvdFvKi0oKwtU2l743GQeShA2iYV78O8TwP+nZSYJNv0aN5unfKSP+I5ftgs4bEnDdJcuOV
 LNRDVPFZThtgxg+S6l50gc7henO9L1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The GPIO reset controller uses gpiolib but there is no Kconfig
dependency reflecting this fact, add one.

With the addition of the controller to the arm64 defconfig this is
causing build breaks for arm64 virtconfig in -next:

aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_reset_gpio_lookup':
/build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined reference to `gpio_device_find_by_fwnode'

Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 85b27c42cf65..f426b4c39179 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -68,6 +68,7 @@ config RESET_BRCMSTB_RESCAL
 
 config RESET_GPIO
 	tristate "GPIO reset controller"
+	depends on GPIOLIB
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"

---
base-commit: 72fb52fb0ac44b6a1edd9bc390e44bce3acccd26
change-id: 20240320-reset-gpiolib-deps-f76269197fc0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


