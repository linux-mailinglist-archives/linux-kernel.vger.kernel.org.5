Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895E67DBB19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjJ3NwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3NwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:52:03 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24AA2;
        Mon, 30 Oct 2023 06:52:00 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6c4a25f6390so2994591a34.2;
        Mon, 30 Oct 2023 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673920; x=1699278720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DNw5hefDLTG0j4qbA4dW0wqpyWD+OlJB5Qqx3rsaXk=;
        b=BQfNFG9Rss2f1v0QI9+rxqsp0s8PGILHBuGEailSNfhhjeib7PiFRvOwSMmbTw8Yim
         s2311zVEa29aiqcsYdFujOiVtMMmZQVIhKyqfAoxIdmIUSy6xyHBTC6nUv2swKtdKQz5
         zfYxRzqhXmgA4v8A9/0QJh2F93HCl5bK43uvnu8P2MIH7mH8cwLunXXh4L3S9p52psqS
         hVFFeG+q2c4rRFe/+jPTMY75os3ZJtFr4BX1dsp2JPJ8BW1uTSrK8BPpskwAky9KuOr1
         Gv6LCfexWjJXvVKP1BVSuJ4W2dsnHz8Er9u7gsUPdYxYjCCAHAc9i0mbOYPYXJ2tYJ34
         KreA==
X-Gm-Message-State: AOJu0YwuUqNBPDxi6cpKXxt5YORhJvqfUhpCvRsCBHdWeIYrnQyAgX45
        HciwpcP9wjpmmbjqa9IXioLF2wSWeg==
X-Google-Smtp-Source: AGHT+IGqQ2k03uHVsRgDfrd7WBDG/yppJcpg1rH6XxSoah8QXZA9jlxcTSfikdDNZEgV3UI8f8mpag==
X-Received: by 2002:a05:6830:1111:b0:6c4:e507:3747 with SMTP id w17-20020a056830111100b006c4e5073747mr10361909otq.30.1698673919749;
        Mon, 30 Oct 2023 06:51:59 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t66-20020a4a5445000000b00581dd3eb895sm1804897ooa.37.2023.10.30.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:51:58 -0700 (PDT)
Received: (nullmailer pid 773869 invoked by uid 1000);
        Mon, 30 Oct 2023 13:51:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] thermal: loongson2: Replace of_device.h with explicit includes
Date:   Mon, 30 Oct 2023 08:51:41 -0500
Message-ID: <20231030135142.773496-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
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
and of.h.

of_device.h isn't needed, but mod_devicetable.h and property.h were
implicitly included.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/loongson2_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 133098dc0854..644596f5e3bb 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -8,9 +8,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
 #include "thermal_hwmon.h"
-- 
2.42.0

