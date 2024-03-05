Return-Path: <linux-kernel+bounces-92656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B088723BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E92285B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E1128370;
	Tue,  5 Mar 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFBQG1Q2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FB85942;
	Tue,  5 Mar 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654852; cv=none; b=jezBI6Hl2ujYck/EvQhlRB6tOm2BhMA7N0YtPBhwLiQdwjz0tT2SyLhRhW1ZLtrBq2P1RU6H41UKfnqr2Nsnm62wjnOh4tYmCJIfdRofY4j00A6D/+Gjbak+CEpY92viDue7Qz0isGSxtUIDP4l9buuv4HfdzLaupprBvsTM1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654852; c=relaxed/simple;
	bh=9u4MuvGx1V+56K9txq9pYyx3UFHJtGTgw8yFnAwt+r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWcseNo7BrKVaW3JqBYac4Lv3SIJn2m5SzHNVrLqDeELYKIPd9voKUnLvxLjJR5Ms3QgeRgwulWdugGpYQ4ITuHiW4nMBM6DGEMAxbLNuc0jprvugsAzd84B4LKX9E96rtJDz5D+NxaMN2daNTVg9F2fSkGi97Y4CwEVj9wKvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFBQG1Q2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709654851; x=1741190851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9u4MuvGx1V+56K9txq9pYyx3UFHJtGTgw8yFnAwt+r8=;
  b=lFBQG1Q21ZED1VFVc72PAxrnxXpuzfw2T4KkTqA2hdM2/jjaSbL64JSv
   1jtIaZwoPrT/5Bpbxo0jbcNy+4LxDSOHy9+EqsLD8Z5hIJ5sDvKEyurj8
   O19MH3OizI2BEXxha+KIj2MIeO1yoQC2AwhSr3I97m27k3hX/f1Z5JKTM
   rgcGPK6rVBpDoBseqkVWHQehb7EeMRyjtAdhiDizDM6i3GKrTeFbpTK41
   lHseJgPahYkcodvR8G8MGEsAzYupsFYTqGN1memjzgbYSBvFSmJUqxuMT
   TFPS/HFKV9q9G11vzEF9KsowGrs1XF23nWJb/Br5SlHg9SfM180YIDCgm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14870237"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14870237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042660"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:07:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E3D3B1A6; Tue,  5 Mar 2024 18:07:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: Intel: atom: sst_ipc: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:07:22 +0200
Message-ID: <20240305160723.1363534-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-mid.h is providing some core parts of the South Complex PM,
which are usually are not used by individual drivers. In particular,
this driver doesn't use it, so simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 3fc2c9a6c44d..0630e58b9d6b 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -19,8 +19,9 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/compress_driver.h>
-#include <asm/intel-mid.h>
+
 #include <asm/platform_sst_audio.h>
+
 #include "../sst-mfld-platform.h"
 #include "sst.h"
 
-- 
2.43.0.rc1.1.gbec44491f096


