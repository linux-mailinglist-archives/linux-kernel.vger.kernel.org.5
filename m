Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2175E45B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGWTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGWTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6F1AE;
        Sun, 23 Jul 2023 12:08:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so27103925e9.1;
        Sun, 23 Jul 2023 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139283; x=1690744083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnVCby4OzPzkMY2F/B5v8SGADAGIqKWRP6OZFHSrWRw=;
        b=myY4y6lqv+gZbpfAr4n2l3Uhj5myynqvays3KJWseQYmQHr288mrgc4NPb0ft4n6Fj
         LDK9861O3Z+HhJtQw4Ef1XXC4uBmndf0xRIqNn8HvIAMhS2oI/Cl1xQwQQUXDAm/ttDq
         4lMhxWsof7FYzgj3vVH+8xRz6QTPISrdxp0UmpcFRbnFZeYqhbIvPi6fAWhDEK6Qy97v
         MaNUbOPYG+bj2lxQJhcgkGDs1aMC+ydaD9M8qtAKqeg5HCZ2BoPxqp2yY4o0GdhnB9Xz
         Xv+8omk8D/zNsWGsH1WO7KWv2L8YUyQhlkEfUWDgRI20UqXakB2d4cwQgwaf8Z3ppyxl
         EktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139283; x=1690744083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnVCby4OzPzkMY2F/B5v8SGADAGIqKWRP6OZFHSrWRw=;
        b=ZKm+tx8BJAVVdH8TWY+lNgJpHbQ5QijlHbJEa+hNKdSWqyYkzl0Biakk6urNNf9/R4
         3u3iSe/iNQwXZxTMTmdP16URvUp6LcBdLJ2lalpRz7BbNBPSb7y0+Biq1qAIGtjAXLEz
         BN77I9givW24osydzL6LmzdsiP+BQOrSkqNMdCAPgS5h/bHWCb18cDPbEIabMR1spGg1
         sE43YbUkOw0NmNfkwdIsweRARpFCD95QycX8G9WMT3h/wbdMtyDoxyf+KPWg/CemOMRN
         mn89vi2RxYjTeyWbdfKRo8VBZB1rs8BQffdsQ6n6mGK6Peor7hHWJ8l7wArsu3VPczio
         AXPQ==
X-Gm-Message-State: ABy/qLY7Cu/fU7VHBOF9pGxrXDDgBI80H52KsYtLW/f3S8gDmAWhyS49
        XEHHV4ETKAeGc8biLJ7DyERgKgQVSr8=
X-Google-Smtp-Source: APBJJlHqn0YhhZCVqVS7II9n8ajUzO1Be23nmZhhpOdSrDSF2TC/5yEYdKko0VaR4qXz14uTcJBBGg==
X-Received: by 2002:a7b:ce98:0:b0:3fb:ba04:6d5d with SMTP id q24-20020a7bce98000000b003fbba046d5dmr4801651wmj.12.1690139283378;
        Sun, 23 Jul 2023 12:08:03 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:03 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/7] dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
Date:   Sun, 23 Jul 2023 21:05:03 +0200
Message-ID: <20230723190725.1619193-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID for Qualcomm SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index bcbe9ee2cdaf..6a8dd2e42b24 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -215,6 +215,7 @@
 #define QCOM_ID_SDA429W			437
 #define QCOM_ID_SM8350			439
 #define QCOM_ID_QCM2290			441
+#define QCOM_ID_SM7125			443
 #define QCOM_ID_SM6115			444
 #define QCOM_ID_IPQ5010			446
 #define QCOM_ID_IPQ5018			447
-- 
2.41.0

