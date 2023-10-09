Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D47BDA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbjJILyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbjJILyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:54:47 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8DAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:54:44 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: [PATCH v7 00/13] sound: Use -EPROBE_DEFER instead of i915 module loading.
Date:   Mon,  9 Oct 2023 13:54:24 +0200
Message-Id: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

Compared to previous version, I added the patch
"ASoC: SOF: Intel: Fix error handling in hda_init()"

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

Maarten Lankhorst (11):
  ASoC: SOF: core: Ensure sof_ops_free() is still called when probe
    never ran.
  ASoC: SOF: Intel: Fix error handling in hda_init()
  ALSA: hda: Intel: Fix error handling in azx_probe()
  ALSA: hda: i915: Allow override of gpu binding.
  ALSA: hda: i915: Add an allow_modprobe argument to snd_hdac_i915_init
  ALSA: hda: i915: Allow xe as match for i915_component_master_match
  ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
  ALSA: hda: Intel: Move snd_hdac_i915_init to before probe_work.
  ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
  ASoC: SOF: Intel: Move binding to display driver outside of deferred
    probe
  ALSA: hda: i915: Remove extra argument from snd_hdac_i915_init

Pierre-Louis Bossart (2):
  ASoC: SOF: core: Add probe_early and remove_late callbacks
  ASoC: SOF: Intel: hda: start splitting the probe

 sound/hda/hdac_i915.c                | 24 ++++++-----
 sound/pci/hda/hda_intel.c            | 60 ++++++++++++++--------------
 sound/soc/intel/avs/core.c           | 13 ++++--
 sound/soc/intel/skylake/skl.c        | 31 +++++---------
 sound/soc/sof/core.c                 | 17 +++++++-
 sound/soc/sof/intel/hda-common-ops.c |  2 +
 sound/soc/sof/intel/hda.c            | 46 +++++++++++++--------
 sound/soc/sof/intel/hda.h            |  2 +
 sound/soc/sof/ops.h                  | 16 ++++++++
 sound/soc/sof/sof-priv.h             |  2 +
 10 files changed, 129 insertions(+), 84 deletions(-)

-- 
2.39.2

