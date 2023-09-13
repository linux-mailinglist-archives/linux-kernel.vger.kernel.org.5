Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F264879EFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjIMRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjIMRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:13:11 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22691
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:13:07 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3a6e180e49aso53605b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625187; x=1695229987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TycX59E5b3dlFgGY1L+jzKDgDIrRQ3+jS2g/Ms9VN9A=;
        b=aTJ69jXNunqkfhvzcfdypL8zLLwX28MbgYnrm1Ky66WzsuYqRju/86npjIUDKZxOaU
         cp/ryRqGV0GkTTGfxHi5TNmTqNK7B9Uvng3VjAKmeyI/sCrObopn+DllRyYiZ4+MzBpS
         yavsfqeuLoSRhmWupYZeS90dVySONaH5Ao3xC+8QsTmAUedLp68QlCytQmV1CI4mmYrB
         X1o5LIFv7hoVmbhly0wBguzB8vSDYfjBT5TybK+jKnAKRYyiWtAl4JcQ4lCoLX2vFmvw
         sPP5igotMX3vZMNsupqBIavg7c7yHJNoWWZd03qyEo0R1VO6oMhI4G5oe9Uu00JM/sbo
         se8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625187; x=1695229987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TycX59E5b3dlFgGY1L+jzKDgDIrRQ3+jS2g/Ms9VN9A=;
        b=eC6IrhAyW6svCpxaJNDyF8meT59rmamNljD8o5k7UDQpedmT3EPHcnLPvPSXVeC1UU
         rycFjSc17u7aQ4z+TXYoJEYobCRn3u1pbuP8l0Pj3aI5yd6/+sTmIyoXUTwPhYYX8Qmc
         ZhjKyIvIBP+UQKIqEcKFoj5zherXK8joDA93uUR3uaNyY4UICQ++mFraoCQDUiGlZN30
         90qRW0LP5bOwMdAEvu4KJbZZhVbal5svDolmyiRC7w47wYsadwMDd8WTPg1z6UDpvbon
         6cFznLo9ONLSQksQUb6LVD7xHUMFAVyipN/hByT8YIMd86gqodi7Io8vbqQVq2+wm+jK
         E4og==
X-Gm-Message-State: AOJu0YweaTxxik0PmRoUCg3dknNA2YzbL7qz0jFi26KwRox0x4/WyRFQ
        9U8vXanlUudywHe0cvFaOJmtJlUr9Fcn/f9WOw==
X-Google-Smtp-Source: AGHT+IGpv77TMcvUEUVSFcCbF4UPPntDMLB3+Kcq3GEi15wPVZGQhJZUau9yW/l4BvE2Ks/L2ADHNSyMWbN06O58bw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:1443:b0:397:f54a:22d6 with
 SMTP id x3-20020a056808144300b00397f54a22d6mr1310455oiv.9.1694625186953; Wed,
 13 Sep 2023 10:13:06 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:13:04 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ/tAWUC/42NQQqDMBBFryKz7hSTSEO76j2KC5uMcaAamUioi
 Hdvai/QzYf3+by/QSJhSnCrNhDKnDhOBfSpAjd0UyBkXxh0rU19VRrTIpObV/TCmSRhWQnyPPI
 vvO8a+zTWmt5DkcxCPb+Pg0dbeOC0RFmPv6y+7d/qrFChc42h2ivX0eUeYgwvOrs4Qrvv+wdjT 2SwzQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694625185; l=2941;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FDmfRrAoS66Rbbc25XcYmCZjZlwmE2RZWNS4Ok/5S0k=; b=E2uwLU3YiJUf5HxNMMXdX8SkcKNpi07uqk0WHe0v9DIfto0Upi/ltttoRVU6rUSIFiESIwDYh
 nM6tsROJ+DDDhGrrDYB1vZqhyjHrUVXazVor5thhRkpcNSlrEop/x7D
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-char-ipmi-ipmi-v2-1-e3bc0f6e599f@google.com>
Subject: [PATCH v2] ipmi: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

In this case, strncpy is being used specifically for its NUL-padding
behavior (and has been commented as such). Moreover, the destination
string is not required to be NUL-terminated [2].

We can use a more robust and less ambiguous interface in
`memcpy_and_pad` which makes the code more readable and even eliminates
the need for that comment.

Let's also use `strnlen` instead of `strlen()` with an upper-bounds
check as this is intrinsically a part of `strnlen`.

Also included in this patch is a simple 1:1 change of `strncpy` to
`strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then we
should opt again for `strscpy_pad`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://lore.kernel.org/all/ZQEADYBl0uZ1nX60@mail.minyard.net/ [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use memcpy_and_pad (thanks Corey)
- Link to v1: https://lore.kernel.org/r/20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com
---
 drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
 drivers/char/ipmi/ipmi_ssif.c       |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 186f1fee7534..d6f14279684d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi *intf, char *str)
 
 	j = 0;
 	while (*p) {
-		int size = strlen(p);
+		int size = strnlen(p, 11);
 
-		if (size > 11)
-			size = 11;
 		data[0] = 0;
 		data[1] = 0;
 		data[2] = 0xf0; /* OEM event without timestamp. */
 		data[3] = intf->addrinfo[0].address;
 		data[4] = j++; /* sequence # */
-		/*
-		 * Always give 11 bytes, so strncpy will fill
-		 * it with zeroes for me.
-		 */
-		strncpy(data+5, p, 11);
+
+		memcpy_and_pad(data+5, 11, p, size, '\0');
 		p += size;
 
 		ipmi_panic_request_and_wait(intf, &addr, &msg);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3b921c78ba08..edcb83765dce 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adapter_name,
 		}
 	}
 
-	strncpy(addr_info->binfo.type, DEVICE_NAME,
+	strscpy(addr_info->binfo.type, DEVICE_NAME,
 		sizeof(addr_info->binfo.type));
 	addr_info->binfo.addr = addr;
 	addr_info->binfo.platform_data = addr_info;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd

Best regards,
--
Justin Stitt <justinstitt@google.com>

