Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12980AB9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574565AbjLHSHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjLHSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:07:39 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472C51729;
        Fri,  8 Dec 2023 10:07:45 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000719EC.0000000065735B6F.0011CB93; Fri, 08 Dec 2023 19:07:43 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/tas2781: leave hda_component in usable state
Date:   Fri,  8 Dec 2023 19:06:49 +0100
Message-ID: <c3e903fedec7d84929664377307019e58dc22494.1702058704.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
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

Unloading then loading the module causes a NULL ponter dereference.

The hda_unbind zeroes the hda_component, later the hda_bind tries
to dereference the codec field.

The hda_component is only initialized once by tas2781_generic_fixup.

Set only previously modified fields to NULL.

BUG: kernel NULL pointer dereference, address: 0000000000000322
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? exc_page_fault+0x7f/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? tas2781_hda_bind+0x59/0x140 [snd_hda_scodec_tas2781_i2c]
 component_bind_all+0xf3/0x240
 try_to_bring_up_aggregate_device+0x1c3/0x270
 __component_add+0xbc/0x1a0
 tas2781_hda_i2c_probe+0x289/0x3a0 [snd_hda_scodec_tas2781_i2c]
 i2c_device_probe+0x136/0x2e0

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..7dfa8aeb5fcc 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -612,9 +612,13 @@ static void tas2781_hda_unbind(struct device *dev,
 {
 	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
+	comps = &comps[tas_priv->index];
 
-	if (comps[tas_priv->index].dev == dev)
-		memset(&comps[tas_priv->index], 0, sizeof(*comps));
+	if (comps->dev == dev) {
+		comps->dev = NULL;
+		strscpy(comps->name, "", sizeof(comps->name));
+		comps->playback_hook = NULL;
+	}
 
 	tasdevice_config_info_remove(tas_priv);
 	tasdevice_dsp_remove(tas_priv);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0

