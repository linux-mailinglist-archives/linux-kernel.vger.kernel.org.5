Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F107AF9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjI0FTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjI0FTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:19:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB221423A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:10:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so16315182276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695791455; x=1696396255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aru77dJHpDYoQpT8/24nvfz2nt6AIFvt/5w/FoDAb0Q=;
        b=UeW8blatAFvIko7YsZsMb8BuKsL+xd0whILJkAwRaMQYEQ4MDcKJm3U+BGplv3krOG
         W22LnM/Nds9AQcQxXgeQL087uRqC1W9aDLFb9i9GpjrRmb4v0lke0+LTNOPukoSpQMpo
         9ftGlygWF3pT9yzwCzUyouLAU6i2A/Nz68kBdNEA6LsQ/bGjGWMfEWwyUEK92jlyiNil
         w0ywGYvLZNSjgm+rkTuHcmzs+3EBtRV5VSXNarHRx9CEXowMJXZqxBjQ5cX+d8VVwJJZ
         4oQcFvdDhAKwhVV9nRs8/iVWUerW161i8i8yK24k/qMWK/smvZ4vtM2Fq1eFJnF6Rqpq
         e5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695791455; x=1696396255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aru77dJHpDYoQpT8/24nvfz2nt6AIFvt/5w/FoDAb0Q=;
        b=PcxXxXCxdF6PsMOxI3fsttco47IeMsIxH8mv87405sFHA5x+VLX6Z9MgTy7hzO4Chk
         yoDT6vrPG8g7z+ER2S7oNxMPrY/a4bThFNVBwM64dOhd+ER9dMhlbPzFbLv8i+YqsFV+
         jkhck3+T4Qdx2vx5io4VBFRmbK0nNqGszYx3BErU2rHgD5l5ML49E4FLt1jFgHRHZp8f
         LcajIMa23Z5npTZa/MPnR83b1WhGNWsCssQ+h/PwI9aA9aymvIVeK3sUN2VVCPDPd1p0
         gcMMikMGRlbbdkBmYbz0GA9DVOEqRJ4DjNIz0m8CvDF9ZPxhlN1oooI54g2LbyIYMC8E
         RdAg==
X-Gm-Message-State: AOJu0Yw6slnin1vi0SnBUvghau4/ei5MPIDpWnE9pz+xC8MZ4AmtMdGG
        zeZ1a4YS7+FKr5+724dexwS6fQITsagfQyjyBw==
X-Google-Smtp-Source: AGHT+IFnVvg1PuAx77h/MFJ8ZakIWwiEpv1J0wKrBDySJuQK38qrLMc4naF2k1eQ4es0jmO9WoyZfFTZLI3IaiSF+w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b91:0:b0:d81:8e4d:b681 with SMTP
 id 139-20020a250b91000000b00d818e4db681mr9870ybl.12.1695791455116; Tue, 26
 Sep 2023 22:10:55 -0700 (PDT)
Date:   Wed, 27 Sep 2023 05:10:54 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF25E2UC/x3NQQ6CQAxA0auQrm1ShqDoVYwL6HS0C8ZJiwRDu
 LsTl2/z/w4upuJwa3YwWdX1nSvaUwP8GvNTUGM1BAodXcMFfbHM5YvRdBVznFPEOA09ERbj+YO Mo0hK57afeCCooWKSdPtP7o/j+AGnvRbcdAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695791453; l=2189;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fXXhr7E2ROv3mcXLZOf8/x1Ki4LsCzf8WOLlQCbDXpg=; b=MM7Zkg9rR+jOqbymVKilqLSpPNnDQPJSrb9+9Iw2lOmis4kPr3Pbyx1d5BrMPSINjL+a4xdg6
 gCzFjdWEfdHC4PS+w7F+tgsSrtjfD3FLHGUNbJQR9XT4eh4JvcWMvxJ
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
Subject: [PATCH] mfd: db8500-prcmu: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect project_name to be NUL-terminated based on its use with
pr_info:
| 	pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
| 		fw_info.version.project_name,
| 		fw_info.version.project,
| 		fw_info.version.api_version,
| 		fw_info.version.func_version,
| 		fw_info.version.errata);

Moreover, NUL-padding does not seem to be needed.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also change `PRCMU_FW_PROJECT_NAME_LEN` to just
sizeof(fw_info.version.project_name) as this is more idiomatic strscpy
usage.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/mfd/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 27a881da4d6e..5b3e355e78f6 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2639,9 +2639,9 @@ static void dbx500_fw_version_init(struct device_node *np)
 	fw_info.version.api_version = (version >> 8) & 0xFF;
 	fw_info.version.func_version = (version >> 16) & 0xFF;
 	fw_info.version.errata = (version >> 24) & 0xFF;
-	strncpy(fw_info.version.project_name,
+	strscpy(fw_info.version.project_name,
 		fw_project_name(fw_info.version.project),
-		PRCMU_FW_PROJECT_NAME_LEN);
+		sizeof(fw_info.version.project_name));
 	fw_info.valid = true;
 	pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
 		fw_info.version.project_name,

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-mfd-db8500-prcmu-c-aeeff615bc80

Best regards,
--
Justin Stitt <justinstitt@google.com>

