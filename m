Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF180BE46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjLJXhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLJXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:37:37 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F82EB;
        Sun, 10 Dec 2023 15:37:44 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006E46F.0000000065764BC4.0012065E; Mon, 11 Dec 2023 00:37:40 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: handle missing EFI calibration data
Date:   Mon, 11 Dec 2023 00:37:33 +0100
Message-ID: <f1f6583bda918f78556f67d522ca7b3b91cebbd5.1702251102.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code does not properly check whether the calibration variable is
available in the EFI. If it is not available, it causes a NULL pointer
dereference.

Check the return value of the first get_variable call also.

BUG: kernel NULL pointer dereference, address: 0000000000000000
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? srso_alias_return_thunk+0x5/0x7f
 ? schedule+0x5e/0xd0
 ? exc_page_fault+0x7f/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? crc32_body+0x2c/0x120
 ? tas2781_save_calibration+0xe4/0x220 [snd_hda_scodec_tas2781_i2c]
 tasdev_fw_ready+0x1af/0x280 [snd_hda_scodec_tas2781_i2c]
 request_firmware_work_func+0x59/0xa0

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..6e506efe61cd 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -455,9 +455,9 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
 		status = efi.get_variable(efi_name, &efi_guid, &attr,
 			&tas_priv->cali_data.total_sz,
 			tas_priv->cali_data.data);
-		if (status != EFI_SUCCESS)
-			return -EINVAL;
 	}
+	if (status != EFI_SUCCESS)
+		return -EINVAL;
 
 	tmp_val = (unsigned int *)tas_priv->cali_data.data;
 

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.43.0

