Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECF807CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441812AbjLGAE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjLGAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:04:42 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F17D53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:04:38 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716E7.0000000065710C14.001190BA; Thu, 07 Dec 2023 01:04:36 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 10/16] ASoC: tas2781: check negative indexes
Date:   Thu,  7 Dec 2023 01:04:26 +0100
Message-ID: <a9ccb1760c5b525036a33b9528b651b409e727c2.1701906455.git.soyer@irl.hu>
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

Negative indexes are not valid here.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/soc/codecs/tas2781-fmwlib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 20dc2df034e9..aa5f56f9ad33 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2198,21 +2198,21 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 		goto out;
 	}
 
-	if (cfg_no >= tas_fmw->nr_configurations) {
+	if (cfg_no < 0 || cfg_no >= tas_fmw->nr_configurations) {
 		dev_err(tas_priv->dev,
 			"%s: cfg(%d) is not in range of conf %u\n",
 			__func__, cfg_no, tas_fmw->nr_configurations);
 		goto out;
 	}
 
-	if (prm_no >= tas_fmw->nr_programs) {
+	if (prm_no < 0 || prm_no >= tas_fmw->nr_programs) {
 		dev_err(tas_priv->dev,
 			"%s: prm(%d) is not in range of Programs %u\n",
 			__func__, prm_no, tas_fmw->nr_programs);
 		goto out;
 	}
 
-	if (rca_conf_no >= rca->ncfgs || rca_conf_no < 0 ||
+	if (rca_conf_no < 0 || rca_conf_no >= rca->ncfgs ||
 		!cfg_info) {
 		dev_err(tas_priv->dev,
 			"conf_no:%d should be in range from 0 to %u\n",
@@ -2304,7 +2304,7 @@ int tasdevice_prmg_load(void *context, int prm_no)
 		goto out;
 	}
 
-	if (prm_no >= tas_fmw->nr_programs) {
+	if (prm_no < 0 || prm_no >= tas_fmw->nr_programs) {
 		dev_err(tas_priv->dev,
 			"%s: prm(%d) is not in range of Programs %u\n",
 			__func__, prm_no, tas_fmw->nr_programs);
@@ -2349,7 +2349,7 @@ int tasdevice_prmg_calibdata_load(void *context, int prm_no)
 		goto out;
 	}
 
-	if (prm_no >= tas_fmw->nr_programs) {
+	if (prm_no < 0 || prm_no >= tas_fmw->nr_programs) {
 		dev_err(tas_priv->dev,
 			"%s: prm(%d) is not in range of Programs %u\n",
 			__func__, prm_no, tas_fmw->nr_programs);
-- 
2.43.0

