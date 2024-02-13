Return-Path: <linux-kernel+bounces-63320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E94852D94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B31F21B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518D1774A;
	Tue, 13 Feb 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5QajlV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29165224E6;
	Tue, 13 Feb 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819149; cv=none; b=OiWP7qugw2d8KzxwVRu929eDZeLjkCcHj6EX0sFxGnsvjtFd9PoeXiOEym/tZAfVLB+hFAURUwn9oEQOgCU5UIJ/h6IjUi4M5mlv42J5T68xmE8xmNc9K2kFEcyBZfoHcde99Hx1i/1F8/Sgl5jGyHYMLwHNX/4xNOZ2eOnQRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819149; c=relaxed/simple;
	bh=ywd10UsSv5X9PzwqZG/+YKBc+M0eD2jqf72bCCzxHWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQwKMPq4EAdWqB9OKeLnPzpzES1QDfI4NM9dFUDJ/MIsDT3Zar3B2Uuy+B5O2S56Ilo/NfqSHiAjUxqmoerBOb841izLudenoWFPhHEziiUhBQtSWKslrBzfbaUTKrK9LhlQJCSDbCDi2jKt7fcrvApgisShbOUInmIEtLE3QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5QajlV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8CCC433F1;
	Tue, 13 Feb 2024 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819148;
	bh=ywd10UsSv5X9PzwqZG/+YKBc+M0eD2jqf72bCCzxHWk=;
	h=From:To:Cc:Subject:Date:From;
	b=K5QajlV1GWq4RfRrLAujUEthGfd1J4/FV2WEAhnBYNNYS83VXXKZZVK9zlpZSWVP4
	 spDptzhPgge/ohUOgNZJCavEXt2CVrTDosHIWs6o2LgQfPp/Dfgd9fHRelSs0EMT7s
	 6EG+p3qHVJil9fOuZfFcQEMAGTw/cjPSFaoom6UKV+8L/i4JFgdEXzT3KXo+IRAJuW
	 c+2Fge13nZ26rX96sAbnQVXoYyGo3hsbktzqCf1NoeN15BOqRNA3GqhNnIHZQ87IjE
	 JKC9YYTujQWktn83sCyNQNvoaRDQr0xmrgrJTsUkKvjn+lgz24AOT5beYT4fVQQZbX
	 rkmuRxgmeY7Lw==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ASoC: meson: add helpers for clk_disable_unprepare
Date: Tue, 13 Feb 2024 11:11:38 +0100
Message-Id: <20240213101220.459641-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Casting between incompatible function types causes a warning with clang-16
because it breaks control flow integrity (KCFI) rules:

sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  243 |                                        (void(*)(void *))clk_disable_unprepare,
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
  406 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~
sound/soc/meson/t9015.c:274:4: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  274 |                         (void(*)(void *))clk_disable_unprepare,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
  406 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~

These two meson drivers cast clk_disable_unprepare() into a different type
in order to have it automatically called from the driver relase. Add
trivial helpers to do the same using correct types.

Fixes: 33901f5b9b16 ("ASoC: meson: add t9015 internal DAC driver")
Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/meson/aiu.c   | 9 ++++++---
 sound/soc/meson/t9015.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 7109b81cc3d0..211f360df284 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -209,6 +209,11 @@ static const char * const aiu_spdif_ids[] = {
 	[MCLK]	= "spdif_mclk_sel"
 };
 
+static void aiu_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int aiu_clk_get(struct device *dev)
 {
 	struct aiu *aiu = dev_get_drvdata(dev);
@@ -239,9 +244,7 @@ static int aiu_clk_get(struct device *dev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       aiu->pclk);
+	ret = devm_add_action_or_reset(dev, aiu_clk_disable, aiu->pclk);
 	if (ret)
 		dev_err(dev, "failed to add reset action on pclk");
 
diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 9c6b4dac6893..e0f9a603a5e9 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -243,6 +243,11 @@ static const struct regmap_config t9015_regmap_config = {
 	.max_register		= POWER_CFG,
 };
 
+static void t9015_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int t9015_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -270,9 +275,7 @@ static int t9015_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			priv->pclk);
+	ret = devm_add_action_or_reset(dev, t9015_clk_disable, priv->pclk);
 	if (ret)
 		return ret;
 
-- 
2.39.2


