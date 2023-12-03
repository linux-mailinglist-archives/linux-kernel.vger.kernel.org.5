Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC10802708
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjLCTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjLCTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:36:20 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E83211E;
        Sun,  3 Dec 2023 11:34:06 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5b383b4184fso40874467b3.1;
        Sun, 03 Dec 2023 11:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632045; x=1702236845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHrqBjURy+mudPJ+6bg27Pk9qQM+xmaxDRnoUP1Py9c=;
        b=AMI3FW8SVrYuqUOrNt/Ih6iy+WKIu5NgwmqcS/cYpwrdeWj+iIFsYqIjDrA6jvua0g
         fRmeEIQ6ghQKvsivQ3B89tNJxZDj0lFSHnC6XfmyLBMLqSGF0zY77HqL96leVHRhn81c
         o7QJh4rfSQNx0OvEytqVcyXH0IWN5mGBGopr5gM/mAj9X9zf/1WUfcUlAA8u9rhOWjIm
         RJiufNVyEtSI8zOcYPUJoN843PYkwd/SFeA6hLzq3VbBrdNhv9rHL9kGDkwwcjko9EnS
         2DzN5nIhSOD0DQpSG3ASYiTaX7h4davfHyg91rGaHBAmuHmDfs52D69QqYrQnoXJDavs
         vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632045; x=1702236845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHrqBjURy+mudPJ+6bg27Pk9qQM+xmaxDRnoUP1Py9c=;
        b=MZFD38bYEJ5w//08VN3ajRarZBBPhQaG7cSEXMjurQvEw+wjS2aCf1e4F+Yp3oYk9q
         m3wice9QovlYz94nZ6zEowu0KoSPKST+j5JJRP7FgstupvgBMifj62hiEmqpeqOyxuq1
         O/UOAiEBqqSVVF/jDhCGSxCRLXCDby7Z+jYe3scX7DpkusQ02ToGTsGWMdmGM+2PH6Yh
         lpcWfSEjAnGs/e+1vUIzPMBPiEQlNfzozma7TPRXZrnJqEZlC+CbVRwUxmen3rdtdvKb
         nFY9YSyBtQ7td//EJhBxWStElvaX/R4+37i0QSZF+3ymHU1XxT1zm9P6U28fBBwGjz1X
         3T7g==
X-Gm-Message-State: AOJu0YzZuS7L57egk5SEJgTYbp+zv/15vqIJ+znfdNnnbqklRPfkYfrZ
        pfikPKjmLABuDH4OGiPsVrodSJSOl0Kxuw==
X-Google-Smtp-Source: AGHT+IGc9OJCrz0Vs7Jwm9KKYJn6cgVwzSJPcWjmn+naJ4Os06xO0RgJu/5QwhQF/G6sjioOlbuV6Q==
X-Received: by 2002:a05:690c:368a:b0:5d7:1940:7d74 with SMTP id fu10-20020a05690c368a00b005d719407d74mr2240772ywb.75.1701632045662;
        Sun, 03 Dec 2023 11:34:05 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id v127-20020a818585000000b005869fd2b5bcsm2769872ywf.127.2023.12.03.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:05 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 32/35] ALSA: use atomic find_bit() functions where applicable
Date:   Sun,  3 Dec 2023 11:33:04 -0800
Message-Id: <20231203193307.542794-31-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA code tests each bit in bitmaps in a for() loop. Switch it to
dedicated atomic find_bit() API.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
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
2.40.1

