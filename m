Return-Path: <linux-kernel+bounces-15385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E0822B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AD4285503
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807D18B1C;
	Wed,  3 Jan 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQOV+NMa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69B18AFA;
	Wed,  3 Jan 2024 10:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941E3C433C7;
	Wed,  3 Jan 2024 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277572;
	bh=B8LTWZaAeIbbuTZxZBAE3c2hb3WyYLM2mLYP5O3fdx8=;
	h=From:To:Cc:Subject:Date:From;
	b=tQOV+NMa5Ds7GmQ+XgOeCZs6na9Bdhl9C3je6Bs7yPrxzvv4ZV5TUxxowGlhJK8RT
	 t8KqMQJsjx4+SkkH96llUoB1cBIDcZItBB4hS4FrZPTzcDEcN4zFOQLTXS2e+TE8h9
	 zNCUnzpqtDMtri1Tw3fp02p5OoDhbJ2S8d5dbA6Gf36LXYMybaCcZFYdMpP24VECjE
	 HzPC0gbIW8FWuDn3CzkuMlRwxodvIqNw9aL57Gv+so14losMmhF21cx63o2vx48/Xo
	 zgN6fALvX6vg4jkGlbrSl1NQX9XSCnU4gSMci4hI5HtDUpgsNENm5/v7JkXZ+PG8Um
	 y244+T7nMQ2Zg==
From: Arnd Bergmann <arnd@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dorian Cruveiller <doriancruveiller@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: fix building without CONFIG_SPI
Date: Wed,  3 Jan 2024 11:25:59 +0100
Message-Id: <20240103102606.3742476-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_SPI is disabled, the driver produces unused-variable warning:

sound/pci/hda/cs35l41_hda_property.c: In function 'generic_dsd_config':
sound/pci/hda/cs35l41_hda_property.c:181:28: error: unused variable 'spi' [-Werror=unused-variable]
  181 |         struct spi_device *spi;
      |                            ^~~
sound/pci/hda/cs35l41_hda_property.c:180:27: error: unused variable 'cs_gpiod' [-Werror=unused-variable]
  180 |         struct gpio_desc *cs_gpiod;
      |                           ^~~~~~~~

Avoid these by turning the preprocessor contionals into equivalent C code,
which also helps readability.

Fixes: 916d051730ae ("ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 52820ca9c603..a51fb6b0f56d 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -215,7 +215,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	if (cs35l41->control_bus == SPI) {
 		cs35l41->index = id;
 
-#if IS_ENABLED(CONFIG_SPI)
 		/*
 		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
 		 * This is only supported for systems with 2 amps, since we cannot expand the
@@ -224,7 +223,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 		 * uses a native chip select), to ensure the second amp does not clash with the
 		 * first.
 		 */
-		if (cfg->cs_gpio_index >= 0) {
+		if (IS_ENABLED(CONFIG_SPI) && cfg->cs_gpio_index >= 0) {
 			spi = to_spi_device(cs35l41->dev);
 
 			if (cfg->num_amps != 2) {
@@ -255,7 +254,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 				spi_setup(spi);
 			}
 		}
-#endif
 	} else {
 		if (cfg->num_amps > 2)
 			/*
-- 
2.39.2


