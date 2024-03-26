Return-Path: <linux-kernel+bounces-118704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE888BE39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1147A302A21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F212B82;
	Tue, 26 Mar 2024 09:43:08 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDC57330;
	Tue, 26 Mar 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446188; cv=none; b=gC/LNlzT/8jTqFIER4irWEn9VygVi5FtNCaaNwil9U+N0pUM43RAVa836d8465PRvN1XzmCdp/XQjj4sHohCHHhVNaIh9yib0I24USYRGgEawCbLLWmMbGnGAsWmV9mRpeifIgUQeg/WMdxB0RVBQZof6lKz9K53Ssmm3O1WGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446188; c=relaxed/simple;
	bh=fnFbU4zyFpMX7N2P8SPsyX5StAHUauELU2tMEYZuxz0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gnAq/DeeCf0gaZ6KhRk0Y4/ziZ68Grkq+Qs9gEBlHuKZvQVI3GnxHW4guB8fsd0kK8ygq8tsJAhU2NOcMbKmZuDzCcD15lp3x2SzNlh/fGJWMkILVA22gHA3GC/ZXkidjp0w/Sm/yRN2DoGNhtWpotTYKnzqaBp/QAVNymRgklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.18.200])
	by mail-app2 (Coremail) with SMTP id by_KCgB35ZiOmAJmN9tuAQ--.5570S2;
	Tue, 26 Mar 2024 17:42:48 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs
Date: Tue, 26 Mar 2024 17:42:38 +0800
Message-Id: <20240326094238.95442-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgB35ZiOmAJmN9tuAQ--.5570S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DKF45Zr4fJF4kCFW3Wrg_yoW5uF4Upr
	W5Wryrtrn7tFWv9rWUZwna9rn7Gw1fta4Utw4UGw4vvan3ur1YkF1jyw4FvFWakrWkuw47
	ZF48Ary3CFyYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIMAWYBgRkQowA1s1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The dreamcastcard->timer could schedule the spu_dma_work and the
spu_dma_work could also arm the dreamcastcard->timer.

When the snd_pcm_substream is closing, the aica_channel will be
deallocated. But it could still be dereferenced in the worker
thread. The reason is that del_timer() will return directly
regardless of whether the timer handler is running or not and
the worker could be rescheduled in the timer handler. As a result,
the UAF bug will happen. The racy situation is shown below:

      (Thread 1)                 |      (Thread 2)
snd_aicapcm_pcm_close()          |
 ...                             |  run_spu_dma() //worker
                                 |    mod_timer()
  flush_work()                   |
  del_timer()                    |  aica_period_elapsed() //timer
  kfree(dreamcastcard->channel)  |    schedule_work()
                                 |  run_spu_dma() //worker
  ...                            |    dreamcastcard->channel-> //USE

In order to mitigate this bug and other possible corner cases,
call mod_timer() conditionally in run_spu_dma(), then implement
PCM sync_stop op to cancel both the timer and worker. The sync_stop
op will be called from PCM core appropriately when needed.

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - call mod_timer() conditionally and implement PCM sync_stop op.

 sound/sh/aica.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 320ac792c7f..3182c634464 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
 		dreamcastcard->clicks++;
 		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
 			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
-		mod_timer(&dreamcastcard->timer, jiffies + 1);
+		if (snd_pcm_running(dreamcastcard->substream))
+			mod_timer(&dreamcastcard->timer, jiffies + 1);
 	}
 }
 
@@ -290,6 +291,8 @@ static void aica_period_elapsed(struct timer_list *t)
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
+	if (!snd_pcm_running(substream))
+		return;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -350,12 +353,19 @@ static int snd_aicapcm_pcm_open(struct snd_pcm_substream
 	return 0;
 }
 
+static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+
+	del_timer_sync(&dreamcastcard->timer);
+	cancel_work_sync(&dreamcastcard->spu_dma_work);
+	return 0;
+}
+
 static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
-	flush_work(&(dreamcastcard->spu_dma_work));
-	del_timer(&dreamcastcard->timer);
 	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
@@ -401,6 +411,7 @@ static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
+	.sync_stop = snd_aicapcm_pcm_sync_stop,
 };
 
 /* TO DO: set up to handle more than one pcm instance */
-- 
2.17.1


