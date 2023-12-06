Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16C80731F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379027AbjLFO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379015AbjLFO4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:56:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A41BD;
        Wed,  6 Dec 2023 06:56:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso7434115e9.0;
        Wed, 06 Dec 2023 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701874601; x=1702479401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucmsp+pjBTlhjv1gBcBSs/5oCUvUo/iNpnLaNAcrn8k=;
        b=ML1lc9aCfZqZ5O9xZS3rUVmzlXxun6Bp4rYsd0FIVy+zueHbD5SyivM/299WQKbNx3
         cDUrdmSDgm8hjlgtdvI2Tfn17CcOtJfwEN/mH4n8qfLJUrMb2C6a1P+ntHUY2QDumepn
         d037sdgDNMO5W/GgB8049/PHurMieJr6apNtMl7o2n9/JMCnDuRu9hFi0jAkYonTBaiF
         YmFII3nObU/Eqpq4ETmvO5mWXR0qzHBjAZnYjt1nZoGAO6wICUMtnC8QPOY0mENWJDa1
         nCim1PDJ2viT3Tzh2fHSchnY1XLNlWOvXzjV9oGPkUIB4Y93QVI3eOOKTQuCHTSyMQNT
         DYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874601; x=1702479401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucmsp+pjBTlhjv1gBcBSs/5oCUvUo/iNpnLaNAcrn8k=;
        b=gq2FT7Mhfevp/al4FhG+/BwNOhA6Fxm8MCfOseLN3rrd7L2OTlkpZwaoJ1iVouNIHY
         11cEECXuG6cNWeQDACNThadUwPNnDsANdaoN4L2x/q0Rlb+/5g52+2JpcwGcWjvI1r/8
         AUWqaxHId7boSO6tiE3kCrcfrJDrvi4bqgEMOe7ZZaEWaVWb0CcjoPKxtgaMR7HNt2Z7
         CfY93IzSOm1OEPzT8c8wh07gXpWJ0Gky+9VB7WPFn74CgHHr1uc+/loj5gbiCjxYlBur
         XsJaDB0vLf5TLAmItEMGlmw1OBEsa+NXMvnZFzQD5eCXm9/E4UTNtYrnVUeJezI0TQCO
         pOBg==
X-Gm-Message-State: AOJu0YxyGoodmzcTs+4W9gMVmn5qJm7mpNyjd109A6L6xwcAyjQpFFwD
        fPKY1deqa2mKySOb5tbpW5t4pGjsJr1k1w==
X-Google-Smtp-Source: AGHT+IG7+vo+2kbfWj+B2+iZx8wGUJvm80UJQo9nm1U74GACAfHzDUu0jtulPYfGZi3/ZDgXtIKwEQ==
X-Received: by 2002:a05:600c:45c5:b0:40b:4ff7:e131 with SMTP id s5-20020a05600c45c500b0040b4ff7e131mr1536006wmo.2.1701874601282;
        Wed, 06 Dec 2023 06:56:41 -0800 (PST)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b0040b37f1079dsm26261538wmb.29.2023.12.06.06.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:56:41 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcmtest: stop timer in the hw_free callback
Date:   Wed,  6 Dec 2023 14:56:37 +0000
Message-Id: <20231206145637.23700-1-ivan.orlov0322@gmail.com>
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

Stop timer in the 'hw_free' callback instead of the 'close' callback
since we want the timer to be stopped before the DMA buffer is released.
Otherwise, it could trigger a kernel panic in some circumstances, for
instance when the DMA buffer is already released but the timer callback
is still running.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/pcmtest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b59b78a09224..645caf1cc881 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -396,8 +396,6 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
 
-	timer_shutdown_sync(&v_iter->timer_instance);
-	v_iter->substream = NULL;
 	playback_capture_test = !v_iter->is_buf_corrupted;
 	kfree(v_iter);
 	return 0;
@@ -499,6 +497,11 @@ static int snd_pcmtst_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int snd_pcmtst_pcm_hw_free(struct snd_pcm_substream *substream)
 {
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_shutdown_sync(&v_iter->timer_instance);
+	v_iter->substream = NULL;
+
 	return 0;
 }
 
-- 
2.34.1

