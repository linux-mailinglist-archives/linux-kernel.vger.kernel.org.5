Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03580739B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379256AbjLFPK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379171AbjLFPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:10:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AACD67;
        Wed,  6 Dec 2023 07:10:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf5398755so819608e87.0;
        Wed, 06 Dec 2023 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875450; x=1702480250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Exeor/DNWicuvK3cbDYRlFe90J3H0CF8DFmA9Uf4TNE=;
        b=ViovDYPD1emESdOx+5t7DNwLzU72R0UQbqP5XMXC6Z+fHyy/wNWo3GjdYyUH6rrzGD
         NlKsHvYXW3QB6PniMFRdTQEYwq2vTJIyMFU33TsFGUcdXE6gO4CYtp09/EubVl/MQUxO
         OMu33m2Mn1zc9t3ydfho+Ym5Je1NYTgS6xssNM+nKjiD+dwxTLG1d4osEtVT4u5Yt7lq
         zlBvMj5ypVDxlWl4k1fKXAhqtcZ0QOp+dT42yHQoWD2392Ej2lof0FqzC1Qoh4igZ8QK
         WYa2h+5YsyVzKGpaeta1CgSYuoyW6L3PU+SnAvfMxlcnMGzctb7ruuHzaY8GZwftEPik
         M+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875450; x=1702480250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Exeor/DNWicuvK3cbDYRlFe90J3H0CF8DFmA9Uf4TNE=;
        b=bKkYtAZLT/MY9loU+44KSBVXzmSW/tT78UiMgldgnkL3LEzFRFqv1KEVOdxRjU4Wmu
         eu4upAYh7+tEpXm7AnsMJepN9vQ+LVpig7t/BBs4xn4idiQnQu2Q1dVtMqEiprqKDiGa
         IIj0QM0z0Wzw124uAdc1TyZsp/dgC5Yhfrj7ZcTHGvttNGD2+mt8AgImZHg+HjnkSrxX
         e1D/O50eTk5ex5U5t90nJsewL4X3Esn4biaWNeUU9/SQ/NrCxXzs5UNaRoUcGsH8rs2u
         TfC+lmwkuaTu/qEthwr9R88wU3l0dY4h3Ib1S4Hu0AVZ1FZAh76RqysmZcyz6HgdSDu7
         QYUg==
X-Gm-Message-State: AOJu0Yz+cx8vkIAbBQZ2wOduU8SauGfPRrSfbx42Vk0sAypBclp2DZxU
        jX72O6FfNBtl0FGU66jYdQi8iSwTyZ1V3g==
X-Google-Smtp-Source: AGHT+IEn8UXEiWwmha6Gi024qxMmnrPujZCDTrYNF5xuJ1fLq2GIvllphNg7a5eh6D5lKFTR82okwg==
X-Received: by 2002:a05:6512:ac2:b0:509:4962:6fe with SMTP id n2-20020a0565120ac200b00509496206femr1552238lfu.1.1701875449455;
        Wed, 06 Dec 2023 07:10:49 -0800 (PST)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b0040b561924bbsm23738486wmo.21.2023.12.06.07.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:10:49 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: pcmtest: stop timer in the hw_free callback
Date:   Wed,  6 Dec 2023 15:10:46 +0000
Message-Id: <20231206151046.25773-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
V1 -> V2:
- Remove useless NULLing of v_iter->substream. It will be released in
'close' callback.

 sound/drivers/pcmtest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b59b78a09224..8a78fa56106f 100644
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
@@ -499,6 +497,10 @@ static int snd_pcmtst_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int snd_pcmtst_pcm_hw_free(struct snd_pcm_substream *substream)
 {
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_shutdown_sync(&v_iter->timer_instance);
+
 	return 0;
 }
 
-- 
2.34.1

