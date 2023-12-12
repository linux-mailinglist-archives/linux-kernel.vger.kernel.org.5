Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1A80E1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjLLC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A39EB;
        Mon, 11 Dec 2023 18:28:42 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d7a47d06eeso52156897b3.1;
        Mon, 11 Dec 2023 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348121; x=1702952921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1ziCHmUMRjRbO8uC0DQdJSiPRQP/fDCaegFJhzzCaw=;
        b=Wp1lG46/3S4h92lGr9FmU3vpqbCUWbjNtZfAfZLy1j+FwlaLb4wvIYWG+6axBfmpBi
         YrQbQTK1VTrruc/nqjLdoYQIG9QcxRxu4aZ66X5YaOzPYfTZogft+qVIeqUg3yEJUZX1
         9DnFtHDfPW6hLWLv6gkaxBt6BL0aCDzLyU/v/Q21qMTEou0N36aigSR0X9+NXl1u+Lab
         YRkjWdEyeDnbGEKcI2wbZz8WvcKh5JTCugM4MwsMpll6XBYsTHyJQb11cSpgTy6Ob6nq
         6Nn9HPzwRQvxMKenbUOqQXz1SliC3s9kW+3jLSCPoAIDxahdsvSlTWx/1BiaqRPzkQN9
         hMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348121; x=1702952921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1ziCHmUMRjRbO8uC0DQdJSiPRQP/fDCaegFJhzzCaw=;
        b=L8WBvz04Dy9BPO01cU1tcxpjXB6vgsQ4o+cJ+6vqEdFQSPlFU6ZthxY50shHIAJYFg
         W3BVZi2mCeQhPZ73vdvvt+OJ5I2jitNkiyrDVGP7igRevSKWeVVnASZcw4aUOL7aZ28L
         MbsQ3apEIIa/fmQtVOzKlPUUqba+KXgxMJyxRo9Us67F0LzcaSuX4nuZz6lrRZ13xAxX
         34tBlU8mtc5Ic+/ZJwKGnQOtiG8afXGtGTRaHJ77HvuX00d1lzUDDhs3+Uv2Jd2/Eeye
         Q6ErOyU6rHPj5HQb318fNuFHgKxvdKNxlNS/xJKmzVgHxyL/ssY9VSwYl04jni/rE6iv
         jV8A==
X-Gm-Message-State: AOJu0Yx9lGJyBDBBeHxFQ97df3F8fTbha/zFtYS7agVMTANKfMbAmGr/
        gII3WcyG2m/pXy68/1X4ejufa8mjDY2ZDw==
X-Google-Smtp-Source: AGHT+IEkj3SrO47EktQbRudrxe7SbWLYCP6nELjcTaeJUHnC5fYO3ykVx8HOtGA5GggcJQHNwWRRGA==
X-Received: by 2002:a0d:dbc5:0:b0:5cb:eac7:38aa with SMTP id d188-20020a0ddbc5000000b005cbeac738aamr4593499ywe.35.1702348120890;
        Mon, 11 Dec 2023 18:28:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id u11-20020a0deb0b000000b005af5bb5e840sm3454168ywe.34.2023.12.11.18.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:40 -0800 (PST)
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
Subject: [PATCH v3 32/35] ALSA: use atomic find_bit() functions where applicable
Date:   Mon, 11 Dec 2023 18:27:46 -0800
Message-Id: <20231212022749.625238-33-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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
using dedicated atomic find_bit() API.

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

