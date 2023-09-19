Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D217A60AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjISLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjISLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:06:08 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3512D;
        Tue, 19 Sep 2023 03:57:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3465002|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.42984-0.00186958-0.568291;FP=7261269027978073474|1|1|19|0|-1|-1|-1;HT=ay29a033018047194;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Uj4ERmC_1695121054;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Uj4ERmC_1695121054)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 18:57:41 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        shumingf@realtek.com, ryans.lee@analog.com, 13916275206@139.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, harshit.m.mogalapalli@oracle.com,
        arnd@arndb.de, yijiangtao@awinic.com, yang.lee@linux.alibaba.com,
        liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/7] ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support
Date:   Tue, 19 Sep 2023 18:57:18 +0800
Message-ID: <20230919105724.105624-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919105724.105624-1-wangweidong.a@awinic.com>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
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

