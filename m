Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B17A709D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjITCgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjITCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:36:51 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F485AC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Xn2eh
        TsuIkEZgo9LmLAl1j0/Kv7Gg6aMVTk7Dj5HatM=; b=pO1ecoWpYqwyk8L+R8PUl
        TuDuls0HDGYhAyNdr+GZv8hh3qXdY2M0CTn1HxpTcNcQhOtFoquF6aObnMb2ipcQ
        78VZbBQktQEn9Kf26cVmZqVx8mmPEm0yS5t42NKEFLS6TfSvGjwR3mYH9vLayBrz
        vBBqk9aCgKdwrZ/of/0qYo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wAXRwV7Wgplju4nCg--.4366S4;
        Wed, 20 Sep 2023 10:35:49 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     perex@perex.cz, tiwai@suse.com, mhocko@suse.com,
        akpm@linux-foundation.org, make_ruc2021@163.com,
        mgorman@techsingularity.net, 42.hyeyoo@gmail.com,
        surenb@google.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: oss: Fix race at SNDCTL_DSP_SETTRIGGER There is a small race window at snd_pcm_oss_set_trigger() that is called from OSS PCM SNDCTL_DSP_SETTRIGGER ioctl; namely the function calls snd_pcm_oss_make_ready() at first, then takes the params_lock mutex for the rest.  When the stream is set up again by another thread between them, it leads to inconsistency, and may result in unexpected results such as NULL dereference of OSS buffer as a fuzzer spotted recently.
Date:   Wed, 20 Sep 2023 10:35:36 +0800
Message-Id: <20230920023536.3535439-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXRwV7Wgplju4nCg--.4366S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1rZw4kAF4DXFyxWry3Jwb_yoW8WF17pr
        s7W34rtrW7JFyvv3WkJw1aqrn8Xr95ta4Ykw48C34Fkw4Fgr4FvFykKF1FqFZYkFWDuan0
        qr4DA34UAr13AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zifb15UUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiVx3wC1etsZbuBgAAsE
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix is simply to cover snd_pcm_oss_make_ready() call into the same
params_lock mutex with snd_pcm_oss_make_ready_locked() variant.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 sound/core/oss/pcm_oss.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 728c211142d1..9a830aeeba63 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2083,21 +2083,14 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	csubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
 
-	if (psubstream) {
-		err = snd_pcm_oss_make_ready(psubstream);
-		if (err < 0)
-			return err;
-	}
-	if (csubstream) {
-		err = snd_pcm_oss_make_ready(csubstream);
-		if (err < 0)
-			return err;
-	}
       	if (psubstream) {
       		runtime = psubstream->runtime;
 		cmd = 0;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		err = snd_pcm_oss_make_ready_locked(psubstream);
+		if (err < 0)
+			goto _skip1;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -2128,6 +2121,9 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 		cmd = 0;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		err = snd_pcm_oss_make_ready_locked(csubstream);
+		if (err < 0)
+			goto _skip2;
 		if (trigger & PCM_ENABLE_INPUT) {
 			if (runtime->oss.trigger)
 				goto _skip2;
-- 
2.37.2

