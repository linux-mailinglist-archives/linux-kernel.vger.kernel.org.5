Return-Path: <linux-kernel+bounces-117512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EB88AC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4810E1C3F241
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F994A0A;
	Mon, 25 Mar 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUPzqbbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A715B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385539; cv=none; b=FTFffJpP6k+ep2uU86Msh+A0SIVZK4aU83x/DEWI0Lxo/eOWQnohXrZJZ+2Npzuke2RvHLhMxKJ2XGMjzMl6s8MojWHFMGJ6TcNlUXF+lJ4MLeDdx8OeNblT3h+LYzBkJnvrdS0F1KXusrkXd9YzKPtHdp2aIkETnMxajr/PIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385539; c=relaxed/simple;
	bh=exWw2+9um48RdgDdrhFVuOynl/Wnh2SvOhm4Vm4qymY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NWUeXzbFM56ffCZKXRDZJElMONQFQw0/DVt/Alut5fWBv6gmzZ87Cjn7AgtfcpWkm3xM+tvLKfW8oWynaYV9eVMLWj4obhQ7QWMNIxEH1HkdTma9O5sO5vvykBeJDLNIi6d+FHrZ/e17hRIaj4e4KA/5Xv8Vw5JeGxgklwpKHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUPzqbbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCADBC433F1;
	Mon, 25 Mar 2024 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385538;
	bh=exWw2+9um48RdgDdrhFVuOynl/Wnh2SvOhm4Vm4qymY=;
	h=From:Date:Subject:To:Cc:From;
	b=ZUPzqbbNGzegLEoTns0RugV3fBWcRLi+K7V6nDcEepxrEqt6uSo1nE1OrxI9VzvEC
	 COqJ6qmpKCJJFiqDL3Y4nH3mrmXvuc/JJPVqsNZS6syCklIgS+ojQ97HNnEVS3xAwh
	 RzeLQyEIZZGc1k4lrVhulHEd7A7ANrALp2QZpWlxBukl1jYqCTBsRerhYlcXFn+G9J
	 By23TpW74cpNIs4WKb2uJEfzUvEVdl6OFbNovf244XOF/ANnh6m8JTy78jy797lGTJ
	 U0UVlV2qnOiCWX/1ForP08wnuUUYXiMUfu3pdbfe42BQbyWaq6aX0MVu6FwVItEkeO
	 /LFd1gccvHMAw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 16:51:03 +0000
Subject: [PATCH v2] reset: gpio: Fix missing gpiolib dependency for GPIO
 reset controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-reset-gpiolib-deps-v2-1-3ed2517f5f53@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHerAWYC/32NQQqDMBBFryKz7pQkWsWuvEdxYXUSh4oJEwkt4
 t2beoAu34P//g6RhCnCvdhBKHFkv2YwlwLGeVgdIU+ZwShTqdIoFIq0oQvsF37iRCGibWpTt7p
 t7KggD4OQ5fcZffSZZ46bl8/5kfTP/s0ljRppsLepVHaoq6Z7kay0XL046I/j+AK1YF9wtQAAA
 A==
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=broonie@kernel.org;
 h=from:subject:message-id; bh=exWw2+9um48RdgDdrhFVuOynl/Wnh2SvOhm4Vm4qymY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAavAduJCjMsYlE3SOF80y6cAWE/8aAA75cbBI16C
 I2io8KiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGrwAAKCRAk1otyXVSH0I4FB/
 9t5Fc4kKD+nskDiozjiXgZf+Bt8OSRCSPgSJiOFR3WtNw171mpNJ2Wx26FA4euI4dxGJnztPu0uDyr
 a1RQrueT2rr3XnWZKeaFzORUiI7aWAXfwOoaaT3ox61eD+q67hh7jFXETp/f0HScEHX1GnL5dUu/36
 +8+Qe+phMpuQW7VzkuDC0fo/YuKoPwnaTizeLU2MNXKWcXOlD9vN+cYosVeurbWyEg0iDXY8ikW8ws
 Z3XT+j51jdpdRiOnNrZnvTQT7k4UFAy/ErroHLmoVT90cxCTZzFatiJNjjnEuSiMmW09gRO8FZppyV
 g2lFF5nk0zpH39iMc6d/DTTdgpq0PU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The GPIO reset controller uses gpiolib but there is no Kconfig
dependency reflecting this fact, add one.

With the addition of the controller to the arm64 defconfig this is
causing build breaks for arm64 virtconfig in -next:

aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_reset_gpio_lookup':
/build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined reference to `gpio_device_find_by_fwnode'

Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.9-rc1.
- Link to v1: https://lore.kernel.org/r/20240320-reset-gpiolib-deps-v1-1-eaf5d30fa647@kernel.org
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
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240320-reset-gpiolib-deps-f76269197fc0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


