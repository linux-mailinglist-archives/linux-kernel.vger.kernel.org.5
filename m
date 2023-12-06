Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37F3807CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441886AbjLGAAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441806AbjLGAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:01 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF511F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:07 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716E1.0000000065710B05.00119062; Thu, 07 Dec 2023 01:00:05 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 08/16] ASoC: tas2781: add configurable global_addr
Date:   Thu,  7 Dec 2023 00:59:49 +0100
Message-ID: <80d655881e1ef744a680f617b2b1105c44b62bad.1701906455.git.soyer@irl.hu>
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

Add ability to handle global_addr of different
chip versions.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h         | 2 ++
 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 1d3c71d7e68d..5f364e4d8995 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -121,6 +121,8 @@ struct tasdevice_priv {
 	bool force_fwload_status;
 	bool playback_started;
 	bool isacpi;
+	unsigned int global_addr;
+
 	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_priv,
 		const struct firmware *fmw, int offset);
 	int (*fw_parse_program_data)(struct tasdevice_priv *tas_priv,
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index c82ed2413fcb..7ebf5d7e4aac 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -72,7 +72,7 @@ static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 
 	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
 		if (tas_priv->ndev < TASDEVICE_MAX_CHANNELS &&
-			sb->slave_address != TAS2781_GLOBAL_ADDR) {
+			sb->slave_address != tas_priv->global_addr) {
 			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
 				(unsigned int)sb->slave_address;
 			tas_priv->ndev++;
-- 
2.43.0

