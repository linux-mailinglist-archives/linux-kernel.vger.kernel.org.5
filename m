Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65957CE9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJRVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJRVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:18:29 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B8FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:18:27 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6cdb4938072so836686a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663906; x=1698268706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yN8Xmmf7uD1d77qxmyThi4rG4N+pXFvSzBoNB6ZmfFk=;
        b=NpnU7MfhCS4XY98IISFshulZfv+fpsfPt3+qx1UQiseUqT/0mB3fvxaMw1g4bJlWvk
         SzDeF2w96iV2k7OI2gN8+R17ZGgxnZ7P+mU7rNz872yBAKntg/U4dV+csARd7tXyJNXq
         c2KmFiEO8gLl/AOxnbxVOW1yC20O/nLgJ6HFYzbjtwmVOubLORZ2SiTZ+Cnznda5nHpX
         IZkFVs4eKuCLlgpAjLiXWwcoR07rAU/zhgzLj5GomKsxSAohA8O/Kblg7IozDt9c0qyg
         rAT/81toXgxYCjBAd6JnoBrKTvHYHG82Fpwh7qLHM1vyg5KksyH5TmaXMBuDMZdlw1Ir
         UANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663906; x=1698268706;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yN8Xmmf7uD1d77qxmyThi4rG4N+pXFvSzBoNB6ZmfFk=;
        b=CfvEep01i0xz+kQbyPgHlJabwfBZ+Uvz0iXsjzVnZGlSoNp3X2Vcc4SwiuSOvvHAl7
         CbesI/P14J6hiaSwQKXLC+dDT1FAEuO9cy3Irb4QSf1DFz7RbwF1YoF8lMvnYpN/pKkR
         6TQAPFzoPGeZt3DrDm0umsymEBIMSZ+eWTHIHpXEzpMTyjP8pZ6rdltA9QcoQItaqXW5
         acyHvnqPTAEuiBOXObxeEBOGRlY8F8KKZAtpJS1J8Ery6huj3m7Zhg6k/W/0TzjHZaKk
         HxbDiKMmW9FcZpczEfg9h0jA1IjIMEUau3qkgvxgrRDHxpqlKG0Dp3Z7CL0Qrk6Qh1yl
         k8gA==
X-Gm-Message-State: AOJu0YzyFY0SluG8ahAFNHKjjzI+l0BF7BY/5HIHRoX0DxRJqMRO7Weh
        P6D8pyBMSFpuKCxvIIwyiiDe30MgooxAQhmh8A==
X-Google-Smtp-Source: AGHT+IEqDPm9pBK525CUrTvp7fWEq/XpUln5u+ElP5FIqJb3IDRLpFT+4MmNyVgB2DEUV0PxPpzarH5RmxWbY1X1Pw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:4f08:0:b0:6c4:abb1:483f with SMTP
 id d8-20020a9d4f08000000b006c4abb1483fmr151782otl.2.1697663906391; Wed, 18
 Oct 2023 14:18:26 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:18:24 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ9LMGUC/53NTQ6DIBCG4asY1p1GsP6kq96jcYE41UkUzEBQY
 7x7qUfo8v0W33MIj0zoxTM7BGMkT86mULdMmFHbAYH61ELlqpC5rMEHtmbZoWeKyB4sBliJcUL
 vIRCsk2y2DWZNFgwUZaVzVatOdw+RPhfGD22X925Tj+SD4/3io/yt/0pRggTsy0IpNE1eNa/Bu WHCu3GzaM/z/AKAqSjd6wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697663905; l=2897;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=lMVpXzAbthcxiCNfxcyNDG6TNfyPkqxWUDDeMmHC4Uw=; b=x86eQLBjWQhfaxdwh4ogz4PqhKCrv1sPzCQUF/5jtKH/6gtucs0svlqppMZ0fYjPZlWMlUBvW
 JKrY4BC107aBjmBPeGu+f1S+rMK+/2wLcsr58oG3dm4WiQ2tbTgNxRy
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
Subject: [PATCH v2] wifi: wl18xx: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
the deliberate comment telling us as much. Furthermore, its only use is
drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
NUL-terminated since its used in scnprintf:
492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
which is defined as:
| #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
...
| #define DRIVER_STATE_PRINT(x, fmt)   \
| 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
| 			  #x " = " fmt "\n", wl->x))

We can also see that NUL-padding is not required.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

The very fact that a plain-english comment had to be made alongside a
manual NUL-byte assignment for such a simple purpose shows why strncpy
is faulty. It has non-obvious behavior that has to be clarified every
time it is used (and if it isn't then the reader suffers).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- add wifi: to subject (thanks Jeff)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wl18xx/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 0b3cf8477c6c..1e4a430d1543 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1516,12 +1516,9 @@ static int wl18xx_handle_static_data(struct wl1271 *wl,
 	struct wl18xx_static_data_priv *static_data_priv =
 		(struct wl18xx_static_data_priv *) static_data->priv;
 
-	strncpy(wl->chip.phy_fw_ver_str, static_data_priv->phy_version,
+	strscpy(wl->chip.phy_fw_ver_str, static_data_priv->phy_version,
 		sizeof(wl->chip.phy_fw_ver_str));
 
-	/* make sure the string is NULL-terminated */
-	wl->chip.phy_fw_ver_str[sizeof(wl->chip.phy_fw_ver_str) - 1] = '\0';
-
 	wl1271_info("PHY firmware version: %s", static_data_priv->phy_version);
 
 	return 0;

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-356a0272bab4

Best regards,
--
Justin Stitt <justinstitt@google.com>

