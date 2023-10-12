Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF847C78D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442954AbjJLVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442911AbjJLVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:53:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044DC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:53:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bcbb95b2so22320307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697147584; x=1697752384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTkEOzvlwSRqd6Swcq6Hh8KnurUwVBxQe6czHRUN7YA=;
        b=FtNoL2noI3RqR2YnxNeaa8qvVLPTp1yVrdLnAP7wKepMJr2uoStoUFLVA/Ej1FRCx9
         JBPTaJAo/FOU/AmLAsazfYh/exqjHQbu3ZHsg1hklq3LtQ7pnUePUXNjcaPrsr32CjI8
         jfyGQCelOcGO6v0BYZTTm4nphF5qvkweVX7zuDuspmyOIgJDPKb/2YDqIFTrn2yxipVi
         U7mSTxQ1WxBTsusu8sCsKloCD2mIawIxKIVPL0S40zPeD1MC7EbArJfuMlVZ8/MOvV/4
         rD5YAEfckx+VELw0saMifUBbrxLcQW0kk+y67uF7MTH3chKdcxngREoQKi1elLzfUEX6
         qdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697147584; x=1697752384;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTkEOzvlwSRqd6Swcq6Hh8KnurUwVBxQe6czHRUN7YA=;
        b=kKgGUBjGtYxSaLv3sp5JLpE2UVZSjz827+01A2MTB4BNlC0XEuA0nsRX3zFwEcO732
         eoB4iGibBuSKxINZXNHdT55h2w+hNXPi3dlKe/UKbkoriYVIWDakQtkkEqnqMivkSYVa
         b8f8+MBaZxDgS/9Q88Z2HVTBfaPHRHXWaG2Zob/bkCC9Oxj8qkMpWNTnQUdMqWpYmoD/
         Camv9Bz5ZG5nFMOh6K7JhT3fjCDFLLmErkeGxjclsBe2uI7JJcnrd6oK1BAAgeFlVtfw
         jDhfX1IymIP3Rl87H66zXg2ZtX5VW6ezIxMCrD3QFojMi/Tz5425PeUi2f7mrY0/0tHC
         rjqA==
X-Gm-Message-State: AOJu0Yxs/MCTPGEp6uHPoiH8FPh0uOrid5+sg4OJ0K7enHiXaWh4r0nP
        HYCyg9n7Izj8GBfadd5oD5s4FttfWGCmF0xJnA==
X-Google-Smtp-Source: AGHT+IH3hZtlVts0HOlSErW//1wUr4F64NtzYskB5unXmRyXv32EwZy/FojwDmAhgCdBFp8rnYnYhUpfhdYfQxR12w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7e4c:0:b0:584:41a6:6cd8 with SMTP
 id p12-20020a817e4c000000b0058441a66cd8mr501646ywn.8.1697147584487; Thu, 12
 Oct 2023 14:53:04 -0700 (PDT)
Date:   Thu, 12 Oct 2023 21:53:03 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL5qKGUC/x3NQQqDMBBA0avIrDuQREJKryJSbDLWWTSGGZWKe
 HeDy7f5/wAlYVJ4NQcIbaw85wr7aCBOQ/4ScqoGZ1xrjXWoi+RYdkzCG4lipgXLtOMv8fz+rIo RzWCSp2fwwTqooSI08v+edP15Xjy38kl0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697147583; l=1868;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vdQUeoyWeauGUEEyEYmjpmzS6T1B4Kyza0zZ2VuUMVU=; b=08rcTE44cKhSckEbxhG3eLzKqTkBARP9qjlbUWs+AlqMspRHIZZZigeo48P5fBG2TNtbAKjvp
 D8L72jxZBnvDlw5D8Lnl4a3l+c5sqVGWu3+A9JBjMYWws5qQcY0Htn6
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
Subject: [PATCH] net: mdio: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect mdiodev->modalias to be NUL-terminated based on its usage with
strcmp():
|       return strcmp(mdiodev->modalias, drv->name) == 0;

Moreover, mdiodev->modalias is already zero-allocated:
|       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
... which means the NUL-padding strncpy provides is not necessary.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..6cf73c15635b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -506,7 +506,7 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	if (IS_ERR(mdiodev))
 		return -ENODEV;
 
-	strncpy(mdiodev->modalias, bi->modalias,
+	strscpy(mdiodev->modalias, bi->modalias,
 		sizeof(mdiodev->modalias));
 	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->dev.platform_data = (void *)bi->platform_data;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-mdio_bus-c-0a0d5e875712

Best regards,
--
Justin Stitt <justinstitt@google.com>

