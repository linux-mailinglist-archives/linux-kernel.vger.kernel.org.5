Return-Path: <linux-kernel+bounces-174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB1813D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47261F22574
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4967208;
	Thu, 14 Dec 2023 22:10:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC6671F0;
	Thu, 14 Dec 2023 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b687c3.dsl.pool.telekom.hu [::ffff:81.182.135.195])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070E5B.00000000657B7C0C.0012CBE8; Thu, 14 Dec 2023 23:04:59 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: check the validity of prm_no/cfg_no
Date: Thu, 14 Dec 2023 23:04:44 +0100
Message-ID: <523780155bfdca9bc0acd39efc79ed039454818d.1702591356.git.soyer@irl.hu>
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

Add additional checks for program/config numbers to avoid loading from
invalid addresses.

If prm_no/cfg_no is negative, skip uploading program/config.

The tas2781-hda driver caused a NULL pointer dereference after loading
module, and before first runtime_suspend.

the state was:
tas_priv->cur_conf = -1;
tas_priv->tasdevice[i].cur_conf = 0;
program = &(tas_fmw->programs[-1]);

BUG: kernel NULL pointer dereference, address: 0000000000000010
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? vprintk_emit+0x175/0x2b0
 ? exc_page_fault+0x7f/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? tasdevice_load_block_kernel+0x21/0x310 [snd_soc_tas2781_fmwlib]
 tasdevice_select_tuningprm_cfg+0x268/0x3a0 [snd_soc_tas2781_fmwlib]
 tasdevice_tuning_switch+0x69/0x710 [snd_soc_tas2781_fmwlib]
 tas2781_hda_playback_hook+0xd4/0x110 [snd_hda_scodec_tas2781_i2c]

Fixes: 915f5eadebd2 ("ASoC: tas2781: firmware lib")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/soc/codecs/tas2781-fmwlib.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index eb55abae0d7b..1dfac9b2fca2 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2219,11 +2219,11 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 		goto out;
 	}
 
-	conf = &(tas_fmw->configs[cfg_no]);
 	for (i = 0, prog_status = 0; i < tas_priv->ndev; i++) {
 		if (cfg_info[rca_conf_no]->active_dev & (1 << i)) {
-			if (tas_priv->tasdevice[i].cur_prog != prm_no
-				|| tas_priv->force_fwload_status) {
+			if (prm_no >= 0
+				&& (tas_priv->tasdevice[i].cur_prog != prm_no
+				|| tas_priv->force_fwload_status)) {
 				tas_priv->tasdevice[i].cur_conf = -1;
 				tas_priv->tasdevice[i].is_loading = true;
 				prog_status++;
@@ -2258,7 +2258,8 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 	}
 
 	for (i = 0, status = 0; i < tas_priv->ndev; i++) {
-		if (tas_priv->tasdevice[i].cur_conf != cfg_no
+		if (cfg_no >= 0
+			&& tas_priv->tasdevice[i].cur_conf != cfg_no
 			&& (cfg_info[rca_conf_no]->active_dev & (1 << i))
 			&& (tas_priv->tasdevice[i].is_loaderr == false)) {
 			status++;
@@ -2268,6 +2269,7 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 	}
 
 	if (status) {
+		conf = &(tas_fmw->configs[cfg_no]);
 		status = 0;
 		tasdevice_load_data(tas_priv, &(conf->dev_data));
 		for (i = 0; i < tas_priv->ndev; i++) {
@@ -2311,7 +2313,7 @@ int tasdevice_prmg_load(void *context, int prm_no)
 	}
 
 	for (i = 0, prog_status = 0; i < tas_priv->ndev; i++) {
-		if (tas_priv->tasdevice[i].cur_prog != prm_no) {
+		if (prm_no >= 0 && tas_priv->tasdevice[i].cur_prog != prm_no) {
 			tas_priv->tasdevice[i].cur_conf = -1;
 			tas_priv->tasdevice[i].is_loading = true;
 			prog_status++;
@@ -2356,7 +2358,7 @@ int tasdevice_prmg_calibdata_load(void *context, int prm_no)
 	}
 
 	for (i = 0, prog_status = 0; i < tas_priv->ndev; i++) {
-		if (tas_priv->tasdevice[i].cur_prog != prm_no) {
+		if (prm_no >= 0 && tas_priv->tasdevice[i].cur_prog != prm_no) {
 			tas_priv->tasdevice[i].cur_conf = -1;
 			tas_priv->tasdevice[i].is_loading = true;
 			prog_status++;

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0


