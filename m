Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5557540BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjGNRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:44:17 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE1272B;
        Fri, 14 Jul 2023 10:44:11 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78362f574c9so84944439f.3;
        Fri, 14 Jul 2023 10:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356650; x=1691948650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbnXx32b0pw3Y6lPoCZenwP0EHedcl32z0w7atSgdAw=;
        b=mC88ucWZnOLMpokKIn1WZQsU+2fqqgAaN0R9N9WnRSS5QaFNSE05XGxXKdgkUELDmS
         7F95qXXPdVSVBbFwwB/qtMQYfhsAVnoUUSjlIgzs7976Nc0deYcuYQDu1ptmtSlkplBm
         Aovmbb94HBEnTt2cP7O0pohZ7U5mmBLschdgdmCtXRgX+qfnQgn64EIGmtwkW8kOmSak
         prb9+GvoHNaoMUbqoNdOLHrCpg8IH9E0MBVaH9r3cwXkJOWZtxN/5BMWcY/vpphzZekk
         dJDFcY28Xdlwq2i1tADCBdTxS844ou4Nr6/7cG2lzbCFxU/fDOiu2ZTZH1pCjTEZaQt4
         Odjg==
X-Gm-Message-State: ABy/qLaoabrK7ZtSpel8KoD1LGDV2Qwkepv+aTZld+TyCseBaWr/yvj7
        OpPnmYZs/OxeFLvOfEl5JG5kh8SIew==
X-Google-Smtp-Source: APBJJlF0b3rNTIdmTZAitWk9gWhvSQaYM66GBdxe+oNBcL54b38RFE7uy2lqSBfVBplWHKv8ftgiIw==
X-Received: by 2002:a5e:941a:0:b0:784:314f:8d68 with SMTP id q26-20020a5e941a000000b00784314f8d68mr5436360ioj.1.1689356650700;
        Fri, 14 Jul 2023 10:44:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w25-20020a056602035900b00783b0780bd8sm2812351iou.4.2023.07.14.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:10 -0700 (PDT)
Received: (nullmailer pid 4053799 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] counter: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:43:57 -0600
Message-Id: <20230714174357.4053541-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/counter/microchip-tcb-capture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index e2d1dc6ca668..975e431d1590 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <soc/at91/atmel_tcb.h>
-- 
2.40.1

