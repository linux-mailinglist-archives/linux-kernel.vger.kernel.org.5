Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF378E099
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjH3U1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbjH3U0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:26:44 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2640659C;
        Wed, 30 Aug 2023 13:13:55 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-34dea77cbe6so484295ab.2;
        Wed, 30 Aug 2023 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693426044; x=1694030844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiuRhg6iucS3MVlpnxrmBmRRAVlZ0cE39FLIWdCqRaU=;
        b=RBKlX/EuKRC4xdJVhzqeY8LerJb35For/TT76Vfw6IadArw92CnRHihOVaOlHTMfEE
         JVlQJe7gFjhxm5dFlBsFrkKY/Zl2DZE2IIGqbwkhaudD4MWmF9SzjXONPr6FxyywzN+s
         t2yB8fsZE+B3bunhuwSZ7cRLLns9zmWCNrtsobvxeO8663lRwWEpWyLgXb7k7ooBh50m
         0avf80+LeVY+//+KsHzz6+GKlHl97hsuIZaU9LFRPKD601IG24SkftlonOzW3PSM6qy5
         C/0Kiqf4lBYpF6Ah6WR4WGRm4wM20xnKw5npyGxZBTwnZjdfoS1xZ7nJusDxxD+wJx8T
         cFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426044; x=1694030844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiuRhg6iucS3MVlpnxrmBmRRAVlZ0cE39FLIWdCqRaU=;
        b=T6A/NmWPkVZRgCbxm+pjH20T4oM4SMQX1roAuWvMjrFX7w9/KUMCVKfTZfU96ynx7c
         p+IBtCs9d5Lqb8xrGZ+HZ+I+ikaExjDMwtzGoSvF8qUzadDiPXtjr14VtsnMOui5fy30
         sLkrlmzGbQ+ikLDXkM4e9MGWbUjH8Sk/jLf0DZkD2bnViRHoOAYn266S8yoSRB1ywHlo
         Q5olRIWq9CYGxJpAsdH3UUN8BUh/Y/hTPLCRrCc6OA5rzOoRV3FGBY/ujFn1irlLNVas
         NA3tZ8d8GM8zVI+7IXebgU0qjY+L6ps0C2q8jt/d9UBRPF923lWm1J67F0W161tlUVAf
         5nfQ==
X-Gm-Message-State: AOJu0YyHA4ORlJ7pFsfArhJn0sP+S3krLtnLx/udxPZ0uCVbGpW8L4Bn
        TP3WN5vI7Fmhe1mDvWNEMHLjlksJBfD6TVLd
X-Google-Smtp-Source: AGHT+IGP53fksQFYKcMY7KGCfJfTN9Gs860Mx6hqvQHlSyYZDePZfzqa1ZUpVzj8rOeZCn08ZsMcTA==
X-Received: by 2002:a05:6e02:928:b0:34d:ee65:a8ce with SMTP id o8-20020a056e02092800b0034dee65a8cemr3499162ilt.19.1693426044046;
        Wed, 30 Aug 2023 13:07:24 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id em13-20020a0566384dad00b004302760aa6bsm4084994jab.4.2023.08.30.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:07:23 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: target: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 20:07:17 +0000
Message-ID: <20230830200717.4129442-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/target/target_core_configfs.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 936e5ff1b209..b3d2c14e2ea9 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;

-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
-		len = strlen(stripped);
 	}
-	if (len > INQUIRY_VENDOR_LEN) {
+	if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
 		pr_err("Emulated T10 Vendor Identification exceeds"
 			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
 			"\n");
--
2.42.0.283.g2d96d420d3-goog


