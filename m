Return-Path: <linux-kernel+bounces-13296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D2820320
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC44B22239
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E723CF;
	Sat, 30 Dec 2023 00:10:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08B7F0;
	Sat, 30 Dec 2023 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b6838a.dsl.pool.telekom.hu [::ffff:81.182.131.138])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EF2.00000000658F5FD0.0014D4A7; Sat, 30 Dec 2023 01:09:51 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 2/4] ALSA: hda/tas2781: add configurable global i2c address
Date: Sat, 30 Dec 2023 01:09:43 +0100
Message-ID: <a252f1efeed5049f027f01e699c9e10e1e05bf9e.1703891777.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703891777.git.soyer@irl.hu>
References: <cover.1703891777.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Make the global i2c address configurable to support compatible amplifiers
with different global i2c address.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h         | 2 ++
 sound/pci/hda/tas2781_hda_i2c.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index e17ceab4fead..dde9f8120d4c 100644
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
index 0f8d5f947f54..49477d17b07c 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -81,7 +81,7 @@ static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 
 	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
 		if (tas_priv->ndev < TASDEVICE_MAX_CHANNELS &&
-			sb->slave_address != TAS2781_GLOBAL_ADDR) {
+			sb->slave_address != tas_priv->global_addr) {
 			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
 				(unsigned int)sb->slave_address;
 			tas_priv->ndev++;
@@ -699,6 +699,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		device_name = "TIAS2781";
 		tas_hda->priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->apply_calibration = tas2781_apply_calib;
+		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
 	} else
 		return -ENODEV;
 
-- 
2.43.0


