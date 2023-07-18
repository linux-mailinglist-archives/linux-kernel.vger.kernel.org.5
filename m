Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1975774C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGRJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGRJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:01:29 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37910198
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:01:26 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/7] sound: Use -EPROBE_DEFER instead of i915 module loading.
Date:   Tue, 18 Jul 2023 10:45:15 +0200
Message-Id: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly loading i915 becomes a problem when upstreaming the new intel driver
for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
driver load of xe, and will fail completely before it loads.

-EPROBE_DEFER has to be returned before any device is created in probe(),
otherwise the removal of the device will cause EPROBE_DEFER to try again
in an infinite loop.

The conversion is done in gradual steps. First I add an argument to
snd_hdac_i915_init to allow for -EPROBE_DEFER so I can convert each driver
separately. Then I convert each driver to move snd_hdac_i915_init out of the
workqueue. Finally I drop the ability to choose modprobe behavior after the
last user is converted.

I suspect the avs and skylake drivers used snd_hdac_i915_init purely for the
modprobe, but I don't have the hardware to test if it can be safely removed.
It can still be done easily in a followup patch to simplify probing.

Maarten Lankhorst (7):
  ALSA: hda/i915: Add an allow_modprobe argument to snd_hdac_i915_init
  ALSA: hda/i915: Allow xe as match for i915_component_master_match
  ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
  ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
  ALSA: hda/intel: Move snd_hdac_i915_init to before probe_work.
  ASoC: SOF: Intel: Remove deferred probe for SOF
  ALSA: hda/i915: Remove extra argument from snd_hdac_i915_init

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org

 sound/hda/hdac_i915.c         | 15 +++------
 sound/pci/hda/hda_intel.c     | 58 +++++++++++++++++++----------------
 sound/soc/intel/avs/core.c    | 13 +++++---
 sound/soc/intel/skylake/skl.c | 31 ++++++-------------
 sound/soc/sof/Kconfig         | 19 ------------
 sound/soc/sof/core.c          | 38 ++---------------------
 sound/soc/sof/intel/Kconfig   |  1 -
 sound/soc/sof/intel/hda.c     | 32 +++++++++++--------
 sound/soc/sof/sof-pci-dev.c   |  3 +-
 sound/soc/sof/sof-priv.h      |  5 ---
 10 files changed, 75 insertions(+), 140 deletions(-)

-- 
2.39.2

