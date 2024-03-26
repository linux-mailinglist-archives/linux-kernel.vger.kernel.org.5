Return-Path: <linux-kernel+bounces-119558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B445988CA70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61FD1C65A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DD1C2A8;
	Tue, 26 Mar 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfiEDf8U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DE2110B;
	Tue, 26 Mar 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473102; cv=none; b=pPrgetmpyOCyJbnQFziBNCID79IlzuH0EDcvc64YI5H9J4N4D97q+VR7buFVSOfV0r+bFdxI8ANG+2qTXCB5P0kMoe9hNSNbHnyc42qmFPMAnamnjJWvCAiC6snAsGiCy/SaRVDmHCDGm0FZcYX2jYZNaO1QiP1ZAeU72N49GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473102; c=relaxed/simple;
	bh=54+WKa1ydkrk+oiWK74oAKFRtaRxLI8Zl8NhBv6zJZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeZFco4O3nVRWUEkkfKI8r6xxghWItoJm3gR4VQ8jJ52XzHRJ53xAFoIU6LI5YLXRLJtvh50xzmJyJvjGREbj98m3aEY492BfEwMq1x4+Jbi68+toEPv7ndlIeIl3aqsXXQhDINTTmqariHSBLHSa1RjSgCYaKHvJbI0mARuMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfiEDf8U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711473100; x=1743009100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=54+WKa1ydkrk+oiWK74oAKFRtaRxLI8Zl8NhBv6zJZ4=;
  b=FfiEDf8UdnDLPXfdU2lHHsdpeS+AZoKL9R8WZC8vMtL9SJ66c+vgG+KZ
   +LFCrT43jF965Z0sYKQ8V1VKcKbt2xB4khYXnj9lG0s67tIWGmWatGcjf
   PsyIQin6dYIIUAF5hKchQS4/m+L6kiGUPCOb16C8R+ExEVE81DtK3PZcb
   P0TtZhAdTCtkj5n/Nj6YDaCm/3Qa3sB/iX/RYy4vAk0IOMEFZ+Ob8TWDI
   n+cGs6gj12Z/mc4a+GpwTYMZZ/gwKktkasvzpjSdoTerKOIzkcQl6wmmA
   1uXYtQhuCh9eZyihuXgidDhIEuwS8RBUJNllpv80BH9Gk9eBXGMX9YpDE
   Q==;
X-CSE-ConnectionGUID: PHygj2LoQeyQEZHtXLWfBA==
X-CSE-MsgGUID: K0Sz7JLGQEqM+wpQdSGrGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6732184"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6732184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072885"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072885"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 10:11:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6BBDBE7; Tue, 26 Mar 2024 19:11:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Date: Tue, 26 Mar 2024 19:09:48 +0200
Message-ID: <20240326171134.1414462-1-andriy.shevchenko@linux.intel.com>
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
v3: resent after imx-es8328 got fixed (Mark)

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


