Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFEB79CF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjILLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjILLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:01:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D59F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516489; x=1726052489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QwVU5oOHgWjfPmqwrEV3ZqF19Xp1vFXf2zAbfRKHkrA=;
  b=PxOFMl6kkPoRw5+xcbWyDBUhlhFzb1h1fJX49oXkLN62/PjBj6IGrd3Y
   2NjGaaKS0dxoigfGZntOP+B5fBTI7ntwdfQiJ7U9H570PpW/VwsW2ZyWf
   eMXSu9TvMPe7tDkW+G9jGBB3zsCpT7GoEsScyMPjsOnaIxr9okp3Z0E1+
   B+SsA6P6XF8Cggp5VPkPP8mapwoNneY5CWnXN2euiYQQQ7RiWfuUfFvxY
   F1MuaW8gYLd1NkS4bqKtDmBR7cPemCNgRGm2skHkitHa41cFPd3zamOMH
   rYrmeSzPLfrvFhXP+6Mm5JjHjzrNelr4AIgMjl3Xk6OcdOQIlnA/5SZeV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381041274"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381041274"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833868062"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="833868062"
Received: from mkidd-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.251.217.72])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:01:10 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     tiwai@suse.com, perex@perex.cz, arnd@arndb.de
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: core: Use dev_name of card_dev as debugfs directory name
Date:   Tue, 12 Sep 2023 14:01:13 +0300
Message-ID: <20230912110113.3166-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use temporary string for the debugfs directory name as
we can use the device name of the card.

This change will also fixes the following compiler warning/error (W=1):

sound/core/init.c: In function ‘snd_card_init’:
sound/core/init.c:367:28: error: ‘%d’ directive writing between 1 and 10 bytes into a region of size 4 [-Werror=format-overflow=]
  367 |         sprintf(name, "card%d", idx);
      |                            ^~
sound/core/init.c:367:23: note: directive argument in the range [0, 2147483646]
  367 |         sprintf(name, "card%d", idx);
      |                       ^~~~~~~~
sound/core/init.c:367:9: note: ‘sprintf’ output between 6 and 15 bytes into a destination of size 8
  367 |         sprintf(name, "card%d", idx);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The idx is guarantied to be less than SNDRV_CARDS (max 256 or 8) by the
code in snd_card_init(), however the compiler does not see that.

The warnings got brought to light by a recent patch upstream:
commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index d61bde1225f2..22c0d217b860 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -278,9 +278,6 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 			 size_t extra_size)
 {
 	int err;
-#ifdef CONFIG_SND_DEBUG
-	char name[8];
-#endif
 
 	if (extra_size > 0)
 		card->private_data = (char *)card + sizeof(struct snd_card);
@@ -364,8 +361,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	}
 
 #ifdef CONFIG_SND_DEBUG
-	sprintf(name, "card%d", idx);
-	card->debugfs_root = debugfs_create_dir(name, sound_debugfs_root);
+	card->debugfs_root = debugfs_create_dir(dev_name(&card->card_dev),
+						sound_debugfs_root);
 #endif
 	return 0;
 
-- 
2.42.0

