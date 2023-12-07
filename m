Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC1808DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjLGQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjLGQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:33:22 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C110013D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:33:28 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d3c9badf5so486764eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966808; x=1702571608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGrwVxWMmdELAdFPjeQCJvW6U+iyFUQZUzdG0JyYV9g=;
        b=u0PQv1q6whvCbIlroxNzRLS6sK65URWtCN7fiEVMm7GBL7Zo0PJNCCMaLWfzr9X7Kl
         PDQerq/5c9OfSaE7spElJU+/TizEFK+0kaSWWhH9ppwsExu1e2YqncPMfn4hiyjrDmzT
         Mum6TPrHFE1ZDJldapZfuJP2VfDrthfWlEO5TuVG4CUvXcMh9c9k1MOpbq1y/C+j5EFB
         RnwKrmh4piM/5dmfaHprZJGlahsNX9vgE0lm/HjqxxmWCGRLxehHQuTj35PjCDiqjUOz
         E73i2+3XapKRiCqZxl5goM/y+5BEVrpq/3UwduCTRThU3kpTtrdRvmeto1YsF6NZ/Sdd
         35XA==
X-Gm-Message-State: AOJu0YwRvGTsZzEXZjU7dh1LoYJN/2hPHdY+NTdiCOwJ2pt6TQfS3gbL
        OwjPGAB+fcHkjqlsi7QzoA==
X-Google-Smtp-Source: AGHT+IHJZI2RPY/K5Mky+6IKTxze943vDat+pn/1PgLr9AmycRYuVAPD80Clw1P3H9lWA+H4fuaB8A==
X-Received: by 2002:a05:6820:1622:b0:58e:2925:cef4 with SMTP id bb34-20020a056820162200b0058e2925cef4mr3077635oob.5.1701966808068;
        Thu, 07 Dec 2023 08:33:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u185-20020a4a57c2000000b0058df6ae23fdsm301623ooa.33.2023.12.07.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:33:27 -0800 (PST)
Received: (nullmailer pid 2729570 invoked by uid 1000);
        Thu, 07 Dec 2023 16:33:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kris Chaplin <kris.chaplin@amd.com>,
        Thomas Delev <thomas.delev@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] w1: amd_axi_w1: Explicitly include correct DT includes
Date:   Thu,  7 Dec 2023 10:33:18 -0600
Message-ID: <20231207163318.2727816-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/w1/masters/amd_axi_w1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/masters/amd_axi_w1.c b/drivers/w1/masters/amd_axi_w1.c
index 24a05c2de5f1..4d3a68ca9263 100644
--- a/drivers/w1/masters/amd_axi_w1.c
+++ b/drivers/w1/masters/amd_axi_w1.c
@@ -12,8 +12,9 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
-- 
2.42.0

