Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7801B7B03B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjI0MRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjI0MQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:16:59 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B3192;
        Wed, 27 Sep 2023 05:16:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3310761|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.42984-0.00186958-0.568291;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=30;RT=30;SR=0;TI=SMTPD_---.Upkf33f_1695817005;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Upkf33f_1695817005)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 20:16:53 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        shumingf@realtek.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, harshit.m.mogalapalli@oracle.com,
        liweilei@awinic.com, yang.lee@linux.alibaba.com,
        u.kleine-koenig@pengutronix.de, yijiangtao@awinic.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/8] ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support
Date:   Wed, 27 Sep 2023 20:16:27 +0800
Message-ID: <20230927121634.94822-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927121634.94822-1-wangweidong.a@awinic.com>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

