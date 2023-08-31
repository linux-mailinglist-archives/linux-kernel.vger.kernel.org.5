Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0246678EF20
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbjHaOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHaOBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:01:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8ACC;
        Thu, 31 Aug 2023 07:01:15 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79536bc6697so31479339f.1;
        Thu, 31 Aug 2023 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693490475; x=1694095275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ2cGHJVHSShioqtMZDfDzYLhYEcSFYiRM+Mt80HyFU=;
        b=H1acRkQljRxx7snyI72iSnHTQNMgDi7/jWQmbIxM/gihAkxPMshgwd+WAl/AHziTjW
         uwUC8t8ZhtFc7k4yTrOHuG0qh7aR+JzTexPvY63IlyCg0u3hbV02g+RyT1NClpDRVXUU
         ljsV/MyNFjQsoySotBlfc/2v01CV1EvsNtpROaZP0tibF/ky4CUTwIZcaWxHBTxyPq6F
         RZxyiqY6dRr7dEvcnukEga1HG4av28CQWifzusv5sKbHE398Ag6KFoYQuHpRWNLenuIL
         Z7od/XCKqtN9R0fpm2krSEO7leC+RieC4NpZcKPTEk4pK0FDUpyPkXDqBUdbYN8T4nJg
         K24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490475; x=1694095275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ2cGHJVHSShioqtMZDfDzYLhYEcSFYiRM+Mt80HyFU=;
        b=AkBW27UxtoAX2oJF1KbAjcWT1kNLgy8UHbc0UhaAo6wUJ3MHLEi8h51ytaylNp26+W
         pdMbPJlp6wjI1xGmm/wWVYpyZ4nefVw9bAx6Bg/cAODz17kIBIYWQxjosTvg++vLZ/dC
         S8K9c9sO8x7/LJvbzQ9nJkk6iuRbTvnnL/RVJYykN2BziVu+cNXSNDzLRug70io4z4Lx
         JIg2hhzuNcIJcA7ncxcb3yzIq0tFF1vUiD6cHBEnNgLIGHdlp2Cw5+ZaF1bDc2tfQmaq
         czZzfghki2xVq9dECGECkBVv2zurW7mUzSrVfTwrwpIMsAX/mzPv0GCheaS1gQ/RqbM+
         Bnkw==
X-Gm-Message-State: AOJu0YyQgqATJOUzKTpieAaDw7jxwWq8KSUfwB0EETwDDpQGrX8Eu4Oo
        rGhxUvQfeqrLE6ZiYqDZeOVH224njM1rF9QK
X-Google-Smtp-Source: AGHT+IH/SGjAn3d+l5/G5NjEXOZVb2wuBP+jsvbVT8g/CLAysp+5APFcI8N9wqPNt3gHjgUPk6FsEw==
X-Received: by 2002:a6b:a05:0:b0:795:16b8:85fc with SMTP id z5-20020a6b0a05000000b0079516b885fcmr6191833ioi.0.1693490474774;
        Thu, 31 Aug 2023 07:01:14 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id c11-20020a5e8f0b000000b007926ee42341sm402862iok.50.2023.08.31.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:01:14 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] kobject: Replace strlcpy with strscpy
Date:   Thu, 31 Aug 2023 14:01:04 +0000
Message-ID: <20230831140104.207019-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
v4:
 * Fixes errors reported by checkpatch.pl

v3:
 * Fixed weird indentation.
 * https://lore.kernel.org/all/20230830202021.4134348-1-azeemshaikh38@gmail.com/

v2:
 * Updated error message to remove @len which is errno now.
 * https://lore.kernel.org/all/20230830150136.3798414-1-azeemshaikh38@gmail.com/

v1:
 * https://lore.kernel.org/all/20230703180528.3709258-1-azeemshaikh38@gmail.com/


 lib/kobject_uevent.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..fb9a2f06dd1e 100644
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
+		pr_warn("%s: insufficient buffer space (%u left) for %s\n",
+			__func__, buffer_size, subsystem);
 		return -ENOMEM;
 	}

--
2.42.0.283.g2d96d420d3-goog


