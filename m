Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7A7E8CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKKUtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:49:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99630D1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4079ed65582so23779705e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699735764; x=1700340564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLBtiPYj3Yy2cVg+bWJ7eQ8pYjPfevkkuxOoGNznoSw=;
        b=mp4kal5X1fTFGgn4v3Vhn+fITh9jiKL1Iv1CNkVz2dr1iNwPUYuPc0yWZFdJL4Lq5Q
         ldy7MQEmGZ/zM9sN29GN8jaGRjbDKvJwkWCHN17n7VD9Nl0m1mEvE4NebdNGQgKwLsvn
         0HxB/APgVS0L05zzwus3GuOV94nBGXLSzrLTKPmmmkbErSfMkGOTqQOfNpSlIqw8wpD1
         EEORiLY8q04F5oAH6xEMAx7Fz3K+QAwt9KJV3UkpwzUrmdptB1xge2jP7at1Gmp1heS+
         JKJZwzcnP6Swnv7R3KkYeKyP/yQzTDXJ15GzlgUL3I2HFmV0XzHvgDvCuhsPyLflat4d
         yUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735764; x=1700340564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLBtiPYj3Yy2cVg+bWJ7eQ8pYjPfevkkuxOoGNznoSw=;
        b=mqvzF1PIPtO4Bh+k06WPMfl8oM9kIzG9KxsJRP46YbIMveayNyUq1zCqnFg46833ME
         M9cNfyDFjqyTZQ08MueyoxUgwJoO4YLOPK/fJKyD2X1WKiPx+zlPcVyaLgWIvYEaMFz2
         Bl+jX+u5spsK0eH/K5b5pF0ZN05/O49YmNxq4YESLW5Q+26AJH4P4ayN9jvf5eGRWLVM
         dIrisX59rQ7o+G0BcfBD+uYkyEltqnY4NnHVVFsaI0rNKwfx9eHf6sbY4R1Ii4OF7mGm
         +un4h+GDRGAFOKGFdAzYpEzVeIlCuStv5SWvHsIp796fSXzRnK7W0t1XK/nEmT4GQttQ
         chUw==
X-Gm-Message-State: AOJu0YxknJSbSByVKHHarBLNyH6QURMV/DBt+5jtmI5Fq3aq7KxP8DTX
        Jqma27X1ri6WsYMRwFMXo9ElBA==
X-Google-Smtp-Source: AGHT+IEyrfjG7/N1sG414WEFffDiTSiFc5t4EfjI4yT0UQcFt1DJflVEFPUR7WGPZlo7p260m0z0TA==
X-Received: by 2002:a05:600c:4ecc:b0:406:8496:bd8b with SMTP id g12-20020a05600c4ecc00b004068496bd8bmr1983168wmq.9.1699735764163;
        Sat, 11 Nov 2023 12:49:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b00407752bd834sm3121226wmq.1.2023.11.11.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:49:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: mailbox: qcom,apcs-kpss-global: drop duplicated qcom,ipq8074-apcs-apps-global
Date:   Sat, 11 Nov 2023 21:49:14 +0100
Message-Id: <20231111204916.35835-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
References: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom,ipq8074-apcs-apps-global compatible is listed in two places: with
and without fallback.  Drop the second case to match DTS.

Fixes: 34d8775a0edc ("dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks for few variants")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index a38413f8d132..a22c8640dc0e 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -41,7 +41,6 @@ properties:
           - const: syscon
       - enum:
           - qcom,ipq6018-apcs-apps-global
-          - qcom,ipq8074-apcs-apps-global
           - qcom,msm8996-apcs-hmss-global
           - qcom,msm8998-apcs-hmss-global
           - qcom,qcm2290-apcs-hmss-global
-- 
2.34.1

