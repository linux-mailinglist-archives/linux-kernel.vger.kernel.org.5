Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959BC7B6E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJCQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbjJCQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F791
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C8C433C9;
        Tue,  3 Oct 2023 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696350737;
        bh=sjh9BGA1nsCUJfo4UKIgAo5O6d5+5ra7VbGEXelDVqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Yz+XCHNJ79P10SM8ZkqFGI5eLP2S2oVNmwc8BfIGAmXrO8QO+CCPBPrdY698nuUGW
         oqBW5ay34H1/tLD5g+17rZsQdmKWhTRP0K8jOFZv6OIA20DuzsFhuTaVRVfpQH2dPD
         qQ6Tu35VrlO9kg03zMGatkCxyVdoncz4sshKMUGMzWbgSETPeTPsN6Pdnw/Pa5M6wv
         Vh08uAsjxO/d+1VZuWUbpcRtsYxY6cvgre7UwDbGS8kxnzBo+7Thfvl4+7ZD7AOBNu
         2m8pd+0RTZDUgKOvN/JKd2+1jJY4nbnthCBWAzUPmZVv+Pwlj/Hp4K8AGRq70OwV4z
         NssPctnmuWf6g==
Received: (nullmailer pid 771085 invoked by uid 1000);
        Tue, 03 Oct 2023 16:32:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: aoa: Replace asm/prom.h with explicit includes
Date:   Tue,  3 Oct 2023 11:32:02 -0500
Message-Id: <20231003163209.770750-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/prom.h should not be included directly as it no longer contains
anything drivers need. Drivers should include of.h and/or other headers
which were getting implicitly included.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/aoa-gpio.h                | 1 -
 sound/aoa/aoa.h                     | 1 -
 sound/aoa/codecs/onyx.c             | 1 +
 sound/aoa/codecs/onyx.h             | 1 -
 sound/aoa/codecs/tas.c              | 2 +-
 sound/aoa/fabrics/layout.c          | 3 ++-
 sound/aoa/soundbus/core.c           | 2 ++
 sound/aoa/soundbus/i2sbus/control.c | 1 -
 sound/aoa/soundbus/i2sbus/core.c    | 1 +
 sound/aoa/soundbus/i2sbus/i2sbus.h  | 1 -
 sound/aoa/soundbus/soundbus.h       | 2 +-
 11 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/aoa/aoa-gpio.h b/sound/aoa/aoa-gpio.h
index 54f9a78fa08e..77ae75d7594c 100644
--- a/sound/aoa/aoa-gpio.h
+++ b/sound/aoa/aoa-gpio.h
@@ -9,7 +9,6 @@
 #define __AOA_GPIO_H
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
-#include <asm/prom.h>
 
 typedef void (*notify_func_t)(void *data);
 
diff --git a/sound/aoa/aoa.h b/sound/aoa/aoa.h
index 3d2d03ff6337..badff9f7cd54 100644
--- a/sound/aoa/aoa.h
+++ b/sound/aoa/aoa.h
@@ -7,7 +7,6 @@
 
 #ifndef __AOA_H
 #define __AOA_H
-#include <asm/prom.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/asound.h>
diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index a8a59d71dcec..e90e03bb0dc0 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -30,6 +30,7 @@
  */
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");
diff --git a/sound/aoa/codecs/onyx.h b/sound/aoa/codecs/onyx.h
index 6c31b7373b78..bbdca841fe90 100644
--- a/sound/aoa/codecs/onyx.h
+++ b/sound/aoa/codecs/onyx.h
@@ -8,7 +8,6 @@
 #define __SND_AOA_CODEC_ONYX_H
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
-#include <asm/prom.h>
 
 /* PCM3052 register definitions */
 
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index ab1472390061..be9822ebf9f8 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -60,10 +60,10 @@
  */
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
-#include <asm/prom.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 850dc8c53e9b..0cd19a05db19 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -7,9 +7,10 @@
  * This fabric module looks for sound codecs based on the
  * layout-id or device-id property in the device tree.
  */
-#include <asm/prom.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include "../aoa.h"
 #include "../soundbus/soundbus.h"
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 39fb8fe4e6ab..8f24a3eea16b 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include "soundbus.h"
 
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
diff --git a/sound/aoa/soundbus/i2sbus/control.c b/sound/aoa/soundbus/i2sbus/control.c
index 7d3abb8b2416..a003ef06de63 100644
--- a/sound/aoa/soundbus/i2sbus/control.c
+++ b/sound/aoa/soundbus/i2sbus/control.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 
-#include <asm/prom.h>
 #include <asm/macio.h>
 #include <asm/pmac_feature.h>
 #include <asm/pmac_pfunc.h>
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 51ed2f34b276..3f49a9e28bfc 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
diff --git a/sound/aoa/soundbus/i2sbus/i2sbus.h b/sound/aoa/soundbus/i2sbus/i2sbus.h
index e86fdbb3b4c5..7a3cae0d6c26 100644
--- a/sound/aoa/soundbus/i2sbus/i2sbus.h
+++ b/sound/aoa/soundbus/i2sbus/i2sbus.h
@@ -13,7 +13,6 @@
 
 #include <sound/pcm.h>
 
-#include <asm/prom.h>
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
 
diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
index db40f9d042b4..877cbad93f12 100644
--- a/sound/aoa/soundbus/soundbus.h
+++ b/sound/aoa/soundbus/soundbus.h
@@ -7,7 +7,7 @@
 #ifndef __SOUNDBUS_H
 #define __SOUNDBUS_H
 
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <linux/list.h>
 
-- 
2.40.1

