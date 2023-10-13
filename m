Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9247C7FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJMIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjJMIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:10:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF5DD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae75ece209so293515366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697184614; x=1697789414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/XXmyKti81VH1ptNw2dE1ihFch8qRO8aJsAFTskBo0=;
        b=PNftcScRwB6nCWGZkNuk+Ig0IdH/zzXBfJXKzelFqHWHzAaewIxkEua2HMAJNp4BQd
         VSgIRueLCzI+Ab04UtrbcY3F4Phh3oH8aOgrlVWfSgphAauD0VmRd9q0OmcWsHfriA8v
         oVxZkMAl+LsI65Fz2/zcdngBag0fUqVW0vF6cU6YYKdNdDt3aQJhDk39eq7/3Z3fuirS
         /G5a7N4iF4SFw9U+wvHTuYNr20uAhFYdJad5VFY9DvFxHidMoopAAAzJzYqgsFIrflvg
         8XoN1hUZ7h/13AlbDpxA1du1NAmxuj2a8RWk6J7OcEX1JmRGJoNGQmnMsjC6yuTDmIWA
         1ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184614; x=1697789414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/XXmyKti81VH1ptNw2dE1ihFch8qRO8aJsAFTskBo0=;
        b=HrVI7aAZzJ2x+u3Jk5nK3Rzdjq95J8RHhLSXURByfi9R199KIQ32F0xQ9QkbMr57SY
         pFYYpmdCbnVLcEOd4QwJ0zBhEoTEgIoz5vEPuZv9oYVnY8yOaMM3QYJlffEKFXnPw1T9
         jTHJMtIKB/4bNvjGG+w8/fDK4vZ4FhWtqWGn5jgfAhZwN7G63o0wCo/AWrMAPmOctdZV
         H4VpcoNbE+/yCFUgWofF/fEBU+2YQtoWOxLPfx1+Ne7NNCbalSHHwJ8RxYj6DDPoUrzw
         KZKULBp3oXWUVso1TGOjzw3dVpKzQaNOeYlARUzNSDwQcWfTMM0QISpTOLwl/5ld4wK6
         eXLA==
X-Gm-Message-State: AOJu0Ywl8DRkAimrjylrE/VkmMuGWGS3M0kAv6LTh949jX8Vk7WRi0+N
        Pd+Fj9wfFgA4j1mYQJmmEcthEQ==
X-Google-Smtp-Source: AGHT+IGoWDADVMXWKr+jNxj7Wbo6DoL/2A7ROb+JP+5px1M2xbYi7735/jq101vucGRY54ky/ufEvQ==
X-Received: by 2002:a17:907:78a:b0:9bd:a662:c066 with SMTP id xd10-20020a170907078a00b009bda662c066mr603283ejb.76.1697184614461;
        Fri, 13 Oct 2023 01:10:14 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906360e00b009a5f1d1564dsm11910761ejb.126.2023.10.13.01.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:10:14 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 10:09:53 +0200
Subject: [PATCH 1/4] iio: adc: Add PM7325 PMIC7 ADC bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-fp5-thermals-v1-1-f14df01922e6@fairphone.com>
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
In-Reply-To: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the defines for the ADC channels found on the PM7325. The list is
taken from downstream msm-5.4 and adjusted for mainline.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
new file mode 100644
index 000000000000..96908014e09e
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H
+
+#ifndef PM7325_SID
+#define PM7325_SID					1
+#endif
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+/* ADC channels for PM7325_ADC for PMIC7 */
+#define PM7325_ADC7_REF_GND			(PM7325_SID << 8 | ADC7_REF_GND)
+#define PM7325_ADC7_1P25VREF			(PM7325_SID << 8 | ADC7_1P25VREF)
+#define PM7325_ADC7_VREF_VADC			(PM7325_SID << 8 | ADC7_VREF_VADC)
+#define PM7325_ADC7_DIE_TEMP			(PM7325_SID << 8 | ADC7_DIE_TEMP)
+
+#define PM7325_ADC7_AMUX_THM1			(PM7325_SID << 8 | ADC7_AMUX_THM1)
+#define PM7325_ADC7_AMUX_THM2			(PM7325_SID << 8 | ADC7_AMUX_THM2)
+#define PM7325_ADC7_AMUX_THM3			(PM7325_SID << 8 | ADC7_AMUX_THM3)
+#define PM7325_ADC7_AMUX_THM4			(PM7325_SID << 8 | ADC7_AMUX_THM4)
+#define PM7325_ADC7_AMUX_THM5			(PM7325_SID << 8 | ADC7_AMUX_THM5)
+#define PM7325_ADC7_GPIO1			(PM7325_SID << 8 | ADC7_GPIO1)
+#define PM7325_ADC7_GPIO2			(PM7325_SID << 8 | ADC7_GPIO2)
+#define PM7325_ADC7_GPIO3			(PM7325_SID << 8 | ADC7_GPIO3)
+#define PM7325_ADC7_GPIO4			(PM7325_SID << 8 | ADC7_GPIO4)
+
+/* 30k pull-up1 */
+#define PM7325_ADC7_AMUX_THM1_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_30K_PU)
+#define PM7325_ADC7_AMUX_THM2_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_30K_PU)
+#define PM7325_ADC7_AMUX_THM3_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_30K_PU)
+#define PM7325_ADC7_AMUX_THM4_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_30K_PU)
+#define PM7325_ADC7_AMUX_THM5_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_30K_PU)
+#define PM7325_ADC7_GPIO1_30K_PU		(PM7325_SID << 8 | ADC7_GPIO1_30K_PU)
+#define PM7325_ADC7_GPIO2_30K_PU		(PM7325_SID << 8 | ADC7_GPIO2_30K_PU)
+#define PM7325_ADC7_GPIO3_30K_PU		(PM7325_SID << 8 | ADC7_GPIO3_30K_PU)
+#define PM7325_ADC7_GPIO4_30K_PU		(PM7325_SID << 8 | ADC7_GPIO4_30K_PU)
+
+/* 100k pull-up2 */
+#define PM7325_ADC7_AMUX_THM1_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_100K_PU)
+#define PM7325_ADC7_AMUX_THM2_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_100K_PU)
+#define PM7325_ADC7_AMUX_THM3_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_100K_PU)
+#define PM7325_ADC7_AMUX_THM4_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_100K_PU)
+#define PM7325_ADC7_AMUX_THM5_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_100K_PU)
+#define PM7325_ADC7_GPIO1_100K_PU		(PM7325_SID << 8 | ADC7_GPIO1_100K_PU)
+#define PM7325_ADC7_GPIO2_100K_PU		(PM7325_SID << 8 | ADC7_GPIO2_100K_PU)
+#define PM7325_ADC7_GPIO3_100K_PU		(PM7325_SID << 8 | ADC7_GPIO3_100K_PU)
+#define PM7325_ADC7_GPIO4_100K_PU		(PM7325_SID << 8 | ADC7_GPIO4_100K_PU)
+
+/* 400k pull-up3 */
+#define PM7325_ADC7_AMUX_THM1_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_400K_PU)
+#define PM7325_ADC7_AMUX_THM2_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_400K_PU)
+#define PM7325_ADC7_AMUX_THM3_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_400K_PU)
+#define PM7325_ADC7_AMUX_THM4_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_400K_PU)
+#define PM7325_ADC7_AMUX_THM5_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_400K_PU)
+#define PM7325_ADC7_GPIO1_400K_PU		(PM7325_SID << 8 | ADC7_GPIO1_400K_PU)
+#define PM7325_ADC7_GPIO2_400K_PU		(PM7325_SID << 8 | ADC7_GPIO2_400K_PU)
+#define PM7325_ADC7_GPIO3_400K_PU		(PM7325_SID << 8 | ADC7_GPIO3_400K_PU)
+#define PM7325_ADC7_GPIO4_400K_PU		(PM7325_SID << 8 | ADC7_GPIO4_400K_PU)
+
+/* 1/3 Divider */
+#define PM7325_ADC7_GPIO4_DIV3			(PM7325_SID << 8 | ADC7_GPIO4_DIV3)
+
+#define PM7325_ADC7_VPH_PWR			(PM7325_SID << 8 | ADC7_VPH_PWR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H */

-- 
2.42.0

