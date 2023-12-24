Return-Path: <linux-kernel+bounces-10658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01E81D852
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899342827C8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3615CF;
	Sun, 24 Dec 2023 08:26:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100317D4;
	Sun, 24 Dec 2023 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [122.235.137.177])
	by mail-app3 (Coremail) with SMTP id cC_KCgCHjBkT64dlc81jAQ--.7486S2;
	Sun, 24 Dec 2023 16:25:55 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
Date: Sun, 24 Dec 2023 16:25:31 +0800
Message-Id: <20231224082533.3540468-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgCHjBkT64dlc81jAQ--.7486S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8ZFyDZr1kWrWxJF4UXFb_yoW8Cr48pF
	WfG3yjkrW8JrWFkanrJw1DWrn0kFn7tay5WrWrC34Iyr1YywnYvF9Y9rWv9Fyagr1rWw4x
	Kw4Fva45Cr1UtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
	W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU38n5UUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When snd_hdsp_load_firmware_from_cache and snd_hdsp_enable_io fails,
the hdsp->fw_uploaded needs to be free.Or there could be memleaks in
snd_hdsp_hwdep_ioctl.

Fixes: 90caaef6a1ce ("ALSA: hdsp: improve firmware caching")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 sound/pci/rme9652/hdsp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index e7d1b43471a2..6f6add2f7c42 100644
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
+free_fw_uploaded:
+	vfree(hdsp->fw_uploaded);
+	hdsp->fw_uploaded = NULL;
+err:
+	return err;
 }
 
 static const struct snd_pcm_ops snd_hdsp_playback_ops = {
-- 
2.34.1


