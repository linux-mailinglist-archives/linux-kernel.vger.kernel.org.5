Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1537C8E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJMUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:53:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71B3C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:53:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b10c488cso39217547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697230414; x=1697835214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OzZl4+HNDCRg4UbOKbkT7uBUITuj6sL+WIkS7NUKeRU=;
        b=VFS9rzlmbYywzA+6iwwLGKwQrfyVafuWixsnnz88rIowp1FR2GwcNYnh87iT9MFtf3
         s3Z0ZsyepACmEG6LZD1+DceH6NBaOGb1mbSJwKRNigyolIlKNP1Kk20CTDr21yat3C0B
         XMjpEq+Ep68MIKYnSlYWFhManYhg4yratCd26dzH77DWz4DdfC7htsA00XNGAbvy/FLR
         neL6QIeF3XSqWHXR/cwUCl9H55EeIwQ7kZxJwA+Bbs2XtqkM7oMYxAO6keaRIEaWvVuM
         BULlKvRNS9xaxCJ6et2hZmAuvp3GhUt/8EHjl8pjyEgDOzMJcCAf+7yMzsQ7eFUtoXgV
         Ii3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697230414; x=1697835214;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzZl4+HNDCRg4UbOKbkT7uBUITuj6sL+WIkS7NUKeRU=;
        b=dcpVKbxjON+QfJXNBIOH1IBcSt1mr4JGFXKZ4/0mKgDVJRrgsAw0Vxj0Z4eN5n6nIn
         wf8vdlcpsN/lJ2bTDL5frLBKTVJ0vIZRyi8cTQwhidexnexKyXonH5eFGU5b00qIBBov
         20HWPD0uqmF0Mjp2J6dxlB5i8F9ka9UOWD91IYghwl38m/5iiM3PJhMPMXgC8IVgyGHZ
         iZahwn7SRsNhNEsr5uZZO8fsoxsDXL2dx25m4opGq2jo7/hVTn7MtlD34cCyVnnVaN1E
         8HUdQuxAAiGin8YVhYkwJ3883f9u2XbJ/riqy7oDQbSaGKfTnZrbiWM9Jg/6Q/fV36DR
         AeOw==
X-Gm-Message-State: AOJu0YxP0+t2pv+MK7Bzux1JlcdrAec/F+2xv78iGvXievX/D64frBWm
        30O02SgyNxZRqX/2/ioDWssGp7VywZaeSEso6g==
X-Google-Smtp-Source: AGHT+IHN26xr3FORe1m3+FXQr3Z2wC+M86g8vFee5wcig6JFqbRrXhFTD8j81hIOU0Ro3yfxxGIoK6Mc1qFrJlQ0ag==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a150:0:b0:5a8:28be:bf86 with SMTP
 id y77-20020a81a150000000b005a828bebf86mr62498ywg.5.1697230413988; Fri, 13
 Oct 2023 13:53:33 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:53:33 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEyuKWUC/x2NzQ6CMBAGX4Xs2U1oi/HnVYwHaD9lI6lkt0EN4
 d2tHuYwl5mVDCowOjcrKRYxeeYqbtdQHPt8B0uqTr71wbUusBXNcf5wUlmgxhmFX6KYYMZ9GX/ sHzwhcWTnu+MhAqcwgGpyVtzk/d9drtv2BccyB/Z+AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697230412; l=2121;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AwGkauBF747GZlKSLUDSAGULd+jPXO4eamh/1mrnOow=; b=jbmxFb3nNGqErXN238ktXtN+UHQuPKfn2bj7BMuyW8p3jYgRrpqT8otgeIeuvlOaf5YY2ER3u
 gfPL8Fjoz8sDgfubNhmKQ4vUxROcTIYlWSY6BhbY42kdlqtcmZbo5a/
X-Mailer: b4 0.12.3
Message-ID: <20231013-strncpy-drivers-net-wireless-ath-ath5k-led-c-v1-1-3acb0b5a21f2@google.com>
Subject: [PATCH] ath5k: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect led->name to be NUL-terminated based on the presence of a
manual NUL-byte assignment.

This NUL-byte assignment was added in Commit daf9669bea30aa22 ("ath5k:
ensure led name is null terminated"). If strscpy() had existed and had
been used back when this code was written then potential bugs and the
need to manually NUL-terminate could have been avoided. Since we now
have the technology, let's use it :)

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. If NUL-padding is required let's opt
for strscpy_pad().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ath/ath5k/led.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/led.c b/drivers/net/wireless/ath/ath5k/led.c
index 33e9928af363..439052984796 100644
--- a/drivers/net/wireless/ath/ath5k/led.c
+++ b/drivers/net/wireless/ath/ath5k/led.c
@@ -131,8 +131,7 @@ ath5k_register_led(struct ath5k_hw *ah, struct ath5k_led *led,
 	int err;
 
 	led->ah = ah;
-	strncpy(led->name, name, sizeof(led->name));
-	led->name[sizeof(led->name)-1] = 0;
+	strscpy(led->name, name, sizeof(led->name));
 	led->led_dev.name = led->name;
 	led->led_dev.default_trigger = trigger;
 	led->led_dev.brightness_set = ath5k_led_brightness_set;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231013-strncpy-drivers-net-wireless-ath-ath5k-led-c-12487cee93be

Best regards,
--
Justin Stitt <justinstitt@google.com>

