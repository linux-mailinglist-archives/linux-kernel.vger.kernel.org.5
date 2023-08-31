Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733278ECD4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjHaMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjHaMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:14:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89430CFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401da71b85eso6851585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693484055; x=1694088855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y280bHt32vSOMwN3pJA4Lm3adazJUGW99dZ6wwJlE0=;
        b=HPaqQ84uCPOMimzD3RchsDOfrghM29pjwKHsftIKVPktU/z5d1G7BmbAJ6zlMYFTtV
         YKO6G9CwHX/9bcMZWHTadU8FrhnTUhrAXqyMRxyVk5i+yqXZqM6CUXOoPmns3E+FIEGC
         nh01YFPTDjA7YfZg2nUuWgsq0idxlV0wil/G+Ojd7o5fswEsYybEo5WpBozoSXgoyj9A
         wR9mTVQBfIxDyCCk28xJP5VfB4JA54CHpsdPKhlNH5IdQoEm3RTZAKltg0HUKvbBCguW
         DTbTpWLlUbRisTAIK1gMVA01ZzqSJiSL8Tika1S8Ps2XWYICW8n+iwMZ2b2URQF8r06/
         2u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484055; x=1694088855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Y280bHt32vSOMwN3pJA4Lm3adazJUGW99dZ6wwJlE0=;
        b=gTslJQ1yBMbNTi3rKs81SbdRRuXx2ICroIQ7gXfUaCHE4HhsVK/xjzRGk8HqfRsU13
         COCUcK5TXhRVNMWXE9YATeVp7i2oqjERjPHAYtgL+Xv6XU/AIL8AbYbvR7amshrBWCm2
         NrqVSWHcFr1SycsBYLQIyqXZ7dSg2UkVe+4V/IY3G5hlHXfGjn18hxy4cQevx8hryz8A
         EAaqgZ59wOxH2LQhvZG/v+bxDXWn5ScW8s0uPDJc7puscN2FGGwcEXv917JTEAL1i0Hc
         nRylbw872xffQKPJyYAk2tmdT+GrniVm1H2F0OQywVvvc7GPapCdSRnbetj6aVEi7BZN
         v4aQ==
X-Gm-Message-State: AOJu0Yw2BwxOa5TW9NqadfAqQAfsCY5bdxggsvbunKLnpuw9hnZ/XjsZ
        II+6hHluOtF+FzLZN2U3jQ8M3WG72OJpnah8K450Kg==
X-Google-Smtp-Source: AGHT+IGxTlzRRZH+FJ0vMjkT9ZfqWnFBgrftiy3OxX0XiVlkI/M74GnS0gNZZTDOKAPCzy5UmARpkQ==
X-Received: by 2002:a7b:c84b:0:b0:401:b204:3b8d with SMTP id c11-20020a7bc84b000000b00401b2043b8dmr4303382wml.27.1693484054896;
        Thu, 31 Aug 2023 05:14:14 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm1799448wmc.10.2023.08.31.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:14:14 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] regulator: Add uapi header
Date:   Thu, 31 Aug 2023 14:14:08 +0200
Message-ID: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UAPI header for regulator.
Include regulator events in the header.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 include/linux/regulator/consumer.h | 47 +--------------------------
 include/uapi/linux/regulator.h     | 52 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 46 deletions(-)
 create mode 100644 include/uapi/linux/regulator.h

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 39b666b40ea6..fb65cf35beca 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -33,6 +33,7 @@
 
 #include <linux/err.h>
 #include <linux/suspend.h>
+#include <uapi/linux/regulator.h>
 
 struct device;
 struct notifier_block;
@@ -84,52 +85,6 @@ struct regulator_dev;
 #define REGULATOR_MODE_IDLE			0x4
 #define REGULATOR_MODE_STANDBY			0x8
 
-/*
- * Regulator notifier events.
- *
- * UNDER_VOLTAGE  Regulator output is under voltage.
- * OVER_CURRENT   Regulator output current is too high.
- * REGULATION_OUT Regulator output is out of regulation.
- * FAIL           Regulator output has failed.
- * OVER_TEMP      Regulator over temp.
- * FORCE_DISABLE  Regulator forcibly shut down by software.
- * VOLTAGE_CHANGE Regulator voltage changed.
- *                Data passed is old voltage cast to (void *).
- * DISABLE        Regulator was disabled.
- * PRE_VOLTAGE_CHANGE   Regulator is about to have voltage changed.
- *                      Data passed is "struct pre_voltage_change_data"
- * ABORT_VOLTAGE_CHANGE Regulator voltage change failed for some reason.
- *                      Data passed is old voltage cast to (void *).
- * PRE_DISABLE    Regulator is about to be disabled
- * ABORT_DISABLE  Regulator disable failed for some reason
- *
- * NOTE: These events can be OR'ed together when passed into handler.
- */
-
-#define REGULATOR_EVENT_UNDER_VOLTAGE		0x01
-#define REGULATOR_EVENT_OVER_CURRENT		0x02
-#define REGULATOR_EVENT_REGULATION_OUT		0x04
-#define REGULATOR_EVENT_FAIL			0x08
-#define REGULATOR_EVENT_OVER_TEMP		0x10
-#define REGULATOR_EVENT_FORCE_DISABLE		0x20
-#define REGULATOR_EVENT_VOLTAGE_CHANGE		0x40
-#define REGULATOR_EVENT_DISABLE			0x80
-#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE	0x100
-#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
-#define REGULATOR_EVENT_PRE_DISABLE		0x400
-#define REGULATOR_EVENT_ABORT_DISABLE		0x800
-#define REGULATOR_EVENT_ENABLE			0x1000
-/*
- * Following notifications should be emitted only if detected condition
- * is such that the HW is likely to still be working but consumers should
- * take a recovery action to prevent problems esacalating into errors.
- */
-#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
-#define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000
-#define REGULATOR_EVENT_OVER_VOLTAGE_WARN	0x8000
-#define REGULATOR_EVENT_OVER_TEMP_WARN		0x10000
-#define REGULATOR_EVENT_WARN_MASK		0x1E000
-
 /*
  * Regulator errors that can be queried using regulator_get_error_flags
  *
diff --git a/include/uapi/linux/regulator.h b/include/uapi/linux/regulator.h
new file mode 100644
index 000000000000..d5f94a301841
--- /dev/null
+++ b/include/uapi/linux/regulator.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __UAPI_LINUX_REGULATOR_CONSUMER_H_
+#define __UAPI_LINUX_REGULATOR_CONSUMER_H_
+
+/*
+ * Regulator notifier events.
+ *
+ * UNDER_VOLTAGE  Regulator output is under voltage.
+ * OVER_CURRENT   Regulator output current is too high.
+ * REGULATION_OUT Regulator output is out of regulation.
+ * FAIL           Regulator output has failed.
+ * OVER_TEMP      Regulator over temp.
+ * FORCE_DISABLE  Regulator forcibly shut down by software.
+ * VOLTAGE_CHANGE Regulator voltage changed.
+ *                Data passed is old voltage cast to (void *).
+ * DISABLE        Regulator was disabled.
+ * PRE_VOLTAGE_CHANGE   Regulator is about to have voltage changed.
+ *                      Data passed is "struct pre_voltage_change_data"
+ * ABORT_VOLTAGE_CHANGE Regulator voltage change failed for some reason.
+ *                      Data passed is old voltage cast to (void *).
+ * PRE_DISABLE    Regulator is about to be disabled
+ * ABORT_DISABLE  Regulator disable failed for some reason
+ *
+ * NOTE: These events can be OR'ed together when passed into handler.
+ */
+
+#define REGULATOR_EVENT_UNDER_VOLTAGE		0x01
+#define REGULATOR_EVENT_OVER_CURRENT		0x02
+#define REGULATOR_EVENT_REGULATION_OUT		0x04
+#define REGULATOR_EVENT_FAIL			0x08
+#define REGULATOR_EVENT_OVER_TEMP		0x10
+#define REGULATOR_EVENT_FORCE_DISABLE		0x20
+#define REGULATOR_EVENT_VOLTAGE_CHANGE		0x40
+#define REGULATOR_EVENT_DISABLE			0x80
+#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE	0x100
+#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
+#define REGULATOR_EVENT_PRE_DISABLE		0x400
+#define REGULATOR_EVENT_ABORT_DISABLE		0x800
+#define REGULATOR_EVENT_ENABLE			0x1000
+/*
+ * Following notifications should be emitted only if detected condition
+ * is such that the HW is likely to still be working but consumers should
+ * take a recovery action to prevent problems esacalating into errors.
+ */
+#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
+#define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000
+#define REGULATOR_EVENT_OVER_VOLTAGE_WARN	0x8000
+#define REGULATOR_EVENT_OVER_TEMP_WARN		0x10000
+#define REGULATOR_EVENT_WARN_MASK		0x1E000
+
+#endif

base-commit: 35d0d2350d774fecf596cfb2fb050559fe5e1850
-- 
2.41.0

