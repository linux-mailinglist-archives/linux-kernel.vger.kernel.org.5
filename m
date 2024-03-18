Return-Path: <linux-kernel+bounces-106625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B631487F11D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64E81C22064
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9157874;
	Mon, 18 Mar 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAh8ZuVY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616A57865;
	Mon, 18 Mar 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793569; cv=none; b=ZSZcQmhSqlUxRJWGHy2QRpAYYgxuhZvKM30Pn/EsfdyrxwNjngtfQFisBCJUTCzP+iShd/YjT+K8qI7EU4VMh20Qeq9doogI2euWBAzlpc6faaZpq3qeaUg97DvtRsHQoMZPFJsBpV00GWVVIXc77F8ydkLpUy5ZxmaUxFs0QF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793569; c=relaxed/simple;
	bh=CXkyF+mHJB3DnOKcJvPFeZxccZw9WhUMjIYiH2jNhnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvmDcUxOWzt/9FDqeZ9F1Q4QmDowkWORSbi6SXEtiKHKalgrwiUY/eWrwncYRFQNv8VeuBlCalcGoRXXfRgLd1T5h8BEdOLkLP1qCXZyWMwIleXZo8wE9AkYlP5J8pCX1d8aoCX8tEKI4Zr387+Ma9SpIcWAgq5bbUJtolvIllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAh8ZuVY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710793568; x=1742329568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CXkyF+mHJB3DnOKcJvPFeZxccZw9WhUMjIYiH2jNhnY=;
  b=aAh8ZuVYfpc4cqjH2fbnjYC9XuRlVOqQgpjYmBVlYr9gd3E0TQ2xmUyt
   m6yBncsRF6yzy37ddMwlEAFAhQDa0C3dbMABNaYOAhTraBMmue0gOQ1Q3
   +ewFsq9GMYLOgMLsCdTdJC1R2m9hcl0bEY3eM5XtrBQ/vFZenksf6gXXF
   X82KxlPELeLhlJ4FyUZrd9APmkfRC/InfCqrgoa80tL/5FHO+/nDL3xy8
   d6h8Zbu3q3828RnRrmYGzvO9AIRX+ywAxCQnkzxHT/56PYDwArE+uXs1t
   nDRShvVfWNj7Mcb9KHnBV+QpnNxWkIZozBQRZbrj2krvGqOpJYoQYtkgn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16356661"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16356661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="937060672"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="937060672"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2024 13:26:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3EBD4241; Mon, 18 Mar 2024 22:26:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Date: Mon, 18 Mar 2024 22:25:16 +0200
Message-ID: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
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
 include/sound/soc-jack.h |  2 --

If I am not mistaken, after
https://lore.kernel.org/r/20240318200804.181516-1-andriy.shevchenko@linux.intel.com
there is no more users. Hence the above is the only dependency.

 sound/soc/soc-jack.c     | 23 ++++-------------------
 2 files changed, 4 insertions(+), 21 deletions(-)

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


