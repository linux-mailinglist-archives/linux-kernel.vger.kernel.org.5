Return-Path: <linux-kernel+bounces-153615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C178AD067
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761C01C21D30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889115252F;
	Mon, 22 Apr 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMotJ4d7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1A13E8B2;
	Mon, 22 Apr 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798922; cv=none; b=CnbpmaWzPmakHBCHp7OFNaaYnueoFNFt5kV0nHSP0Es/ZqyhM8GsRg/qkx9gIkOFDX+f80dgExEZXC54ghCe+9hnXYzrsUke780hNzA+b4rhyR1j2yRMAW9oCw5sOgaiyoBXoRKgXqVuaZVYSy2p6pSuih1hLygWCq+sUK0D8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798922; c=relaxed/simple;
	bh=QvCJ68qrNmktK+1RElI+xrQxhN3qOPjuTTX6hAZbtIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGYrST4q2QqMbt7rJKaz4fNiC+LBx9QYl+n3bPE0ZN268USuS40Mt4/kVqU8FMU3JpY1HT8Lz+8iQLdv8fHLB4VFePdcE+XQcjeGysvSesMN5iWjTvF058CBFg9kdLmCsmH63GotHK/2Qrr/zEOAqkqBy0H8kC9qBiscz2gHG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMotJ4d7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713798921; x=1745334921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QvCJ68qrNmktK+1RElI+xrQxhN3qOPjuTTX6hAZbtIc=;
  b=XMotJ4d7OQwcQptNwhmsU2NmhsVrQd/47hcp6rISL8sWFbrE5KE2NV9k
   8yxHvpZe58DpEgyQCEmfj+VjwA/Snq2uOcawBc7g1GIlBwwm2MVrWaI1s
   JuuR333xVzeKmJmngMzrtNGIdwFWboGGZOeq3s5n1LRjbrgP1GCAPBylc
   8JkTHpwhAZnpA28J5mKdgUl0zc0wu+jRFMDlPJITBakCwYD2alrvie5D/
   kOly4w6Q6hRSUcXXc6w4R+AOIOkKX67iHgR4P7RE/qOhPglH+hffqIUwm
   sJga83un30hUmhO18DRpLI2LJ7ytblfEPdK9MdZh8ETU2s8UrAIfv6oa9
   Q==;
X-CSE-ConnectionGUID: l2dC6HRuTPCEizZdXeP4gQ==
X-CSE-MsgGUID: z5DZh7k4RDKXMrdoH7W1FA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13178098"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13178098"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 08:15:20 -0700
X-CSE-ConnectionGUID: jLkbddDbQwinK0r2Q6A8kA==
X-CSE-MsgGUID: o6MKjEI3QuKxDklZzuuzJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23926265"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 22 Apr 2024 08:15:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E24ACFD; Mon, 22 Apr 2024 18:15:15 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: soc.h: Don't use "proxy" headers
Date: Mon, 22 Apr 2024 18:15:13 +0300
Message-ID: <20240422151513.2052167-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/soc.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0376f7e4c15d..2a1b6c198547 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -11,20 +11,30 @@
 #define __LINUX_SND_SOC_H
 
 #include <linux/args.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/notifier.h>
-#include <linux/workqueue.h>
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/regmap.h>
+#include <linux/lockdep.h>
 #include <linux/log2.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <sound/ac97_codec.h>
 #include <sound/compress_driver.h>
 #include <sound/control.h>
-#include <sound/ac97_codec.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+struct module;
+struct platform_device;
+
+/* For the current users of sound/soc.h to avoid build issues */
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 /*
  * Convenience kcontrol builders
@@ -412,7 +422,6 @@
 #define SOC_ENUM_SINGLE_VIRT_DECL(name, xtexts) \
 	const struct soc_enum name = SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(xtexts), xtexts)
 
-struct device_node;
 struct snd_jack;
 struct snd_soc_card;
 struct snd_soc_pcm_stream;
@@ -427,6 +436,7 @@ struct soc_enum;
 struct snd_soc_jack;
 struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
+
 #include <sound/soc-dapm.h>
 #include <sound/soc-dpcm.h>
 #include <sound/soc-topology.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


