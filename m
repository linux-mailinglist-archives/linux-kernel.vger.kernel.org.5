Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A27F544E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbjKVXKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjKVXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:10:45 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22ED67;
        Wed, 22 Nov 2023 15:10:29 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b09035b850so9353439f.3;
        Wed, 22 Nov 2023 15:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694628; x=1701299428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nObZTQG+vS/ySodGEz6Iv/w17ZhPrcgGwx4FOFJsZzw=;
        b=XqRHBWuSXleIR7gQxiEQ2sGA9nH+WTUjyWit9qDN0AkDRP4Eaj+/zmJTNbMwCsEOL1
         RWCrsU/7KwQ5yYOT8ww4V22uO6qkd4RZoNOwdILTzcfoIC4q9LwP+MWlH1EgeBMXOYGk
         kRXk5QNUAuXYUqU8j9lYhvZoIZVWYDxcwwnSqMZU7Jhdryg5oJ9dVOQcqas7EG/h3rNj
         y8YUeuRKo1crVBXTZwDy9UTOZyrPdeVNoNDcYjgyAzokK1MrCtikT7W5pINAH5KrOIJS
         MuxXM8sEEbQciBCygO2kuA0uKrXV/w0EE0H/orRC8udZrr9FdaRCLyZ+R57KX9qA7/Cz
         xJHg==
X-Gm-Message-State: AOJu0YwM/3XoF8Uwi2tTXPd8kZ9/YpUDpbCRyUNuOI+Z7iZmkQm75rec
        GkjnRPDl+6X1c/K9Awsph/7G+KfmTw==
X-Google-Smtp-Source: AGHT+IFvKpBEdYZ9/KyZEiuYK/DH0zs9MuSIB/uw5bxPP6OJc7zL6iD5sdevE3Th0g/Jx7YFZ/XesQ==
X-Received: by 2002:a05:6602:4194:b0:7a9:571c:5694 with SMTP id bx20-20020a056602419400b007a9571c5694mr4404420iob.10.1700694628566;
        Wed, 22 Nov 2023 15:10:28 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g14-20020a056638060e00b004664a5a22d2sm115195jar.83.2023.11.22.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:10:28 -0800 (PST)
Received: (nullmailer pid 2847984 invoked by uid 1000);
        Wed, 22 Nov 2023 23:10:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] leds: syscon: Support 'reg' in addition to 'offset' for register address
Date:   Wed, 22 Nov 2023 16:07:55 -0700
Message-ID: <20231122230754.2844665-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register-bit-led binding now also supports 'reg' in addition to
'offset' for the register address. Add support to the driver to get the
address from 'reg'.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
The binding change landed, but v2[1] was never applied. The last 
resend[2] may have missed kernel.org addresses.

[1] https://lore.kernel.org/all/20210913192816.1225025-3-robh@kernel.org/
[2] https://lore.kernel.org/all/20231025190619.881090-2-robh@kernel.org/

 drivers/leds/leds-syscon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index 360a376fa738..d633ad519d0c 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -81,7 +81,8 @@ static int syscon_led_probe(struct platform_device *pdev)
 
 	sled->map = map;
 
-	if (of_property_read_u32(np, "offset", &sled->offset))
+	if (of_property_read_u32(np, "reg", &sled->offset) &&
+	    of_property_read_u32(np, "offset", &sled->offset))
 		return -EINVAL;
 	if (of_property_read_u32(np, "mask", &sled->mask))
 		return -EINVAL;
-- 
2.42.0

