Return-Path: <linux-kernel+bounces-119597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366888CAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F5A1F659AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC01CF9B;
	Tue, 26 Mar 2024 17:31:29 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6D1C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474289; cv=none; b=ZKqHdSLbqv7a0BT7gtJ7SIm+aoM7PizsQeu+tECjtREzW/pGaXP6ZQUGqf1CVyFN1ceFbcnJrqrCiBRUTiZHRsP4l2KQ+fsqpz5mHBsg4tmjtg5s0as8gdasdkbMPayVo4NmutObEuFaqEECgjzMX0MJTriLWuxpLOa0uqpOkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474289; c=relaxed/simple;
	bh=bq4YNkziyQcZmvz2N637u5vOHPJJEnrP824rDyNrXGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l28p/Fvs/cswbIfSFqNNnFXWM8He9i2JXLl62aEc6KFkrd/ITZQ7OgbqJOe40I2QffviBsZdvxcdFUo2ty1zzlpHnfPm+4g2pIw/e3PDX1+J+tYF0Z+ktvHKbNgTMKKLjhMW5mwumH+X3KBqQ9SEm78Wg6aRU5r5eQFKNj09uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by baptiste.telenet-ops.be with bizsmtp
	id 3VXD2C00R0SSLxL01VXDi8; Tue, 26 Mar 2024 18:31:18 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAdO-0053lJ-Rf;
	Tue, 26 Mar 2024 18:31:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAdl-001ZMO-Kd;
	Tue, 26 Mar 2024 18:31:13 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: DRM_WERROR should depend on DRM
Date: Tue, 26 Mar 2024 18:31:11 +0100
Message-Id: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in asking the user about enforcing the DRM compiler
warning policy when configuring a kernel without DRM support.

Fixes: f89632a9e5fa6c47 ("drm: Add CONFIG_DRM_WERROR")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f2bcf5504aa77679..2e1b23ccf30423a9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -423,7 +423,7 @@ config DRM_PRIVACY_SCREEN
 
 config DRM_WERROR
 	bool "Compile the drm subsystem with warnings as errors"
-	depends on EXPERT
+	depends on DRM && EXPERT
 	default n
 	help
 	  A kernel build should not cause any compiler warnings, and this
-- 
2.34.1


