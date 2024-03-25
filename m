Return-Path: <linux-kernel+bounces-117269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AF88A970
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232621F2D54F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9C12E1C1;
	Mon, 25 Mar 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fvs2yDWa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBE155756;
	Mon, 25 Mar 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377421; cv=none; b=sjV+mPtlYmJ0cSPZ0KmPTcFxE95Xa3bUlz2ccoOsq8UFm4czQShu3Ilzx7jkOZ+xyZOQMV8AFpXxVYmjMqqKj1AYIc+bSU6egR/VL+CnQaIS3qFjzRL5PLCfjgh2gfiX4d7vpWHfrjBK/kqjLxgWDG5g/A1n1XZKmT0piPp494Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377421; c=relaxed/simple;
	bh=4aIDgEXJp9CJ/1kTSz+yIr/23FqqJgqh4VDseMLsP8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0txUEZuhA4AFqxuWlKaRJM/1pP4hOqfYYA5p84dxBYDov2PIqVsI7ooE7w6eJf8XAKmEeLQRx30wyZbiCw8y1Jz8MeLN1D7IJMDDx8/Ko4j+491Z3PnPhYkQUtfSn7OA6mdiBKUKPUzdMIlJYy3uVIRnShlHTJi0cnNix9hAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fvs2yDWa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711377420; x=1742913420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4aIDgEXJp9CJ/1kTSz+yIr/23FqqJgqh4VDseMLsP8o=;
  b=Fvs2yDWa0rLiaWxENBoyNDIJ7OKge1DpKkUXVeJ0mRheuEXY9+OIvDei
   z7+l7V6bALLzcqW6GGPoU5NqnfJsqTofNJ7QOYkoxj9aZs+k+PbnCM2PE
   83tSNaeSv2ZUdvYH30dM+PvBL3m7pEIq6Bz5fQK6fekQBAbPE4uuDLIzH
   6Bg5mof6QL//fMRWNeVH7zTV3e9DLJxHwmnDg5JuKye+c4PxBKVFKz0vk
   3OCpRDTpvHzEFODDLS1qi+rqNwRb3z73f/bbsQxY3PETTqKKcClBg3TjC
   dZOB5h+kTF+A5oxcgI0lbSiv5HrrPax+JSGWc84WNudRCP/2NUkE4Kai4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6511058"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6511058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070504"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 07:36:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E42B0101; Mon, 25 Mar 2024 16:36:55 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Date: Mon, 25 Mar 2024 16:33:50 +0200
Message-ID: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: updated dependent driver as well (Mark)
 include/sound/soc-jack.h              |  2 --
 sound/soc/generic/simple-card-utils.c |  2 --
 sound/soc/soc-jack.c                  | 23 ++++-------------------
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/sound/soc-jack.h b/include/sound/soc-jack.h
index a0abb1ee5110..3a81d4b8ca8a 100644
--- a/include/sound/soc-jack.h
+++ b/include/sound/soc-jack.h
@@ -44,7 +44,6 @@ struct snd_soc_jack_zone {
 /**
  * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
  *
- * @gpio:         legacy gpio number
  * @idx:          gpio descriptor index within the function of the GPIO
  *                consumer device
  * @gpiod_dev:    GPIO consumer device
@@ -59,7 +58,6 @@ struct snd_soc_jack_zone {
  *		       ADC).
  */
 struct snd_soc_jack_gpio {
-	unsigned int gpio;
 	unsigned int idx;
 	struct device *gpiod_dev;
 	const char *name;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 81077d16d22f..b4876b4f259d 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -752,8 +752,6 @@ int simple_util_init_jack(struct snd_soc_card *card,
 	if (!prefix)
 		prefix = "";
 
-	sjack->gpio.gpio = -ENOENT;
-
 	if (is_hp) {
 		snprintf(prop, sizeof(prop), "%shp-det", prefix);
 		pin_name	= pin ? pin : "Headphones";
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index b2cc13b9c77b..63971396b708 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -8,7 +8,6 @@
 
 #include <sound/jack.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
@@ -345,21 +344,9 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 				goto undo;
 			}
 		} else {
-			/* legacy GPIO number */
-			if (!gpio_is_valid(gpios[i].gpio)) {
-				dev_err(jack->card->dev,
-					"ASoC: Invalid gpio %d\n",
-					gpios[i].gpio);
-				ret = -EINVAL;
-				goto undo;
-			}
-
-			ret = gpio_request_one(gpios[i].gpio, GPIOF_IN,
-					       gpios[i].name);
-			if (ret)
-				goto undo;
-
-			gpios[i].desc = gpio_to_desc(gpios[i].gpio);
+			dev_err(jack->card->dev, "ASoC: Invalid gpio at index %d\n", i);
+		        ret = -EINVAL;
+		        goto undo;
 		}
 got_gpio:
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
@@ -373,7 +360,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 					      gpios[i].name,
 					      &gpios[i]);
 		if (ret < 0)
-			goto err;
+			goto undo;
 
 		if (gpios[i].wake) {
 			ret = irq_set_irq_wake(gpiod_to_irq(gpios[i].desc), 1);
@@ -401,8 +388,6 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 	devres_add(jack->card->dev, tbl);
 	return 0;
 
-err:
-	gpio_free(gpios[i].gpio);
 undo:
 	jack_free_gpios(jack, i, gpios);
 	devres_free(tbl);
-- 
2.43.0.rc1.1.gbec44491f096


