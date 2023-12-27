Return-Path: <linux-kernel+bounces-11844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A875481EC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7891C20E03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9495225;
	Wed, 27 Dec 2023 06:05:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3D5220;
	Wed, 27 Dec 2023 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [115.200.231.230])
	by mail-app3 (Coremail) with SMTP id cC_KCgAHAhmCvotl__uKAQ--.53033S2;
	Wed, 27 Dec 2023 14:04:51 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
Date: Wed, 27 Dec 2023 14:03:20 +0800
Message-Id: <20231227060322.3556052-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgAHAhmCvotl__uKAQ--.53033S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8ZFyDZr1kWrWxJF4UXFb_yoW8CF4rpF
	WfW3yjkr48JrWFkanrJw1DWFn0kFn7tayrWrWrC34Iyr15Awn0vF9Y9rWv9FyYgr4rWw4x
	Kw1Fva45Cr1UtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU24E_UUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When snd_hdsp_load_firmware_from_cache and snd_hdsp_enable_io fails,
the hdsp->fw_uploaded needs to be free.Or there could be memleaks in
snd_hdsp_hwdep_ioctl.

Fixes: 90caaef6a1ce ("ALSA: hdsp: improve firmware caching")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: remove label 'err' which is unused.
---
 sound/pci/rme9652/hdsp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index e7d1b43471a2..b83b0c484f8e 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4874,21 +4874,20 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 
 		if (copy_from_user(hdsp->fw_uploaded, firmware_data,
 				   HDSP_FIRMWARE_SIZE)) {
-			vfree(hdsp->fw_uploaded);
-			hdsp->fw_uploaded = NULL;
-			return -EFAULT;
+			err = -EFAULT;
+			goto free_fw_uploaded;
 		}
 
 		hdsp->state |= HDSP_FirmwareCached;
 
 		err = snd_hdsp_load_firmware_from_cache(hdsp);
 		if (err < 0)
-			return err;
+			goto free_fw_uploaded;
 
 		if (!(hdsp->state & HDSP_InitializationComplete)) {
 			err = snd_hdsp_enable_io(hdsp);
 			if (err < 0)
-				return err;
+				goto free_fw_uploaded;
 
 			snd_hdsp_initialize_channels(hdsp);
 			snd_hdsp_initialize_midi_flush(hdsp);
@@ -4897,7 +4896,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 			if (err < 0) {
 				dev_err(hdsp->card->dev,
 					"error creating alsa devices\n");
-				return err;
+				goto free_fw_uploaded;
 			}
 		}
 		break;
@@ -4912,6 +4911,11 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		return -EINVAL;
 	}
 	return 0;
+
+free_fw_uploaded:
+	vfree(hdsp->fw_uploaded);
+	hdsp->fw_uploaded = NULL;
+	return err;
 }
 
 static const struct snd_pcm_ops snd_hdsp_playback_ops = {
-- 
2.34.1


