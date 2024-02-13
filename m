Return-Path: <linux-kernel+bounces-63326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22B852DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A5128AA14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83F22625;
	Tue, 13 Feb 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFhoOky3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072D225CE;
	Tue, 13 Feb 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819374; cv=none; b=sCmnHzoDx10ulMkfks5dh64LhBNCcq4dWmnbnqb7T+QUOqyhRD1TnCGMGmqcrTMgI6aruFUqIH7jg5Edo63KaH0RAjOaJIBStRPhYVz8g2YC2DKt1EZiXNnHhgWe2NtKsqpegN0fsHw+I0WhxcLmFwyPkk0aR+JPECbjQd5l4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819374; c=relaxed/simple;
	bh=k33CtS/Oue9+/X++3MgidqCmxeXWtvkicfBhbDgKtr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LS+jzF6h63LYGfJXrJmM5Wx2VQta+9UmnOZd8sDj6Af7yGt5sygl03ef/6PyoqiIXmYOktP+cNmMaLSnvHNS2Rr2sjuFzkStAam8he13JLqIOWXhbF87nuPraHYF1JTfkhWkeLQtteFoFPBHCyNS5UI/XSpG8l+Ag+UI5Ih6vvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFhoOky3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59E7C433C7;
	Tue, 13 Feb 2024 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819374;
	bh=k33CtS/Oue9+/X++3MgidqCmxeXWtvkicfBhbDgKtr0=;
	h=From:To:Cc:Subject:Date:From;
	b=JFhoOky3BG+Mf/sBqIr/THaRi7qZBEf2N3cS/D7dfxEInAfgUeO3VOTTkpu/um3He
	 1BYQgAsg+/jBAWldEkFTV9+pDw95l3iQWTmLAsrR+N6fwvkxI127MC2KzO3izhNpet
	 G6UlIo/7n660MGaesxrt3dIwn6oqOBgy/tvFhId1bpcXGXerTLVBVRdcLgOl/iCEvu
	 DUDCXx6cSRK24oxj9nnODLo8y2TliNZSs2Oyqr7WSJvhhqw3YEY+yaSp/VAcf3C7l5
	 6iUvhF0tpDcPmdUR+N9/NccYuUFb7v9YiuuDanaLoTkpEPIZQrAlZr/OfTc/Nno+og
	 69y0hZ5pg1oGw==
From: Arnd Bergmann <arnd@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] nvmem: meson-efuse: fix function pointer type mismatch
Date: Tue, 13 Feb 2024 11:15:47 +0100
Message-Id: <20240213101607.460930-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   78 |                                        (void(*)(void *))clk_disable_unprepare,

Address this with a trivial helper function that adjusts the return code.

Fixes: 611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvmem/meson-efuse.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index b922df99f9bc..3b9e31d7d073 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -38,6 +38,11 @@ static const struct of_device_id meson_efuse_match[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_efuse_match);
 
+static void meson_efuse_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int meson_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -74,9 +79,7 @@ static int meson_efuse_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
+	ret = devm_add_action_or_reset(dev, meson_efuse_clk_disable, clk);
 	if (ret) {
 		dev_err(dev, "failed to add disable callback");
 		return ret;
-- 
2.39.2


