Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8A7BDA61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346400AbjJILzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjJILyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:54:50 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D9AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:54:48 -0700 (PDT)
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
Subject: [PATCH v7 04/13] ASoC: SOF: Intel: Fix error handling in hda_init()
Date:   Mon,  9 Oct 2023 13:54:28 +0200
Message-Id: <20231009115437.99976-5-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
References: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hda_codec_i915_init() errors are ignored in
hda_init() so it can never return -EPROBE_DEFER.

Fix this before we move the call to hda_init() from the
deferred probe to early probe.

While at it, also fix error handling when hda_dsp_ctrl_get_caps
fails.

Suggested-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 86a2571488bcc..2f189473323f3 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -848,13 +848,21 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* init i915 and HDMI codecs */
 	ret = hda_codec_i915_init(sdev);
-	if (ret < 0)
-		dev_warn(sdev->dev, "init of i915 and HDMI codec failed\n");
+	if (ret < 0 && ret != -ENODEV) {
+		dev_err_probe(sdev->dev, ret, "init of i915 and HDMI codec failed\n");
+		goto out;
+	}
 
 	/* get controller capabilities */
 	ret = hda_dsp_ctrl_get_caps(sdev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(sdev->dev, "error: get caps error\n");
+		hda_codec_i915_exit(sdev);
+	}
+
+out:
+	if (ret < 0)
+		iounmap(sof_to_bus(sdev)->remap_addr);
 
 	return ret;
 }
-- 
2.39.2

