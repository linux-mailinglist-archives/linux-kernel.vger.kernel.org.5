Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885DB75ED16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGXIIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGXIIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:08:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEAFE;
        Mon, 24 Jul 2023 01:08:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb84194bf3so7976365ad.3;
        Mon, 24 Jul 2023 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690186108; x=1690790908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnjnEM1q4FaIbu0XLbBMFL7FTXZt/Gd9eRGXpPcG/Vw=;
        b=bZQtBrhMr0cUsQ384TewyyuQjYBuSXTgIm7TDluHBqi9F/9gJu1SyBJBqFgfePUGBY
         oYups6EcndxOA4vxt11LpADG2+NP81YGpJoRJfqR07iUlcOPJBiOepJAHNnfL4kLIkbv
         F69gSXIbnBnGWEXwt+o2yFLnKXL/Mdu5/fFetjxGbKhPR4Srfr9LtFpI4zSur3R/f4r5
         jOil2c8bJG0y4HyY3TFQnS0GAcJu6eXcfSEY8icxdMEEfyuCXbYTt8ux2mZfs6xVkNRY
         idVmoPyyrOYk1sQ7QeSviuLvQPgVKvC1M/WfBpNtU+srFTHvXfExJ/ZH3BT1kmLwGaD6
         L9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186108; x=1690790908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnjnEM1q4FaIbu0XLbBMFL7FTXZt/Gd9eRGXpPcG/Vw=;
        b=L0KhHoI9uFWA2Pmt7pL4b7VOJHB6P5tfKjpOGrIHM9UE0TZ0kK3r9EPdhKLTB+Cuny
         oNAEA0pvmC3jbtACZVeLi9QMfC+S1F5B1inELk/p5CE9l5+OpUo87WB4gB9fGHoeD7fT
         uKCQn8w4Jh8RGvrqGJQFV47emzr3i/K0aY/TXKLm8lh4jDraGKmywnax6DHJYYtS1+c6
         wWgNZUr9LdETaVLsky9tZCl1npgkl5s0QJ69I6rvEC6p/h16sQTaVKRqcihtdKQQcJNz
         2y9X3jU5cRgfb2VmYKkz+F7OMkFP5S1ZncAclrVt2zzYjUWA3BWtX8HysvD863zMDfbH
         ZdHQ==
X-Gm-Message-State: ABy/qLbNDLQj+RuJSYfrYRvkx1x4Lf0iCAX1Nias/UBwBdsPYv9oHKN/
        0xg6QfbrgdPIxGIXX3/2yJv1aX2lkwI=
X-Google-Smtp-Source: APBJJlHMuefu6wZvJjrdOrw4A5U3v2EERq/cIjbO2kLFG0eQp1uULaHgOpVMPQhp0OP0UPWFpewnIA==
X-Received: by 2002:a17:902:c103:b0:1b5:561a:5ca9 with SMTP id 3-20020a170902c10300b001b5561a5ca9mr7113521pli.50.1690186108617;
        Mon, 24 Jul 2023 01:08:28 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9f1d:4d2f:6739:324d])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001b8622c1ad2sm8159957plg.130.2023.07.24.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:08:28 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] xtensa: PMU: fix base address for the newer hardware
Date:   Mon, 24 Jul 2023 01:08:19 -0700
Message-Id: <20230724080819.2305666-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With introduction of ERI access control in RG.0 base address of the PMU
unit registers has changed. Add support for the new PMU configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/core.h  |  9 +++++++++
 arch/xtensa/kernel/perf_event.c | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 0e1bb6f019d6..3f5ffae89b58 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -52,4 +52,13 @@
 #define XTENSA_STACK_ALIGNMENT	16
 #endif
 
+#ifndef XCHAL_HW_MIN_VERSION
+#if defined(XCHAL_HW_MIN_VERSION_MAJOR) && defined(XCHAL_HW_MIN_VERSION_MINOR)
+#define XCHAL_HW_MIN_VERSION (XCHAL_HW_MIN_VERSION_MAJOR * 100 + \
+			      XCHAL_HW_MIN_VERSION_MINOR)
+#else
+#define XCHAL_HW_MIN_VERSION 0
+#endif
+#endif
+
 #endif
diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index a0d05c8598d0..183618090d05 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -13,17 +13,26 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
+#include <asm/core.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
+#define XTENSA_HWVERSION_RG_2015_0	260000
+
+#if XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RG_2015_0
+#define XTENSA_PMU_ERI_BASE		0x00101000
+#else
+#define XTENSA_PMU_ERI_BASE		0x00001000
+#endif
+
 /* Global control/status for all perf counters */
-#define XTENSA_PMU_PMG			0x1000
+#define XTENSA_PMU_PMG			XTENSA_PMU_ERI_BASE
 /* Perf counter values */
-#define XTENSA_PMU_PM(i)		(0x1080 + (i) * 4)
+#define XTENSA_PMU_PM(i)		(XTENSA_PMU_ERI_BASE + 0x80 + (i) * 4)
 /* Perf counter control registers */
-#define XTENSA_PMU_PMCTRL(i)		(0x1100 + (i) * 4)
+#define XTENSA_PMU_PMCTRL(i)		(XTENSA_PMU_ERI_BASE + 0x100 + (i) * 4)
 /* Perf counter status registers */
-#define XTENSA_PMU_PMSTAT(i)		(0x1180 + (i) * 4)
+#define XTENSA_PMU_PMSTAT(i)		(XTENSA_PMU_ERI_BASE + 0x180 + (i) * 4)
 
 #define XTENSA_PMU_PMG_PMEN		0x1
 
-- 
2.30.2

