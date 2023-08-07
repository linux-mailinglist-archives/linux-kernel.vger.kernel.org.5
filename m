Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F553771CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHGJBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHGJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:01:42 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5293319BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:01:28 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 4/9] ALSA: hda/i915: Allow xe as match for i915_component_master_match
Date:   Mon,  7 Aug 2023 11:00:40 +0200
Message-Id: <20230807090045.198993-5-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xe is a new driver for intel GPU's that shares the sound related code
with i915.

Don't allow it to be modprobed though; the module is not upstream yet
and we should exclusively use the EPROBE_DEFER mechanism.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/hdac_i915.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 961fcd3397f4..12c1f8d93499 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -115,7 +115,8 @@ static int i915_component_master_match(struct device *dev, int subcomponent,
 	hdac_pci = to_pci_dev(bus->dev);
 	i915_pci = to_pci_dev(dev);
 
-	if (!strcmp(dev->driver->name, "i915") &&
+	if ((!strcmp(dev->driver->name, "i915") ||
+		 !strcmp(dev->driver->name, "xe")) &&
 	    subcomponent == I915_COMPONENT_AUDIO &&
 	    connectivity_check(i915_pci, hdac_pci))
 		return 1;
-- 
2.39.2

