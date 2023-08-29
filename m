Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B257D78C67B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjH2Nx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbjH2Nw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:52:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFABD7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693317177; x=1724853177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uEpMob8MSDwWPb9K6z1p9AUsGzPr2SlnFbqr1ruzBBg=;
  b=Ak72eaGDmijmx9TtvFhnZUhtFs2q/SQOjA2YlfwZ2gZMePG74TmY3NZm
   wH/jXl9qTcoEcvUcc4ThpB8zTXAgcAKldv/KfHY1RzGNA7dzWWiLyCNS/
   PvDePOGUYBzMJXcQ62ndjmftOm7/wr4pQY5Y3YzqWefv0trI5XFn4BLDI
   27knGa30jDLtimA1zyB8cGmXsf5pCH5IjZ8qgTY6ZPr+9Jv++zpI5iVkl
   MYRV4lotUeN4SS1t9N717vxgHx0+kT4FNFjeiOmWFWfBdH85WqDcSG3bS
   BR1kgQtxqNKB4CIFnZtoEChgsej88GA/DCLyhkVtQcPOfl0k4V4yOJceo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379141115"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="379141115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985357063"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985357063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 06:52:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D871933B; Tue, 29 Aug 2023 16:52:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
Date:   Tue, 29 Aug 2023 16:52:52 +0300
Message-Id: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of reiterating the list, use list_for_each_entry_safe()
that allows to continue without starting over.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Takashi, if you have anybody or want yourself to spend some time,
I believe you can simplify a lot the parser in this file with
the help of lib/cmdline.c APIs.

 sound/core/control_led.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index a78eb48927c7..afc9ffc388e3 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -297,16 +297,13 @@ static void snd_ctl_led_clean(struct snd_card *card)
 {
 	unsigned int group;
 	struct snd_ctl_led *led;
-	struct snd_ctl_led_ctl *lctl;
+	struct snd_ctl_led_ctl *lctl, _lctl;
 
 	for (group = 0; group < MAX_LED; group++) {
 		led = &snd_ctl_leds[group];
-repeat:
-		list_for_each_entry(lctl, &led->controls, list)
-			if (!card || lctl->card == card) {
+		list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
+			if (!card || lctl->card == card)
 				snd_ctl_led_ctl_destroy(lctl);
-				goto repeat;
-			}
 	}
 }
 
@@ -314,7 +311,7 @@ static int snd_ctl_led_reset(int card_number, unsigned int group)
 {
 	struct snd_card *card;
 	struct snd_ctl_led *led;
-	struct snd_ctl_led_ctl *lctl;
+	struct snd_ctl_led_ctl *lctl, _lctl;
 	struct snd_kcontrol_volatile *vd;
 	bool change = false;
 
@@ -329,14 +326,12 @@ static int snd_ctl_led_reset(int card_number, unsigned int group)
 		return -ENXIO;
 	}
 	led = &snd_ctl_leds[group];
-repeat:
-	list_for_each_entry(lctl, &led->controls, list)
+	list_for_each_entry(lctl, _lctl, &led->controls, list)
 		if (lctl->card == card) {
 			vd = &lctl->kctl->vd[lctl->index_offset];
 			vd->access &= ~group_to_access(group);
 			snd_ctl_led_ctl_destroy(lctl);
 			change = true;
-			goto repeat;
 		}
 	mutex_unlock(&snd_ctl_led_mutex);
 	if (change)
-- 
2.40.0.1.gaa8946217a0b

