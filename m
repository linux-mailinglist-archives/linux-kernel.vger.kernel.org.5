Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9B7541FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjGNR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjGNR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:58:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E493AAE;
        Fri, 14 Jul 2023 10:57:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3458a08310aso9713395ab.3;
        Fri, 14 Jul 2023 10:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357099; x=1691949099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44RGqmRByB++x0pZyV4QqL+0qOBYQ4NNQZsvR4a019o=;
        b=fMmUUyEmP0KZCUKGJc9zpSfzaNjBNV/kWO9aLt5y8KsZeghmf8f9f0w+t8Ul3M/lT9
         E+p1fubO5i7nFcPeCF8X5j59ATal0ZN0y0HzBslKqxzFCsE8sq8I4dXz0d/xIu2cXc0q
         bthq8R5/vs6OKEfKOlRRMSo7Fkb3bvnmaQUXDunFmzPmj8OjKrZYRAWQ25s56gbkGzHj
         9o/SqVWi7pUS+lVXQ0eRAfbH1Gyr0TTaiJIL6xqcSEbZF5J2/s+BSHtFvZMOtcufDxah
         Bdfr4Tzr0wrlTZ+cYmSF9+VzJJmlwynx+Ynb9r4S7YQnhMWiOux8lgC8tYTW/8mK8FUz
         JNKA==
X-Gm-Message-State: ABy/qLY9cApvsEPjo2fzAv8i+QN50qbS4/ZLeUOuazbxEWqPl6dY4FQV
        jG3VX56Gdg3TgF1JbqMg4qD+qwABmoli
X-Google-Smtp-Source: APBJJlFe8SbQNbUlRMjsEqT0wEurF1xR5zSupzRA6oiQW5V/ooxSS6/xkhT3s1UdMoYitGoipqxc+w==
X-Received: by 2002:a92:d181:0:b0:346:3920:5df2 with SMTP id z1-20020a92d181000000b0034639205df2mr4817458ilz.21.1689357098955;
        Fri, 14 Jul 2023 10:51:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q16-20020a056e02079000b00345d5a3748csm2855615ils.63.2023.07.14.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:38 -0700 (PDT)
Received: (nullmailer pid 4067080 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: amlogic: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:23 -0600
Message-Id: <20230714175124.4066972-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/amlogic/meson-canvas.c      | 1 +
 drivers/soc/amlogic/meson-ee-pwrc.c     | 3 +--
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 3 +--
 drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index 383b0cfc584e..b6e06c4d2117 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/soc/amlogic/meson-canvas.h>
 #include <linux/of_address.h>
diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index f54acffc83f9..cfb796d40d9d 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -4,13 +4,12 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 5d4f12800d93..33df520eab95 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -5,13 +5,12 @@
  * SPDX-License-Identifier: GPL-2.0+
  */
 
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <linux/module.h>
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 25b4b71df9b8..b994f03380b0 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -7,7 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/meson-a1-power.h>
-- 
2.40.1

