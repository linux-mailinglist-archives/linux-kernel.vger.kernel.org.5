Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877BF754175
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjGNRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjGNRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:51:13 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D95272A;
        Fri, 14 Jul 2023 10:50:48 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3460e9f2376so9771105ab.1;
        Fri, 14 Jul 2023 10:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356898; x=1691948898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CARk8m5bFpPq/qmxx/0x+uVWSJmnqQA5gBA6mVg1YY=;
        b=diyBi0bkLM5ZakuEHrvGJ0AQ4p2lG3emBnZ93nH/qroIHY2meWOOWHCe6uSC3ABzEQ
         pQvokE6KfYIIcNziEQO72UuYmV2IqKNXlwgd53+SBRCd5huCca3MO7dxKm/nruPzoNfb
         bJ/nN32EuOmbhO3Gb1UoTO7aM7PQgi//huLWV6auTwKZ1GR7TVt+Yvq3U4uUugkaj8Hy
         d0tQ9bKI+TG/b2gf9uf7j6hGj+IC2pYeXvUpbIgFD+X8RFMxIG8z6W6c33LVEyGKYqnp
         UoX1MvU6Eamcbfd9W3Vzhjftoxp2Nb03SlFc/webzgdj0P1infCpR/qwewZgcnhVNev7
         8swQ==
X-Gm-Message-State: ABy/qLYQsWcpOO89ibDja4emCVojN5LH2E2TWkdhVq6syTBj4Q4rcZqv
        zOD1FeS4w0Oqi9/206IpSB6Y9Scw0A==
X-Google-Smtp-Source: APBJJlGcD/3pKc5eNyHzvRsU4zvcN5jdPy/HEERL4NjbsHsOarT+fg6OcnCSzkS2GsbRcX1zR8XPpA==
X-Received: by 2002:a92:cc4c:0:b0:347:7059:386c with SMTP id t12-20020a92cc4c000000b003477059386cmr5089789ilq.16.1689356898318;
        Fri, 14 Jul 2023 10:48:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r5-20020a92d445000000b00345f89a2718sm2893815ilm.48.2023.07.14.10.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:48:17 -0700 (PDT)
Received: (nullmailer pid 4060705 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mux: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:54 -0600
Message-Id: <20230714174754.4060608-1-robh@kernel.org>
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
 drivers/mux/core.c | 1 -
 drivers/mux/mmio.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 990e7bc17c85..775816112932 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -19,7 +19,6 @@
 #include <linux/mux/consumer.h>
 #include <linux/mux/driver.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/slab.h>
 
 /*
diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 245bc07eee4b..fd1d121a584b 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -10,7 +10,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mux/driver.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-- 
2.40.1

