Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4377D2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjHOTD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbjHOTCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC41BF0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 304B5219AD;
        Tue, 15 Aug 2023 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiqXzAgJEKHlp1AZFo+uKtC6D/wVCSD9GdB9VXlnpF4=;
        b=Pd5UtkVHp+fHJxaC9wG7YZ3G5hosm7/XkLmE842clgRYk7qf6iImCSoaGQkViJF9yjn9lw
        1nArvvU/wv8UNYx0Gcr0jTSyNUOPkL/KPAmd/bZdKjAbhbXtubyUhPtHAxs3YHg8XLoMtI
        KX8E/IJWbElYHCZbY4rahgM1x9fnQFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiqXzAgJEKHlp1AZFo+uKtC6D/wVCSD9GdB9VXlnpF4=;
        b=GqB4FIqK68pJtv2CVcjLVMwKVWcW9mNIGoZzTnZWFsz6VXxq+pLEvDj90afoIgtpPJLvsw
        t+MJsynamhcKLwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02CB81353E;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8IhLO57L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 24/25] ASoC: pcm: Drop obsoleted PCM copy_user ops
Date:   Tue, 15 Aug 2023 21:01:35 +0200
Message-Id: <20230815190136.8987-25-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now all ASoC users have been replaced to use the new PCM copy ops,
let's drop the obsoleted copy_user ops and its helper function.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc-component.h |  7 -------
 sound/soc/soc-component.c     | 20 --------------------
 sound/soc/soc-pcm.c           |  2 --
 3 files changed, 29 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 8040f001f2fb..17bea3144551 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -137,10 +137,6 @@ struct snd_soc_component_driver {
 		struct timespec64 *audio_ts,
 		struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 		struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
-	int (*copy_user)(struct snd_soc_component *component,
-			 struct snd_pcm_substream *substream, int channel,
-			 unsigned long pos, void __user *buf,
-			 unsigned long bytes);
 	int (*copy)(struct snd_soc_component *component,
 		    struct snd_pcm_substream *substream, int channel,
 		    unsigned long pos, struct iov_iter *buf,
@@ -513,9 +509,6 @@ int snd_soc_pcm_component_pointer(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
 				unsigned int cmd, void *arg);
 int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream);
-int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
-				    int channel, unsigned long pos,
-				    void __user *buf, unsigned long bytes);
 int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
 			       struct iov_iter *buf, unsigned long bytes);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index ffa2dd8a21ba..f18406dfa1e4 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1070,26 +1070,6 @@ int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
 	return -EINVAL;
 }
 
-int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
-				    int channel, unsigned long pos,
-				    void __user *buf, unsigned long bytes)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_component *component;
-	int i;
-
-	/* FIXME. it returns 1st copy now */
-	for_each_rtd_components(rtd, i, component)
-		if (component->driver->copy_user)
-			return soc_component_ret(
-				component,
-				component->driver->copy_user(
-					component, substream, channel,
-					pos, buf, bytes));
-
-	return -EINVAL;
-}
-
 struct page *snd_soc_pcm_component_page(struct snd_pcm_substream *substream,
 					unsigned long offset)
 {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 71403da28d37..ae02d1d80c88 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2975,8 +2975,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.sync_stop	= snd_soc_pcm_component_sync_stop;
 		if (drv->copy)
 			rtd->ops.copy		= snd_soc_pcm_component_copy;
-		else if (drv->copy_user)
-			rtd->ops.copy_user	= snd_soc_pcm_component_copy_user;
 		if (drv->page)
 			rtd->ops.page		= snd_soc_pcm_component_page;
 		if (drv->mmap)
-- 
2.35.3

