Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5F807CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441868AbjLGAAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjLGAAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:00 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422B19E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:07 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716F3.0000000065710B05.0011905D; Thu, 07 Dec 2023 01:00:05 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 07/16] ALSA: hda/tas2781: load_calibration just load
Date:   Thu,  7 Dec 2023 00:59:48 +0100
Message-ID: <ebf628b2742d0e1b1f824c4f0e9b8e4c0a2bc106.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the apply_calibration outside to make it clearer.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 2b5031e4dda3..c82ed2413fcb 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -470,7 +470,6 @@ static int load_calibration_efi_1(struct tasdevice_priv *tas_priv)
 		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
 			tm->tm_year, tm->tm_mon, tm->tm_mday,
 			tm->tm_hour, tm->tm_min, tm->tm_sec);
-		tas2781_apply_calib(tas_priv);
 	} else
 		tas_priv->cali_data.total_sz = 0;
 
@@ -548,6 +547,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	 * calibrated data inside algo.
 	 */
 	tasdevice_load_calibration(tas_priv);
+	tasdevice_apply_calibration(tas_priv);
 
 out:
 	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-- 
2.43.0

