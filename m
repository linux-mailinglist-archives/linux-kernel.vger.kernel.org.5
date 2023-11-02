Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488A7DF2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjKBMy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:54:55 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029C112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:54:46 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-581ed744114so434027eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698929685; x=1699534485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0TjCm27kPn1fbRaa234/Wv9QR/vO4k2O7cQuwk/rSc=;
        b=L1F5E1utA+x9G89a2yC+T8k1CZ43hoXSnIIhShvy7072c2gMFxkFYZj1VCIfvmNrew
         xfXR7ldbuLUcWiOK+i8huJWDOq6zEd6kbh2Zd1gKEvFWu1DQ6SwCO2PEjw1/eNrjgIgy
         nbnoL10ot+YYspl6PwJO7Lad4a0YEOY9uKg54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929685; x=1699534485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0TjCm27kPn1fbRaa234/Wv9QR/vO4k2O7cQuwk/rSc=;
        b=vw70iHcmqZWr8Z1JAGWrdl1lGEWw6Z7yDgkEtv1rmA18iHQMK0eViSVlN2WgEB5QxP
         eC+A145K63DvCAn7aUEolsybCWNulrGqatOZvlUiCiL9noRbfPxf2MgiquUNsTROq8z/
         FTBzYUIVYKgH786dsgxm//yYbBcrXYiTdzHtQTdT3Rl83+0+xjYxwPy8jxk3PY0qlJc+
         Rocb9jpUf8VY/lB85+0JZxwSxJ5+hlgwA7jlWTwQ4gX2KywZLYG3IO1sf+8fwKTlGrBi
         6mvqRlR0hA4N2Frxa1Me2h/ErgIftGQq+sme6Q4Rb/rxZ6wAaQ6udtl/QKV9Tgq7ci1g
         R2Hw==
X-Gm-Message-State: AOJu0YxGOHq77BJavY9BrXERSgj4lGOx7T4p0PW4cva/ycyIc2r3kp8T
        DEwTw/fN26lnoMbZOGOazN6UiX+Gdc+A9/lW7s4=
X-Google-Smtp-Source: AGHT+IEe6gqoIsRx0Ax4Od60cbOYQ3dQrsZKcWcNwHbsGzZe7MJ/wwlkxulQpadaMEjkTYHO1hC+2A==
X-Received: by 2002:a4a:c885:0:b0:587:2b9b:985a with SMTP id t5-20020a4ac885000000b005872b9b985amr7860727ooq.9.1698929685302;
        Thu, 02 Nov 2023 05:54:45 -0700 (PDT)
Received: from jdenose34.roam.corp.google.com (99-137-158-190.lightspeed.cicril.sbcglobal.net. [99.137.158.190])
        by smtp.gmail.com with ESMTPSA id d200-20020a4a52d1000000b005737ca61829sm996467oob.13.2023.11.02.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:54:44 -0700 (PDT)
From:   Jonathan Denose <jdenose@chromium.org>
X-Google-Original-From: Jonathan Denose <jdenose@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jefferymiller@google.com, Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: [PATCH] Input: psmouse - add resync_on_resume dmi check
Date:   Thu,  2 Nov 2023 07:52:47 -0500
Message-ID: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some elantech touchpads consistently fail after resuming from
suspend at sanity_check in elantech_packet_check_v4. This means
the touchpad is completely unusable after suspend resume.

With different permutations of i8042 nomux, nopnp, reset, and noloop
kernel options enabled, and with crc_enabled the touchpad fails in
the same way.

Resyncing the touchpad after receiving the
PACKET_UNKNOWN/PSMOUSE_BAD_DATA return code allows the touchpad to
function correctly on resume. The touchpad fails to reconnect with
the serio reconnect no matter how many times it retries, so this
change skips over that retry sequence and goes directly to resync.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/input/mouse/psmouse-base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a0aac76b1e41d..3c6eefcb9582f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -12,6 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -105,6 +106,16 @@ static struct attribute *psmouse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(psmouse_dev);
 
+static const struct dmi_system_id resync_on_resume[] = {
+	{
+		.ident = "Lenovo N24",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo N24"),
+		},
+	}
+};
+
 /*
  * psmouse_mutex protects all operations changing state of mouse
  * (connecting, disconnecting, changing rate or resolution via
@@ -285,6 +296,12 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 				     "%s at %s lost sync at byte %d\n",
 				     psmouse->name, psmouse->phys,
 				     psmouse->pktcnt);
+			if (dmi_check_system(resync_on_resume)) {
+				psmouse_notice(psmouse, "issuing resync request");
+				__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
+				psmouse_queue_work(psmouse, &psmouse->resync_work, 0);
+				return -EIO;
+			}
 			if (++psmouse->out_of_sync_cnt == psmouse->resetafter) {
 				__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 				psmouse_notice(psmouse,
-- 
2.42.0.820.g83a721a137-goog

