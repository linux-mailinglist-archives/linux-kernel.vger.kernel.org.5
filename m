Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767917D73E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJYTJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:09:09 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68507BB;
        Wed, 25 Oct 2023 12:09:04 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b2e22a4004so20526b6e.3;
        Wed, 25 Oct 2023 12:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260943; x=1698865743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diZnW8kdNsKvHujvt7WxRnsVerr3Lfx5/qdqU5i3RQM=;
        b=s7LyCyCsTKA6RpIz3Ms21tR3u8UAmJ2afX+8t+Uc0HPwbgI6lSB92wWNkUp+7py6Gy
         zo3jMb3Ev1x5WD6WrX06fl1+f4iGKBLKfXt4woQ/SsRlNkRZSvYcEbge8K2OyZD3Nb0E
         NoiYtVC8i4rJ8WJD+w8U1pCByC8z+aIaQZVNIhNHMPKwHzfUFj8S55fBtDtmKDK8xrGD
         FqyrXGW6xPtdnyX4quwoRfnmluGCO9G6u6BrjS6FkCDlP7XxKnVCqg5jVijelkYzJKh5
         w9veDbRqrJu5FeNL/sKgo0RM6DDjs32Cy4O64sV0dcTGzIlmD+OTmxRiI93IDdzPIPnu
         KVuQ==
X-Gm-Message-State: AOJu0YxERgshNZWrCHku6URz/t0MJqbZUuv1ou/WLze7XUxJb8mODAc4
        eWVazPG4MZP33jtBWtfIfg==
X-Google-Smtp-Source: AGHT+IGNhdbpT+nTTR3so/ZeRMM1OFJOCFE1ff2Dp4BJtCMeBb5k4sQ3Nat0pfxKNYWMHJQT/pexeA==
X-Received: by 2002:aca:220e:0:b0:3ae:5e0e:1669 with SMTP id b14-20020aca220e000000b003ae5e0e1669mr17480795oic.42.1698260943637;
        Wed, 25 Oct 2023 12:09:03 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k5-20020a0568080e8500b003afe5617691sm2457409oil.12.2023.10.25.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:09:03 -0700 (PDT)
Received: (nullmailer pid 904131 invoked by uid 1000);
        Wed, 25 Oct 2023 19:09:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] leds: syscon: Support 'reg' in addition to 'offset' for register address
Date:   Wed, 25 Oct 2023 14:06:19 -0500
Message-ID: <20231025190619.881090-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register-bit-led binding now also supports 'reg' in addition to
'offset' for the register address. Add support to the driver to get the
address from 'reg'.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
The binding change landed, but v2[1] was never applied.

[1] https://lore.kernel.org/all/20210913192816.1225025-3-robh@kernel.org/

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

