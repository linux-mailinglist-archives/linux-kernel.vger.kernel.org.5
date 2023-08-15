Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F9777D2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjHOTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjHOTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018441BEB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:01:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2B741F8C3;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3VMFP/ThTKsmB7svo+Y2YbkVeoI7hlTMO+M5msj2cY=;
        b=mm09zqvI44MC0922Q7QnkyYJvxBZYPcsk3RCwu6F07NcF5wi97H0zbEDkJT0cWMa6+PtXR
        b8mV93NLPGNqrE8XEGWR7fXMmlBJ6DO9rz4drcQuvhd9g9EWdzlWYXs0GF8mYCkZeKq0cZ
        8YTTgyEVMis/jT31jpEFAU0QKnh8rTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3VMFP/ThTKsmB7svo+Y2YbkVeoI7hlTMO+M5msj2cY=;
        b=Sgp0i9A+cNlhxo1Y+AdjM8Mf1wTrvb5b3JtTK83KCaJ3d/BkRsIq3o5OdWkzdVUyS6J4Q0
        RXCFae0By7k2XGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8171353E;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wEucJZvL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:47 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/25] ALSA: dummy: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:15 +0200
Message-Id: <20230815190136.8987-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the dummy driver code to use the new unified PCM
copy callback.  As dummy driver doesn't do anything in the callback,
it's just a simple replacement.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 9c17b49a2ae1..4317677ba24a 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -626,14 +626,7 @@ static int alloc_fake_buffer(void)
 
 static int dummy_pcm_copy(struct snd_pcm_substream *substream,
 			  int channel, unsigned long pos,
-			  void __user *dst, unsigned long bytes)
-{
-	return 0; /* do nothing */
-}
-
-static int dummy_pcm_copy_kernel(struct snd_pcm_substream *substream,
-				 int channel, unsigned long pos,
-				 void *dst, unsigned long bytes)
+			  struct iov_iter *iter, unsigned long bytes)
 {
 	return 0; /* do nothing */
 }
@@ -667,8 +660,7 @@ static const struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
-	.copy_user =	dummy_pcm_copy,
-	.copy_kernel =	dummy_pcm_copy_kernel,
+	.copy =		dummy_pcm_copy,
 	.fill_silence =	dummy_pcm_silence,
 	.page =		dummy_pcm_page,
 };
-- 
2.35.3

