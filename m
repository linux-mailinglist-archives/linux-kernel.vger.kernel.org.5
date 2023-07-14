Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC8754099
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjGNRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjGNRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:40:27 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F03A84;
        Fri, 14 Jul 2023 10:40:26 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7835e5fa459so85909739f.2;
        Fri, 14 Jul 2023 10:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356425; x=1691948425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb4dR+z+OTgQHnETYo6UxSYgXlKF4+KcDIOkEstmL88=;
        b=WWRgi3LgRp2uUy3NaxYM4yySlWTYlvGZbfYObAPl4igxHvgA/8Hji2vFaLyyVjFzIL
         18U7/TvkstDzpxNJ+KUWP9xoF7Bym0+JOavkn4MV9QXYYb/0EEjk4AfUd3t1cbP0d/bT
         aEA+uDvfmy01/cUpBAnSGwKq5WhFDzAT5IqJdqmj8gx0KGtQ/pTKsRxCRBrvupPA4i2v
         nIo9fLozf/fJwHPWmhVnjofH0Q5CQCnBS2C1W6bxvNkc4Bin+TwmtFavN+piInf2K1UQ
         2mBKi95JP4Dc5vf+dZLzl/3XFHxqUBjAQpBw6SHXgcyGXViX+8Rb5bwc25Jutzt/69o8
         2eEg==
X-Gm-Message-State: ABy/qLav7WPQE1QaLpBzKsJKqe4ajeEwvGvChctxJbcGQZLG72HE/31y
        gWJUtxEoAmpNfIbxbwa9C2TnbdUULA==
X-Google-Smtp-Source: APBJJlEBL3vIYFO5LMg3/N8C4xffY/g7NVOhko+tf5h+Zi20xBg5HDeMdJ4KgecQvDnjn4wWMSFFdQ==
X-Received: by 2002:a6b:3c03:0:b0:783:7275:9c47 with SMTP id k3-20020a6b3c03000000b0078372759c47mr4957903iob.7.1689356425225;
        Fri, 14 Jul 2023 10:40:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x11-20020a02ac8b000000b0042bb13cb80fsm2741577jan.120.2023.07.14.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:24 -0700 (PDT)
Received: (nullmailer pid 4039894 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:20 -0600
Message-Id: <20230714174021.4039807-1-robh@kernel.org>
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
 arch/arm64/kernel/cpuidle.c | 2 --
 arch/arm64/kernel/pci.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index d1f68599c29f..f372295207fb 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -9,8 +9,6 @@
 #include <linux/acpi.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/psci.h>
 
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..f872c57e9909 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -11,8 +11,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/of_pci.h>
-#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
-- 
2.40.1

