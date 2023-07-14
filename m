Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C9754186
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjGNRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjGNRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526EF35BD;
        Fri, 14 Jul 2023 10:52:00 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34642952736so9742245ab.3;
        Fri, 14 Jul 2023 10:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356996; x=1691948996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Zl9ZOznQn0z/OyvCDvuTYi3+h4lEQZHsyG8cOFSOc4=;
        b=UMYJ96ozF+0SIe4quJoX52ECLx3VaiRKC5AslwyKwjesNVre5X80h87qTyMbYAeeWC
         0fbE7M3GVD+jxjSaDHBylML27YaC1cTnwEENVtfFCY/c41Rav/DXe/rSKPwxBRW5SplN
         BdBHcvmX0kwNLMJXNRAxghAjQjYHu6NzXq4JPJdNYxLRkj5pKUBHzKfseX3NwhyX641N
         GQrrlK5tv32IdxON0PZ2e0eIxfTuAdt80opEz4QaDZyZXUmvByMQzHR4HppohwHPrQAI
         PFoZX4ZuGoeUp97P1q45Kf7AJ45MTclSEE+cjFebz+ui7oQmtvnWN7RTYW9Cc77ShABS
         txqg==
X-Gm-Message-State: ABy/qLbh+UCAgo/6zzDTApF9lxWvrAEBWLVC/3d3foNTN/BAG9dQEook
        +SfGqUd18gZz55zw3EM4iw==
X-Google-Smtp-Source: APBJJlHyhOQHM8DYxUbkCpRl+VNuf7Fk5/wUH7gPm88oLEInYJkKFUKSDSTtUF7PbOeG9gGJZIAX0Q==
X-Received: by 2002:a05:6e02:933:b0:346:50ce:d602 with SMTP id o19-20020a056e02093300b0034650ced602mr4857766ilt.1.1689356996535;
        Fri, 14 Jul 2023 10:49:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h7-20020a02b607000000b0042b1d495aecsm2711161jam.123.2023.07.14.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:55 -0700 (PDT)
Received: (nullmailer pid 4062949 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:09 -0600
Message-Id: <20230714174909.4062739-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
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
 drivers/platform/chrome/cros_ec.c          | 1 +
 drivers/platform/mellanox/mlxreg-hotplug.c | 1 -
 drivers/platform/mellanox/mlxreg-io.c      | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 8b7949220382..5d36fbc75e1b 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/slab.h>
diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index b7dcc64cd238..6ddfea0d4c5b 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -12,7 +12,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_data/mlxreg.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
index ddc08abf398c..83ba037408cd 100644
--- a/drivers/platform/mellanox/mlxreg-io.c
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -11,7 +11,6 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_data/mlxreg.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-- 
2.40.1

