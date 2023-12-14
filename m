Return-Path: <linux-kernel+bounces-250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F40813E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C608A1C21F04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D86C6F2;
	Thu, 14 Dec 2023 23:33:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD96C6C8;
	Thu, 14 Dec 2023 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b687c3.dsl.pool.telekom.hu [::ffff:81.182.135.195])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000710F7.00000000657B90D2.0012CE04; Fri, 15 Dec 2023 00:33:38 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: select program 0, conf 0 by default
Date: Fri, 15 Dec 2023 00:33:27 +0100
Message-ID: <038add0bdca1f979cc7abcce8f24cbcd3544084b.1702596646.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Currently, cur_prog/cur_conf remains at the default value (-1), while
program 0 has been loaded into the amplifiers.

In the playback hook, tasdevice_tuning_switch tries to restore the
cur_prog/cur_conf. In the runtime_resume/system_resume,
tasdevice_prmg_load tries to load the cur_prog as well.

Set cur_prog and cur_conf to 0 if available in the firmware.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..e974510367e3 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -543,6 +543,10 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 	tasdevice_prmg_load(tas_priv, 0);
+	if (tas_priv->fmw->nr_programs > 0)
+		tas_priv->cur_prog = 0;
+	if (tas_priv->fmw->nr_configurations > 0)
+		tas_priv->cur_conf = 0;
 
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


