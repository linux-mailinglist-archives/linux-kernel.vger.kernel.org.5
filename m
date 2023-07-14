Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627B754234
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjGNSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjGNSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:02:11 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE203A8F;
        Fri, 14 Jul 2023 11:01:32 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b9c57c4d12so320489a34.1;
        Fri, 14 Jul 2023 11:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357624; x=1691949624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD3/Nwpd4WJ/So+epUL0cjI+Em8klOV8PbZ4Er1vnus=;
        b=Ck7kSOptwP3pT34bumevST9sCI/JWndHXXDJ64+hzdFl7KOHbkdO+irhDIXExaU+v+
         rzoiDM1igqDlamfyf3gDQfqvtgFkLYgvm+7Ts3dmhFJ+6/t3GmuNfMTuAmhixzNWooTl
         7Xz3wjAXRxS7NrEifP3Lwz8RyiIVUbDA6NltMzP3Kyue+P3JMJPSaJHcxQfTD4mW59Rp
         Nt43vzVrJINJfs7FYl6yQWlivEOd+RhnsKpTZ4fflB3IgsymAoOkw8w6CtAMNHOScdoJ
         9fHRe1sQlNXTzdbwAl8+tZWKzDnQfK316Azt5YTvJXJ3GRzndW/1LuIDpM023VnehahD
         Pmqw==
X-Gm-Message-State: ABy/qLb1+VnkiQSNL2uL5mjSTPLpFgRySsMuhkOU/AvW/s5bSE97I7Su
        y5iAueZXG6LW5LJUheISe8NIA2TbE0ye
X-Google-Smtp-Source: APBJJlFVG4BlnE8e/gefDbF6oc9DvjMZ4WAVgq8QrgRHEibJv0xhLoUNCJhTGiSxb3ZZ48aipTm60Q==
X-Received: by 2002:a05:6602:2565:b0:783:63d6:4cb with SMTP id dj5-20020a056602256500b0078363d604cbmr5308389iob.14.1689357158415;
        Fri, 14 Jul 2023 10:52:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a13-20020a6b660d000000b00786fe5039b8sm2805662ioc.46.2023.07.14.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:37 -0700 (PDT)
Received: (nullmailer pid 4068243 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: starfive: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:49 -0600
Message-Id: <20230714175149.4068174-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/starfive/jh71xx_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 7d5f50d71c0d..d3b78a619d40 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -10,7 +10,6 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/starfive,jh7110-pmu.h>
-- 
2.40.1

