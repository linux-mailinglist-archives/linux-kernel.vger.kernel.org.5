Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10D6751109
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGLTNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGLTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:13:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836791FC7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:13:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3159acfc48cso896993f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689189222; x=1689794022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QHVO7BLuBhdhHKLquYTQM6WPJRF2zzEP1Lh58ULoUg=;
        b=X5THPtP/o3bSxe7TyAsA7WCM8sLDROd6YZyUh53cQiL5zZvuTlU/shPlowSv6/ahO5
         67ZGcnpToEmvPKaLlSsvcBS/ZkNhDxTz4AmjZoqvZUKm/vhajm+z+koBm5Fl/5cMmT5q
         FLG+y/20nJdQHIW8TZljbM2xmQ/M3cpwhhv9oXV/sg5tgQIY0TjKpBM5O1p47f6ya2F6
         OYYCr1Yy/UOS591fpvj7e7DXdpnB41Rd88SMclAZMdVZWcU5EENWnEXTZZFb3bcl2h8x
         W643qQ+jn0FT0qp3pM1WbfLYGzn075Hqyv8lVNxFbvqkj6aRXjouAPoPlOpU2zvSwcbV
         uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189222; x=1689794022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QHVO7BLuBhdhHKLquYTQM6WPJRF2zzEP1Lh58ULoUg=;
        b=CbKf7tq9+4zxzAWF+4vRXQoW9QXHjnfVuDOlBooViZoUi69qWqF9a3/rubPA94mwn4
         C2WoRlDdjMlPbvOhw0/3zBaIw9jqUctWb0nnx8flXWncshIINewe8XbkSZrcZza4Bjlj
         xfYUg9DogOD03Tokp7tp3p7QnSM4eTOFRxpFzwW3a1Z7q/bzkXHrGt5EZ6x+deuVyVXr
         CFHHvMNgVjy85v2dsJhxMP78KoUWxBNsqjaEqPTQWgyRp8AF91SgGntr8yCjNAXiieRX
         cna0/cyd9hujWstEM7Y4qfUwRMiqwUtOec3jd5YnSIOz29Jrt7QF6lswxnwUetzkm7SY
         jXvw==
X-Gm-Message-State: ABy/qLZF6tcg8DBJxPNxOiVfvCboELw8XPkUtn5Hi2ZE2qSiyZ3vaIpl
        0hndGezhJfckL+Q+vGxW12M=
X-Google-Smtp-Source: APBJJlHdlJ6lu/yHbOb/wtnZacEcBnt6ZjRG6zPJF8Mr3ONmlp/q4gsnHtJpxCyWarn9DZr5Fp3Hsg==
X-Received: by 2002:a5d:4941:0:b0:313:ddde:6ecd with SMTP id r1-20020a5d4941000000b00313ddde6ecdmr256553wrs.1.1689189221727;
        Wed, 12 Jul 2023 12:13:41 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.92])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00313e59cb371sm5848063wrq.12.2023.07.12.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:13:41 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcmtest: Extend error injection, decrease buffer filling overhead
Date:   Wed, 12 Jul 2023 23:13:25 +0400
Message-Id: <20230712191325.8791-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend 'pcmtest' virtual driver with 'open' callback error injection
functionality, as it already can inject errors into other PCM callbacks.

Fix the driver to use already defined variables where it is possible.

Additionally, decrease the buffer filling overhead with conditional
reminder calculation in the 'inc_buf_pos' inline function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/pcmtest.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 291e7fe47893..08e14b5eb772 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -65,6 +65,7 @@ static int inject_delay;
 static bool inject_hwpars_err;
 static bool inject_prepare_err;
 static bool inject_trigger_err;
+static bool inject_open_err;
 
 static short fill_mode = FILL_MODE_PAT;
 
@@ -88,6 +89,9 @@ module_param(inject_prepare_err, bool, 0600);
 MODULE_PARM_DESC(inject_prepare_err, "Inject EINVAL error in the 'prepare' callback");
 module_param(inject_trigger_err, bool, 0600);
 MODULE_PARM_DESC(inject_trigger_err, "Inject EINVAL error in the 'trigger' callback");
+module_param(inject_open_err, bool, 0600);
+MODULE_PARM_DESC(inject_open_err, "Inject EBUSY error in the 'open' callback");
+
 
 struct pcmtst {
 	struct snd_pcm *pcm;
@@ -140,7 +144,8 @@ static inline void inc_buf_pos(struct pcmtst_buf_iter *v_iter, size_t by, size_t
 {
 	v_iter->total_bytes += by;
 	v_iter->buf_pos += by;
-	v_iter->buf_pos %= bytes;
+	if (v_iter->buf_pos >= bytes)
+		v_iter->buf_pos %= bytes;
 }
 
 /*
@@ -196,10 +201,10 @@ static void check_buf_block_ni(struct pcmtst_buf_iter *v_iter, struct snd_pcm_ru
 	u8 current_byte;
 
 	for (i = 0; i < v_iter->b_rw; i++) {
-		current_byte = runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)];
+		ch_num = i % channels;
+		current_byte = runtime->dma_area[buf_pos_n(v_iter, channels, ch_num)];
 		if (!current_byte)
 			break;
-		ch_num = i % channels;
 		if (current_byte != patt_bufs[ch_num].buf[(v_iter->total_bytes / channels)
 							  % patt_bufs[ch_num].len]) {
 			v_iter->is_buf_corrupted = true;
@@ -239,7 +244,7 @@ static void fill_block_pattern_n(struct pcmtst_buf_iter *v_iter, struct snd_pcm_
 
 	for (i = 0; i < v_iter->b_rw; i++) {
 		ch_num = i % channels;
-		runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)] =
+		runtime->dma_area[buf_pos_n(v_iter, channels, ch_num)] =
 			patt_bufs[ch_num].buf[(v_iter->total_bytes / channels)
 					      % patt_bufs[ch_num].len];
 		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
@@ -364,6 +369,9 @@ static int snd_pcmtst_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pcmtst_buf_iter *v_iter;
 
+	if (inject_open_err)
+		return -EBUSY;
+
 	v_iter = kzalloc(sizeof(*v_iter), GFP_KERNEL);
 	if (!v_iter)
 		return -ENOMEM;
-- 
2.34.1

