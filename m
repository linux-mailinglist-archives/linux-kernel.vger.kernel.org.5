Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABD7B3656
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjI2PG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjI2PGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:06:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC811A7;
        Fri, 29 Sep 2023 08:06:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-4060b623e64so5166795e9.0;
        Fri, 29 Sep 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695999981; x=1696604781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+HDInQo6A1OIfSQ4kDLBbQAIE/uOQhrvXDem09PR3k=;
        b=lupwsMhYhrKqD+UUkkiBkP2KN8oPDTsweMZGxSt0FI6jY71+XWypyyRABzACjaFuZc
         gMh+IbK6iHqyvKr3DgpIMwQIcc5eEHS5A7e1UoNVP+pKHhMJqXfw293J4Qu4H73wuWK1
         ssUpbX9Im+FNl+z2rthvk4b8+6q4yis0rB/PZtKJq5pDMmwBFEHDq7zQ1o+DP1tzd3dV
         woknr0MvA+kSl66dtbhFgl4q4k3E9mZm2Kc7LBikzodaLIzG56PXEHU9yZ9NBhaN8Cjv
         EMvXYeKE8O/8H3Wcb25qLAb2cXm0ZG5PefHdziSFO1Yq2wHaYXC9qlDcRnEIPxcI6aub
         i69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695999981; x=1696604781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+HDInQo6A1OIfSQ4kDLBbQAIE/uOQhrvXDem09PR3k=;
        b=OPQj3w4Q2zQ7OBQUrsL/29dM8iL53ZjqxF7oS4m/NcS3RBnxrXByfBcBrT+UmLLu3C
         LiX9LvXjKKqdFcqJFemk5x7STFSU+TNXl+4e49pHdkLo8CmmDNEHgj1qewWCof0UCEsz
         aFGYGnzFKkrEm4SDeRjIlHrO+i30gQLHZN47PYua9kTgvCNd2z91ptKo6rWt6RzAJ8OO
         v3I7MWXb8y6iVtEx1DAwXnBWJUqLCYpqvyCsKRbsSwKc2buHbhoL74qVggmFt0TtwF3i
         +bAV3zDSr7Jw3F20EQF40QNalUq0fFIrzHYtZzSBqOZTbXTFaZIYCy0w+cSuaSW2bVT7
         GyCw==
X-Gm-Message-State: AOJu0YxXZhZK+DCUcXohq+GjefH2+VWXtYVdnFwYITLfU7awLd8L97Tv
        hKNaTz/xFwsuWNu+QtNqWjt6/toJ4ZX/8g==
X-Google-Smtp-Source: AGHT+IFajsTW5J93K/OzzdCwONkeonYv1BhbbEV7MBCbRDZMmPHOe8BVXYC6nzOe54XQkf98bAaeqA==
X-Received: by 2002:a7b:cd85:0:b0:402:ebe1:7960 with SMTP id y5-20020a7bcd85000000b00402ebe17960mr4202891wmj.2.1695999980586;
        Fri, 29 Sep 2023 08:06:20 -0700 (PDT)
Received: from localhost ([2a02:810d:1640:10d8:9259:8ee2:26ea:3669])
        by smtp.gmail.com with ESMTPSA id y19-20020a1c4b13000000b00405bbfd5d16sm1606110wma.7.2023.09.29.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:06:20 -0700 (PDT)
From:   Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Joerg Schambacher <joerg.hifiberry@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
Date:   Fri, 29 Sep 2023 17:05:55 +0200
Message-Id: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS5754/6 power amplifiers use the same pcm512x driver with
only minor restictions described in the bindings document.

Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
---
 Documentation/devicetree/bindings/sound/pcm512x.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index 3aae3b41bd8e..77006a4aec4a 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -1,12 +1,12 @@
-PCM512x audio CODECs
+PCM512x and TAS575x audio CODECs/amplifiers
 
 These devices support both I2C and SPI (configured with pin strapping
-on the board).
+on the board). The TAS575x devices only support I2C.
 
 Required properties:
 
-  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141" or
-                 "ti,pcm5142"
+  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
+                 "ti,pcm5142", "ti,tas5754" or "ti,tas5756"
 
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
@@ -25,6 +25,7 @@ Optional properties:
     through <6>.  The device will be configured for clock input on the
     given pll-in pin and PLL output on the given pll-out pin.  An
     external connection from the pll-out pin to the SCLK pin is assumed.
+    Caution: the TAS-desvices only support gpios 1,2 and 3
 
 Examples:
 
-- 
2.34.1

