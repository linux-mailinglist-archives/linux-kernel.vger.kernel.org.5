Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856457F00BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKRPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjKRPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:37 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC5E1FF9;
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5c516f92759so32039337b3.2;
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322713; x=1700927513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqvvn3jC6Vz8bzOhTQHPcM8ndCOZ4pDWuw3ZxWJvphM=;
        b=cSoJGbdUB2e8+JfALFn1StMsw2Z57vXAv8W3lpRnBCvQ3pT50egm1YoxTOYi1LLcD8
         hwrD+VPnOFkk7hSSAmOVhPTdwGqPWIPZOVwiylyErS6WcXRS8BzSvRqAdb4b6IGFdhVt
         3Eoqurbr05XjloHaIaCCZztvsVWSMiBPzYu/zPRC5ZEaqS65HGekyB4/11SFgyL7oGqF
         4spoIaXqnL2oOQzd1zO3vyO9aeC8XF5Zl5gYjUcF4Qv/bntzsg/yg2L3eSEP7lnQVI3g
         okmeVAJDLcCljZCE2jpY6icyq0x4G+l2O5KDcgxBgd2JUydy1igv+nx57E8ZWsmSoYAe
         HlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322713; x=1700927513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqvvn3jC6Vz8bzOhTQHPcM8ndCOZ4pDWuw3ZxWJvphM=;
        b=NccrJYZc/bVG7fZHBfGv6FaQQg4ay2NVnMzvgmU4IqC/3JlzOx5pvxvQefhzcwE3pg
         GrqjxISDDLZidVYHGBsnnFLQQpdk6ezt6LT85dUcVGT238kmXf+N+up+yir+HKwA6kh8
         ex759O+75POHSkZVn2tpi2wa2bIYX/zQ29CRlE7WgoWBnxdCdEb+EqHoZ7NqVhi3Xhk6
         BMMHWonvgbb7TQRT4TOTOj0LBKAJU/gpUXBBq5c6vIcCT/pgtiPdC12yd/1ZJ8wmxeKb
         m395yq98186MKMfU7TS5SMFEhA7h11kURS0ap5k195kHL9RAnBiRzZvAJqYrIPe/ME26
         rQpA==
X-Gm-Message-State: AOJu0YxDZXNP4f16SYMcts/+E8HL3Hv8zIyiWb4xFofejrJOlTeF2Jw8
        M9zOGhlqbHCGO/bNVVkPzr02gveBsmrAByqI
X-Google-Smtp-Source: AGHT+IHi1UfS8eoFXkfozWsLdq/Iqyn0m7FQM2MTep2E1EPNYtNXp8LEwhBmcZHJxn/bgTZr34eiJg==
X-Received: by 2002:a81:f202:0:b0:5c9:9097:6427 with SMTP id i2-20020a81f202000000b005c990976427mr546580ywm.44.1700322713616;
        Sat, 18 Nov 2023 07:51:53 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id b65-20020a0dd944000000b005a8c392f498sm1167875ywe.82.2023.11.18.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:52 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Daniel Mack <zonque@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 30/34] ALSA: use atomic find_bit() functions where applicable
Date:   Sat, 18 Nov 2023 07:51:01 -0800
Message-Id: <20231118155105.25678-31-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA code tests each bit in bitmaps in a for() loop. Switch it to
dedicated atomic find_bit() API.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 sound/pci/hda/hda_codec.c |  7 +++----
 sound/usb/caiaq/audio.c   | 13 +++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 01718b1fc9a7..29254005f394 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3275,10 +3275,9 @@ static int get_empty_pcm_device(struct hda_bus *bus, unsigned int type)
 
 #ifdef CONFIG_SND_DYNAMIC_MINORS
 	/* non-fixed slots starting from 10 */
-	for (i = 10; i < 32; i++) {
-		if (!test_and_set_bit(i, bus->pcm_dev_bits))
-			return i;
-	}
+	i = find_and_set_next_bit(bus->pcm_dev_bits, 32, 10);
+	if (i < 32)
+		return i;
 #endif
 
 	dev_warn(bus->card->dev, "Too many %s devices\n",
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 4981753652a7..74dfcf32b439 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -610,7 +610,7 @@ static void read_completed(struct urb *urb)
 	struct snd_usb_caiaq_cb_info *info = urb->context;
 	struct snd_usb_caiaqdev *cdev;
 	struct device *dev;
-	struct urb *out = NULL;
+	struct urb *out;
 	int i, frame, len, send_it = 0, outframe = 0;
 	unsigned long flags;
 	size_t offset = 0;
@@ -625,17 +625,14 @@ static void read_completed(struct urb *urb)
 		return;
 
 	/* find an unused output urb that is unused */
-	for (i = 0; i < N_URBS; i++)
-		if (test_and_set_bit(i, &cdev->outurb_active_mask) == 0) {
-			out = cdev->data_urbs_out[i];
-			break;
-		}
-
-	if (!out) {
+	i = find_and_set_bit(&cdev->outurb_active_mask, N_URBS);
+	if (i >= N_URBS) {
 		dev_err(dev, "Unable to find an output urb to use\n");
 		goto requeue;
 	}
 
+	out = cdev->data_urbs_out[i];
+
 	/* read the recently received packet and send back one which has
 	 * the same layout */
 	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
-- 
2.39.2

