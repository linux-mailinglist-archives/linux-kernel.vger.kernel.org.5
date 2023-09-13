Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53E79F207
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjIMT2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjIMT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:28:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5C1BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:28:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403012f276dso1880165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694633320; x=1695238120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzK1Gimv1xbcD7M0xpMSCJyPfPmTXUtdX1MVmzku7CY=;
        b=UnrnNOCMQ6X1WTBQ9aT0BIqAoHusz/5LrHPYaoEdBdS/mJ+KRq2f/swK4HsBXVjtNZ
         WUKiK6u3yN8FxmTpO+M7Sw7+aCUoN0QzwxHqOVNKN8jD95VlKi5U9j3A5c0O2KuLvcld
         HRm27+Zr4laSvObwoAJC5ZFkeH44bJ9wJZbHBdWCZlAnDOVVoLZGiV9KR1nqtd+xnufz
         VXqLZ+s8Yp/qeAInUoMN/ZJXng/BSIb5L4dq1pp3McjfaDIN1ey9c9lmj4T+DjMRBh9c
         4q3bivDpOPRQUuKrnzfUilt5MtFxax3/HoIRCkAXLMmnU+71F9xbHuDrId4vkMm/Barz
         OmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633320; x=1695238120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzK1Gimv1xbcD7M0xpMSCJyPfPmTXUtdX1MVmzku7CY=;
        b=cbGgrSSXFbxcUoF045zKZcqRkNDqz7NS39pVWL6dcMl2qWxmm2XFkwYtHR/yg9Ve7g
         uftdj/KPm+mcpnhndXyt027Ri7Nd+qC+eDC8+501apblagmgtHauwRt8vnkEenD3Qo/b
         ySEUw09rnA7WM3j8u50u2MsO2coijTB1LbZ00NO50LtqBDsIGnyJ2UZWBrTbWRr9UT1n
         DO/D55rZl1sxJsG76xx04apg3bUTMcq68sr6xLXSBviDIZGL/oVNSV195QlCj3VOvmqu
         DVJcPSTBXxODQkVctHNMB/fpkLV1VDyB+6uk0Msrw2X+bXSnZCjlXBcmtqbo38+6aRdP
         hZLw==
X-Gm-Message-State: AOJu0Yz0sAkdEVVYvPImtjMWmFxVCE/nOm6XEjU+9Fl2nFscBc/WKfmZ
        vQSvuGPjuWq5qm72sA3/49O8jA==
X-Google-Smtp-Source: AGHT+IGpWVNvAHt4Oe3xGSQbh+t4882VAf6lPjxTPDgD6HQvFzZGuinscL0kjz+WNd1FXQ1L5EBgGw==
X-Received: by 2002:a1c:4c0d:0:b0:3fd:3006:410b with SMTP id z13-20020a1c4c0d000000b003fd3006410bmr2882173wmf.34.1694633320443;
        Wed, 13 Sep 2023 12:28:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3b50:bca5:a754:7463])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b004013797efb6sm2847248wmj.9.2023.09.13.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:28:39 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH 2/2] firmware: qcom-scm: order includes alphabetically
Date:   Wed, 13 Sep 2023 21:28:26 +0200
Message-Id: <20230913192826.36187-2-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913192826.36187-1-bartosz.golaszewski@linaro.org>
References: <20230913192826.36187-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For easier maintenance order the included headers in qcom_scm.c
alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom_scm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 06fe8aca870d..507ce24a3aeb 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -2,24 +2,25 @@
 /* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  */
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
-#include <linux/export.h>
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/init.h>
 #include <linux/interconnect.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/clk.h>
+#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
-#include <linux/arm-smccc.h>
+#include <linux/types.h>
 
 #include "qcom_scm.h"
 
-- 
2.39.2

