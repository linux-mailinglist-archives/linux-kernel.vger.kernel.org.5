Return-Path: <linux-kernel+bounces-168478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B968BB8FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FE6B210BE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E015C0;
	Sat,  4 May 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bDyqP1LK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E045A3D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783707; cv=none; b=sTlLo+YB1yh6CNWfKKeAcR0qwSFZOnPvbiW+7RqMIqoz1aeMGHvQAmHBkBeGBhecOCwuwB865bV3Y04wPD3RNltnAKOm9RtLsKEyZldJIO9vSWOtzWH23YEZ3QuJq1Zx+5Rv4xsB/u1nuVrXDKITORNBeO3+qmXmdh7N/PhGTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783707; c=relaxed/simple;
	bh=Xeq84x7+deG4MGSpV1ZaAGqd0aBLNe6JdPAMeW2diSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2V4V+2LLzycOW5aWVTrwabzRmVGWxH1PLVdnQiBkMb/TzUkDI6Fj/M0f4dQTEfECXmu1xJGG3dE31DNpIGtYbiuaaxFXntZ0gSNgDm7t3E94H4x/itZqsiu+NQ3Q4Xp7Q95ZECEiDVdpLjXbxwN4hFLuxyguf6ZXuLdwUjVoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bDyqP1LK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4440lEm6006859;
	Fri, 3 May 2024 19:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714783634;
	bh=PZECwmsiSKdaFLHYPMeTePxshIgNJPnCOw9ZMej35Tw=;
	h=From:To:CC:Subject:Date;
	b=bDyqP1LKqVzvEnaO5d2J7AiuMXWqjDqDtNPY0YGjia/It9WnaVGRFJbTCqVCmY3W9
	 x6SFZ70dC315oL6KSEfFQsU2AF2HBxk/Gu1Qyq5F5lDce+mB5emGiubkav+JNUDdH+
	 YRLPvNPaQKpjlZH6ZqC1vK8DuZIFM6UQbzcyxm7w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4440lEEa026856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 19:47:14 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 19:47:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 19:47:13 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4440l8pY076839;
	Fri, 3 May 2024 19:47:08 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <kevin-lu@ti.com>, <cameron.berkenpas@gmail.com>, <tiwai@suse.de>,
        <baojun.xu@ti.com>, <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: ASoc/tas2781: Fix an issue reported by robot kernel test
Date: Sat, 4 May 2024 08:47:03 +0800
Message-ID: <20240504004704.1738-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix an issue reported by robot kernel test and two harmless changes.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Changed the copyright year to 2024
 - tasdevice-fmw.c --> tas2781-fmwlib.c
 - | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202405021200.YHInjV43-lkp@intel.com/
---
 sound/soc/codecs/tas2781-fmwlib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 45760fe19523..a6be81adcb83 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// tasdevice-fmw.c -- TASDEVICE firmware support
+// tas2781-fmwlib.c -- TASDEVICE firmware support
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 
@@ -1878,7 +1878,7 @@ int tas2781_load_calibration(void *context, char *file_name,
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
 	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	struct tasdevice_fw *tas_fmw;
 	struct firmware fmw;
 	int offset = 0;
-- 
2.34.1


