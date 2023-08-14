Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FC77B806
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHNL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjHNL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946B199D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9802F219A2;
        Mon, 14 Aug 2023 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1jnv2TKHrrOjh5R9qzztXMwqp9Vm6qINMCnjF1D9Wc=;
        b=SBbnDbSu0L8THz/OoTd5VRbtp7n/e6q/+lX7OGgoe2QKdWM560iviFuad2kmEG56VIgNji
        BbaW9ulcmsKfl3JQCGtYMzJGxmldXysjbLSUhlShwKL7NeWNxFZvfFxRRftyODQ82u0XoR
        B95E8RRqSnIzNin1bnuU/yepzRSzkok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1jnv2TKHrrOjh5R9qzztXMwqp9Vm6qINMCnjF1D9Wc=;
        b=+bgCVsBKoH9wIMSgoZMDbYPbxgA3w/vTHyGgo53BWssz101P57OtGhHWIT4Ht240ApPPEy
        cZ5s5iNomP/YfxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 722EB138EE;
        Mon, 14 Aug 2023 11:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOn9GkkW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:53 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 18/25] ASoC: component: Add generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:16 +0200
Message-Id: <20230814115523.15279-19-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814115523.15279-1-tiwai@suse.de>
References: <20230814115523.15279-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For following the ALSA PCM core change, a new PCM copy ops is added
toe ASoC component framework: snd_soc_component_driver receives the
copy ops, and snd_soc_pcm_component_copy() helper is provided.

This also fixes a long-standing potential bug where the ASoC driver
covers only copy_user PCM callback and misses the copy from kernel
pointers (such as OSS PCM layer), too.

As of this patch, the old copy_user is still kept, but it'll be
dropped later after all drivers are converted.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc-component.h |  7 +++++++
 sound/soc/soc-component.c     | 20 ++++++++++++++++++++
 sound/soc/soc-pcm.c           |  4 +++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 87f248a06271..8040f001f2fb 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -141,6 +141,10 @@ struct snd_soc_component_driver {
 			 struct snd_pcm_substream *substream, int channel,
 			 unsigned long pos, void __user *buf,
 			 unsigned long bytes);
+	int (*copy)(struct snd_soc_component *component,
+		    struct snd_pcm_substream *substream, int channel,
+		    unsigned long pos, struct iov_iter *buf,
+		    unsigned long bytes);
 	struct page *(*page)(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream,
 			     unsigned long offset);
@@ -512,6 +516,9 @@ int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
 				    void __user *buf, unsigned long bytes);
+int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
+			       int channel, unsigned long pos,
+			       struct iov_iter *buf, unsigned long bytes);
 struct page *snd_soc_pcm_component_page(struct snd_pcm_substream *substream,
 					unsigned long offset);
 int snd_soc_pcm_component_mmap(struct snd_pcm_substream *substream,
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 4356cc320fea..ccab47f22122 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1052,6 +1052,26 @@ int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
+			       int channel, unsigned long pos,
+			       struct iov_iter *buf, unsigned long bytes)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *component;
+	int i;
+
+	/* FIXME. it returns 1st copy now */
+	for_each_rtd_components(rtd, i, component)
+		if (component->driver->copy)
+			return soc_component_ret(
+				component,
+				component->driver->copy(
+					component, substream, channel,
+					pos, buf, bytes));
+
+	return -EINVAL;
+}
+
 int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
 				    void __user *buf, unsigned long bytes)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8896227e4fb7..71403da28d37 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2973,7 +2973,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.ioctl		= snd_soc_pcm_component_ioctl;
 		if (drv->sync_stop)
 			rtd->ops.sync_stop	= snd_soc_pcm_component_sync_stop;
-		if (drv->copy_user)
+		if (drv->copy)
+			rtd->ops.copy		= snd_soc_pcm_component_copy;
+		else if (drv->copy_user)
 			rtd->ops.copy_user	= snd_soc_pcm_component_copy_user;
 		if (drv->page)
 			rtd->ops.page		= snd_soc_pcm_component_page;
-- 
2.35.3

