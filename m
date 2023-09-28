Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF387B18B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjI1K56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjI1K5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:57:55 -0400
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701219D;
        Thu, 28 Sep 2023 03:57:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3256088|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.42984-0.00186958-0.568291;FP=7333335452469810594|1|1|20|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=31;RT=31;SR=0;TI=SMTPD_---.UqYH8Bg_1695898659;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UqYH8Bg_1695898659)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 18:57:47 +0800
From:   wangweidong.a@awinic.com
To:     girdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        herve.codina@bootlin.com, rdunlap@infradead.org,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, ajye_huang@compal.corp-partner.google.com,
        harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
        yang.lee@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
        liweilei@awinic.com, yijiangtao@awinic.com, trix@redhat.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH V6 01/10] ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support
Date:   Thu, 28 Sep 2023 18:57:18 +0800
Message-ID: <20230928105727.47273-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928105727.47273-1-wangweidong.a@awinic.com>
References: <20230928105727.47273-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add two properties, the "awinic,audio-channel" property and the
"awinic,sync-flag". The "awinic,audio-channel" is used to make
different PA load different configurations, the "awinic,sync-flag"
is used to synchronize the phases of multiple PA. These two properties
will be read by the corresponding driver, allowing multi-PA to
achieve better playback effect.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/awinic,aw88395.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 4051c2538caf..b977d3de87cb 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -32,11 +32,25 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  awinic,audio-channel:
+    description:
+      It is used to distinguish multiple PA devices, so that different
+      configurations can be loaded to different PA devices
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+
+  awinic,sync-flag:
+    description:
+      Flag bit used to keep the phase synchronized in the case of multiple PA
+    $ref: /schemas/types.yaml#/definitions/flag
+
 required:
   - compatible
   - reg
   - '#sound-dai-cells'
   - reset-gpios
+  - awinic,audio-channel
 
 unevaluatedProperties: false
 
@@ -51,5 +65,7 @@ examples:
             reg = <0x34>;
             #sound-dai-cells = <0>;
             reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+            awinic,audio-channel = <0>;
+            awinic,sync-flag;
         };
     };
-- 
2.41.0

