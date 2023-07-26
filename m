Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D1763BED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjGZQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjGZQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:05:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C82723
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:04:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QG4hRq093677;
        Wed, 26 Jul 2023 11:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690387483;
        bh=RqPTPPm9p67tOnufA72AQDttXZi1O2KWrNR/xTOOx9U=;
        h=From:To:CC:Subject:Date;
        b=iD3i1fUODkLrm0cwtpbJaa9ULNOUuRR4S47hiEjqXYNTB+7rraACPdV3Mk+I0i/fM
         A1DW232syTMnR9z/dtH7XrgqoSiqtOTmwzCGrwYB9FXGL/sJ6MfbSO9ucpYMXIeWDV
         y7KLRMPPzDLkU3sf0u1egyVAzHptRVKBSJoNkii4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QG4h1T126459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 11:04:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 11:04:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 11:04:43 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QG4g64104809;
        Wed, 26 Jul 2023 11:04:42 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] ARM: keystone: Merge memory.h into the only file that uses it
Date:   Wed, 26 Jul 2023 11:04:40 -0500
Message-ID: <20230726160441.101566-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines in memory.h can go into the file that makes use of them.
No reason to have a header here, remove.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 12 ++++++++++--
 arch/arm/mach-keystone/memory.h   | 18 ------------------
 2 files changed, 10 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/memory.h

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e0ca26182e0bd..e8a06bd69bf22 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -18,10 +18,18 @@
 #include <asm/mach/time.h>
 #include <asm/page.h>
 
-#include "memory.h"
-
 #include "keystone.h"
 
+#define KEYSTONE_LOW_PHYS_START		0x80000000ULL
+#define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
+#define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
+					 KEYSTONE_LOW_PHYS_SIZE - 1)
+
+#define KEYSTONE_HIGH_PHYS_START	0x800000000ULL
+#define KEYSTONE_HIGH_PHYS_SIZE		0x400000000ULL	/* 16G */
+#define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
+					 KEYSTONE_HIGH_PHYS_SIZE - 1)
+
 #ifdef CONFIG_ARM_LPAE
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
diff --git a/arch/arm/mach-keystone/memory.h b/arch/arm/mach-keystone/memory.h
deleted file mode 100644
index 1b9ed1271e059..0000000000000
--- a/arch/arm/mach-keystone/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2014 Texas Instruments, Inc.
- *	Santosh Shilimkar <santosh.shilimkar@ti.com>
- */
-#ifndef __MEMORY_H
-#define __MEMORY_H
-
-#define KEYSTONE_LOW_PHYS_START		0x80000000ULL
-#define KEYSTONE_LOW_PHYS_SIZE		0x80000000ULL /* 2G */
-#define KEYSTONE_LOW_PHYS_END		(KEYSTONE_LOW_PHYS_START + \
-					 KEYSTONE_LOW_PHYS_SIZE - 1)
-
-#define KEYSTONE_HIGH_PHYS_START	0x800000000ULL
-#define KEYSTONE_HIGH_PHYS_SIZE		0x400000000ULL	/* 16G */
-#define KEYSTONE_HIGH_PHYS_END		(KEYSTONE_HIGH_PHYS_START + \
-					 KEYSTONE_HIGH_PHYS_SIZE - 1)
-#endif /* __MEMORY_H */
-- 
2.39.2

