Return-Path: <linux-kernel+bounces-116462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4380889F25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE98A1C34991
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951115F3F0;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A1185F27;
	Mon, 25 Mar 2024 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338023; cv=none; b=rPxJOMs0swrdxtOBfJ6YmCo8Eif14NUT8je4waZ9DfaViMJQgB+aF3LPxVofx8ldyN1/FeRcwJmmR5vFzKULvdGRmwGQ76jQkBvz8s5WSlZ+mTePj+Hm3Rea82CLY6yTG7SxdZier5oDvL71hY17J4+9+hH6bsL0QmT5pILhvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338023; c=relaxed/simple;
	bh=cm6ZnN81c2x49XQx/b2mFqGyUdAzRwWF8NYiQkUhL2c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DgxNrLw6RcfuntButEW9Gfzx0aZqQDJbuEMz0j/dJmMhiyKGppcasHlkeD9tmiekx7SWtve8HttJHUsUkcXksv2lqy754Vhx+w8YjxFy5tFM26iSTSGdoqawlaRoGILdRCkfmo9psbRHc7ImYdppvKdwaw32AMILiVAhcv+h4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.154])
	by mail-app4 (Coremail) with SMTP id cS_KCgBXeb0C8gBmkGxFAQ--.46008S2;
	Mon, 25 Mar 2024 11:39:56 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] ALSA: sh: aica: reorder cleanup operations to avoid UAF bug
Date: Mon, 25 Mar 2024 11:39:46 +0800
Message-Id: <20240325033946.47052-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgBXeb0C8gBmkGxFAQ--.46008S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4UZw1kZFWxuFWDCrykXwb_yoW8Ar1fpF
	Z8WF93KFn7KFyvkFWUZrn2gryxGw1fta1Dtw45J3yjvFs3Xr1Fka45K3ySgFW3trZ5u39r
	tw45Xw1avr90va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMJAWX+3hkBYwBgsW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The dreamcastcard->timer could schedule the spu_dma_work and the
spu_dma_work could also arm the dreamcastcard->timer.

When the Yamaha AICA card is closing, the dreamcastcard->channel
will be deallocated. But it could still be dereferenced in the
worker thread. The reason is that del_timer() will return directly
regardless of whether the timer handler is running or not and the
worker could be rescheduled in the timer handler. As a result, the
UAF bug will happen. The racy situation is shown below:

      (Thread 1)                 |      (Thread 2)
snd_aicapcm_pcm_close()          |
 ...                             |  run_spu_dma() //worker
                                 |    mod_timer()
  flush_work()                   |
  del_timer()                    |  aica_period_elapsed() //timer
  kfree(dreamcastcard->channel)  |    schedule_work()
                                 |  run_spu_dma() //worker
  ...                            |    dreamcastcard->channel-> //USE

In order to mitigate this bug, use timer_shutdown_sync() to shutdown
the timer and then use flush_work() to cancel the worker.

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 sound/sh/aica.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 320ac792c7f..bc68a3903f2 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -354,8 +354,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+	timer_shutdown_sync(&dreamcastcard->timer);
 	flush_work(&(dreamcastcard->spu_dma_work));
-	del_timer(&dreamcastcard->timer);
 	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
-- 
2.17.1


