Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7AD791029
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351025AbjIDCrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbjIDCrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:47:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888010A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693795652; x=1725331652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+K68lfgDJnncZhdPoXtkx8rsl+vybU3TKHpTw1jqewI=;
  b=kLBUccU65pY9rKRlZr79JRhLwbKO4teLiZUBZKYhEUUAmiVVwcVUksln
   GyZsnvSg63ghWLYDwZF2LUlHZI9yrVRdL8di9gnI1Ewes303NxekEfiK/
   EOI698AGrWt7JJU/XiFACVBPah58iv5xBt3p1xBJwcQoSXTSUWxzN0Ngw
   NNQjvXTghumF/+jSMbl+PYEKjXbUKup6qXVAlqGsaP3aC6mHrtkM99E14
   bAX6epo5HpqLuXl9vln7m7+UmKBxKcbMu5cxwzvpZP4ULXyM+6UReK8UC
   u17wZuAW9Y8PRZbg0eoNfygSyQyNmmK6zvFZChLF84TFQ1YuZAs116hCj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="407499748"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="407499748"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="810743609"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="810743609"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2023 19:47:29 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: rt5645: NULL pointer access when removing jack
Date:   Mon,  4 Sep 2023 18:40:46 +0800
Message-Id: <20230904104046.4150208-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine driver calls snd_soc_component_set_jack() function with NULL
jack and data parameters when removing jack in codec exit function.
Do not access data when jack is NULL.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/codecs/rt5645.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 5be5ec0260e9..2412b0853364 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3263,13 +3263,17 @@ static int rt5645_component_set_jack(struct snd_soc_component *component,
 {
 	struct snd_soc_jack *mic_jack = NULL;
 	struct snd_soc_jack *btn_jack = NULL;
-	int *type = (int *)data;
+	int type;
 
-	if (*type & SND_JACK_MICROPHONE)
-		mic_jack = hs_jack;
-	if (*type & (SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-		SND_JACK_BTN_2 | SND_JACK_BTN_3))
-		btn_jack = hs_jack;
+	if (hs_jack) {
+		type = *(int *)data;
+
+		if (type & SND_JACK_MICROPHONE)
+			mic_jack = hs_jack;
+		if (type & (SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			SND_JACK_BTN_2 | SND_JACK_BTN_3))
+			btn_jack = hs_jack;
+	}
 
 	return rt5645_set_jack_detect(component, hs_jack, mic_jack, btn_jack);
 }
-- 
2.34.1

