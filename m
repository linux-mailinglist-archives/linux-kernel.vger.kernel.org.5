Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC397C8EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJMVTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:19:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E195
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:19:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a538026d1so3583032276.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697231942; x=1697836742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4+CtI556J9JFEvOEeYrRcVrS1TVGZF3yEU9Xn9OFZQ=;
        b=NjvuZHHp3Q2oe5XUefCBd9GTF09bhdNGJvhVrebFTQuck8UWquJp/r0TOx+nGR9ImN
         DVZIfmrsONZ3Za8rSoamW3RZ1TsPAZjKe7kRzmQHJpMelJwQBrE1oIO+XjVrRQ3bWRN9
         4kf6m8Bwo75xMGMRCNMIrEGqWu/7H6u46TbBO/UjGhwY0qhqnu6muxmCYMTV0Pq8QSRE
         v6xRivdZxugkAcFHPe3UwFHS2cynuCW9H0UTXrnKGozgs66IdGKes4WMQ47Or2P3aPLQ
         ttFSSNcA5oJATjcJe1BNdRzjopz4QXDRlG2RAiJNbFDEkd39543JBOqAlgp5OM4Qt29A
         3mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231942; x=1697836742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4+CtI556J9JFEvOEeYrRcVrS1TVGZF3yEU9Xn9OFZQ=;
        b=gTLtqhV6VRIT6wjRsfqhQLkXkzIR8d6Pa1TTuU+6xcEziDKcTqkcj6M6+Y3sI7nfw7
         oSYPC+mJy6wHSFYMcGJxe8hLAIc7rxRwoRxAjuuLKgGNCHMajyNrCmHYKZXp1NGPdymp
         oizLtMvUDLrxGg9LIAZ3pP+R4dPpPHIOsQJzUWu8JCcyIT4/YuNjY6gXRQxOmaYXHx0y
         DHH26Kytm7ers+MogLIZ613YGH5qp7XqhaqpQNJHOJz0lX+5dNQZFZZoKNMquXAeo0/C
         ddmY/Sz5a24ZuXldeDqh8Jb1J9s25qIxniHuBg2OFTNiNLOLBCK7jT9cbJItRfBxjOI6
         +VNA==
X-Gm-Message-State: AOJu0YxqnZBgYkqi0RGqnu9fZIIDHauVc8Fa4cbHDKI3Aqz4BorSydns
        Tpz8r8bgo/yhNZzKb4Zm9TMUPTvNxm1xF36gvg==
X-Google-Smtp-Source: AGHT+IEFb+Qs6BTE+zyGOCrDNzNGdtyo01KqMmcNmLj5isa5JH6R18iurGgDqKsZiv3/Xb0t9jJcuSPS0a+wC2ky9w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3287:0:b0:d9a:57da:f947 with SMTP
 id y129-20020a253287000000b00d9a57daf947mr240255yby.10.1697231942564; Fri, 13
 Oct 2023 14:19:02 -0700 (PDT)
Date:   Fri, 13 Oct 2023 21:19:02 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEW0KWUC/x2NwQ6CMBAFf4Xs2U0oKCb+ivFQ21fZSCrZbUBD+
 HerhznMZWYjgwqMLs1GikVMXrmKOzQURp8fYInVqWu73rWuZyuaw/zhqLJAjTMKr6KYYMa+jD+ G58SSpXDglOL9eIrnAT5Rjc6KJO//8Hrb9y8Km03XgAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697231941; l=1572;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OSQ5/H1d2DSJHA3zq39nDy1jyEwcj6KdEZ8Bf85001Y=; b=rK8wm0iB2qBgcr7yAjY8LjP8bH4QTKD95phQLYodnopUNZNaD494aasGTBmnNvqeAdPqZ7GPn
 ANHCGppFYCEDI4mQKlnrCmk0WDBjgv6VrZFvqJH39tvoq2tMaXQyncq
X-Mailer: b4 0.12.3
Message-ID: <20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com>
Subject: [PATCH] ath6kl: replace deprecated strncpy with memcpy
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
[1] and as such we should prefer more robust and less ambiguous
interfaces.

The affected code's purpose is to truncate strings that are too long
with "..." like:
foobar -> fo...

The lengths have been carefully calculated and as such this has decayed
to a simple byte copy from one buffer to another -- let's use memcpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ath/ath6kl/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 201e45554070..15f455adb860 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1677,7 +1677,7 @@ static void ath6kl_init_get_fwcaps(struct ath6kl *ar, char *buf, size_t buf_len)
 
 			/* add "..." to the end of string */
 			trunc_len = strlen(trunc) + 1;
-			strncpy(buf + buf_len - trunc_len, trunc, trunc_len);
+			memcpy(buf + buf_len - trunc_len, trunc, trunc_len);
 
 			return;
 		}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-ffdb45d76eaf

Best regards,
--
Justin Stitt <justinstitt@google.com>

