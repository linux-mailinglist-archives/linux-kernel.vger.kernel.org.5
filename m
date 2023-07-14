Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23675409E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjGNRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjGNRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:40:23 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89035A4;
        Fri, 14 Jul 2023 10:40:23 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-78372b895d6so89133939f.2;
        Fri, 14 Jul 2023 10:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356422; x=1691948422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kHAerUkbs1RohJjOwCTFu4xlcT9S1s0/Let059Z2xg=;
        b=CupngxT0p+NFdPJ5HH0jmIqofC4fTXb9nnC867pZvqLUlsy6GepmQLmzuWTVGRQWdo
         NycU8wmvOdqMOOu/u4mM1P7qdb5cx/n/Vc6j3yP2fbQY7t7LJ6FdIq4iacx57+a3a2mK
         CuUiqpwBV91YMgDT6xyHJKU6qyh6rmpUL/rFRK/swnHMv4JmUuMIYPNL7llSauLnBuhA
         Q+f5SEsiLe1vaslphyLJMu4yi1OuniTaQIRtDjGn0SK9pTocf4zWninrEPYeTdDIaqM7
         rHGdu7HR4FaZGCqSOe95e+qMpN9GVhaDusmwywxlq7AL2XD2Kh5h9bYirG/vK7Z9bfZB
         rhHQ==
X-Gm-Message-State: ABy/qLbQGHBt/EDCEwOszjnggYmx6KEvGUEH7/8PKUJssFrd9zcfcATj
        EQzS6Ztarr4usJQBHwKvXQ==
X-Google-Smtp-Source: APBJJlFzSkB1qa3MKPkKdeVSqv6+ocZW+jua27gEw/v/06Z0vShwRdeeMZ9Q8qyEEEnAjtOwOcYg5A==
X-Received: by 2002:a6b:d90e:0:b0:783:67a3:a69f with SMTP id r14-20020a6bd90e000000b0078367a3a69fmr6393180ioc.18.1689356422263;
        Fri, 14 Jul 2023 10:40:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y3-20020a6be503000000b00760f256037dsm2825959ioc.44.2023.07.14.10.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:21 -0700 (PDT)
Received: (nullmailer pid 4039743 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:13 -0600
Message-Id: <20230714174014.4039560-1-robh@kernel.org>
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
 arch/arm/kernel/devtree.c | 1 -
 arch/arm/kernel/setup.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 264827281113..fdb74e64206a 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/smp.h>
 
 #include <asm/cputype.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c66b560562b3..15eca804239e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -15,10 +15,10 @@
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
-#include <linux/of_platform.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
-- 
2.40.1

