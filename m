Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78117C6B13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbjJLK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbjJLK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:27:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24FD8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:27:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so1128978e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697106428; x=1697711228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qijCfZsHvHC96hQQZArQt7jQu+tpQM/wpUps9/WsIyQ=;
        b=kPHh3qk13GAeqoTfLFo0I7BWdDbYN3y7iWrdr2FHHDMFUs/z+bJIyIv28vjyOJuDCY
         WK1soCRlmoFWnrtNxZK2BX7CKHMhYOB1HxCr0iccZ0oNR1FNBV5luMJuk00yX691dFct
         BwOB4EUlMcqV80C/TwMkXfCpJ5xvfassGG9gR2uGJTL2Ebw8FjPXEt9pq6pQ/MpBX6w7
         XLextbvHW1Kz0B/Liu4h0/yTpMUDfDme0mUpJzBiRZBw1Fokr9rw/nuzuJAFXASvFCHH
         geYQhKCcJTKmMh8dZWY3Z8/YZMntc5fgvXPmyGy33ewkxCE4lQiyiJL66/1+UkPMxENJ
         p4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697106428; x=1697711228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qijCfZsHvHC96hQQZArQt7jQu+tpQM/wpUps9/WsIyQ=;
        b=D2zSfQvLsXhentTZRzTwj6KpUvssWg1kkuSGxVGFXbiWXTpPJDlGl/88flnOoiV1Wf
         tQG6DpMUExig+tsdCXo4GEuk9/D9SG8SQEjgwyVIOg3BYDAJqC3okoJpi2Bi05A1mNH/
         xzLs0VrY5J/1yWNLr96JRskoHu27xn5DkfJsZ3xPtA48+pujCOjXeSgpdzNZe9cN6ckj
         kQwY1FwRtArm7apdXjcdPoFnccWLTx8msPD28IL0faHclV06hixBPzQ3VOIplv0sroDi
         IWDXksocPhpyEUHeoKP8/ZlilCT7+n8kte3UeuJta8TLsmgFFq+epxXDExBInvx/RY5T
         z5Rw==
X-Gm-Message-State: AOJu0YyRW5TLGhxox15opr5/c2sD6s3NY+V1KeJrHeBX97wzKCB6q8ud
        FcckuUXlmBQzVRkOncXxREHRSQ==
X-Google-Smtp-Source: AGHT+IHL56KOMkORTZhlEKfCtkjP4Y4TCN8HnBEroM2SEse98GL1iDYmlexphHHxq7EGLPNQ3mZDqw==
X-Received: by 2002:a05:6512:3c2:b0:503:17c0:5374 with SMTP id w2-20020a05651203c200b0050317c05374mr16734076lfp.65.1697106428201;
        Thu, 12 Oct 2023 03:27:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm21506797wmk.1.2023.10.12.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:27:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/POWER_ALLOCATOR),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal/core: Reorder the headers inclusion
Date:   Thu, 12 Oct 2023 12:26:59 +0200
Message-Id: <20231012102700.2858952-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next changes will move the thermal device structure inside the
thermal core code. Consequently, the traces must be included after
thermal_core.h as this one contains the thermal zone device structure
definition the traces need.

Reorder the inclusions.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_power_allocator.c | 6 +++---
 drivers/thermal/thermal_core.c        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d1c6ad92e5b4..6056ed15460b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -11,12 +11,12 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace_ipa.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace_ipa.h" 
+
 #define INVALID_TRIP -1
 
 #define FRAC_BITS 10
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9ee0ec3bdff6..51a6bed47213 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -21,13 +21,13 @@
 #include <linux/of.h>
 #include <linux/suspend.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace.h"
+
 static DEFINE_IDA(thermal_tz_ida);
 static DEFINE_IDA(thermal_cdev_ida);
 
-- 
2.34.1

