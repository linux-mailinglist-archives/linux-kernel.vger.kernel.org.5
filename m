Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16D78E083
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjH3UWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjH3UWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:22:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6681BD5;
        Wed, 30 Aug 2023 13:21:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-792707f78b5so6957039f.1;
        Wed, 30 Aug 2023 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693426832; x=1694031632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z4JICYPyprUjqWySgKr+yoLytnJucks9de9gSK2KLo=;
        b=PUU9HrJqYUlxQTmzf2qVn4aAhIn95YNF5zHwCfY522VAhJ5iv1RCNmtLSliuqfIX8Q
         avEU1CEdMKKjjY4sA+2rVnkj4mdNpwj6T2EICwr+mDsvtJaH50mcWSfVaojp3b6Hmtn2
         rmoBWYtYmHXrbKEf84oKWOn381+9RP9uHNj89woudnZxv3rpjJjxGK7uMT6p0w4FymcR
         DtTg4WsQKABLtb0IW37oJO0tVu6Tz3Rk315yzKWfm7Tbl1jr8Kq9Isqmsu3SsSsJLNHR
         gECFO04Kyb2/HyNzXUMeCp7D7GLUs+wK1I3D1vubskQ0tpbYiV8G4yn/geSsAw2klu+7
         I06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426832; x=1694031632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z4JICYPyprUjqWySgKr+yoLytnJucks9de9gSK2KLo=;
        b=Eh3YneOKg/vl6QS1VvQ+Wh9VM3VgWaIR4ZnXpZEKmK3zGTISnRERbhVCMMzmVoO/Hj
         loG2KkoJ7lmi/I/eXHvlYs9ym5qp4wmTPEE731ornN/ZH86KsYCVkkz/gV7kuGFn2Bp+
         HS73NfdExaNYyIi4apeeEAd8JievMfoRRhaKtJNoxdh7K/1S0Y6uo5kg7KSwOUD9lLWX
         TU7aEWss4p5IS2S5q2ZEo2R3239FcH0KTIja6OWTTjRGCYjP4Qm+WMzI4A7gHSG9CHuk
         PK8HrTLic4q1vz+RPLiPKWE7TN6nEH01GNmqY4k0Jj5XU2W04fEVE1bDGWp+C/Xkp25O
         MxzA==
X-Gm-Message-State: AOJu0Yzhglj52ilvRUFsXQDoT5upPUEhdvonsFgSKCTsbjo2pSIhBD8o
        slbfbgYriPR4XdoCLZDn/nw=
X-Google-Smtp-Source: AGHT+IHsYjwRoqRZqSkKyQkvwQXLT7GJggloVjV7k0+2ZWPVrbeNlqVTvlgZFgXjWH22AHWbNVCFJQ==
X-Received: by 2002:a6b:e801:0:b0:783:6272:afbb with SMTP id f1-20020a6be801000000b007836272afbbmr3846961ioh.9.1693426832173;
        Wed, 30 Aug 2023 13:20:32 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id s24-20020a02cc98000000b0042b4f1c08desm4132304jap.27.2023.08.30.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:20:31 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kobject: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 20:20:21 +0000
Message-ID: <20230830202021.4134348-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v3:
 * Fixed weird indentation.

v2:
 * Updated error message to remove @len which is errno now.
 * https://lore.kernel.org/all/20230830150136.3798414-1-azeemshaikh38@gmail.com/

v1:
 * https://lore.kernel.org/all/20230703180528.3709258-1-azeemshaikh38@gmail.com/

 lib/kobject_uevent.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..032d81b959f0 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -254,10 +254,10 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
 	int buffer_size = sizeof(env->buf) - env->buflen;
 	int len;

-	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
-	if (len >= buffer_size) {
-		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
-			buffer_size, len);
+	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
+	if (len < 0) {
+		pr_warn("init_uevent_argv: insufficient buffer space "
+			"(%u left) for %s\n", buffer_size, subsystem);
 		return -ENOMEM;
 	}

--
2.42.0.rc2.253.gd59a3bf2b4-goog


